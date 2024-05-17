#Manages scenes load and free with transitions between.
#get_animation_player() and (optionally) set_text(txt)
extends Node

#Available scnee Levels
#LevelInfo is in utility/level_resource.gd
@onready var levels =  {
		"start" = LevelInfo.new("Main Hub","res://levels/hub_principal.tscn"),
		"level2" = LevelInfo.new("Desert","res://levels/level_2.tscn"),
		"level3" = LevelInfo.new("Great City", "res://levels/level_3.tscn"),
}


#Avaliable transitions Controls
#Scene of type Control that will be allocated(instantiated) to invoke fadein and fadeout animation.
#It is mandatory that the scene has an AnimationPlayer with an animation called 'fade'
#It is mandatory that the scene has a get_animation_player() method that returns the AnimationPlayer responsible for the fade animation
@onready var transitions  = {
		"circle" = preload("res://transitions/scenes/st_hole.tscn"),
		"rectangle" = preload("res://transitions/scenes/st_color_rect.tscn"),
		"sonic" = preload("res://transitions/scenes/st_sonic_like.tscn"),
	}

#Current level scene. When changing scenes, the current one is released and the new one becomes the current one
var current_scene = null
#Instance of the transition Control
var _st_node:Control
#Path of new level scene to be loaded. 
var _new_level:LevelInfo = null


func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1) #current scene is the current child


#Change level scene (call this method to change scenes)
#levelinfo_name is a name of a map entry of a LevelInfo resource type. (see get_level_info() and levels array)
#transition is a scene (Control) that represents a transition with animation (see transitions array). Default = "rectangle"
func goto_scene(levelinfo_name:String, transition:String="rectangle"):
	_new_level = get_level_info(levelinfo_name) 
	_instantiate_transition(transitions[transition]) # create transition UI
	fade_out() #first fadeout, then after the the animation is finisehd the level in _new_level will be loaded
	

#Returns LevelInfo from levels array
func get_level_info(index:String):
	if levels.has(index):
		return levels[index]
	else:
		push_warning('Level idx not found by GlobalManager')
		return null


func fade_out():
	#If there is a camera, centers the transition Control
	if get_viewport().get_camera_2d() != null:
		_st_node.global_position =  get_viewport().get_camera_2d().get_screen_center_position() - get_tree().root.content_scale_size*0.5
	else:
		_st_node.global_position = Vector2.ZERO
	
	if _st_node.has_method('set_text'): #if fade_out, do not show any text
		_st_node.set_text('')
	
	_st_node.get_animation_player().play_backwards('fade')
	#wait for animation_finished to complete before loading new level
	await _st_node.get_animation_player().animation_finished
	
	if _new_level != null:
		_load_scene()


func fade_in():
	#If there is a camera, centers the transition Control
	if get_viewport().get_camera_2d() != null:
		_st_node.global_position =  get_viewport().get_camera_2d().get_screen_center_position() - get_tree().root.content_scale_size*0.5
	else:
		_st_node.global_position = Vector2.ZERO
	_st_node.get_animation_player().play('fade')
	
	if _st_node.has_method('set_text'):
		_st_node.set_text(_new_level.level_name)
	
	#wait for animation_finished to complete before freeing transition Control
	await _st_node.get_animation_player().animation_finished
	_st_node.queue_free()


func _instantiate_transition(transition_ps):
	_st_node = transition_ps.instantiate()
	add_child(_st_node)
	_st_node.z_index = RenderingServer.CANVAS_ITEM_Z_MAX #puts the transition Control in front of all components


func _load_scene():
	current_scene.free() #free old scene
	var s = ResourceLoader.load(_new_level.level_resource_path) #new scene
	current_scene = s.instantiate() #load new scene
	current_scene.ready.connect(fade_in) #after the ready signal of the loaded scene, invoke fade_in()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	_new_level = null

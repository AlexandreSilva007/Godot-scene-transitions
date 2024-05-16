#Scene transitions base class. Derived classes MUST implement get_animtaion_player() method.
class_name SceneTransition extends Control

#Returns the scene transition AnimationPlayer
func get_animation_player():
	pass
	
#Set transition text, IF it exists
func set_text(txt):
	pass

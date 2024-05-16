extends CharacterBody2D

const SPEED = 6000.0
var mouse_move:bool = false

#player moves only by mouse left button hold
func _unhandled_input(event):
	if event.is_action_pressed("Click"):
		mouse_move = true
	elif event.is_action_released("Click"):
		mouse_move = false

func _physics_process(delta):
	if mouse_move:
		var mouse_pos = get_global_mouse_position()
		var dir = global_position.direction_to(mouse_pos)
		
		if global_position.distance_to(mouse_pos) > 30: #it´s not close enough
			velocity = dir*delta*SPEED
			move_and_slide()

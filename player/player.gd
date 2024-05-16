extends CharacterBody2D


const SPEED = 6000.0
var mouse_move:bool = false


func _unhandled_input(event):
	if event.is_action_pressed("Click"):
		mouse_move = true
	elif event.is_action_released("Click"):
		mouse_move = false

func _physics_process(delta):
	if mouse_move:
		var dir = global_position.direction_to(get_global_mouse_position())
		
		if global_position.distance_to(get_local_mouse_position()) > 50:
			velocity = dir*delta*SPEED
			move_and_slide()

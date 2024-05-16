extends Node2D


func _on_area_2d_body_entered(body):
	GlobalManager.goto_scene( $Area2D.level_name )


func _on_area_2d_2_body_entered(body):
	GlobalManager.goto_scene( $Area2D2.level_name )



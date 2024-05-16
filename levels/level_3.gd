
extends Node2D


func _on_area_2d_body_entered(body):
	#could be GlobalManager.goto_scene( "start" ,"sonic")
	GlobalManager.goto_scene( $Area2D.level_name ,"sonic")

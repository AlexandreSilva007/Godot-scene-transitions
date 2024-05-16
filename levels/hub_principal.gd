extends Node2D




func _on_area_2d_body_entered(body):
	print('Colidiu')
	print(body)
	GlobalManager.goto_scene( $Area2D.level_name )

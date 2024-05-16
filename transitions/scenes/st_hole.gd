extends SceneTransition

func get_animation_player():
	return $AnimationPlayer
	
func set_text(txt):
	$Label.text = txt

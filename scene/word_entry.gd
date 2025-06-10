extends Button

func fly_to(target_position: Vector2):
	var tween = create_tween()
	tween.tween_property(self, "global_position", target_position, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

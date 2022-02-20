extends TextureRect

var glow_amount = 2.0

func _on_statue_mouse_entered() -> void:
	$shadow.modulate = Color(glow_amount, glow_amount, glow_amount, glow_amount)


func _on_statue_mouse_exited() -> void:
	$shadow.modulate = Color(1, 1, 1, 1)

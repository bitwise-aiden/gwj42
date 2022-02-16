class_name Heart extends Sprite


# Public variables

export(Texture) var texture_empty: Texture
export(Texture) var texture_full: Texture


# Private variables

var __tween: Tween = Tween.new()


# Lifecycle methods

func _ready() -> void:
	add_child(__tween)


# Public methods

func set_full(full: bool) -> void:
	var position_original: Vector2 = position

	__tween.interpolate_property(
		self,
		"position",
		position,
		position - Vector2(0.0, 20.0),
		0.1
	)
	__tween.start()

	yield(__tween, "tween_completed")

	__tween.interpolate_property(
		self,
		"position",
		position,
		position_original,
		0.1
	)

	yield(__tween, "tween_completed")

	if full:
		texture = texture_full
	else:
		texture = texture_empty

class_name Scroll extends Node2D


# Private variables

onready var __prevent_mouse: ColorRect = $prevent_mouse
onready var __scroll_body: ColorRect = $scroll_body
onready var __scroll_bottom: NinePatchRect = $scroll_bottom
onready var __scroll_top: NinePatchRect = $scroll_top

onready var __content: Control = $content

onready var __start_position_y: float = __scroll_bottom.rect_position.y
onready var __start_size_y: float = __scroll_body.rect_size.y

onready var __audio_dict: Dictionary = {"bus": "effect", "choice": "paper", "loop": false}

var __tween: Tween = Tween.new()


# Lifecycle methods

func _ready() -> void:
	add_child(__tween)

	if __content:
		remove_child(__content)
		__scroll_body.add_child(__content)

		__content.rect_position.x = 0.0


# Public methods

func roll(duration: float = 0.3) -> void:
	__tween.interpolate_property(
		__scroll_bottom,
		"rect_position:y",
		__scroll_bottom.rect_position.y,
		__start_position_y,
		duration
	)

	__tween.interpolate_property(
		__scroll_body,
		"rect_size:y",
		__scroll_body.rect_size.y,
		__start_size_y,
		duration
	)

	__tween.interpolate_property(
		__prevent_mouse,
		"color:a",
		0.4,
		0.0,
		0.2
	)

	__tween.start()
	Event.emit_signal("emit_audio", __audio_dict)
	yield(__tween,"tween_all_completed")

	__prevent_mouse.visible = false


func unroll(duration: float = 0.5) -> void:
	var size: float = 0.0
	if __content:
		size = __content.rect_size.y

	__prevent_mouse.visible = true

	__tween.interpolate_property(
		__scroll_bottom,
		"rect_position:y",
		__start_position_y,
		__start_position_y + size,
		duration
	)

	__tween.interpolate_property(
		__scroll_body,
		"rect_size:y",
		__start_size_y,
		__start_size_y + size,
		duration
	)

	__tween.interpolate_property(
		__prevent_mouse,
		"color:a",
		0.0,
		0.4,
		0.2
	)

	Event.emit_signal("emit_audio", __audio_dict)
	__tween.start()

	yield(__tween,"tween_all_completed")


# Private methods

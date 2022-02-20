extends Control

# Private variables

onready var __button_play: Button = $buttons/button_play


# Lifecycle methods

func _ready() -> void:
	__button_play.connect("pressed", Event, "emit_signal", ["change_menu", "main"])

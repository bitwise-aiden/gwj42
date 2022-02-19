extends Control

# Private variables

onready var __button_back: Button = $button_back


# Lifecycle methods

func _ready() -> void:
	__button_back.connect("pressed", Event, "emit_signal", ["change_menu", "main"])

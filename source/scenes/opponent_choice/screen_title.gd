extends Control

# Private variables

onready var __button_options: Button = $buttons/button_options
onready var __button_play: Button = $buttons/button_play
onready var __button_quit: Button = $buttons/button_quit
onready var __button_tutorial: Button = $buttons/button_tutorial


# Lifecycle methods

func _ready() -> void:
	__button_options.connect("pressed", Event, "emit_signal", ["change_menu", "options"])
	__button_play.connect("pressed", Event, "emit_signal", ["change_menu", "game"])
	__button_quit.connect("pressed", Event, "emit_signal", ["change_menu", "quit"])
	__button_tutorial.connect("pressed", Event, "emit_signal", ["change_menu", "tutorial"])


	var audio_dict = {"bus": "effect", "choice": "menu_select", "loop": false}
	__button_options.connect("button_down", AudioManager, "play_audio", [audio_dict])
	__button_play.connect("button_down", AudioManager, "play_audio", [audio_dict])
	__button_quit.connect("button_down", AudioManager, "play_audio", [audio_dict])
	__button_tutorial.connect("button_down", AudioManager, "play_audio", [audio_dict])

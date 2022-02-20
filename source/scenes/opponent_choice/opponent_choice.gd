extends Control

onready var opponent_one_spot = get_node("opponent_one_spot")
onready var opponent_two_spot = get_node("opponent_two_spot")

var opponent_array = Array()
var god_data = preload("res://source/data/god_data_table.gd")
var gods


# Private variables

onready var __scroll: Scroll = $scroll
onready var __screen_title: Control = $scroll/scroll_body/content/screen_title
onready var __screen_tutorial: Control = $scroll/scroll_body/content/screen_tutorial
onready var __screen_options: Control = $scroll/scroll_body/content/screen_options

onready var __scroll_position_y: float = __scroll.position.y

var __tween: Tween = Tween.new()

var __opponent_button_1: opponent_button
var __opponent_button_2: opponent_button


# Lifecycle methods

func _ready():
	add_child(__tween)

	add_opponents()

	__scroll.position.y -= 300.0

	Event.connect("change_menu", self, "__change_menu")

	# Play menu music
	var audio_dict = {"bus": "music", "choice": "menu", "loop": false}
	Event.emit_signal("emit_audio", audio_dict)

	yield(Transition.stop(), "completed")

	if !GameState.playing:
		__tween.interpolate_property(
			__scroll,
			"position:y",
			__scroll.position.y,
			__scroll_position_y,
			0.5
		)
		__tween.start()

		yield(__tween,"tween_all_completed")
		yield(__scroll.unroll(), "completed")



func add_opponents():
	GameState.randomize_opponents()

	if __opponent_button_1:
		opponent_one_spot.remove_child(__opponent_button_1)
		__opponent_button_1.queue_free()

	__opponent_button_1 = opponent_button.new(GameState.opponent_option_0)
	opponent_one_spot.add_child(__opponent_button_1)

	if __opponent_button_2:
		opponent_two_spot.remove_child(__opponent_button_2)
		__opponent_button_2.queue_free()

	__opponent_button_2 = opponent_button.new(GameState.opponent_option_1)
	opponent_two_spot.add_child(__opponent_button_2)


# Private methods

func __change_menu(menu_name: String) -> void:
	yield(__scroll.roll(), "completed")

	match menu_name:
		"game":
			GameState.initialize()
			add_opponents()

			__tween.interpolate_property(
				__scroll,
				"position:y",
				__scroll.position.y,
				__scroll.position.y - 300.0,
				0.5
			)

			__tween.start()

			yield(__tween, "tween_all_completed")
		"quit":
			__tween.interpolate_property(
				__scroll,
				"position:y",
				__scroll.position.y,
				__scroll.position.y - 300.0,
				0.5
			)

			__tween.start()

			yield(__tween, "tween_all_completed")

			get_tree().quit()
		_:
			__screen_title.visible = menu_name == "main"
			__screen_tutorial.visible = menu_name == "tutorial"
			__screen_options.visible = menu_name == "options"

			yield(__scroll.unroll(), "completed")

extends Control

onready var opponent_one_spot = get_node("opponent_one_spot")
onready var opponent_two_spot = get_node("opponent_two_spot")

var opponent_array = Array()
var god_data = preload("res://source/data/god_data_table.gd")
var gods


# Private variables

onready var __button_settings: Button = $button_settings
onready var __scroll: Scroll = $scroll
onready var __screen_title: Control = $scroll/scroll_body/content/screen_title
onready var __screen_tutorial: Control = $scroll/scroll_body/content/screen_tutorial
onready var __screen_options: Control = $scroll/scroll_body/content/screen_options
onready var __screen_won: Control = $scroll/scroll_body/content/screen_won

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
	__button_settings.connect("pressed", self, "__open_menu", ["options"])

	# Play menu music
	var audio_dict = {"bus": "music", "choice": "menu", "loop": false}
	Event.emit_signal("emit_audio", audio_dict)

	yield(Transition.stop(), "completed")

	if !GameState.playing:
		yield(__open_menu("main"), "completed")




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

	if GameState.zeus_active && __opponent_button_1.opponent_name == "" && __opponent_button_2.opponent_name == "":
		yield(__open_menu("won"), "completed")


# Private methods

func __change_menu(menu_name: String) -> void:
	yield(__scroll.roll(), "completed")

	if GameState.playing && !menu_name in ["options", "won"]:
		__tween.interpolate_property(
			__scroll,
			"position:y",
			__scroll.position.y,
			__scroll.position.y - 300.0,
			0.5
		)

		__tween.start()

		yield(__tween, "tween_all_completed")
		return

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
			__screen_won.visible = menu_name == "won"

			yield(__scroll.unroll(), "completed")

		if menu_name == "won":
			GameState.playing = false


func __open_menu(menu_name: String) -> void:
	__tween.interpolate_property(
		__scroll,
		"position:y",
		__scroll.position.y,
		__scroll_position_y,
		0.5
	)
	__tween.start()

	yield(__tween, "tween_all_completed")
	yield(__change_menu(menu_name), "completed")

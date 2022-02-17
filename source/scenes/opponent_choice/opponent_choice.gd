extends Control

onready var opponent_one_spot = get_node("opponent_one_spot")
onready var opponent_two_spot = get_node("opponent_two_spot")

var opponent_array = Array()
var god_data = preload("res://source/data/god_data_table.gd")
var gods


func _ready():
	add_opponents()

	# Play menu music
	var audio_dict = {"bus": "music", "choice": "menu", "loop": false}
	Event.emit_signal("emit_audio", audio_dict)



func add_opponents():
	GameState.randomize_opponents()

	opponent_one_spot.add_child(opponent_button.new(GameState.opponent_option_0))
	opponent_two_spot.add_child(opponent_button.new(GameState.opponent_option_1))


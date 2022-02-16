extends Control

onready var opponent_one_spot = get_node("opponent_one_spot")
onready var opponent_two_spot = get_node("opponent_two_spot")

var rng = RandomNumberGenerator.new()

var opponent_array = Array()
var file = File.new()
var gods_file = file.open("res://source/data/gods.json", file.READ)
var gods_text = file.get_as_text()
var gods

#change these values when an opponent is defeated
var opponent_one = 0
var opponent_two = 1

func _ready():
	gods = JSON.parse(gods_text).result

	if typeof(gods) == TYPE_DICTIONARY:
		fill_opponents_array()
		add_opponents()
	else:
		push_error("Unexpected results from parsing gods.")
	

func fill_opponents_array():
	for god in gods:
		opponent_array.append(opponent_button.new(gods[god]["name"], gods[god]["description"]))

func add_opponents():
	rng.randomize()
	opponent_one_spot.add_child(opponent_array[rng.randi_range(0,opponent_array.size() -1)])
	opponent_two_spot.add_child(opponent_array[rng.randi_range(0,opponent_array.size() -1)])


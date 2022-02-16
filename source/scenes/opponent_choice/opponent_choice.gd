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
	rng.randomize()
	for god in gods:
		if god == "zeus":
			pass
		else:
			opponent_array.append(opponent_button.new(gods[god]["name"], gods[god]["description"]))
	opponent_array.shuffle()
	opponent_array.append(opponent_button.new(gods["zeus"]["name"], gods["zeus"]["description"]))


func add_opponents():
#	rng.randomize()
#	var number_one = rng.randi_range(0,opponent_array.size() -1)
#	var number_two = rng.randi_range(0,opponent_array.size() -1)
#	while number_one == number_two:
#		number_two = rng.randi_range(0,opponent_array.size() -1)
	if opponent_array.size() < 2:
		opponent_array.empty()
		fill_opponents_array()
	opponent_one_spot.add_child(opponent_array.pop_front())
	opponent_two_spot.add_child(opponent_array.pop_front())


extends Control

onready var opponent_one_spot = get_node("opponent_one_spot")
onready var opponent_two_spot = get_node("opponent_two_spot")

var rng = RandomNumberGenerator.new()

var opponent_array = Array()
var god_data = preload("res://source/data/god_data_table.gd")
var gods

#change these values when an opponent is defeated
var opponent_one = 0
var opponent_two = 1

func _ready():
	gods = god_data.new()
	fill_opponents_array()
	add_opponents()

	# Play menu music
	var audio_dict = {"bus": "music", "choice": "menu", "loop": false}
	Event.emit_signal("emit_audio", audio_dict)


func fill_opponents_array():
	rng.randomize()
	print(gods.get_data())
	var temp = gods.get_data()
	for god in temp:
		if god == "zeus":
			pass
		else:
			opponent_array.append(opponent_button.new(temp[god]["name"], temp[god]["description"]))
	opponent_array.shuffle()
	opponent_array.append(opponent_button.new(temp["zeus"]["name"], temp["zeus"]["description"]))



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


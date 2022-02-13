extends Control

onready var opponent_one_spot = get_node("opponent_one_spot")
onready var opponent_two_spot = get_node("opponent_two_spot")

var opponent_array = Array()
# lowercase names of all the gods.
var opponent_names = ["zeus", "thor"]

#change these values when an opponent is defeated
var opponent_one = 0
var opponent_two = 1

func _ready():
	fill_opponents_array(2)
	add_opponents()
	
func fill_opponents_array(var opponents):
	for i in range(opponents):
		opponent_array.append(opponent_button.new(opponent_names[i]))
	
func add_opponents():
	#Something here isn't working as intended
	opponent_one_spot.add_child(opponent_array[opponent_one])
	opponent_two_spot.add_child(opponent_array[opponent_two])


extends Node


# Public methods

var current_god: String
var god_data: Dictionary = {}

var opponents_current: Array = []
var opponents_previous: Array = []

var opponent_option_0: String
var opponent_option_1: String

var player_profile: Texture
var player_name: String


# Lifecycle methods

func _ready() -> void:
	randomize()


# Public methods

func initialize() -> void:
	var gods: GodDataTable = GodDataTable.new()
	god_data = gods.get_data()

	for god in god_data:
		if god in ["zeus", "hades"]:
			pass
		else:
			opponents_current.append(god)

	opponents_current.shuffle()

	opponents_current.append("zeus")

	match randi() % 4:
		0:
			player_profile = load("res://assets/sprites/player/liioni_portrait.png")
			player_name = "Lil'Oni"
		1:
			player_profile = load("res://assets/sprites/player/dave_portrait.png")
			player_name = "Dave"
		2:
			player_profile = load("res://assets/sprites/player/orbit_portrait.png")
			player_name = "Orbit"
		3:
			player_profile = load("res://assets/sprites/player/velop_portrait.png")
			player_name = "velop"


func current_god_data() -> GodData:
	return god_data[current_god]


func kill(opponent: String) -> void:
	opponents_previous.append(opponent)

	if opponent_option_0 == opponent:
		opponent_option_0 = ""
	else:
		opponent_option_1 = ""


func pick_opponent(opponent: String) -> void:
	current_god = opponent


func randomize_opponents() -> void:
	# This is for infinite loop
	if opponents_current.size() < 2:
		opponents_current.empty()
		initialize()

	if !opponent_option_0:
		opponent_option_0 = opponents_current.pop_front()

	if !opponent_option_1:
		opponent_option_1 = opponents_current.pop_front()


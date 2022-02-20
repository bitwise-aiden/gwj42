extends Node


# Public methods

var playing: bool = false
var zeus_active: bool = false

var current_god: String
var god_data: Dictionary = {}

var opponents_amon: Array = []
var opponents_current: Array = []
var opponents_previous: Array = []

var opponent_option_0: String = ""
var opponent_option_1: String = ""

var player_profile: Texture
var player_name: String


# Lifecycle methods

func _ready() -> void:
	randomize()


# Public methods

func initialize() -> void:
	playing = true
	zeus_active = false

	opponents_amon.clear()
	opponents_current.clear()
	opponents_previous.clear()

	var gods: GodDataTable = GodDataTable.new()
	god_data = gods.get_data()

	for god in god_data:
		if god in ["amon_ra_paper", "amon_ra_scissors", "amon_ra_rock"]:
			opponents_amon.append(god)
		elif god in ["zeus", "hades"]:
			pass
		else:
			opponents_current.append(god_data[god].id)

	opponents_amon.shuffle()
	opponents_current.shuffle()

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
	if !playing:
		return

	if !opponent_option_0:
		opponent_option_0 = __get_next_god()

	if !opponent_option_1:
		opponent_option_1 = __get_next_god()


# Private method

func __get_next_god() -> String:
	# Start of the game case
	if opponents_previous.empty():
		return opponents_current.pop_front()

	if !opponents_current.empty():
		if opponent_option_0.begins_with("amon") || opponent_option_1.begins_with("amon"):
			return opponents_current.pop_front()

		if opponents_previous[-1].begins_with("amon"):
			return opponents_current.pop_front()

	if !opponents_amon.empty():
		return opponents_amon.pop_front()

	if !zeus_active && !opponent_option_0 && !opponent_option_1:
		zeus_active = true
		Event.emit_signal("zeus")
		return "zeus"

	return ""




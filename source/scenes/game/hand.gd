class_name Hand extends Node2D


# Public variables

export(bool) var can_interact: bool = true


# Private variables

onready var __positions: Array = $positions.get_children()
onready var __runes: Array = $runes.get_children()
onready var __triggers: Array = $triggers.get_children()

var __active_plinth: Plinth = null
var __active_rune_index: int = -1
var __following: bool = false

# Lifecycle methods

func _ready() -> void:
	if !can_interact:
		return

	for i in __triggers.size():
		__triggers[i].connect("mouse_entered", self, "__rune_activate", [i])
		__triggers[i].connect("mouse_exited", self, "__rune_deactivate", [i])


func _process(delta: float) -> void:
	if __active_rune_index == -1 || __runes[__active_rune_index] == null:
		return

	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		__following = true

		__runes[__active_rune_index].global_position = get_viewport().get_mouse_position()
	elif __following:
		__following = false

		if __active_plinth:
			var position: Position2D = __active_plinth.next_position()
			if position:
				__runes[__active_rune_index].move(position.global_position, false)

				__runes[__active_rune_index] = null

				return

		__runes[__active_rune_index].hover_stop(__positions[__active_rune_index].global_position)
		__active_rune_index = -1


# Public methods

func add(rune: Rune) -> void:
	__runes.append(rune)


func next_position() -> Position2D:
	if __runes.size() <= __positions.size():
		return __positions[__runes.size()]

	return null


# Private methods

func __plinth_activate(plinth: Plinth) -> void:
	__active_plinth = plinth


func __plinth_deactivate(plinth: Plinth) -> void:
	if __active_plinth == plinth:
		__active_plinth = null


func __rune_activate(rune_index: int) -> void:
	if __following || rune_index >= __runes.size() || __runes[rune_index] == null:
		return

	__runes[rune_index].hover_start()

	__active_rune_index = rune_index


func __rune_deactivate(rune_index: int) -> void:
	if rune_index >= __runes.size() || __runes[rune_index] == null:
		return

	__runes[rune_index].hover_stop(__positions[rune_index].global_position)

	if __active_rune_index == rune_index && !__following:
		__active_rune_index = -1

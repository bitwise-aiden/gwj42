class_name Hand extends Node2D


# Public variables

export(bool) var can_interact: bool = true

var active_rune: Rune = null


# Private variables

onready var __positions: Array = $positions.get_children()
onready var __runes: Array = []
onready var __triggers: Array = $triggers.get_children()

var __active_plinth: Plinth = null
var __active_rune_index: int = -1
var __following: bool = false


# Lifecycle methods

func _ready() -> void:
	for _position in __positions:
		__runes.append(null)

	if !can_interact:
		return

	for i in __triggers.size():
		__triggers[i].connect("mouse_entered", self, "__rune_activate", [i])
		__triggers[i].connect("mouse_exited", self, "__rune_deactivate", [i])


# Public methods

func add(rune: Rune) -> void:
	for i in __runes.size():
		if __runes[i] == null:
			__runes[i] = rune

			yield(rune.move(__positions[i].global_position, can_interact), "completed")

			break


func can_add() -> bool:
	for i in __runes.size():
		if __runes[i] == null:
			return true

	return false


func deactivate_rune(rune: Rune) -> void:
	for i in __runes.size():
		if __runes[i] == rune:
			__runes[i].hover_stop(__positions[i].global_position, true)


func runes() -> Array:
	var remaining: Array = []

	for rune in __runes:
		if rune != null:
			remaining.append(rune)

	return remaining


func remove(rune: Rune) -> void:
	for i in __runes.size():
		if __runes[i] == rune:
			__runes[i] = null

# Private methods

func __rune_activate(rune_index: int) -> void:
	if __runes[rune_index] == null:
		return

	active_rune = __runes[rune_index]
	active_rune.hover_start()
	


func __rune_deactivate(rune_index: int) -> void:
	if __runes[rune_index] == active_rune:
		active_rune = null

	if __runes[rune_index] == null:
		return

	__runes[rune_index].hover_stop(__positions[rune_index].global_position)

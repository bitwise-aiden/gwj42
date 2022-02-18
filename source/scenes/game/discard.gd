class_name Discard extends Node2D


# Private variables

onready var __runes: Array = []


# Public methods

func add(rune: Rune, move: bool = true) -> void:
	__runes.append(rune)

	if move:
		yield(rune.move(global_position, false, z_index), "completed")


func empty() -> bool:
	return __runes.empty()


func shuffle() -> void:
	__runes.shuffle()


func pop() -> Rune:
	var rune: Rune = __runes.pop_back()

	rune.get_parent().move_child(rune, Globals.DECK_SIZE_MAX - 1 - __runes.size())

	return rune

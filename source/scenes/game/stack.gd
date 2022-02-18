class_name Stack extends Node2D


# Private variables

onready var __runes: Array = []
onready var __next_position: Vector2 = global_position


# Public methods

func add(rune: Rune) -> void:
	var rune_position: Vector2 = __next_position

	__next_position = rune_position + Vector2(randf() * 10.0 - 5.0, -20.0)

	__runes.append(rune)

	yield(rune.move(rune_position, false, z_index), "completed")


func empty() -> bool:
	return __runes.empty()


func pop() -> Rune:
	__next_position = __runes[-1].global_position

	return __runes.pop_back()

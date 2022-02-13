class_name Stack extends Node2D


# Private variables

onready var __runes: Array = $runes.get_children()
onready var __next_position: Vector2 = global_position


# Lifecycle methods

func _ready() -> void:
	var offset: float = 0.0

	for rune in __runes:
		rune.position += Vector2(offset, 0.0)

		offset += randf() * 10.0 - 5.0
		offset = clamp(offset, -20.0, 20.0)


# Public methods

func add(rune: Rune) -> void:
	var rune_position: Vector2 = __next_position

	__next_position = rune_position + Vector2(randf() * 10.0 - 5.0, -20.0)

	__runes.append(rune)

	yield(rune.move(rune_position, false), "completed")


func top() -> Rune:
	return __runes[-1]


func pop() -> Rune:
	return __runes.pop_back()

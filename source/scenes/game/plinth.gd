class_name Plinth extends Sprite


# Public varaibles

onready var hover_area: Area2D = $hover_area


# Private variables

onready var __rune_position: Position2D = $rune_position;

var __rune: Rune = null


# Public variables

func add(rune: Rune) -> void:
	__rune = rune

	yield(rune.move(__rune_position.global_position, false), "completed")


func can_add() -> bool:
	return __rune == null

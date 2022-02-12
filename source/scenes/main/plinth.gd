class_name Plinth extends Sprite


# Public varaibles

onready var hover_area: Area2D = $hover_area


# Private variables

onready var __rune_position: Position2D = $rune_position;

var __rune: Rune = null


# Public variables

func next_position() -> Position2D:
	if __rune:
		return null

	return __rune_position

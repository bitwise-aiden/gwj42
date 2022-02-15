extends Node


# Time globals

# Current rate of time passing.
#	1.0 is default
#	< 1.0 is slowed down
#	> 1.0 is speed up
var time_modifier: float = 1.0


# Game globals

const DECK_SIZE_MAX: int = 9

# This polygon is used with the Geometry class
# to check where the runes land, to control dust.
var plinth_check_polygon

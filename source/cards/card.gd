class_name Card


# Public enums

enum Types { PARCHMENT, SHEARS, STONE }
enum Elements { NORMAL }


# Private variables

var type: int = 0
var element: int = 0


# Lifecycle methods

func _init(type: int, element: int) -> void:
	self.type = type
	self.element = element


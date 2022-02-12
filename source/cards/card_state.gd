class_name CardState


# Public variables

var card: Card = null
var used: bool = false


# Lifecycle methods

func _init(card, used) -> void:
	self.card = card
	self.used = used

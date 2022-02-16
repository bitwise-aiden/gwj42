class_name PlayerState


# Public variables

var hand: Array = []
var health: int = 0
var plinths: Array = []


# Lifecycle methods

func _init(health: int, plinths: Array, hand: Hand) -> void:
	self.health = health

	for plinth in plinths:
		var rune: Rune = plinth.get_rune()
		if rune:
			self.plinths.append(rune.card_state.card.type)
		else:
			self.plinths.append(null)

	for rune in hand.runes():
		self.hand.append(rune.card_state.card.type)


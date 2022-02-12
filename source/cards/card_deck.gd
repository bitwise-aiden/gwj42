class_name CardDeck


# Public variables

var cards: Array = []


# Public methods

func add(card_state: CardState) -> void:
	cards.append(card_state)


func remove(card_state: CardState) -> void:
	var index: int = cards.find(card_state)

	if index == -1:
		return

	cards.remove(index)

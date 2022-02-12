class_name CardPool


# Private constants

const __CARD_COUNT_PER_TYPE: int = 3
const __CARD_COUNT_PER_ELEMENT: int = 1


# Public variables

var cards: Array = []


# Lifecycle methods

func _init(element: int = Card.Elements.NORMAL) -> void:
	for i in __CARD_COUNT_PER_TYPE:
		var card_element: int = Card.Elements.NORMAL
		if i < __CARD_COUNT_PER_ELEMENT:
			card_element = element

		for type in Card.Types.size():
			var card: Card = Card.new(
				type,
				card_element
			)

			add(card)


# Public methods

func add(card: Card) -> void:
	var card_state: CardState = CardState.new(
		card,
		false
	)

	cards.append(card_state)


func size() -> int:
	return cards.size()

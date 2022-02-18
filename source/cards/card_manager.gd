class_name CardManager


# Public variables

var deck: CardDeck = null
var pool: CardPool = null
var element: int = Card.Elements.NORMAL


# Lifecycle methods

func _init(deck: Array = [3, 3, 3], element: int = Card.Elements.NORMAL) -> void:
	self.deck = CardDeck.new()
	self.pool = CardPool.new(deck, element)
	self.element = element

	for card_state in pool.cards:
		add_deck(card_state)


# Public methods

func add_pool(card: Card) -> void:
	pool.add(card)


func add_deck(card_state: CardState) -> void:
	if card_state.used:
		return

	deck.add(card_state)
	card_state.used = true


func remove_deck(card_state: CardState) -> void:
	if !card_state.used:
		return

	deck.remove(card_state)
	card_state.used = false

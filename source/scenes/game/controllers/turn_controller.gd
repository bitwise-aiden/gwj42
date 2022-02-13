class_name TurnController extends Node


# Private constants

const _RUNE_SCENE: PackedScene = preload("res://source/scenes/game/rune.tscn")


# Private variables

var _deck: CardDeck = null
var _discard: Discard = null
var _hand: Hand = null
var _plinths: Array = []
var _stack: Stack = null


# Lifecycle methods

func _init(
	discard: Discard,
	hand: Hand,
	plinths: Array,
	stack: Stack
) -> void:
	_discard = discard
	_hand = hand
	_plinths = plinths
	_stack = stack


# Public methods

func draw() -> void:
	while _hand.can_add():
		if _stack.empty():
			yield(__shuffle_discard(), "completed")

		var rune: Rune = _stack.pop()

		yield(_hand.add(rune), "completed")


func set_deck(deck: CardDeck) -> void:
	_deck = deck

	__initialize_discard()


# Private methods

func __initialize_discard() -> void:
	for card_state in _deck.cards:
		var rune: Rune = _RUNE_SCENE.instance()
		rune.global_position = _discard.global_position
		rune.card_state = card_state

		add_child(rune)

		_discard.add(rune, false)


func __shuffle_discard() -> void:
	_discard.shuffle()

	while !_discard.empty():
		var rune: Rune = _discard.pop()

		yield(_stack.add(rune), "completed")

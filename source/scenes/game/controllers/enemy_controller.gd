class_name EnemyTurnController extends TurnController


# Private constants

const __MATCH_MAPPING: Dictionary = {
	Card.Types.PARCHMENT: [Card.Types.SHEARS, Card.Types.PARCHMENT, Card.Types.STONE],
	Card.Types.SHEARS: [Card.Types.STONE, Card.Types.SHEARS, Card.Types.PARCHMENT],
	Card.Types.STONE: [Card.Types.PARCHMENT, Card.Types.STONE, Card.Types.SHEARS]
}

# Lifecycle methods

func _init(
	discard: Discard,
	hand: Hand,
	hearts: Array,
	plinths: Array,
	stack: Stack
).(discard, hand, hearts, plinths, stack) -> void:
	pass


# Public methods

func pick_rune(opponent: PlayerState) -> void:
	print("Other player has %d health" % opponent.health)

	__generate_options(opponent)

	match opponent.health:
		5,4:
			__pick_rune_hard()
		3,2:
			__pick_rune_medium()
		1:
			__pick_rune_easy(opponent)


# Private methods

func __pick_rune_hard() -> void:
	#
	# Yes, I am calling `randi` the hard AI.
	# You try playing against it and tell me it isn't ;p
	#
	var plinths_ordered: Array = []

	for plinth in _plinths:
		if randi() % 2 == 0:
			plinths_ordered.push_front(plinth)
		else:
			plinths_ordered.push_back(plinth)

	for plinth in plinths_ordered:
		if plinth.can_add():
			var runes: Array = _hand.runes()
			var rune: Rune = runes[randi() % runes.size()]

			_hand.remove(rune)
			yield(plinth.add(rune), "completed")

			emit_signal("rune_picked", PlayerState.new(_health, _plinths, _hand))

			break


func __pick_rune_medium() -> void:
	__pick_rune_hard()


func __pick_rune_easy(opponent: PlayerState) -> void:
	__pick_rune_hard()


func __generate_options(opponent: PlayerState) -> void:
#	var opponent_options: Array = []
#
#	for plinth in opponent.plinths:
#		if plinth == null:
#			opponent_options.append(opponent.hand)
#		else:
#			opponent_options.append(plinth)
	var state: PlayerState = PlayerState.new(_health, _plinths, _hand)
	var opponent_options: Dictionary = {}

	var null_index: int = opponent.plinths.has(null)
	if null_index == -1:
		opponent_options[opponent.plinths] = null
	else:
		for type in opponent.hand:
			var plinths: Array = opponent.plinths.duplicate()
			plinths[null_index] = type

			opponent_options[plinths] = null

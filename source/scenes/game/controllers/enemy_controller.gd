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
	var state: PlayerState = PlayerState.new(_health, _plinths, _hand)

	var options: Array = __generate(state.hand, state.plinths)
	var opponent_options: Array = __generate(opponent.hand, opponent.plinths)

	var potential_results: Dictionary = {
		-1: [],
		+0: [],
		+1: []
	}

	for opponent_option in opponent_options:
		for option in options:
			var score: int = __score(option, opponent_option)
			potential_results[score].append(option)


	var option: Array = []

	while option.empty():
		pass
		match 1:
			1:
				pass # find option with 100% lose chance
			2:
				pass # find option with 100% not win chance
			3:
				pass # find option with 100% draw chance
			4:
				pass # find option with potential win chance
			5:
				pass # find option with 100% win chance


func __generate(cards: Array, plinths: Array) -> Array:
	if !plinths.has(null):
		return [plinths]

	var options: Dictionary = {}

	for i in plinths.size():
		if plinths[i] == null:
			for card in cards:
				var plinths_copy: Array = plinths.duplicate()
				plinths_copy[i] = card

				if plinths_copy.has(null):
					var cards_copy: Array = cards.duplicate()
					var card_index: int = cards_copy.find(card)
					cards_copy.remove(card_index)

					for option in __generate(cards_copy, plinths_copy):
						options[option] = null
				elif !options.has(plinths_copy):
					options[plinths_copy] = null

	return options.keys()


func __score(a: Array, b: Array) -> int:
	var result: int = 0

	for i in a.size():
		match [a[i], b[i]]:
			[0, 1], [1, 2], [2, 0]:
				result -= 1

			[1, 0], [2, 1], [0, 2]:
				result += 1

	return int(sign(float(result)))

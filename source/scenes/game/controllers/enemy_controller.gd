class_name EnemyTurnController extends TurnController


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

func pick_rune() -> void:
	for plinth in _plinths:
		if plinth.can_add():
			var runes: Array = _hand.runes()
			var rune: Rune = runes[randi() % runes.size()]

			_hand.remove(rune)
			yield(plinth.add(rune), "completed")

			emit_signal("rune_picked")

			break

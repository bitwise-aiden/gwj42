extends Node2D


# Private variables

var __enemy_controller: EnemyTurnController = null
var __enemy_manager: CardManager = null
var __player_controller: PlayerTurnController = null
var __player_manager: CardManager = null


# Lifecycle methods

func _ready() -> void:
	randomize()

	__enemy_controller = EnemyTurnController.new(
		$enemy_discard,
		$enemy_hand,
		$enemy_plinths.get_children(),
		$enemy_stack
	)
	add_child(__enemy_controller)

	__enemy_manager = CardManager.new()
	__enemy_controller.set_deck(__enemy_manager.deck)
	__enemy_controller.connect("died", self, "__controller_died", [false])

	__player_controller = PlayerTurnController.new(
		$player_discard,
		$player_hand,
		$player_plinths.get_children(),
		$player_stack
	)
	add_child(__player_controller)

	__player_manager = CardManager.new()
	__player_controller.set_deck(__player_manager.deck)
	__player_controller.connect("died", self, "__controller_died", [true])

	__player_controller.connect("rune_picked", __enemy_controller, "pick_rune")

	__game_loop()


# Private methods

func __controller_died(was_player: bool) -> void:
	print("controller died, was player: %s" % was_player)


func __game_loop() -> void:
	while true: # TODO: once health is in, wait until player dead
		__enemy_controller.draw()
		yield(__player_controller.draw(), "completed")

		yield(__enemy_controller, "rune_picked")
		yield(__enemy_controller, "rune_picked")

		__enemy_controller.flip()
		yield(__player_controller.flip(), "completed")

		yield(__score_round(), "completed")

		__enemy_controller.discard()
		yield(__player_controller.discard(), "completed")


func __score_round() -> void:
	var enemy_runes: Array = __enemy_controller.get_runes()
	var player_runes: Array = __player_controller.get_runes()

	var result: int = 0

	for i in player_runes.size():
		var enemy_rune: Rune = enemy_runes[i]
		var player_rune: Rune = player_runes[i]

		match [player_rune.card_state.card.type, enemy_rune.card_state.card.type]:
			[0, 1], [1, 2], [2, 0]:
				yield(enemy_rune.attack(player_rune), "completed")
				result -= 1

			[1, 0], [2, 1], [0, 2]:
				yield(player_rune.attack(enemy_rune), "completed")
				result += 1

			_:
				enemy_rune.move(enemy_rune.global_position)
				yield(player_rune.move(player_rune.global_position), "completed")

	if result > 0:
		__enemy_controller.damage(result)
	else:
		__player_controller.damage(abs(result))

	print("player: %s, enemy: %s" %[__player_controller.__health, __enemy_controller.__health])

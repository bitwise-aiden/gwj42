extends Node2D


# Private variables

var __enemy_controller: EnemyTurnController = null
var __enemy_manager: CardManager = null
var __player_controller: PlayerTurnController = null
var __player_manager: CardManager = null


# Lifecycle methods

func _ready() -> void:
	__enemy_controller = EnemyTurnController.new(
		$enemy_discard,
		$enemy_hand,
		$enemy_plinths.get_children(),
		$enemy_stack
	)
	add_child(__enemy_controller)

	__enemy_manager = CardManager.new()
	__enemy_controller.set_deck(__enemy_manager.deck)
	__enemy_controller.draw()

	__player_controller = PlayerTurnController.new(
		$player_discard,
		$player_hand,
		$player_plinths.get_children(),
		$player_stack
	)
	add_child(__player_controller)

	__player_manager = CardManager.new()
	__player_controller.set_deck(__player_manager.deck)
	__player_controller.draw()

	__player_controller.connect("rune_picked", __enemy_controller, "pick_rune")

	__game_loop()


# Private methods

func __game_loop() -> void:
	while true: # TODO: once health is in, wait until player dead
		yield(__enemy_controller, "rune_picked")
		yield(__enemy_controller, "rune_picked")

		__enemy_controller.flip()
		yield(__player_controller.flip(), "completed")

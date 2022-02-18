extends Node2D


# Private constants

const __RESULT_TEXT = "%s won!"


# Private variables

onready var __label_end_result: Label = $ui/screen_end/label_result
onready var __label_round_result: Label = $ui/screen_round/label_result
onready var __label_opponent_name: Label = $ui/screen_game/label_opponent_name
onready var __button_menu: Button = $ui/screen_end/buttons/button_menu
onready var __button_next: Button = $ui/screen_end/buttons/button_next
onready var __button_replay: Button = $ui/screen_end/buttons/button_replay
onready var __screen_end: Control = $ui/screen_end
onready var __screen_game: Control = $ui/screen_game
onready var __screen_round: Control = $ui/screen_round
onready var __speech_bubble: SpeechBubble = $ui/screen_game/speech_bubble
onready var __texture_rect_opponent: TextureRect = $ui/screen_game/texture_rect_opponent

var __enemy_controller: EnemyTurnController = null
var __enemy_manager: CardManager = null
var __player_controller: PlayerTurnController = null
var __player_manager: CardManager = null

var __alive: bool = true
var __god_data: GodData


# Lifecycle methods

func _ready() -> void:
	Globals.plinth_check_polygon = $plinth_check_polygon.polygon
	randomize()

	__enemy_controller = EnemyTurnController.new(
		$enemy_discard,
		$enemy_hand,
		$enemy_hearts.get_children(),
		$enemy_plinths.get_children(),
		$enemy_stack
	)
	add_child(__enemy_controller)

	__enemy_manager = CardManager.new()
	__enemy_controller.set_deck(__enemy_manager.deck)
	__enemy_controller.connect("died", self, "__controller_died", [false])

	var player_hearts: Array = $player_hearts.get_children()
	player_hearts.invert()

	__player_controller = PlayerTurnController.new(
		$player_discard,
		$player_hand,
		player_hearts,
		$player_plinths.get_children(),
		$player_stack
	)
	add_child(__player_controller)

	__player_manager = CardManager.new()
	__player_controller.set_deck(__player_manager.deck)
	__player_controller.connect("died", self, "__controller_died", [true])

	__player_controller.connect("rune_picked", __enemy_controller, "pick_rune")

	__button_menu.connect("pressed", SceneManager, "load_scene", ["menu"])
	__button_next.connect("pressed", SceneManager, "load_scene", ["opponent_choice"])
	__button_replay.connect("pressed", SceneManager, "load_scene", ["game"])

	# Play menu music
	var audio_dict = {"bus": "music", "choice": "battle", "loop": false}
	Event.emit_signal("emit_audio", audio_dict)

	__god_data = GameState.current_god_data()
	__label_opponent_name.text = __god_data.name
	__texture_rect_opponent.texture = __god_data.texture()

	yield(Transition.stop(), "completed")

	__enemy_controller.heal()
	__player_controller.heal()

	__speech_bubble.show_text(__god_data.message("open_taunt"))

	__game_loop()


# Private methods

func __controller_died(was_player: bool) -> void:
	__alive = false

	__screen_end.visible = true

	if was_player:
		__label_end_result.text = __RESULT_TEXT % "The God" # Replace with god name
		__button_next.text = "Back"
		__speech_bubble.show_text(__god_data.message("game_win"))
	else:
		__label_end_result.text = __RESULT_TEXT % "You"
		__button_next.text = "Continue"
		__speech_bubble.show_text(__god_data.message("game_lose"))
		GameState.kill(GameState.current_god)


func __game_loop() -> void:
	while __alive:
		__enemy_controller.draw()
		yield(__player_controller.draw(), "completed")

		__player_controller.set_interact(true)

		yield(__enemy_controller, "rune_picked")
		yield(__enemy_controller, "rune_picked")

		__player_controller.set_interact(false)

		__enemy_controller.flip()
		yield(__player_controller.flip(), "completed")

		yield(__score_round(), "completed")

		__screen_round.visible = true && __alive

		yield(get_tree().create_timer(0.5), "timeout")

		__enemy_controller.discard()
		__player_controller.discard()

		yield(get_tree().create_timer(1.7), "timeout")

		__screen_round.visible = false


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

	match result:
		1, 2:
			__label_round_result.text = "Win"
			__enemy_controller.damage(result)
			if __enemy_controller._health > 0:
				__speech_bubble.show_text(__god_data.message("round_lose"))
			else:
				__speech_bubble.show_text(__god_data.message("game_lose"))
		-1, -2:
			__label_round_result.text = "Loss"
			__player_controller.damage(abs(result))
			if __player_controller._health > 0:
				__speech_bubble.show_text(__god_data.message("round_win"))
			else:
				__speech_bubble.show_text(__god_data.message("game_win"))
		0:
			__label_round_result.text = "Draw"
			__speech_bubble.show_text(__god_data.message("round_draw"))

extends Node2D


# Private constants

const __RESULT_TEXT = "%s won!"


# Private variables

onready var __label_end_result: Label = $ui/scroll/scroll_body/content/screen_end/label_result
onready var __label_opponent_name: Label = $ui/screen_game/label_opponent_name
onready var __button_menu: Button = $ui/scroll/scroll_body/content/screen_end/buttons/button_menu
onready var __button_next: Button = $ui/scroll/scroll_body/content/screen_end/buttons/button_next
onready var __button_replay: Button = $ui/scroll/scroll_body/content/screen_end/buttons/button_replay
onready var __button_pause: Button = $ui/screen_game/button_pause
onready var __button_pause_continue: Button = $ui/scroll/scroll_body/content/screen_pause/buttons/button_continue
onready var __button_pause_restart: Button = $ui/scroll/scroll_body/content/screen_pause/buttons/button_restart
onready var __button_pause_menu: Button = $ui/scroll/scroll_body/content/screen_pause/buttons/button_menu
onready var __screen_end: Control = $ui/scroll/scroll_body/content/screen_end
onready var __screen_pause: Control = $ui/scroll/scroll_body/content/screen_pause
onready var __screen_game: Control = $ui/screen_game
onready var __scroll: Scroll = $ui/scroll
onready var __speech_bubble: SpeechBubble = $ui/screen_game/speech_bubble
onready var __texture_rect_opponent: TextureRect = $ui/screen_game/texture_rect_opponent

onready var __scroll_position_y: float = __scroll.position.y

var __enemy_controller: EnemyTurnController = null
var __enemy_manager: CardManager = null
var __player_controller: PlayerTurnController = null
var __player_manager: CardManager = null

var __alive: bool = true
var __god_data: GodData

var __tween: Tween = Tween.new()


# Lifecycle methods

func _ready() -> void:
	add_child(__tween)

	__scroll.position.y -= 300.0

	randomize()
	Globals.plinth_check_polygon = $plinth_check_polygon.polygon

	__god_data = GameState.current_god_data()

	__enemy_controller = EnemyTurnController.new(
		$enemy_discard,
		$enemy_hand,
		$enemy_hearts.get_children(),
		$enemy_plinths.get_children(),
		$enemy_stack
	)
	add_child(__enemy_controller)

	__enemy_manager = CardManager.new(__god_data.deck)
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
	__button_pause.connect("pressed", self, "__pause", [true])
	__button_pause_continue.connect("pressed", self, "__pause", [false])
	__button_pause_restart.connect("pressed", SceneManager, "load_scene", ["game"])
	__button_pause_menu.connect("pressed", SceneManager, "load_scene", ["opponent_choice"])


	# Play menu music
	var audio_dict = {"bus": "music", "choice": "battle", "loop": false}
	Event.emit_signal("emit_audio", audio_dict)

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

	var audio_dict = {"bus": "music", "choice": "battle_end", "loop": false}
	Event.emit_signal("emit_audio", audio_dict)

	if was_player:
		__label_end_result.text = __RESULT_TEXT % "The God" # Replace with god name
		__button_next.text = "Back"
		__speech_bubble.show_text(__god_data.message("game_win"))
	else:
		__label_end_result.text = __RESULT_TEXT % "You"
		__button_next.text = "Continue"
		__speech_bubble.show_text(__god_data.message("game_lose"))
		GameState.kill(GameState.current_god)

	__screen_end.visible = true

	yield(get_tree().create_timer(1.0), "timeout")
	yield(__scroll_show(), "completed")


func __game_loop() -> void:
	__enemy_controller.refill_stack()
	yield(__player_controller.refill_stack(), "completed")

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

		yield(get_tree().create_timer(0.5), "timeout")

		__enemy_controller.discard()
		__player_controller.discard()

		yield(get_tree().create_timer(1.7), "timeout")



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
				enemy_rune.bounce()
				yield(player_rune.bounce(), "completed")

	match result:
		1, 2:
			__enemy_controller.damage(result)
			if __enemy_controller._health > 0:
				__speech_bubble.show_text(__god_data.message("round_lose"))
			else:
				__speech_bubble.show_text(__god_data.message("game_lose"))
		-1, -2:
			__player_controller.damage(abs(result))
			if __player_controller._health > 0:
				__speech_bubble.show_text(__god_data.message("round_win"))
			else:
				__speech_bubble.show_text(__god_data.message("game_win"))
		0:
			__speech_bubble.show_text(__god_data.message("round_draw"))


func __scroll_show() -> void:
	__tween.interpolate_property(
		__scroll,
		"position:y",
		__scroll.position.y,
		__scroll_position_y,
		0.3
	)
	__tween.start()

	yield(__tween,"tween_all_completed")
	yield(__scroll.unroll(0.3), "completed")


func __scroll_hide() -> void:
	yield(__scroll.roll(0.3), "completed")

	__tween.interpolate_property(
		__scroll,
		"position:y",
		__scroll.position.y,
		__scroll_position_y - 300.0,
		0.3
	)
	__tween.start()

	yield(__tween,"tween_all_completed")


func __pause(paused: bool) -> void:
	if paused:
		__button_pause.visible = false
		__screen_pause.visible = true

		yield(__scroll_show(), "completed")
	else:
		yield(__scroll_hide(), "completed")

		__button_pause.visible = true
		__screen_pause.visible = false

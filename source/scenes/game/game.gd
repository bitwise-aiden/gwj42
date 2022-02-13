extends Node2D

# Private constants

const __RUNE_SCENE: PackedScene = preload("res://source/scenes/game/rune.tscn")


# Private variables

onready var __enemy_hand: Hand = $enemy_hand
onready var __enemy_stack: Stack = $enemy_stack
onready var __player_hand: Hand = $player_hand
onready var __player_stack: Stack = $player_stack
onready var __player_plinths: Array = $player_plinths.get_children()

var __enemy: CardManager = null
var __player: CardManager = null


# Lifecycle methods

func _ready() -> void:
	__player = CardManager.new()
	__initialize_runes(
		__player.deck,
		__player_stack,
		__player_hand,
		true,
		Vector2(-100.0, 400.0)
	)

	__enemy = CardManager.new()
	__initialize_runes(
		__enemy.deck,
		__enemy_stack,
		__enemy_hand,
		false,
		Vector2(980.0, -84.0)
	)

	for plinth in __player_plinths:
		if plinth is Plinth:
			plinth.hover_area.connect("mouse_exited", __player_hand, "__plinth_dectivate", [plinth])
			plinth.hover_area.connect("mouse_entered", __player_hand, "__plinth_activate", [plinth])


# Private method

func __initialize_runes(deck: CardDeck, stack: Stack, hand: Hand, visible: bool, start: Vector2) -> void:
	for card_state in deck.cards:
		var rune: Rune = __RUNE_SCENE.instance()
		rune.global_position = start
		rune.card_state = card_state

		add_child(rune)

		stack.add(rune)

		yield(get_tree().create_timer(0.7), "timeout")


	yield(get_tree().create_timer(0.7), "timeout")

	yield(__draw_rune(stack, hand, visible), "completed")
	yield(__draw_rune(stack, hand, visible), "completed")
	yield(__draw_rune(stack, hand, visible), "completed")


func __draw_rune(stack: Stack, hand: Hand, visible: bool) -> void:
	var hand_position: Position2D = hand.next_position()
	if !hand_position:
		return

	var rune: Rune = stack.top()

	# TODO: Handling for empty stack

	yield(rune.move(hand_position.global_position, visible), "completed")

	stack.pop()
	hand.add(rune)

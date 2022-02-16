class_name PlayerTurnController extends TurnController


# Private variables

var __active_plinth: Plinth = null
var __active_rune: Rune = null
var __following: bool = false


# Lifecycle methods

func _init(
	discard: Discard,
	hand: Hand,
	plinths: Array,
	stack: Stack
).(discard, hand, plinths, stack) -> void:
	for plinth in plinths:
		plinth.hover_area.connect("mouse_exited", self, "__plinth_dectivate", [plinth])
		plinth.hover_area.connect("mouse_entered", self, "__plinth_activate", [plinth])


func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT) && __active_rune && _interact:
		var can_add: bool = false

		for plinth in _plinths:
			can_add = can_add || plinth.can_add()

		if !can_add && !__following:
			return

		__following = true

		__active_rune.global_position = get_viewport().get_mouse_position()
		__active_rune.z_index = 10
	elif __following:
		__following = false

		if __active_plinth && __active_plinth.can_add():
			_hand.remove(__active_rune)

			var rune: Rune = __active_rune
			__active_rune = null

			yield(__active_plinth.add(rune), "completed")

			emit_signal("rune_picked")

		else:
			_hand.deactivate_rune(__active_rune)
			__active_rune.z_index = 0
	else:
		__active_rune = _hand.active_rune


# Private methods

func __plinth_activate(plinth: Plinth) -> void:
	__active_plinth = plinth


func __plinth_dectivate(plinth: Plinth) -> void:
	if __active_plinth != plinth:
		return

	__active_plinth = null

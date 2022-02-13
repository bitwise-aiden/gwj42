class_name Rune extends Sprite


# Public variables

export(Texture) var sprite_parchment: Texture = null
export(Texture) var sprite_shears: Texture = null
export(Texture) var sprite_stone: Texture = null

var card_state: CardState = null setget __card_state_set, __card_state_get


# Private variables

onready var __sprite_type: Sprite = $type

var __ready: bool = false
var __tween: Tween = Tween.new()


# Lifecylce method

func _ready() -> void:
	add_child(__tween)

	__ready = true

	self.card_state = card_state


# Public methods

func hover_start() -> void:
	__tween.interpolate_property(
		self,
		"global_position",
		global_position,
		global_position - Vector2(0.0, 10.0),
		0.2
	)
	__tween.start()

func hover_stop(origin: Vector2) -> void:
	__tween.stop(self, "global_position")

	__tween.interpolate_property(
		self,
		"global_position",
		global_position,
		origin,
		0.2
	)
	__tween.start()

func move(incoming: Vector2, visible: bool = true) -> void:
	# Move up off stack
	__tween.interpolate_property(
		self,
		"global_position",
		global_position,
		global_position + Vector2.UP * 20.0,
		0.1,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	__tween.start()

	yield(__tween, "tween_completed")

	# Move accross to be inline with desired location
	__tween.interpolate_property(
		self,
		"global_position",
		global_position,
		Vector2(incoming.x, global_position.y),
		0.5,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	__tween.start()

	yield(__tween,"tween_completed")

	if __sprite_type.visible != visible:

		# Begin flip
		__tween.interpolate_property(
			self,
			"scale:x",
			1.0,
			0.0,
			0.1
		)
		__tween.start()

		yield(__tween, "tween_completed")

		__sprite_type.visible = visible

		# End flip
		__tween.interpolate_property(
			self,
			"scale:x",
			0.0,
			1.0,
			0.1
		)
		__tween.start()

		yield(__tween, "tween_completed")

	# Fall down to desired location
	__tween.interpolate_property(
		self,
		"global_position",
		global_position,
		incoming,
		0.5,
		Tween.TRANS_EXPO,
		Tween.EASE_IN
	)
	__tween.start()

	yield(__tween,"tween_completed")

	# TODO: Particles here


# Private methods

func __card_state_get() -> CardState:
	return card_state


func __card_state_set(incoming: CardState) -> void:
	card_state = incoming

	if !__ready || !card_state:
		return

	match card_state.card.type:
		Card.Types.PARCHMENT:
			__sprite_type.texture = sprite_parchment

		Card.Types.SHEARS: # Elephant Shoe - Cavedens
			__sprite_type.texture = sprite_shears

		Card.Types.STONE:
			__sprite_type.texture = sprite_stone

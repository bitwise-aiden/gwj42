class_name Rune extends Sprite


# Private constants

const __SPEED_HORIZONTAL: float = 600.0
const __SPEED_VERTICAL: float = 700.0

# Public variables

export(Texture) var sprite_parchment: Texture = null
export(Texture) var sprite_shears: Texture = null
export(Texture) var sprite_stone: Texture = null
export(Resource) var dust_scene : Resource

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

func attack(other: Rune) -> void:
	var origin: Vector2 = global_position

	var offset: Vector2 = (origin - other.position).normalized() * 50.0

	yield(move(other.global_position + offset), "completed")
	yield(move(origin), "completed")


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
	z_index = 10

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
	var horizontal_position: Vector2 = Vector2(incoming.x, global_position.y)
	__tween.interpolate_property(
		self,
		"global_position",
		global_position,
		horizontal_position,
		(global_position - horizontal_position).length() / __SPEED_HORIZONTAL,
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
			0.15
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
			0.15
		)
		__tween.start()

		yield(__tween, "tween_completed")

	# Fall down to desired location
	var vertical_position: Vector2 = incoming
	__tween.interpolate_property(
		self,
		"global_position",
		global_position,
		incoming,
		(global_position - vertical_position).length() / __SPEED_VERTICAL,
		Tween.TRANS_EXPO,
		Tween.EASE_IN
	)
	__tween.start()

	yield(__tween,"tween_completed")

	z_index = 0

	# Dust particles (Should we add some variables to set?)
	var new_dust = dust_scene.instance()
	self.call_deferred("add_child", new_dust)


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


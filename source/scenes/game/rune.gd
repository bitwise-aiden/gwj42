class_name Rune extends Sprite


# Private constants

const __SPEED_HORIZONTAL: float = 900.0
const __SPEED_VERTICAL: float = 900.0
const __SPEED_RETURN: float = 1200.0

# Public variables

export(Texture) var sprite_parchment: Texture = null
export(Texture) var sprite_shears: Texture = null
export(Texture) var sprite_stone: Texture = null
export(Resource) var dust_scene : Resource

var card_state: CardState = null setget __card_state_set, __card_state_get


# Private variables

onready var __sprite_type: Sprite = $type

var __is_hovering: bool = false
var __is_moving: bool = false
var __is_following: bool = false
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
	other.get_node("attack_particles").emitting = true
	Event.emit_signal("add_shake", 0.4)
	Event.emit_signal("emit_audio", {"bus": "effect", "choice": "rune_thud", "loop": false})
	yield(move(origin), "completed")


func follow_start() -> void:
	__is_following = true
	__tween.stop_all()


func follow_stop() -> void:
	__is_following = false


func hover_start() -> void:
	if __is_moving:
		return

	__is_hovering = true

	__tween.interpolate_property(
		self,
		"global_position",
		global_position,
		global_position - Vector2(0.0, 10.0),
		0.2
	)
	__tween.start()
	__tween.custom_multiplayer


func hover_stop(origin: Vector2, override: bool = false) -> void:
	if !__is_hovering && !override && !__is_following:
		return

	__tween.remove_all()

	__tween.interpolate_property(
		self,
		"global_position",
		global_position,
		origin,
		0.2
	)
	__tween.start()

	yield(__tween, "tween_completed")

	__is_hovering = false


func move(incoming: Vector2, visible: bool = true) -> void:
	__is_moving = true

	z_index = 10

	__tween.remove_all()

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
		(global_position - incoming).length() / __SPEED_VERTICAL,
		Tween.TRANS_EXPO,
		Tween.EASE_IN
	)
	__tween.start()

	yield(__tween,"tween_completed")

	z_index = 0
	# Make thump sound only when on screen
	if self.position.x > 0 and self.position.x < 1280:
		Event.emit_signal("emit_audio", {"bus": "effect", "choice": "rune_drop", "loop": false})
		if not Geometry.is_point_in_polygon(incoming, Globals.plinth_check_polygon):
			# Dust particles (Should we add some variables to set?)
			var new_dust = dust_scene.instance()
			self.call_deferred("add_child", new_dust)

	__is_moving = false


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

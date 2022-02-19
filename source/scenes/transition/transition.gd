extends Node2D


# Private variables

onready var __color_fade: ColorRect = $color_fade
onready var __color_opponent: ColorRect = $color_opponent
onready var __color_player: ColorRect = $color_player
onready var __texture_opponent: TextureRect = $color_opponent/texture_opponent
onready var __texture_player: TextureRect = $color_player/texture_player

var __tween: Tween = Tween.new()


# Lifecycle methods

func _ready() -> void:
	add_child(__tween)


# Public methods

func start(show_profiles: bool = false) -> void:
	if show_profiles:
		__texture_opponent.texture = GameState.god_data[GameState.current_god].texture()
		__texture_player.texture = GameState.player_profile

		__tween.interpolate_property(
			__color_opponent,
			"rect_position:x",
			-1480,
			-100,
			0.5,
			Tween.TRANS_EXPO,
			Tween.EASE_IN
		)

		__tween.interpolate_property(
			__color_player,
			"rect_position:x",
			1280,
			-100,
			0.5,
			Tween.TRANS_EXPO,
			Tween.EASE_IN
		)

	__tween.interpolate_method(
		self,
		"__set_fade_threshold",
		0.0,
		1.0,
		0.8,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN,
		0.2
	)

	__tween.start()

	yield(__tween, "tween_all_completed")
	yield(get_tree().create_timer(0.75), "timeout")


func stop() -> void:
	__tween.interpolate_property(
		__color_opponent,
		"rect_position:x",
		__color_opponent.rect_position.x,
		-1480,
		0.5,
		Tween.TRANS_EXPO,
		Tween.EASE_IN,
		0.2
	)

	__tween.interpolate_property(
		__color_player,
		"rect_position:x",
		__color_player.rect_position.x,
		1280,
		0.5,
		Tween.TRANS_EXPO,
		Tween.EASE_IN,
		0.2
	)

	__tween.interpolate_method(
		self,
		"__set_fade_threshold",
		1.0,
		0.0,
		1.0
	)

	__tween.start()

	yield(__tween, "tween_all_completed")


# Private methods

func __set_fade_threshold(value: float) -> void:
	__color_fade.material.set_shader_param("threshold", value)

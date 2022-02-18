extends TextureButton

class_name opponent_button

onready var popup = get_parent().get_node("Popup")

var closed_statue = load("res://assets/sprites/opponents/statue_closed.png")
var picture_statue
var opponent_name
var opponent_description


# Private variables


onready var __button_back: Button = $"../scroll/scroll_body/content/button_back"
onready var __button_battle: Button = $"../scroll/scroll_body/content/button_battle"
onready var __label_name: Label = $"../scroll/scroll_body/content/name"
onready var __label_description: RichTextLabel = $"../scroll/scroll_body/content/description"
onready var __scroll: Scroll = $"../scroll" # For Dave <3
onready var __texture_portrait: TextureRect = $"../scroll/scroll_body/content/portrait"


onready var __scroll_position_y: float = __scroll.position.y

var __tween: Tween = Tween.new()


func _ready():
	add_child(__tween)

	__scroll.position.y -= 300.0

	__button_back.connect("pressed", self, "__button_back_pressed")
	__button_battle.connect("pressed", self, "__button_battle_pressed")

func _init(var n):
	opponent_name = n
	opponent_description = GameState.god_data[n].description
	picture_statue = load("res://assets/sprites/opponents/"+ opponent_name + "_statue.png")
	set_normal_texture(closed_statue)
	set_hover_texture(picture_statue)


func _pressed():
	__texture_portrait.texture = GameState.god_data[opponent_name].texture()
	__label_name.text = opponent_name
	__label_description.bbcode_text = "[center]%s[/center]" % opponent_description

	__tween.interpolate_property(
		__scroll,
		"position:y",
		__scroll.position.y,
		__scroll_position_y,
		0.5
	)
	__tween.start()

	yield(__tween,"tween_all_completed")

	__scroll.unroll()


func __button_back_pressed() -> void:
	yield(__scroll.roll(), "completed")

	__tween.interpolate_property(
		__scroll,
		"position:y",
		__scroll.position.y,
		__scroll_position_y - 300.0,
		0.5
	)
	__tween.start()

	yield(__tween,"tween_all_completed")


func __button_battle_pressed() -> void:
	Event.emit_signal("emit_audio", {"bus": "effect", "choice": "GONG", "loop": false})

	GameState.pick_opponent(opponent_name)
	yield(Transition.start(true), "completed")

	SceneManager.load_scene("game", false)

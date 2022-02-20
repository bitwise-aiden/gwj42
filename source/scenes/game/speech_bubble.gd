class_name SpeechBubble extends NinePatchRect

# Public variables
export(float, 0.05, 1.0) var character_transition_time : float = 0.1

# Private constants

const __PADDING: float = 63.0


# Private variables

onready var __text_speech: RichTextLabel = $text_speech

var __tween: Tween = Tween.new()

var __audio_dict : Dictionary

var __game_node
var __is_speaking: bool = false
var __speech_done: bool = false


# Lifecycle methods

func _ready() -> void:
	add_child(__tween)
	__game_node = get_tree().get_root().get_node("game")
	__game_node.connect("ready", self, "__get_god_data")

func _process(delta: float) -> void:
	if visible and not __is_speaking and not __speech_done:
		__speak()

# Public methods

func show_text(text: String) -> void:
	visible = true
	__speech_done = false
	
	__text_speech.bbcode_text = "[center]%s[/center]" % text
	__text_speech.percent_visible = 0.0

	__tween.interpolate_method(
		self,
		"__show_text",
		0.0,
		1.0,
		text.length() * character_transition_time
	)


	__tween.start()

	yield(__tween, "tween_all_completed")
	__speech_done = true
	yield(get_tree().create_timer(1.5), "timeout")
		
	visible = false


# Private methods

func __show_text(percentage: float) -> void:
	__text_speech.percent_visible = percentage
	rect_size.y = __text_speech.rect_size.y + __PADDING

func __get_god_data() -> void:
	__audio_dict = {"bus": "effect", "choice":__game_node.god_data.name, "loop": false}

func __speak() -> void:
	__is_speaking = true
	Event.emit_signal("emit_audio", __audio_dict)
	yield(get_tree().create_timer(character_transition_time), "timeout")
	__is_speaking = false

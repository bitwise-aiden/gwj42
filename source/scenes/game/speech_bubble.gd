class_name SpeechBubble extends NinePatchRect


# Private constants

const __PADDING: float = 63.0


# Private variables

onready var __text_speech: RichTextLabel = $text_speech

var __tween: Tween = Tween.new()


# Lifecycle methods

func _ready() -> void:
	add_child(__tween)


# Public methods

func show_text(text: String) -> void:
	visible = true

	__text_speech.bbcode_text = "[center]%s[/center]" % text
	__text_speech.percent_visible = 0.0

	__tween.interpolate_method(
		self,
		"__show_text",
		0.0,
		1.0,
		0.75
	)


	__tween.start()

	yield(__tween, "tween_all_completed")
	yield(get_tree().create_timer(1.5), "timeout")

	visible = false


# Private methods

func __show_text(percentage: float) -> void:
	__text_speech.percent_visible = percentage
	rect_size.y = __text_speech.rect_size.y + __PADDING

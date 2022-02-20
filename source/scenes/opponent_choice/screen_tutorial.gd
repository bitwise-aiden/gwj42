extends Control


# Private variables

onready var __button_back: Button = $button_back
onready var __button_next: Button = $button_next
onready var __button_skip: Button = $button_skip
onready var __pages: Array = $pages.get_children()


var __page: int = 0


# Lifecycle methods

func _ready() -> void:
	__button_back.connect("pressed", self, "__change_page", [-1])
	__button_next.connect("pressed", self, "__change_page", [+1])
	__button_skip.connect("pressed", Event, "emit_signal", ["change_menu", "main"])

	__change_page(0)


# Private methods

func __change_page(value: int) -> void:
	__page += value

	match __page:
		-1, 8:
			Event.emit_signal("change_menu", "main")
			__page = 0

			return
		0:
			__button_back.text = "MENU"
			__button_skip.visible = false
		1:
			__button_back.text = "BACK"
			__button_skip.visible = true
		6:
			__button_next.text = "NEXT"
			__button_skip.visible = true
		7:
			__button_next.text = "MENU"
			__button_skip.visible = false


	for i in __pages.size():
		__pages[i].visible = i == __page

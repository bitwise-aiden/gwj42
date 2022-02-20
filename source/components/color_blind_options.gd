extends Control


# Private variables

onready var __options: Array = $options.get_children()


# Lifecycle methods

func _ready() -> void:
	for index in __options.size():
		__options[index].connect("pressed", self, "__option_toggled", [index])

	var value: int = SettingsManager.get_setting(
		"gameplay/Colorblind Shader/Type",
		0
	)

	__option_toggled(value, true)


# Private methods

func __option_toggled(option_index: int, override: bool = false) -> void:
	var value: bool = __options[option_index].pressed || override

	for index in __options.size():
		__options[index].pressed = index == option_index && value

	if value == false:
		option_index = 0

		__options[0].pressed = true
		__options[0].grab_focus()

	SettingsManager.set_setting(
		"gameplay/Colorblind Shader/Type",
		option_index,
		true
	)

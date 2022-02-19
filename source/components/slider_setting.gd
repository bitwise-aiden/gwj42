extends HSlider

# Public variables
export (String) var display_name = "Volume"
export (String) var setting_name = null


# Private variables

onready var __label = $label


# Lifecycle methods

func _ready() -> void:
	if !setting_name:
		Logger.warn("Volume slider '%s' does not have a controlled bus." % display_name)

	value = SettingsManager.get_setting(setting_name)

	__label.text = display_name

	connect("value_changed", self, "__value_changed")


# Private methods

func __value_changed(value: float) -> void:
	SettingsManager.set_setting(setting_name, value, true)

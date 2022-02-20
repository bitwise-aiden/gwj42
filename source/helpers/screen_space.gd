extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	yield(get_tree().get_root(), "ready")
	Event.connect("setting_changed", self, "set_shader")
	set_shader(["Type", SettingsManager.get_setting("gameplay/Colorblind Shader/Type")])

func set_shader(details: Array) -> void:
	if details[0] in ["gameplay/Colorblind Shader/Type", "Type"]:
		$ss_shaders.material.set_shader_param("mode", details[1])
	if details[0] in ["gameplay/Colorblind Shader/Intensity", "Intensity"]:
		$ss_shaders.material.set_shader_param("intensity", details[1])

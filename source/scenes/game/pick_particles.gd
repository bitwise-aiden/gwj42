extends CPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.amount = max(floor(32 * SettingsManager.get_setting("graphics/Particles")), 4)

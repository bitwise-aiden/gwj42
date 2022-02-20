extends Node2D

# Public variables
export(float, 0.0, 5.0) var lifetime : float = 1.0
export(int, 0, 200) var num_particles : int = 64

# Private variables
var __life_timer : Timer

func _ready() -> void:
	__life_timer = Timer.new()
	__life_timer.wait_time = lifetime
	__life_timer.one_shot = true
	__life_timer.connect("timeout", self, "__life_timer_timeout")
	self.add_child(__life_timer)
	__life_timer.start()

func _enter_tree() -> void:
	for child in self.get_children():
		child.lifetime = lifetime
		child.amount = max(floor(num_particles * SettingsManager.get_setting("graphics/Particles")), 4)
		child.emitting = true

func __life_timer_timeout() -> void:
	self.queue_free()

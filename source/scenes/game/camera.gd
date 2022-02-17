extends Camera2D

export var decay = 0.8
export var max_offset = Vector2(100, 75)
export var max_roll = 0.1

var shake = 0.0
var shake_power = 2

onready var noise = OpenSimplexNoise.new()
var noise_y = 0

func _ready() -> void:
	Event.connect("add_shake", self, "add_shake")
	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2

func add_shake(amount):
	shake = min((shake + amount) * SettingsManager.get_setting("gameplay")["Shake Intensity"], 1.0)

func _process(delta: float) -> void:
	if shake:
		shake = max(shake - decay * delta, 0)
		shake()

func shake():
	var amount = pow(shake, shake_power)
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed * 2, noise_y)
	offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed * 3, noise_y)

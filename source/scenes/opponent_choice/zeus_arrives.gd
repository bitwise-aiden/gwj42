extends AnimationPlayer

onready var __audio_dict : Dictionary = {"bus": "effect", "choice": "thunder", "loop": false}

var only1 = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Event.connect("zeus", self, "zeus_is_here")

func zeus_is_here() -> void:
	if !only1:
		Event.emit_signal("emit_audio", __audio_dict)
		self.play("zeus_arrives")
		only1 = true


func _on_zeus_arrives_animation_finished(anim_name: String) -> void:
	if anim_name == "zeus_arrives":
		self.play("RESET")

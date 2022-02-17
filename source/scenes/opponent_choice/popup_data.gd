extends Popup

onready var picture = get_node("picture")
onready var description = get_node("description")
onready var name_popup = get_node("name_popup")

var opponent_name: String = ""

func _ready():
	pass

func _on_back_button_pressed():
	hide()


func _on_battle_button_pressed():
	# GONG
	Event.emit_signal("emit_audio", {"bus": "effect", "choice": "GONG", "loop": false})

	# Scene transition here! For now, wait.
	yield(get_tree().create_timer(1.5), "timeout")

	GameState.pick_opponent(opponent_name)

	SceneManager.load_scene("game")

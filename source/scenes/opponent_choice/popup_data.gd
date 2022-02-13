extends Popup

onready var picture = get_node("picture")
onready var description = get_node("description")
onready var name_popup = get_node("name_popup")

func _ready():
	pass

func _on_back_button_pressed():
	hide()


func _on_battle_button_pressed():
	get_tree().change_scene("res://source/scenes/game/game.tscn")

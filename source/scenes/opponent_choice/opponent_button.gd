extends TextureButton

class_name opponent_button

onready var popup = get_parent().get_node("Popup")

var picture_statue
var opponent_name
var opponent_description

func _ready():
	pass

func _init(var n):
	opponent_name = n
	opponent_description = GameState.god_data[n].description
	picture_statue = load("res://assets/sprites/opponents/"+ opponent_name + "_statue.png")
	set_normal_texture(picture_statue)

func _pressed():
	popup.picture.texture = load("res://assets/sprites/opponents/"+ opponent_name + "_portrait.png")
	popup.name_popup.texture = load("res://assets/sprites/opponents/"+ opponent_name + "_name.png")
	popup.description.set_text(opponent_description)
	popup.opponent_name = opponent_name
	popup.popup()

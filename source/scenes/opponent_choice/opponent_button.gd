extends TextureButton

class_name opponent_button

onready var popup = get_parent().get_node("Popup")

var picture_statue
var opponent_name
var opponent_description

func _ready():
	pass
	
func _init(var n, var d):
	opponent_name = n
	opponent_description = d
	picture_statue = load("res://assets/sprites/opponents/"+ opponent_name + "_statue.png")
	set_normal_texture(picture_statue)

func _pressed():
	#This will bring up a zoomed in picture + information about the opponent
	#print("This is: " + opponent_name)
	#print("This is the parent: " + get_parent().name)
	#print("This is the popup: " + popup.name)
	popup.picture.texture = load("res://assets/sprites/opponents/"+ opponent_name + "_portrait.png")
	popup.name_popup.texture = load("res://assets/sprites/opponents/"+ opponent_name + "_name.png")
	popup.description.add_text(opponent_description)
	popup.popup()

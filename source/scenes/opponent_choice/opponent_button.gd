extends TextureButton

class_name opponent_button

var picture_statue
var opponent_name

func _ready():
	pass
	
func _init(var n):
	opponent_name = n
	picture_statue = load("res://assets/sprites/opponents/"+ opponent_name + "_statue.png")
	set_normal_texture(picture_statue)

func _pressed():
	#This will bring up a zoomed in picture + information about the opponent
	print("This is: " + opponent_name)

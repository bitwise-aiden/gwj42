#god_data.gd
class_name GodData extends Resource

var name
var description


# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(g_name = "", g_description = ""):
	name = g_name
	description = g_description


func texture() -> Texture:
	return load("res://assets/sprites/opponents/"+ name + "_portrait.png") as Texture

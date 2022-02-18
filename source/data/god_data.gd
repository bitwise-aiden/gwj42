#god_data.gd
class_name GodData extends Resource

var name
var description
var messages
var deck


# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(g_name = "", g_description = "", g_messages = {}, g_deck = [3, 3, 3]):
	name = g_name
	description = g_description
	messages = g_messages
	deck = g_deck


func message(type: String) -> String:
	if messages.has(type) && !messages[type].empty():
		return messages[type][randi() % messages[type].size()]

	return "Fallback message!"


func texture() -> Texture:
	return load("res://assets/sprites/opponents/"+ name + "_portrait.png") as Texture

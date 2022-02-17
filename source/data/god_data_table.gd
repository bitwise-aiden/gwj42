#god_data_table.gd
class_name GodDataTable extends Resource

const GodStats = preload("res://source/data/god_data.gd")

var data = {
	"zeus": GodStats.new("zeus", "The King of the gods"),
	"amon_ra": GodStats.new("amon_ra", "Sun god - One of the creator gods - head of a hawk"),
	"chicomecoatl": GodStats.new("chicomecoatl", "Goddess of agriculture"),
	"gaia": GodStats.new("gaia", "The Earth Goddess"),
	#"poseidon": GodStats.new("poseidon", "The God of the Seas"),
	#"dionysus": GodStats.new("dionysus", "The God of Wine"),
	"hades": GodStats.new("hades", "The God of the Underworld")
	}

func get_data():
	return data

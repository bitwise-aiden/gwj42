#god_data_table.gd
extends Resource

const GodStats = preload("res://source/data/god_data.gd")

var data = {
	"zeus": GodStats.new("zeus", "Zeus Lorem ipsum dolor sit amet,"),
	"amon_ra": GodStats.new("amon_ra", "amon_ra Lorem ipsum dolor sit amet,"),
	"chicomecoat": GodStats.new("chicomecoat", "chicomecoat Lorem ipsum dolor sit amet,"),
	"gaia": GodStats.new("gaia", "gaia Lorem ipsum dolor sit amet,"),
	"hades": GodStats.new("hades", "hades Lorem ipsum dolor sit amet,")
	}

func get_data():
	return data

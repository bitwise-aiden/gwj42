#god_data_table.gd
class_name GodDataTable extends Resource

var data = {
	"zeus": GodData.new(
		"zeus",
		"The King of the gods",
		{
			"open_taunt": ["Hahaha, you dare challenge me!?"],
			"round_draw": ["Hmmm...", "Ugh..."],
			"round_lose": ["No!", "Ouch!", "Grrr..."],
			"round_win": ["I've got you now!", "Another step closer to victory!", "Calculated."],
			"game_lose": ["How is that possible?"],
			"game_win": ["Hahaha, I didn't doubt it for a second!"],
		}
	),
	"amon_ra": GodData.new(
		"amon_ra",
		"Sun god - One of the creator gods - head of a hawk",
		{
			"open_taunt": ["Hahaha, you dare challenge me!?"],
			"round_draw": ["Hmmm...", "Ugh..."],
			"round_lose": ["No!", "Ouch!", "Grrr..."],
			"round_win": ["I've got you now!", "Another step closer to victory!", "Calculated."],
			"game_lose": ["How is that possible?"],
			"game_win": ["Hahaha, I didn't doubt it for a second!"],
		}
	),
	"chicomecoatl": GodData.new(
		"chicomecoatl",
		"Goddess of agriculture",
		{
			"open_taunt": ["Hahaha, you dare challenge me!?"],
			"round_draw": ["Hmmm...", "Ugh..."],
			"round_lose": ["No!", "Ouch!", "Grrr..."],
			"round_win": ["I've got you now!", "Another step closer to victory!", "Calculated."],
			"game_lose": ["How is that possible?"],
			"game_win": ["Hahaha, I didn't doubt it for a second!"],
		}
	),
	"gaia": GodData.new(
		"gaia",
		"The Earth Goddess",
		{
			"open_taunt": ["Hahaha, you dare challenge me!?"],
			"round_draw": ["Hmmm...", "Ugh..."],
			"round_lose": ["No!", "Ouch!", "Grrr..."],
			"round_win": ["I've got you now!", "Another step closer to victory!", "Calculated."],
			"game_lose": ["How is that possible?"],
			"game_win": ["Hahaha, I didn't doubt it for a second!"],
		}
	),
#	"poseidon": GodData.new(
#		"poseidon",
#		"The God of the Seas",
#		{
#			"open_taunt": ["Hahaha, you dare challenge me!?"],
#			"round_draw": ["Hmmm...", "Ugh..."],
#			"round_lose": ["No!", "Ouch!", "Grrr..."],
#			"round_win": ["I've got you now!", "Another step closer to victory!", "Calculated."],
#			"game_lose": ["How is that possible?"],
#			"game_win": ["Hahaha, I didn't doubt it for a second!"],
#		}
#	),
#	"dionysus": GodData.new(
#		"dionysus",
#		"The God of Wine",
#		{
#			"open_taunt": ["Hahaha, you dare challenge me!?"],
#			"round_draw": ["Hmmm...", "Ugh..."],
#			"round_lose": ["No!", "Ouch!", "Grrr..."],
#			"round_win": ["I've got you now!", "Another step closer to victory!", "Calculated."],
#			"game_lose": ["How is that possible?"],
#			"game_win": ["Hahaha, I didn't doubt it for a second!"],
#		}
#	),
	"hades": GodData.new(
		"hades",
		"The God of the Underworld",
		{
			"open_taunt": ["Hahaha, you dare challenge me!?"],
			"round_draw": ["Hmmm...", "Ugh..."],
			"round_lose": ["No!", "Ouch!", "Grrr..."],
			"round_win": ["I've got you now!", "Another step closer to victory!", "Calculated."],
			"game_lose": ["How is that possible?"],
			"game_win": ["Hahaha, I didn't doubt it for a second!"],
		}
	)
}

func get_data():
	return data

#god_data_table.gd
class_name GodDataTable extends Resource

var data = {
	"zeus": GodData.new(
		"zeus",
		"The King of the gods",
		{
			"open_taunt": ["You are mere moments away from heaven now!", "By Hades or by might, your fate is sealed!"],
			"round_draw": ["It is of no matter...", "Ugh..."],
			"round_lose": ["No!", "Hm!", "Oh, for heaven's sake!"],
			"round_win": ["Heaven help you!", "Prayers alone cannot help you now!", "Finally a round worthy of my name!", "...and the Lord taketh away!"],
			"game_lose": ["Defeated by a mortal!? IMPOSSIBLE!", "Blasphemy!!"],
			"game_win": ["It is as I ordained.", "It was written in the heavens"],
		}
	),
	"amon_ra": GodData.new(
		"amon_ra",
		"Egyptian Sun God",
		{
			"open_taunt": ["Such a stupid mortal. You will never best my strategy!", "You cannot outsmart me!"],
			"round_draw": ["Hmmm...", "Ugh..."],
			"round_lose": ["Humph", "I'll just have to change things up a bit!"],
			"round_win": ["How can you ever expect to win!?", "Another step closer to victory!", "Calculated."],
			"game_lose": ["But I executed the plan!??", "Next time I'll outsmart you!"],
			"game_win": ["I knew I had the winning strategy!"],
		},
		[9, 0, 0]
	),
	"chicomecoatl": GodData.new(
		"chicomecoatl",
		"Goddess of agriculture",
		{
			"open_taunt": ["Let's see what you got!"],
			"round_draw": ["Hmmm...", "Ugh..."],
			"round_lose": ["My plan wilters!", "Ouch!", "Grrr..."],
			"round_win": ["Things are really starting to bloom!", "You look like you could use some sunshine. Have you spoken to Ra recently?", "It is harvesting season!"],
			"game_lose": ["I'm all shriveled up!"],
			"game_win": ["What a bountiful harvest!", "It was only a matter of sun, water and time!"],
		}
	),
	"gaia": GodData.new(
		"gaia",
		"The Earth Goddess",
		{
			"open_taunt": ["Hahaha, you dare challenge me!?"],
			"round_draw": ["Hmmm...", "Ugh..."],
			"round_lose": ["Is it getting hotter in here?", "Ouch!", "Grrr..."],
			"round_win": ["", "Another step closer to victory!", "Calculated."],
			"game_lose": ["How is that possible?"],
			"game_win": ["Mother nature always finds a way."],
		}
	),
	"poseidon": GodData.new(
		"poseidon",
		"The God of the Seas",
		{
			"open_taunt": ["Hahaha, you dare challenge me!?"],
			"round_draw": ["Hmmm...", "Ugh..."],
			"round_lose": ["No!", "Ouch!", "Grrr..."],
			"round_win": ["I've got you now!", "Another step closer to victory!", "Calculated."],
			"game_lose": ["How is that possible?"],
			"game_win": ["Hahaha, I didn't doubt it for a second!"],
		}
	),
	"dionysus": GodData.new(
		"dionysus",
		"The God of Wine",
		{
			"open_taunt": ["Hahaha, you dare challenge me!?"],
			"round_draw": ["Hmmm...", "Ugh..."],
			"round_lose": ["No!", "Ouch!", "Grrr..."],
			"round_win": ["I've got you now!", "Another step closer to victory!", "Calculated."],
			"game_lose": ["How is that possible?"],
			"game_win": ["Hahaha, I didn't doubt it for a second!"],
		}
	),
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

#god_data_table.gd
class_name GodDataTable extends Resource

var data = {
	"zeus": GodData.new(
		"zeus",
		"The King of the gods",
		{
			"open_taunt": ["You are mere moments away from heaven now!", "By Hades or by might, your fate is sealed!"],
			"round_draw": ["It is of no matter...", "AGAIN!"],
			"round_lose": ["No!", "Hm!", "Oh, for heaven's sake!"],
			"round_win": ["Heaven help you!", "Prayers alone cannot help you now!", "Finally a round worthy of my name!", "...and the Lord taketh away!"],
			"game_lose": ["Defeated by a mortal!? IMPOSSIBLE!", "Blasphemy!!", "Me damnit!"],
			"game_win": ["It is as I ordained.", "It was written in the heavens"],
		}
	),
	"amon_ra": GodData.new(
		"amon_ra",
		"Egyptian Sun God",
		{
			"open_taunt": ["Such a stupid mortal. You will never best my strategy!", "You cannot outsmart me!"],
			"round_draw": ["Matching my strategy? You will surely lose the next one.", "let me try that one again."],
			"round_lose": ["Humph", "I'll just have to change things up a bit!", "You cannot possibly understand my strategy!"],
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
			"round_draw": ["Hmmm...", "My harvest comes soon."],
			"round_lose": ["My plan wilters!", "Ouch!", "I demand a sacrifice!"],
			"round_win": ["Things are really starting to bloom!", "You look like you could use some sunshine. Have you spoken to Ra recently?", "It is harvesting season!"],
			"game_lose": ["I'm all shriveled up!"],
			"game_win": ["What a bountiful harvest!", "It was only a matter of sun, water and time!"],
		}
	),
	"gaia": GodData.new(
		"gaia",
		"The Earth Goddess",
		{
			"open_taunt": ["I will rock you to your core!"],
			"round_draw": ["For a round to be successful, you must planet", "I'll come back around next turn"],
			"round_lose": ["Is it getting hotter in here?", "Looks like there is no peace on Earth this round.", "Grrr..."],
			"round_win": ["That should keep you grounded!", "A new day dawns...", "I don't need any more trash talk"],
			"game_lose": ["I can't believe it was you that brought me back to Earth!"],
			"game_win": ["Mother nature always finds a way.", "Looks like it is Earth day today!"],
		}
	),
	"poseidon": GodData.new(
		"poseidon",
		"The God of the Seas",
		{
			"open_taunt": ["Hahaha, you dare challenge me!?"],
			"round_draw": ["Blub, blub, blooob...", "*bubble noises*", "Let's H2Go again!", "hmmm..."],
			"round_lose": ["Cod you let me win one?", "You sun of a beach!", "This is giving me emoceans!"],
			"round_win": ["Look at you, floundering around!", "Let the waves of defeat wash over you.", "Yeah, buoy!!"],
			"game_lose": ["I got lost at sea!"],
			"game_win": ["Now, now, no need to get salty", "It was sink or swim... you made your choice!"],
		}
	),
	"dionysus": GodData.new(
		"dionysus",
		"The God of Wine",
		{
			"open_taunt": ["A new drinking buddy!? What joy!", "Who are you calling a drunk?"],
			"round_draw": ["Great minds drink alike!", "Anyone for another round?", "huh? What am I drawing?"],
			"round_lose": ["I have made some pour decisions.", "Another round! Waiter!!"],
			"round_win": ["It must be wine o'clock!", "oooh, what year is this bottle??", "No need to wine about it."],
			"game_lose": ["I think I'm going to be sick."],
			"game_win": ["You really can't hold your wine, can you?!"],
		}
	),
	"hades": GodData.new(
		"hades",
		"The God of the Underworld",
		{
			"open_taunt": ["All aboard! Next stop... Hell."],
			"round_draw": ["You are only prolonging the inevitable.", "Can I tell you about my new cryptocurrency?"],
			"round_lose": ["Hmmm, they don't usually fight back.", "You won this round but you cannot beat death."],
			"round_win": ["Looks like you are dying to get into hell... I can help with that.", "That tick that you have? It is a dead give away."],
			"game_lose": ["Well that was a grave affair.", "Zeus is going to hear of this."],
			"game_win": ["You died... I mean, you lost."],
		}
	)
}

func get_data():
	return data

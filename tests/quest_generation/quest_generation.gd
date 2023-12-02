extends Node2D

func _ready():
	var generate_button = get_node("CanvasLayer/Control/Button")
	generate_button.pressed.connect(self.generate_variations)
	
	get_node("CanvasLayer/Control/StoryVariation1/Text").text = build_story()
	get_node("CanvasLayer/Control/StoryVariation2/Text").text = build_story()

func generate_variations():
	get_node("CanvasLayer/Control/StoryVariation1/Text").text = build_story()
	get_node("CanvasLayer/Control/StoryVariation2/Text").text = build_story()
	
func build_story():
	## Create a quest
	var quest_type = Globals.choose(Globals.QUEST_LIST)
	var q
	if quest_type == Globals.QUEST_ESCORT_CHARACTER:
		q = quest_escort_character.new()
	elif quest_type == Globals.QUEST_ESCORT_ITEM:
		q = quest_escort_item.new()
	elif quest_type == Globals.QUEST_DESTROY_CHARACTER:
		pass
	elif quest_type == Globals.QUEST_DESTROY_ITEM:
		pass
	elif quest_type == Globals.QUEST_SEARCH_CHARACTER:
		pass
	elif quest_type == Globals.QUEST_SEARCH_ITEM:
		pass
	q.generate()
	
	## Create Tavern
	var tavern = location_tavern.new()
	tavern.generate()
	
	## Create Bar Tender
	var bartender = character_object.new()
	bartender.generate()
	
	var associate_1 = character_object.new()
	associate_1.generate()
	var associate_2 = character_object.new()
	associate_2.generate()
	var associate_3 = character_object.new()
	associate_3.generate()
	
	var random_city = location_city.new()
	random_city.generate()
	
	var random_city2 = location_city.new()
	random_city2.generate()
	
	var teller = story_teller.new()
	teller.add_elements({
		"tavern_name": tavern.name, 
		"tavern.thesaris": tavern.thesaris(), 
		"bartender_fullname": bartender.get_full_name(), 
		"bartender_race": get_race_name(bartender.race),
		"bartender.he_she_gender": get_text_he_she(bartender.gender),
		"bartender.his_her_gender": get_text_his_her(bartender.gender),
		"associate_1.first_name": associate_1.first_name,
		"associate_1.full_name": associate_1.get_full_name(), 
		"associate_1.race": get_race_name(associate_1.race),
		"associate_1.he_she_gender": get_text_he_she(associate_1.gender),
		"associate_2.first_name": associate_2.first_name,
		"associate_2.full_name": associate_2.get_full_name(), 
		"associate_2.race": get_race_name(associate_2.race),
		"associate_2.he_she_gender": get_text_he_she(associate_2.gender),
		"associate_3.first_name": associate_3.first_name,
		"associate_3.full_name": associate_3.get_full_name(), 
		"associate_3.race": get_race_name(associate_3.race),
		"associate_3.he_she_gender": get_text_he_she(associate_3.gender),
		"random_city.name": random_city.name,
		"random_location.name": random_city2.name
	})
	
	## Other thoughts on how to add more "random"
	## -  Alter the structure of this story: 
	## 	-- Not meeting a group, just going to a tavern
	##  -- Delivering something to the tavern, leads to new quest
	##  -- At the bar drinking, fight breaks out, you hurt the wrong person and you need to flee
	##  -- Local bard asks for escort to another tavern
	##  -- Waitress talks of an evil people who come into place, she asks you to help vanquish them
	## - Build out different characters to offer different quests, randomly chosen (See above for ideas)
	## - Different intro scenarios
	## 	-- In the middle of a job, something goes wrong or the job is ending which leads to something else
	## 	-- Captured by someone, you need to break out
	##  -- Doing a mundane task, when something happens
	##  -- You are about to have your head chopped off, but are saved randomly
	
	var story = ""
	## Introduction
	teller.paragraph_start()
	teller.add_sentence("And so our adventure begins...")
	
	var weather = Globals.choose(Globals.WEATHER_LIST)
	if weather == Globals.WEATHER_SUNNY:
		teller.add_sentence("The air is crisp, the sun is bright and the smell and sight of spring surrounds your senses.")
	elif weather == Globals.WEATHER_RAIN:
		teller.add_sentence("You are drenched from the rain, it must have been raining for the past couple hours.")
	elif weather == Globals.WEATHER_SNOW:
		teller.add_sentence("The cold air is reaching your bones, you are glad your cold journey is nearly coming to an end.")
	
	teller.add_sentence("You find yourself traveling along the road south of the city {random_city.name} where you plan to meet a few of your fellow companions for work.")
	teller.paragraph_end()
	
	## Describe Location
	teller.paragraph_start()
	teller.add_sentence("You make your way through town until you arrive just outside the {tavern_name}, a {tavern.thesaris} located in {random_city.name}.")
	teller.add_sentence("From the outside it doesn't look like much, but inside the drinks and food are the best in town.")
	teller.paragraph_end()
	
	## Walk into Location
	## Opportunities for random:
	## - Have tavern serve random person to greet, not always the bartender. Could be waitress, bartender or no one who works there. Could be a fellow patron
	## - Interactions could be more varied, friendly, not friendly
	teller.add_elements({
		"tavern.descriptors": tavern.get_random_description(), 
	})
	teller.paragraph_start()
	teller.add_sentence("You walk inside, {tavern.descriptors}")
	teller.add_sentence("You see a {bartender_race} standing behind the bar, {bartender.he_she_gender} looks over your way and a smile crosses {bartender.his_her_gender} face.")
	teller.add_sentence_quote("Bartender", "Hello there! My name is {bartender_fullname} and welcome to the {tavern_name}!")
	teller.add_sentence_quote("", "What can I get for you?")
	teller.paragraph_end()
	
	teller.paragraph_start()
	teller.add_sentence("You look past the bartender and notice {associate_1.first_name} sitting at a table with the rest of your company.")
	teller.add_sentence_quote("You look back at the bartender", "A round of ales for the table over there.")
	teller.add_sentence("You point in the direction of your companions.")
	teller.add_sentence_quote("Bartender", "Coming right up fella!")
	teller.paragraph_end()
	
	## Group introduction
	## - Introductions to group members could vary, maybe these people are not friends just work associates you do not know
	## - Associated could be friendly, not friendly etc...
	teller.paragraph_start()
	teller.add_sentence("You begin to make your way over to your fellow companions and as you draw closer...")
	teller.add_sentence_quote("{associate_1.first_name} looks toward you", "Well look who decided to finally show up!")
	teller.add_sentence("The table of companions erupt into loud laughter, drawing attention from the other patreons in the room.")
	teller.add_sentence("You shake hands with {associate_1.full_name}, a {associate_1.race} you have known for ages.")
	teller.add_sentence("You walk around the table and give {associate_2.full_name}, a {associate_2.race}, a big smack on the shoulders as you exchange pleasantries.")
	teller.add_sentence("The last time you saw one another was at {random_location.name} over five years ago.")
	teller.add_sentence("Finally making your way around the table to where {associate_3.full_name}, a {associate_3.race} is sitting.")
	teller.add_sentence_quote("{associate_3.first_name} stands up to face you and says", "Where is my ale?!")
	teller.add_sentence("and the whole table erupts into another eruption of laughter.")
	teller.add_sentence("You give {associate_3.first_name} a firm handshake, pat on the shoulder and finally make your way to your seat.")
	teller.paragraph_end()
	
	## Quest Offer
	teller.add_elements({
		"quest_object.relation": "",
		"quest_object.name": "",
		"quest_character.full_name": "",
		"quest_location.name": "",
	})
	teller.paragraph_start()
	teller.add_sentence("Just as you begin to sit down, the bartender arrives with drinks for everyone at the table.")
	teller.add_sentence("After delivering each frosty glass of ale the bartender begins wiping his serving tray down with his towel,")
	teller.add_sentence_quote("he looks toward you and everyone else at the table", "You look like a hardy bunch, you wouldn't happen to be looking for some work now would ya?")
	teller.add_sentence_quote("You nod towards the bartender", "Aye, as a matter of fact we are looking for some work")
	## Escort Character Quest Type
	if q.type == Globals.QUEST_ESCORT_CHARACTER:
		teller.add_elements({
			"quest_character_to_escort.first_name": q.character_to_escort.first_name,
			"quest_escort_too_location.name": q.escort_too_location.name,
			"quest_character_to_escort.relation": get_relation(q.character_to_escort.gender),
			"quest_character_to_escort.he_she": get_text_he_she(q.character_to_escort.gender)
		})
		teller.add_sentence_quote("Barthender", "Excellent, Could you escort my {quest_character_to_escort.relation} {quest_character_to_escort.first_name} too {quest_escort_too_location.name}?")
		teller.add_sentence_quote("", "{quest_character_to_escort.he_she} has a very important meeting to get too.")
		teller.add_sentence_quote("", "I will make it worth your while for a safe delivery, 100 gold now and 200 gold upon your return. I will also throw in this round of drinks!")	
	elif q.type == Globals.QUEST_ESCORT_ITEM:
		var quest_escort_too_location = location_city.new()
		quest_escort_too_location.generate()
		#quest_escort_too_location.save(db)
		teller.add_elements({
			"quest_item_to_escort.name": q.item_to_escort.name,
			"quest_escort_too_character.full_name": q.escort_too_character.get_full_name(),
			"quest_escort_too_location.name": quest_escort_too_location.name,
		})
		teller.add_sentence_quote("Bartender", "Excellent, I have a {quest_item_to_escort.name}, a precious family heirloom, that needs delivered too {quest_escort_too_character.full_name} over in {quest_escort_too_location.name}.")
		teller.add_sentence_quote("", "I will make it worth your while for a safe delivery, 100 gold now and 200 gold upon your return. I will also throw in this round of drinks!")	
	
	## Quest Acceptence
	teller.add_sentence_quote("You look towards everyone seated at the table", "Well, I think we can all agree to that!")
	teller.add_sentence("The table erupts into a loud laughter once again.")
	
	teller.paragraph_end()
	
	## Closing
	teller.paragraph_start()
	teller.add_sentence("As the night fades away with drinks, stories and immence laughter - the adventure is set and begins at first light.")
	teller.paragraph_end()
	
	return teller.get_story()

func get_relation(gender):
	if gender == Globals.GENDER_FEMALE:
		return "daughter"
	else:
		return "son"
		
func get_text_he_she(gender):
	if gender == Globals.GENDER_FEMALE:
		return "she"
	else:
		return "he"

func get_text_his_her(gender):
	if gender == Globals.GENDER_FEMALE:
		return "her"
	else:
		return "his"

func get_race_name(race):
	if race == Globals.RACE_HUMAN:
		return "human"
	elif race == Globals.RACE_DWARF:
		return "dwarf"
	elif race == Globals.RACE_ELF:
		return "elf"

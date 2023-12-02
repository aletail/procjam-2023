extends Node

## Gender Types
const GENDER_MALE = 1
const GENDER_FEMALE = 2
const GENDER_LIST:Array = [GENDER_MALE, GENDER_FEMALE]

## Race Types
const RACE_HUMAN = 1
const RACE_DWARF = 2
const RACE_ELF = 3
const RACE_LIST:Array = [RACE_HUMAN, RACE_DWARF, RACE_ELF]

## Quest Types
const QUEST_ESCORT_CHARACTER = 1
const QUEST_ESCORT_ITEM = 2
const QUEST_DESTROY_CHARACTER = 3
const QUEST_DESTROY_ITEM = 4
const QUEST_SEARCH_CHARACTER = 5
const QUEST_SEARCH_ITEM = 6
const QUEST_LIST:Array = [QUEST_ESCORT_CHARACTER, QUEST_ESCORT_ITEM]

## Item Types
const ITEM_SWORD = 1
const ITEM_TREASURE = 2
const ITEM_LIST:Array = [ITEM_SWORD, ITEM_TREASURE]

## Location Types
const LOCATION_TAVERN = 1
const LOCATION_CITY = 2
const LOCATION_LIST:Array = [LOCATION_TAVERN, LOCATION_CITY]

## Weather
const WEATHER_SUNNY = 1
const WEATHER_RAIN = 2
const WEATHER_SNOW = 3
const WEATHER_LIST:Array = [WEATHER_SUNNY, WEATHER_RAIN, WEATHER_SNOW]

# Util.choose(["one", "two"])   returns one or two
func choose(choices:Array):
	randomize()

	var rand_index = randi() % choices.size()
	return choices[rand_index]
	
func choose_from_dictionary(choices:Dictionary):
	var size = choices.size()
	var random_key = choices.keys()[randi() % size]
	return random_key
	
func get_random_location_type():
	var types = ["location_city", "location_tavern"]
	return Globals.choose(types)

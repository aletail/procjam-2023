class_name character_object extends story_object
## Character Object
## Defines all data about our characters, extends database_object class so this can be stored in the database

## First Name
var first_name = "": set = set_first_name, get = get_first_name
func get_first_name():
	return data_model_values["first_name"]
func set_first_name(value):
	first_name = value
	data_model_values["first_name"] = value

## Last Name
var last_name = "": set = set_last_name, get = get_last_name
func get_last_name():
	return data_model_values["last_name"]
func set_last_name(value):
	last_name = value
	data_model_values["last_name"] = value

## Gender
var gender = 0: set = set_gender, get = get_gender
func get_gender():
	return data_model_values["gender"]
func set_gender(value):
	gender = value
	data_model_values["gender"] = value

## Race
var race = 0: set = set_race, get = get_race
func get_race():
	return data_model_values["race"]
func set_race(value):
	race = value
	data_model_values["race"] = value
	
## Height
var height = "": set = set_height, get = get_height
func get_height():
	return data_model_values["height"]
func set_height(value):
	height = value
	data_model_values["height"] = value
	
## Weight
var weight = "": set = set_weight, get = get_weight
func get_weight():
	return data_model_values["weight"]
func set_weight(value):
	weight = value
	data_model_values["weight"] = value
## Strength
var strength = 0: set = set_strength, get = get_strength
func get_strength():
	return strength
func set_strength(value):
	strength = value
	data_model_values["strength"] = value
	
## Dexterity
var dexterity = 0: set = set_dexterity, get = get_dexterity
func get_dexterity():
	return dexterity
func set_dexterity(value):
	dexterity = value
	data_model_values["dexterity"] = value
	
## Constitution
var constitution = 0: set = set_constitution, get = get_constitution
func get_constitution():
	return constitution
func set_constitution(value):
	constitution = value
	data_model_values["constitution"] = value
	
## Intelligence
var intelligence = 0: set = set_intelligence, get = get_intelligence
func get_intelligence():
	return intelligence
func set_intelligence(value):
	intelligence = value
	data_model_values["intelligence"] = value
	
## Wisdom
var wisdom = 0: set = set_wisdom, get = get_wisdom
func get_wisdom():
	return wisdom
func set_wisdom(value):
	wisdom = value
	data_model_values["wisdom"] = value
	
## Charisma
var charisma = 0: set = set_charisma, get = get_charisma
func get_charisma():
	return charisma
func set_charisma(value):
	charisma = value
	data_model_values["charisma"] = value

	
## Constructor
func _init():
	## Call parent class constructor
	super()
	
	## Database
	database_table_name = "character"
	
	##Initialize Data Model Structure
	data_model_structure["first_name"] = {"data_type":"text", "not_null": true}
	data_model_structure["last_name"] = {"data_type":"text", "not_null":true}
	data_model_structure["gender"] = {"data_type":"int", "not_null":true}
	data_model_structure["race"] = {"data_type":"int", "not_null":true}
	data_model_structure["height"] = {"data_type":"real", "not_null":true}
	data_model_structure["weight"] = {"data_type":"int", "not_null":true}
	data_model_structure["strength"] = {"data_type":"int", "not_null":true}
	data_model_structure["dexterity"] = {"data_type":"int", "not_null":true}
	data_model_structure["constitution"] = {"data_type":"int", "not_null":true}
	data_model_structure["intelligence"] = {"data_type":"int", "not_null":true}
	data_model_structure["wisdom"] = {"data_type":"int", "not_null":true}
	data_model_structure["charisma"] = {"data_type":"int", "not_null":true}
	
## Generate
func generate(_gender:int=0, _race:int=0):
	## Descriptors 
	var hair_colors:Array = ["Red", "Orange", "Blond", "Brown", "Black"]
	var eye_colors:Array = ["Blue", "Green", "Hazel", "Brown", "Yellow"]
	var walk_motion:Array = ["Normal", "Swift", "Slow", "Deliberate"]
	
	var rng = RandomNumberGenerator.new()
	randomize()
	
	## If gender is 0, random select a gender
	if _gender==0:
		gender = Globals.choose(Globals.GENDER_LIST)
	else:
		gender = _gender	
		
	## If race is 0, random select a race
	if _race==0:
		race = Globals.choose(Globals.RACE_LIST)
	else:
		race = _race	
	
	## Roll base attribute stats
	roll_attributes()
	
	## Determine names
	if race==Globals.RACE_HUMAN:
		## Get Human Names
		set_human_names()
		## Height
		height = snapped(rng.randf_range(4.10, 6.4), 0.01)
		## Weight
		weight = rng.randi_range(114, 270)
	elif race==Globals.RACE_DWARF:
		## Get Dwarf Names
		set_dwarf_names()
		## Height
		height = snapped(rng.randf_range(4.2, 4.8), 0.01)
		## Weight
		weight = rng.randi_range(134, 226)
	elif race==Globals.RACE_ELF:
		## Get Elf Names
		set_elf_names()
		## Height
		height = snapped(rng.randf_range(4.8, 6.6), 0.01)
		## Weight
		weight = rng.randi_range(92, 186)
		
	## Add descriptors
	add_descriptor("HairColor", hair_colors[rng.randi_range(0, hair_colors.size()-1)])
	add_descriptor("EyeColor", eye_colors[rng.randi_range(0, eye_colors.size()-1)])
	add_descriptor("WalkMotion", walk_motion[rng.randi_range(0, walk_motion.size()-1)])

## Set Human Names
func set_human_names():
	var db = SQLite.new()
	db.path = "res://data/data"
	db.verbosity_level = SQLite.VERBOSE
	db.read_only = true
	db.open_db()
	
	## Select Random first name based on gender
	var query_string = "SELECT Text FROM FirstName WHERE Gender = ? LIMIT 1 OFFSET ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM FirstName WHERE Gender = ?), 1)"
	var success = db.query_with_bindings(query_string, [gender, gender])
	if success:
		first_name = db.query_result[0]["Text"].to_lower()
		first_name = first_name[0].to_upper() + first_name.substr(1,-1)
	else:
		print("Error selecting first name")
		
	## Select Random last name
	query_string = "SELECT Text FROM LastName LIMIT 1 OFFSET ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM LastName), 1)"
	success = db.query(query_string)
	if success:
		last_name = db.query_result[0]["Text"].to_lower()
		last_name = last_name[0].to_upper() + last_name.substr(1,-1)
	else:
		print("Error selecting last name")
	
	db.close_db()
	
## Set Dwarf Names
func set_dwarf_names():
	var db = SQLite.new()
	db.path = "res://data/data"
	db.verbosity_level = SQLite.VERBOSE
	db.read_only = true
	db.open_db()
	
	## First Names
	var fname_array:Array = [];
	var query_string = "SELECT Text FROM FirstName WHERE Gender = ? LIMIT 100 OFFSET ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM FirstName WHERE Gender = ?), 100)"
	var success = db.query_with_bindings(query_string, [gender, gender])
	if success:
		for first_name in db.query_result:
			fname_array.push_back(first_name["Text"])
	else:
		print("Error selecting first names")
		
	var adjective_array : Array = []
	for adjective in db.select_rows("DwarfAdjective", "", ["Adjective"]):
		adjective_array.push_back(adjective["Adjective"])
		
	var nouns_array : Array = []
	for noun in db.select_rows("DwarfNoun", "", ["Noun"]):
		nouns_array.push_back(noun["Noun"])
		
	var firstname_chain = MarkovNameGenerator.new(fname_array, 7, 3)
	
	first_name = firstname_chain.NextName()
	last_name = adjective_array.pick_random() + nouns_array.pick_random()
	
	db.close_db()
	
func set_elf_names():
	var db = SQLite.new()
	db.path = "res://data/data"
	db.verbosity_level = SQLite.VERBOSE
	db.read_only = true
	db.open_db()
	
	## First Names
	var fname_array:Array = [];
	var query_string = "SELECT Text FROM FirstName WHERE Gender = ? LIMIT 100 OFFSET ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM FirstName WHERE Gender = ?), 100)"
	var success = db.query_with_bindings(query_string, [gender, gender])
	if success:
		for first_name in db.query_result:
			fname_array.push_back(first_name["Text"])
	else:
		print("Error selecting first names")
		
	var adjective_array : Array = []
	for adjective in db.select_rows("ElfAdjective", "", ["Adjective"]):
		adjective_array.push_back(adjective["Adjective"])
		
	var nouns_array : Array = []
	for noun in db.select_rows("ElfNoun", "", ["Noun"]):
		nouns_array.push_back(noun["Noun"])
		
	var firstname_chain = MarkovNameGenerator.new(fname_array, 7, 3)
	
	first_name = firstname_chain.NextName()
	last_name = adjective_array.pick_random() + nouns_array.pick_random()
	
	db.close_db()

# Fills in base character attributes
func roll_attributes():
	var dice = Dice.new()
	
	strength = dice.roll(3, 6)
	dexterity = dice.roll(3, 6)
	constitution = dice.roll(3, 6)
	intelligence = dice.roll(3, 6)
	wisdom = dice.roll(3, 6)
	charisma = dice.roll(3, 6)

func get_full_name():
	return first_name + " " + last_name

class_name quest_escort_character extends quest_object
	
## Character To Escort
var character_to_escort: set = set_character_to_escort, get = get_character_to_escort
var character_to_escort_id = 0
func get_character_to_escort():
	## Open the database
	#var db = SQLite.new()
	#db.path = "user://test"
	#db.verbosity_level = SQLite.VERBOSE
	#db.read_only = true
	#db.open_db()
	#
	#if data_model_values.has("character_to_escort_id"):
		#character_to_escort.load(data_model_values["character_to_escort_id"], db)
		#
	#db.close_db()
	
	return character_to_escort
	
func set_character_to_escort(value):
	character_to_escort = value
	character_to_escort_id = character_to_escort.id
	data_model_values["character_to_escort"] = character_to_escort.id
	
## Location Type
var location_type = 0: set = set_location_type, get = get_location_type
func get_location_type():
	if data_model_values.has("location_type"):
		return data_model_values["location_type"]
	else:
		return false
	
func set_location_type(value):
	location_type = value
	data_model_values["location_type"] = value
	
## Location Object
var escort_too_location: set = set_escort_too_location, get = get_escort_too_location
var escort_too_location_id = 0
func get_escort_too_location():
	### Open the database
	#var db = SQLite.new()
	#db.path = "user://test"
	#db.verbosity_level = SQLite.VERBOSE
	#db.read_only = true
	#db.open_db()
	#
	#if data_model_values.has("escort_too_location_id"):
		#escort_too_location.load(data_model_values["escort_too_location_id"], db)
		#
	#db.close_db()
	
	return escort_too_location
	
func set_escort_too_location(value):
	escort_too_location = value
	escort_too_location_id = escort_too_location.id
	data_model_values["escort_too_location"] = escort_too_location.id

## Constructor
func _init():
	## Call parent class constructor
	super()
	
	## Database
	database_table_name = "quest_escort_character"
	
	## Initialize Data Model Structure
	data_model_structure["character_to_escort"] = {"data_type":"int", "not_null":false}
	data_model_structure["location_type"] = {"data_type":"int", "not_null":false}
	data_model_structure["escort_too_location"] = {"data_type":"int", "not_null":false}

func generate():
	type = Globals.QUEST_ESCORT_CHARACTER
	
	## Generate a character
	character_to_escort = character_object.new()
	character_to_escort.generate()
	#character_to_escort.save(db)
	#character_to_escort_id = character_to_escort.id
	
	## Get a random location type
	location_type = Globals.get_random_location_type()
	
	## Generate location based on type
	var location_instance = null
	var class_list = ProjectSettings.get_global_class_list()
	for class_dictionary in class_list:
		if class_dictionary["class"] == location_type:
			print(class_dictionary["path"])
			escort_too_location = load(class_dictionary["path"]).new()
			escort_too_location.generate()
			#escort_too_location.save(db)
			#escort_too_location_id = escort_too_location.id

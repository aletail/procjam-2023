class_name quest_escort_item extends quest_object

## Item To Escort
var item_to_escort: set = set_item_to_escort, get = get_item_to_escort
var item_to_escort_id = 0
func get_item_to_escort():
	### Open the database
	#var db = SQLite.new()
	#db.path = "user://test"
	#db.verbosity_level = SQLite.VERBOSE
	#db.read_only = true
	#db.open_db()
	#
	#if data_model_values.has("item_to_escort_id"):
		#item_to_escort.load(data_model_values["item_to_escort_id"], db)
		#
	#db.close_db()
	
	return item_to_escort
	
func set_item_to_escort(value):
	item_to_escort = value
	item_to_escort_id = item_to_escort.id
	data_model_values["item_to_escort"] = item_to_escort.id
	
## Escort To Character
var escort_too_character: set = set_escort_too_character, get = get_escort_too_character
var escort_too_character_id = 0
func get_escort_too_character():
	### Open the database
	#var db = SQLite.new()
	#db.path = "user://test"
	#db.verbosity_level = SQLite.VERBOSE
	#db.read_only = true
	#db.open_db()
	#
	#if data_model_values.has("escort_too_character_id"):
		#escort_too_character.load(data_model_values["escort_too_character_id"], db)
		
	#db.close_db()
	
	return escort_too_character
	
func set_escort_too_character(value):
	escort_too_character = value
	escort_too_character_id = escort_too_character.id
	data_model_values["escort_too_character"] = escort_too_character.id
	
## Constructor
func _init():
	## Call parent class constructor
	super()
	
	## Database
	database_table_name = "quest_escort_item"
	
	## Initialize Data Model Structure
	data_model_structure["item_to_escort"] = {"data_type":"int", "not_null":false}
	data_model_structure["escort_too_character"] = {"data_type":"int", "not_null":false}

func generate():
	## Select a type at random
	type = Globals.QUEST_ESCORT_ITEM
	
	## Generate an item
	item_to_escort = item_treasure.new()
	item_to_escort.generate()
	#item_to_escort.save(db)
	#item_to_escort_id = item_to_escort.id
	
	## Generate a character
	escort_too_character = character_object.new()
	escort_too_character.generate()
	#escort_too_character.save(db)
	#escort_too_character_id = escort_too_character.id

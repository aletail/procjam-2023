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
	
## Constructor
func _init():
	## Call parent class constructor
	super()
	
	## Database
	database_table_name = "character"
	
	##Initialize Data Model Structure
	data_model_structure["first_name"] = {"data_type":"text", "not_null": true}
	data_model_structure["last_name"] = {"data_type":"text", "not_null":true}

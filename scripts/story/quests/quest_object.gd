class_name quest_object extends database_object
## Quest Object

## Type
## See globals for types: res://scripts/globals.gd
var type = 0: set = set_type, get = get_type
func get_type():
	return data_model_values["type"]
func set_type(value):
	type = value
	data_model_values["type"] = value

## Constructor
func _init():
	## Call parent class constructor
	super()
	
	## Database
	database_table_name = "quest"
	
	## Initialize Data Model Structure
	data_model_structure["type"] = {"data_type":"int", "not_null":true}

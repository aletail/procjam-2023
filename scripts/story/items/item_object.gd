class_name item_object extends story_object
## Item Object

## Name
var name = "": set = set_name, get = get_name
func get_name():
	return data_model_values["name"]
func set_name(value):
	name = value
	data_model_values["name"] = value

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
	database_table_name = "item"
	
	##Initialize Data Model Structure
	data_model_structure["name"] = {"data_type":"text", "not_null": true}
	data_model_structure["type"] = {"data_type":"int", "not_null":true}

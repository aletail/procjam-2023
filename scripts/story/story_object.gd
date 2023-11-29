class_name story_object extends database_object
## Story Object
## Anything that is to be included in the story should extend this
## Gives Descriptors to any child classes
	
## Descriptors
## Descritpors are stored as JSON in the database
var descriptor_string:String = "": set = set_descriptor_string, get = get_descriptor_string
var descriptors:Dictionary = Dictionary()
func get_descriptor_string():
	return data_model_values["descriptor_string"]
	
func set_descriptor_string(value):
	descriptor_string = value
	data_model_values["descriptor_string"] = value
	var array = JSON.parse_string(value)
	descriptors.clear()
	for key in array:
		descriptors[key] = array[key]
		
func add_descriptor(key:String, value:String):
	descriptors[key] = value
	descriptor_string = JSON.stringify(descriptors)

## Constructor
func _init():
	## Call parent class constructor
	super()
	
	## Initialize Data Model Structure
	data_model_structure["descriptor_string"] = {"data_type":"text", "not_null":true}

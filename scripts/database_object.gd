class_name database_object
## Database Object
## Base class to add basic database support to child objects (Save, Load)
## All data defined by the data model will be stored in the database

## Data Model
var data_model_values:Dictionary = Dictionary()
var data_model_structure:Dictionary = Dictionary()

## Database
var database_table_name:String

## id of the object
var id = null: set = set_id, get = get_id
func get_id():
	if(data_model_values.has("id")):
		return data_model_values["id"]
	else:
		return false
func set_id(value):
	id = value
	data_model_values["id"] = value
	
	
## Constructor - Child classes will need to call this constructor
func _init():
	## Initialize Data Model Structure
	data_model_structure["id"] = {"data_type":"int", "primary_key": true, "not_null": true}
	
	
## Save - Inserts/Updates record
func save(db:SQLite):
	## Create the table if it does not exist
	db.create_table(database_table_name, data_model_structure)
	
	if(get_id()):
		db.update_rows(database_table_name, "id="+str(get_id()), data_model_values)
	else:
		db.insert_row(database_table_name, data_model_values)
		id = db.last_insert_rowid
		
	
## Load the requested record by ID
func load(id:int, db:SQLite):
	var rows = db.select_rows(database_table_name, "id="+str(id), ["*"])
	for row in rows:
		for column in row:
			self.set(column, row[column])


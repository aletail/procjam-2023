extends Node2D


func _ready():
	## Open the database
	var db = SQLite.new()
	db.path = "user://test"
	db.verbosity_level = SQLite.VERBOSE
	db.open_db()
	
	## Create and save a character
	var c = character_object.new()
	c.first_name = "Jay"
	c.last_name = "Richardson"
	c.save(db)
	
	## Load up the same character
	var c2 = character_object.new()
	c2.load(c.id, db)
	
	print(c2.id)
	print(c2.first_name)
	print(c2.last_name)
	
	## Close the database
	db.close_db()

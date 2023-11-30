extends Node2D

func _ready():
	## Open the database
	var db = SQLite.new()
	db.path = "user://test"
	db.verbosity_level = SQLite.VERBOSE
	db.open_db()
	
	var i = item_sword.new()
	i.generate()
	i.save(db)
	
	db.close_db()

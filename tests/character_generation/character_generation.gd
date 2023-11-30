extends Node2D

func _ready():
	## Open the database
	var db = SQLite.new()
	db.path = "user://test"
	db.verbosity_level = SQLite.VERBOSE
	db.open_db()
	
	var c = character_object.new()
	c.generate(0, 0)
	c.save(db)
	
	var dwarf = character_object.new()
	dwarf.generate(0, 1)
	dwarf.save(db)
	
	var elf = character_object.new()
	elf.generate(1, 2)
	elf.save(db)
	
	db.close_db()

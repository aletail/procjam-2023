extends Node2D


func _ready():
	var rng = RandomNumberGenerator.new()
	
	## Create some descriptors - TO be included in character generation
	var hair_colors:Array = ["Red", "Orange", "Blond", "Brown", "Black"]
	var eye_colors:Array = ["Blue", "Green", "Hazel", "Brown", "Yellow"]
	var walk_motion:Array = ["Normal", "Swift", "Slow", "Deliberate"]
	
	## Open the database
	var db = SQLite.new()
	db.path = "user://test"
	db.verbosity_level = SQLite.VERBOSE
	db.open_db()
	
	## Create and save a character
	var c = character_object.new()
	c.first_name = "Jay"
	c.last_name = "Richardson"
	c.add_descriptor("HairColor", hair_colors[rng.randi_range(0, hair_colors.size()-1)])
	c.add_descriptor("EyeColor", eye_colors[rng.randi_range(0, eye_colors.size()-1)])
	c.add_descriptor("WalkMotion", walk_motion[rng.randi_range(0, walk_motion.size()-1)])
	c.save(db)
	
	## Create new character, test the loading
	var c2 = character_object.new()
	c2.load(c.id, db)
	
	print(c2.id)
	print(c2.first_name)
	print(c2.last_name)
	print(c2.descriptors)
	
	## Close the database
	db.close_db()

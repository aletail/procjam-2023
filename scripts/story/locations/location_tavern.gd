class_name location_tavern extends location_object

## Generate
func generate():
	var rng = RandomNumberGenerator.new()
	randomize()
	
	type = 0
	
	var db = SQLite.new()
	db.path = "res://data/data"
	db.verbosity_level = SQLite.QUIET
	db.open_db()
	
	var adjectives = db.select_rows("TavernAdjective", "", ["Adjective"])
	var adjective_array : Array = []
	for adjective in adjectives:
		adjective_array.push_back(adjective["Adjective"])
		
	var titles = db.select_rows("TavernTitle", "", ["Title"])
	var titles_array : Array = []
	for title in titles:
		titles_array.push_back(title["Title"])
		
	var nouns = db.select_rows("TavernNoun", "", ["Noun"])
	var nouns_array : Array = []
	for noun in nouns:
		nouns_array.push_back(noun["Noun"])
		
	var dice = Dice.new()
	var roll = dice.roll(1, 10)
	
	if(roll==1):
		name = adjective_array.pick_random() + " " + nouns_array.pick_random() + "\n"
	elif(roll==2):
		name = adjective_array.pick_random() + " " + nouns_array.pick_random() + " " + titles_array.pick_random() + " \n"
	elif(roll==3):
		name = adjective_array.pick_random() + " " + nouns_array.pick_random() + "\n"	
	elif(roll==4):
		name = adjective_array.pick_random() + " " + nouns_array.pick_random() + " " + titles_array.pick_random() + "\n"	
	elif(roll==5):
		name = nouns_array.pick_random() + " & " + nouns_array.pick_random() + "\n"	
	elif(roll==6):
		name = nouns_array.pick_random() + " & " + nouns_array.pick_random() + " " + titles_array.pick_random() + "\n"	
	elif(roll==7):
		name = "The " + nouns_array.pick_random() + " & " + nouns_array.pick_random() + "\n"	
	elif(roll==8):
		name = "The " + nouns_array.pick_random() + " & " + nouns_array.pick_random() + " " + titles_array.pick_random() + "\n"	
	elif(roll==9):
		name = adjective_array.pick_random() + " " + titles_array.pick_random() + "\n"
	elif(roll==10):
		name = "The " + adjective_array.pick_random() + " " + titles_array.pick_random() + "\n"
		
	## Descriptors
	var smells:Array = ["Stale Alcohol", "Fire", "Dusty and Dry"]
	var lighting:Array = ["Dimly Lit", "Bright"]
	var structure:Array = ["Wood", "Brick"]
	
	## Add descriptors
	add_descriptor("Smell", smells[rng.randi_range(0, smells.size()-1)])
	add_descriptor("Lighting", lighting[rng.randi_range(0, lighting.size()-1)])
	add_descriptor("Structure", structure[rng.randi_range(0, structure.size()-1)])
	
	db.close_db()

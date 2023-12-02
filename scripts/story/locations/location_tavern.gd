class_name location_tavern extends location_object

## Generate
func generate():
	var rng = RandomNumberGenerator.new()
	randomize()
	
	type = Globals.LOCATION_TAVERN
	
	var db = SQLite.new()
	db.path = "res://data/data"
	db.verbosity_level = SQLite.VERBOSE
	db.read_only = true
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
		name = adjective_array.pick_random() + " " + nouns_array.pick_random()
	elif(roll==2):
		name = adjective_array.pick_random() + " " + nouns_array.pick_random() + " " + titles_array.pick_random()
	elif(roll==3):
		name = adjective_array.pick_random() + " " + nouns_array.pick_random()
	elif(roll==4):
		name = adjective_array.pick_random() + " " + nouns_array.pick_random() + " " + titles_array.pick_random()	
	elif(roll==5):
		name = nouns_array.pick_random() + " & " + nouns_array.pick_random()	
	elif(roll==6):
		name = nouns_array.pick_random() + " & " + nouns_array.pick_random() + " " + titles_array.pick_random()
	elif(roll==7):
		name = "The " + nouns_array.pick_random() + " & " + nouns_array.pick_random()
	elif(roll==8):
		name = "The " + nouns_array.pick_random() + " & " + nouns_array.pick_random() + " " + titles_array.pick_random()
	elif(roll==9):
		name = adjective_array.pick_random() + " " + titles_array.pick_random()
	elif(roll==10):
		name = "The " + adjective_array.pick_random() + " " + titles_array.pick_random()
		
	## Descriptors
	var smells:Array = ["stale alcohol", "burning wood", "dust", "mold", "musty", "food"]
	var lighting:Array = ["dimly lit", "brightly lit", "darkly lit"]
	var structure:Array = ["wood", "brick", "thatch", "mud", "bamboo"]
	
	## Add descriptors
	## Add two smells
	smells.shuffle()
	add_descriptor("Smell", smells[0] + " and " + smells[1])
	add_descriptor("Lighting", lighting[rng.randi_range(0, lighting.size()-1)])
	structure.shuffle()
	add_descriptor("Structure", structure[0] + " and " + structure[1])
	
	db.close_db()
	
## Get a Random Description
func get_random_description():
	var description = ""
	var d = Globals.choose_from_dictionary(descriptors)
	## Format: smells of stale alcohol and burning fire wood consume your senses	
	if d == "Smell":
		description = " smells of " + descriptors["Smell"] + " consume your senses."
	## Format: you wait as your eyes adjust to the dimly lit room
	elif d == "Lighting":
		description = " you wait as your eyes adjust to the " +  descriptors["Lighting"] + " room." 
	## Format: you notice and admire the structure of wood and brick of the establishment
	elif d == "Structure":
		description = " you notice and admire the structure of "+ descriptors["Structure"] +" of the room."
		
	return description
	
func thesaris():
	# different names for type of place
	var t:Array = [
		"tavern",
		"watering hole",
		"bar",
		"pub",
		"saloon",
		"alehouse",
		"barroom",
	];
	print(Globals.choose(t))
	return Globals.choose(t)

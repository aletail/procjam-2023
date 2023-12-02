class_name location_city extends location_object

## Generate
func generate():
	var rng = RandomNumberGenerator.new()
	randomize()
	
	type = Globals.LOCATION_CITY
	
	var db = SQLite.new()
	db.path = "res://data/data"
	db.verbosity_level = SQLite.VERBOSE
	db.read_only = true
	db.open_db()
	
	## City Names
	var cityname_array:Array = [];
	var query_string = "SELECT Name FROM CityName LIMIT 1000 OFFSET ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM CityName), 100)"
	var success = db.query(query_string)
	if success:
		for city_name in db.query_result:
			cityname_array.push_back(city_name["Name"])
	else:
		print("Error selecting city names")
	
	var cityname_chain = MarkovNameGenerator.new(cityname_array, 7, 3)
	name = cityname_chain.NextName()
	
	db.close_db()
	
func thesaris():
	# different names for type of place
	var t:Array = [
		"town",
		"village",
	];
	return Globals.choose(t)

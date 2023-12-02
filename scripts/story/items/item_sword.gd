class_name item_sword extends item_object

## Generate
func generate():
	var rng = RandomNumberGenerator.new()
	randomize()

	name = "Sword"
	type = Globals.ITEM_SWORD
	
	## Descriptors
	var materials:Array = ["Wooden", "Steel"]
	var weights:Array = ["Heavy", "Light", "Average"]
	var hilts:Array = ["Jewel Encrusted", "Leather"]
	
	## Add descriptors
	add_descriptor("Material", materials[rng.randi_range(0, materials.size()-1)])
	add_descriptor("Weight", weights[rng.randi_range(0, weights.size()-1)])
	add_descriptor("Hilt", hilts[rng.randi_range(0, hilts.size()-1)])

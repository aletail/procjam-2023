class_name item_treasure extends item_object

## Generate
func generate():
	var types:Array = ["gemstone", "small statue", "bracelet", "chalice", "lockett", "ring", "necklace", "tapestry", "painting", "music box"]
	name = Globals.choose(types)
	type = Globals.ITEM_TREASURE

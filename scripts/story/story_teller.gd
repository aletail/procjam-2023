class_name story_teller extends database_object

var story_elements:Dictionary = {}
var paragraph_list:Array = []
var sentence_list:Array = []

var thesaris:Dictionary = {
	"arrive": ["arrive", "show up"],
	"walk": ["walk", "stroll", "jaunt", "parade", "run", "saunter"],
	"smile": ["smile", "smirk", "grin"],
	"standing": ["standing", "fixed"],
	"companions": ["companions", "party", "company", "associates"],
	"ales": ["ales", "drinks"]
}
var phrase:Dictionary = {
	"hello there": ["hello there", "greetings", "hi", "howdy", "welcome"],
	"What can I get for you?": ["What can I get for you?", "What can I do for you?", "What can I get ya?"],
	"You make your way": ["You make your way", "You travel"],
}

func add_element(key:String, value:String):
	story_elements[key] = value.to_lower()
	
func add_elements(d:Dictionary):
	story_elements.merge(d)

func paragraph_start():
	sentence_list.push_back("[p]")
func paragraph_end():
	sentence_list.push_back("[p]")
	
func add_sentence(text:String):
	## Scan for words/phrases to randomize
	var words = text.to_lower().split(" ")
	var count = 0
	for w in words:
		if thesaris.has(w):
			words[count] = Globals.choose(thesaris[w])
		if phrase.has(w):
			words[count] = Globals.choose(phrase[w])
		count+=1
	
	## Combine all words back into a sentence, replacing any elements
	text = " ".join(words).format(story_elements)
	
	## Capitalize the first letter
	text = text[0].to_upper() + text.substr(1,-1)
	sentence_list.push_back("" + text + "")

func add_sentence_quote(teller:String, text:String):
	var words
	var count = 0
	
	if teller:
		## Scan for words/phrases to randomize
		words = teller.to_lower().split(" ")
		count = 0
		for w in words:
			if thesaris.has(w):
				words[count] = Globals.choose(thesaris[w])
			if phrase.has(w):
				words[count] = Globals.choose(phrase[w])
			count+=1
		## Combine all words back into a sentence, replacing any elements
		teller = " ".join(words).format(story_elements)
	
	## Scan for words/phrases to randomize
	words = text.to_lower().split(" ")
	count = 0
	for w in words:
		if thesaris.has(w):
			words[count] = Globals.choose(thesaris[w])
		if phrase.has(w):
			words[count] = Globals.choose(phrase[w])
		count+=1
	## Combine all words back into a sentence, replacing any elements
	text = " ".join(words).format(story_elements)
	
	## Capitalize the first letter
	text = text[0].to_upper() + text.substr(1,-1)
	if teller:
		teller = teller[0].to_upper() + teller.substr(1,-1)
		sentence_list.push_back("[b]" + teller + "[/b]: \"[i]" + text + "[/i]\"")
	else:
		sentence_list.push_back("\"[i]" + text + "[/i]\"")
			
	
func get_story():
	return " ".join(sentence_list)

func get_text_he_she(sex):
	if sex == Globals.SEX_FEMALE:
		return "she"
	else:
		return "he"

extends Node

class_name MarkovNameGenerator

var _chains : Dictionary = {}
var _samples : Array = []
var _used : Array = []
var _rnd = RandomNumberGenerator.new()
var _order : int = 0
var _minLength : int = 0

func _init(sampleNames:Array=[], order:int=0, minLength:int=0):
	# fix parameter values
	if order < 1:
		order = 1
		
	if minLength < 1:
		minLength = 1	

	_order = order
	_minLength = minLength
	
	# split comma delimted lines
	for line in sampleNames:
		var tokens:Array = str(line).split(",")
		for word in tokens:
			var upper = word.to_upper()
			if(upper.length() < order + 1):
				continue
			_samples.append(upper)
		
	# Build Chains
	for word in _samples:
		#for n in range(10,0,-1)
		for letter in range(0, word.length() - order, 1):
			var token = word.substr(letter, order)
			var entry : Array = []
			if(_chains.has(token)):
				entry = _chains[token]
			else:
				entry.clear()
				_chains[token] = entry
				
			entry.push_back(word[letter + order])

func NextName()->String:
	var s = ""
	var check = true
	while(check):
		var n = _rnd.randi_range(0, _samples.size()-1)
		var nameLength = _samples[n].length()
		s = _samples[n].substr(_rnd.randi_range(0, _samples[n].length() - _order), _order)
		while(s.length() < nameLength):
			var token = s.substr(s.length() - _order, _order)
			var c = GetLetter(token)
			if(c != '?'):
				s += GetLetter(token)
			else:
				break
		
		if(s.contains(" ")):
			var tokens = s.split(' ')
			s = ""
			for t in range(0, tokens.size(), 1):
				if(tokens[t] == ""):
					continue
				if(tokens[t].length() == 1):
					tokens[t] = tokens[t].to_upper();
				else:
					tokens[t] = tokens[t].substr(0, 1) + tokens[t].substr(1, tokens[t].length()).to_lower()
				if(s!=""):
					s += " "
				s += tokens[t]		
		else:
			s = s.substr(0, 1) + s.substr(1, s.length()).to_lower()
		
		if(_used.has(s) || s.length() < _minLength):
			check = true
		else:
			check = false
			
	_used.push_back(s)
	return s
		
func Reset():
	_used.clear()
	
func GetLetter(token):
	if(!_chains.has(token)):
		return '?'
	var letters = _chains[token]
	var n = _rnd.randi_range(0, letters.size()-1)
	return letters[n]

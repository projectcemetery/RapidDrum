extends Reference

const PRESET_LIST_FILE = "user://presets.json";

# Constructor
func _init():
	pass

# Read preset dictionary
func readDict(name):
	var file = File.new()
	if not file.file_exists():
		return null
	
	file.open(name, file.READ)
	var text = file.get_as_text()
	var fileDict = {}
	fileDict.parse_json(text)
	file.close()
	return fileDict

# Save dict
func saveDict(name, dict):
	var file = File.new()
	file.open(name, file.WRITE)
	file.store_string(dict.to_json())
	file.close()

# Get preset list
func getList():
	var dict = readDict(PRESET_LIST_FILE)
	return dict.keys()

# Save track
func saveTrack(name, track):
	if name == "":
		return
	var dict = readDict(PRESET_LIST_FILE)
	dict[name] = true
	saveDict(PRESET_LIST_FILE, dict)
	var fileName = "user://%s.json" % name
	saveDict(fileName, track)

# Load track
func loadTrack(name):
	return readDict(name)
extends Reference

const PRESET_LIST_FILE = "presets";

# Constructor
func _init():
	var dict = readDict(PRESET_LIST_FILE)
	if dict == null:
		initPresets()

# Init presets
func initPresets():
	var dict = readDict(PRESET_LIST_FILE, true)
	var dir = Directory.new()
	for d in dict.keys():
		dir.copy(getFileName(d, true), getFileName(d))
	
	dir.copy(getFileName(PRESET_LIST_FILE, true), getFileName(PRESET_LIST_FILE))

# Get file name from resources or user
func getFileName(name, isRes = False):
	if isRes:
		return "res://Assets/%s.json" % name
	else:
		return "user://%s.json" % name

# Read preset dictionary
func readDict(name, isRes = False):
	var fileName = getFileName(name, isRes)

	var file = File.new()
	if not file.file_exists(fileName):
		return null
	
	file.open(fileName, file.READ)
	var text = file.get_as_text()
	var fileDict = parse_json(text)
	file.close()
	return fileDict

# Save dict
func saveDict(name, dict):
	var fileName = getFileName(name)
	var file = File.new()
	file.open(fileName, file.WRITE)
	file.store_string(to_json(dict))
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
	if dict == null:
		dict = {}
	dict[name] = true
	saveDict(PRESET_LIST_FILE, dict)
	var data = track.toDict()
	saveDict(name, data)

# Load track
func loadTrack(name):
	return readDict(name)

# Delete track
func deleteTrack(name):
	var dict = readDict(PRESET_LIST_FILE)
	if dict == null:
		return
	
	dict.erase(name)
	saveDict(PRESET_LIST_FILE, dict)
	var dir = Directory.new()
	dir.remove(getFileName(name))
	
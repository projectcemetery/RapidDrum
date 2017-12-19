extends Reference

var constants = preload("res://Scripts/Constants.gd")
var assetManager = preload("res://Scripts/AssetManager.gd").new()

# Get file name from resources or user
func getFileName(name):
	"""
	Get drum kit full name
	
	@param String name - drum kit file full path
	@return String - full path to file
	"""
	
	return "user://%s/%s/%s.json" % [constants.ASSETS_PATH, constants.PAD_PRESETS_PATH, name]

# Read preset dictionary
func readDict(name, isRes = False):
	var fileName = getFileName(name)
	print(fileName)

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
	var files = assetManager.getDirectoryFiles("user://assets/pad_presets")
	var res = []
	for f in files:
		var fn = f.get_file().get_basename()
		res.append(fn)
		
	return res

# Save track
func saveTrack(name, track):
	if name == "":
		return
		
	var data = track.toDict()
	saveDict(name, data)

# Load track
func loadTrack(name):
	return readDict(name)

# Delete track
func deleteTrack(name):
	var dir = Directory.new()
	dir.remove(getFileName(name))
	
extends Reference

var constants = preload("res://Scripts/Constants.gd")
var assetManager = preload("res://Scripts/AssetManager.gd").new()

func _getDrumkitsPath():
	"""
	Get drum kits path
	
	@return String
	"""
	return "%s/%s" % [constants.ASSETS_PATH, constants.DRUMKITS_PATH]

func loadDrumkit(name):
	"""
	Load drum kit by name
	
	@param String name - name of drum kit
	@return DrumKit - drumkit data
	Example:
		loadDrumkit("Rock")
	"""
	var kitFile = assetManager.loadFile("%s/%s.json" % [_getDrumkitsPath(), name])
	
func getDrumkitList():
	"""
	Get drum kit list
	
	@return Array<Drumkit> - list of drum kits
	"""
	var files = assetManager.getDirectoryFiles(_getDrumkitsPath())
	for f in files:
		var data = assetManager.loadFile(f)
		if data != null:
			var json = parse_json(data)
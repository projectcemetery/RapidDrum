extends Reference

var constants = preload("res://Scripts/Constants.gd")
var assetManager = preload("res://Scripts/AssetManager.gd").new()

func loadDrumkit(name):
	"""
	Load drum kit by name
	
	@param String name - name of drum kit
	
	Example:
		loadDrumkit("Rock")
	"""
	var kitFile = assetManager.loadFile("%s.json" % [name])
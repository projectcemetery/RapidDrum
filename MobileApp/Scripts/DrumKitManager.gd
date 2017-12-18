extends Reference

var constants = preload("res://Scripts/Constants.gd")
var assetManager = preload("res://Scripts/AssetManager.gd").new()

func initDrumkits():
	"""
	Init drum kits
	Copy from res to user
	"""
	
	var directory = Directory.new()
	var dstPath = assetManager.getFullPath("%s/%s" % [constants.ASSETS_PATH, constants.DRUMKITS_PATH])
	if (directory.dir_exists(dstPath)):
		return
	
	var srcPath = assetManager.getFullPathFromArray([constants.ASSETS_PATH, constants.DRUMKITS_PATH], true)
	print(directory.copy(srcPath, dstPath))
	
func loadDrumkit(name):
	"""
	Load drum kit by name
	
	@param String name - name of drum kit
	
	Example:
		loadDrumkit("Rock")
	"""
	var kitFile = assetManager.loadFile("%s.json" % [name])
extends Reference

var constants = preload("res://Scripts/Constants.gd")
var assetManager = preload("res://Scripts/AssetManager.gd").new()

func prepareContent():
	"""
	Prepare content for first use
	Copy built-in drum kits
	Copy presets
	
	@return void
	"""
	
	assetManager.copyDirectory(constants.BUILT_IN_ASSETS, constants.USER_ASSETS)
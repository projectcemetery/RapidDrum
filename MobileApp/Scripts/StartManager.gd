extends Reference

func _getKitFilePath(id):
	"""
	Get drum kit full path name
	
	@param id - drum kit id
	@return full path
	
	Example:
		var fileName = _getKitFilePath("Rock")
	"""
	
	return "%s/%s/%s.json" % [constants.ASSETS_PATH, constants.DRUMKITS_PATH]

func _initPresets():
	"""
	Init "song" presets
	Copy them from res to user
	"""
	pass

func _initDrumKits():
	"""
	Init drum kits
	Copy them from res to user
	"""
	pass

func prepareContent():
	"""
	Prepare content for first use
	Copy built-in drum kits
	Copy presets
	"""
	
	_initPresets()
	_initDrumKits()
extends Reference

static func prepareContent():
	"""
	Prepare content for first use
	Copy built-in drum kits
	Copy presets
	"""
	
	var presetManagerClass = load("res://Scripts/PresetManager.gd")
	var presetManager = presetManagerClass.new()
	presetManager.initPresets()
	
	var drumKitManagerClass = load("res://Scripts/DrumKitManager.gd")
	var drumKitManager = drumKitManagerClass.new()
	drumKitManager.initDrumkits()
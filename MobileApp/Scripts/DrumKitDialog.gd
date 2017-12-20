extends PopupDialog

var drumkitManager = preload("res://Scripts/DrumKitManager.gd").new()

# Downloaded list
var loadedList

# On node ready
func _ready():
	loadedList = get_node("TabContainer/Loaded/LoadedList")
	
func fillLoaded():
	"""
	Fill loaded drum kits
	
	@return void
	"""
	drumkitManager.getDrumkitList()
extends Reference

var collections = []

signal TrackPadChanged

# Constructor
func _init():
	pass

# On pad changed
func onPadChanged(x, y, index):
	emit_signal("TrackPadChanged", x, y, index)
	
# Add pad collection to track
func addPadCollection(coll):
	collections.append(coll)
	var index = len(collections) - 1
	coll.connect("PadChanged", self, "onPadChanged", [index])

# Return collection
func getPadCollection(index):
	return collections[index]
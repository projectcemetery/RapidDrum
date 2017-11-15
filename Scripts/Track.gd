extends Reference

var collections = []

signal TrackPadChanged

# Constructor
func _init():
	pass

# On pad changed
func onPadChanged(x, y, index):
	emit_signal("TrackPadChanged", x, y, index)

# Get collection count
func getCount():
	return len(collections)

# Add pad collection to track
func addPadCollection(coll):
	collections.append(coll)
	var index = len(collections) - 1
	coll.connect("PadChanged", self, "onPadChanged", [index])

# Remove collection by index
func removePadCollection(index):
	collections.remove(index)

# Return collection
func getPadCollection(index):
	return collections[index]
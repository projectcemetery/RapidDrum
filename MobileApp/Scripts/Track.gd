extends Reference

# Collections of track
var collections = []

# Tempo of track
var tempo
# On pad change
signal TrackPadChanged

# Constructor
func _init():
	pass

# Set track tempo
func setTempo(v):
	tempo = v

# Get tempo
func getTempo():
	return tempo

# On pad changed
func onPadChanged(x, y, pressed, index):
	emit_signal("TrackPadChanged", x, y, pressed, index)

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

# Convert track to dict
func toDict():
	var lst = []
	for col in collections:
		lst.append(col.toDict())
	
	return {
		"tempo" : tempo,
		"collections" : lst
	}
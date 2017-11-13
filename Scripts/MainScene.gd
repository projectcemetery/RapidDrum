extends Node2D

var constants = preload("res://Scripts/Constants.gd")
var padCollectionClass = preload("res://Scripts/PadCollection.gd")
var trackClass = load("res://Scripts/Track.gd")

# Current page count
var pageNumber = 0
# Control for manipulation with pads
var padControl
# Pad player
var padPlayer
# Track to play
var track 

# On pad changed
func onPadChanged(x, y):
	print(x,y)

# On ready
func _ready():
	track = trackClass.new()
	
	for i in range(0, constants.PAGE_COUNT):
		var padColl = padCollectionClass.new()
		track.addPadCollection(padColl)

	padControl = get_node("MainUI/PadControl")
	padControl.setPadCollection(track.getPadCollection(pageNumber))
	padPlayer = get_node("PadPlayer")

# On play button toggled
func _on_PlayButton_toggled(pressed):
	pass
#	if pressed:
#		padPlayer.start()
#	else:
#		padPlayer.stop()

# On page changed
func _on_PageControl_PageChanged(page):
	pageNumber = page

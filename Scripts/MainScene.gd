extends Node2D

var constants = preload("res://Scripts/Constants.gd")
var padCollectionClass = preload("res://Scripts/PadCollection.gd")
var trackClass = preload("res://Scripts/Track.gd")
var kitClass = preload("res://Scripts/DrumKit.gd")

# Current page count
var pageNumber = 0
# Control for manipulation with pads
var padControl
# Pad player
var padPlayer
# Track to play
var track 
# Drum kit
var drumKit

# On ready
func _ready():
	track = trackClass.new()
	drumKit = kitClass.new(self)
	
	for i in range(0, constants.PAGE_COUNT):
		var padColl = padCollectionClass.new()
		track.addPadCollection(padColl)

	padControl = get_node("MainUI/PadControl")
	padControl.setPadCollection(track.getPadCollection(pageNumber))
	padPlayer = get_node("PadPlayer")
	padPlayer.setTrack(track)
	padPlayer.setKit(drumKit)

# On play button toggled
func _on_PlayButton_toggled(pressed):	
	if pressed:
		padPlayer.play()
	else:
		padPlayer.stop()

# On page changed
func _on_PageControl_PageChanged(page):
	pageNumber = page

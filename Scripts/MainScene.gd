extends Node2D

var constants = preload("res://Scripts/Constants.gd")
var padCollectionClass = preload("res://Scripts/PadCollection.gd")
var trackClass = preload("res://Scripts/Track.gd")
var kitClass = preload("res://Scripts/DrumKit.gd")

# Current page count
var pageNumber = 0
# Control for manipulation with pads
var padControl
# Page control
var pageControl
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
	
	var padColl = padCollectionClass.new()
	track.addPadCollection(padColl)

	padControl = get_node("MainUI/PadControl")
	padControl.setPadCollection(track.getPadCollection(pageNumber))	
	padPlayer = get_node("PadPlayer")
	padPlayer.setTrack(track)
	padPlayer.setKit(drumKit)
	
	pageControl = get_node("MainUI/PageControl")
	padPlayer.setTempo(constants.DEFAULT_TEMPO)

# Update pad collection for pad control
func updatePadCollection():
	var coll = track.getPadCollection(pageNumber)
	padControl.setPadCollection(coll)

# On play button toggled
func _on_PlayButton_toggled(pressed):	
	if pressed:
		pageControl.block()
		pageControl.switchToPage(0)
		padPlayer.play()
	else:
		pageControl.unblock()
		padControl.clearTicks()
		padPlayer.stop()

# On page changed
func _on_PageControl_PageChanged(page):
	pageNumber = page
	updatePadCollection()

# On page added
func _on_PageControl_PageAdded():
	var padColl = padCollectionClass.new()
	track.addPadCollection(padColl)
	pageNumber += 1
	updatePadCollection()

# On page removed
func _on_PageControl_PageRemoved():
	track.removePadCollection(pageControl.getCount())
	pageNumber -= 1
	updatePadCollection()

# On player step changed
func _on_PadPlayer_PlayerStepChanged(step):
	padControl.setActiveTick(step)

# On player page/collection changed
func _on_PadPlayer_CollectionChanged(page):
	pageControl.switchToPage(page)

# On tempo changed
func _on_TempoControl_TempoChanged(tempo):
	padPlayer.setTempo(tempo)

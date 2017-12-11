extends Node2D

var constants = preload("res://Scripts/Constants.gd")
var padCollectionClass = preload("res://Scripts/PadCollection.gd")
var trackClass = preload("res://Scripts/Track.gd")
var kitClass = preload("res://Scripts/DrumKit.gd")
var presetManagerClass = load("res://Scripts/PresetManager.gd")

# Current page count
var pageNumber = 0
# Control for manipulation with pads
var padControl
# Page control
var pageControl
# Pad player
var padPlayer
# Tempo control
var tempoControl
# Track to play
var track 
# Drum kit
var drumKit

# For loading and saving presets
var presetManager
# Dialog for open track
var openDialog
# Dialog for save track
var saveDialog

# On ready
func _ready():
	track = trackClass.new()
	drumKit = kitClass.new(self)
	
	var padColl = padCollectionClass.new()
	track.addPadCollection(padColl)

	padControl = get_node("MainUI/PadControl")
	padPlayer = get_node("PadPlayer")
	padPlayer.setKit(drumKit)
	
	pageControl = get_node("MainUI/PageControl")
	track.setTempo(constants.DEFAULT_TEMPO)
	
	tempoControl = get_node("MainUI/TempoControl")
	
	openDialog = get_node("MainUI/OpenDialog")
	saveDialog = get_node("MainUI/SaveDialog")
	presetManager = presetManagerClass.new()
	
	var vol = constants.MIN_BUS_VOLUME + constants.DEFAULT_VOLUME
	AudioServer.set_bus_volume_db(constants.DEFAULT_BUS_INDEX, vol)
	
	setTrack(track)

# Set track
func setTrack(tr):
	pageNumber = 0
	track = tr
	padControl.setPadCollection(track.getPadCollection(pageNumber))
	padPlayer.setTrack(track)
	tempoControl.setTempo(track.getTempo())
	updatePadCollection()

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
	track.setTempo(tempo)

# On open button pressed
func _on_OpenButton_pressed():
	var lst = presetManager.getList()
	openDialog.setList(lst)
	openDialog.popup()

# On save button pressed
func _on_SaveButton_pressed():
	var lst = presetManager.getList()
	saveDialog.setList(lst)
	saveDialog.popup()

# On save track
func _on_SaveDialog_SaveTrack(trackName):
	saveDialog.hide()
	presetManager.saveTrack(trackName, track)

# On open track
func _on_OpenDialog_OpenTrack(name):
	var trackData = presetManager.loadTrack(name)
	if trackData != null:
		var tempo = trackData["tempo"]
		var colls = trackData["collections"]
		var tr = trackClass.new()
		tr.setTempo(int(tempo))
		for data in colls:
			var col = padCollectionClass.new()
			col.fromDict(data)
			tr.addPadCollection(col)
		setTrack(tr)
		pageControl.setPageCount(len(colls))
		pageControl.switchToPage(0)
	openDialog.hide()

# On delete track
func _on_SaveDialog_DeleteTrack(name):
	presetManager.deleteTrack(name)
	var lst = presetManager.getList()
	saveDialog.setList(lst)

# On volume chagne
func _on_VolumeControl_VolumeChange(volume):
	var vol = constants.MIN_BUS_VOLUME + volume	
	AudioServer.set_bus_volume_db(constants.DEFAULT_BUS_INDEX, vol)

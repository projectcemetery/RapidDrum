extends Node2D

var constants = preload("res://Scripts/Constants.gd")
var padCollectionClass = preload("res://Scripts/PadCollection.gd")

# Collection of Pad data
var padCollection
# Control for manipulation with pads
var padControl
# Pad player
var padPlayer

var snarePlay
var stepPlay = 0
var players = []

# On ready
func _ready():
	padCollection = padCollectionClass.new()
	padControl = get_node("PadControl")
	padControl.setPadCollection(padCollection)
	padPlayer = get_node("PadPlayer")

# On play button toggled
func _on_PlayButton_toggled(pressed):	
	if pressed:
		padPlayer.start()
	else:
		padPlayer.stop()

# On page changed
func _on_PageControl_PageChanged(pageNumber):
	print(pageNumber)

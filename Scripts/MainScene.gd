extends Node2D

var constants = preload("res://Scripts/Constants.gd")
var padCollectionClass = preload("res://Scripts/PadCollection.gd")

# Collections of Pad data
var padList = []
# Current page count
var pageNumber = 0
# Control for manipulation with pads
var padControl
# Pad player
var padPlayer


# On ready
func _ready():
	for i in range(0, constants.PAGE_COUNT):
		padList.append(padCollectionClass.new())

	padControl = get_node("MainUI/PadControl")
	padControl.setPadCollection(padList[pageNumber])
	padPlayer = get_node("PadPlayer")

# On play button toggled
func _on_PlayButton_toggled(pressed):	
	if pressed:
		padPlayer.start()
	else:
		padPlayer.stop()

# On page changed
func _on_PageControl_PageChanged(page):
	pageNumber = page

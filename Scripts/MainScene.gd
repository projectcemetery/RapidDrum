extends Node2D

var constants = preload("res://Scripts/Constants.gd")
var padCollectionClass = preload("res://Scripts/PadCollection.gd")

# Collection of Pad data
var padCollection
# Control for manipulation with pads
var padControl
# Timer for playing
var playerTimer

var snarePlay
var stepPlay = 0
var players = []

# On ready
func _ready():
	padCollection = padCollectionClass.new()
	padControl = get_node("PadControl")
	playerTimer = get_node("PlayerTimer")
	padControl.setPadCollection(padCollection)
	snarePlay = get_node("AudioStreamPlayer2D")	

# Fill players for timer
func fillPlayers():
	players = []
	for x in range(0, constants.PAD_COL_COUNT):
		var col = padCollection.getCol(x)
		print(col)
		if col[7] == true:
			players.append(snarePlay)
		else:
			players.append(null)

# On play button toggled
func _on_PlayButton_toggled(pressed):
	stepPlay = 0
	if pressed:
		fillPlayers()
		playerTimer.start()
	else:
		playerTimer.stop()

# Player timer work
func _on_PlayerTimer_timeout():
	var player = players[stepPlay]
	if player != null:
		player.play()
	
	stepPlay += 1
	if stepPlay >= constants.PAD_COL_COUNT:
		stepPlay = 0

# On page changed
func _on_PageControl_PageChanged(pageNumber):
	print(pageNumber)

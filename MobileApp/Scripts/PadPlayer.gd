extends Node

# Constant to get Sixth from Fourth
const FOUR = 4

var constants = preload("res://Scripts/Constants.gd")

# Timer player
var player
# Track to play
var track
# Kit to play
var drumKit
# Play list to play
var playList = []
# Play step
var step = 0
# Playlist count
var listCount = 0
# Page or collection's count
var pageCount = 0
# Current page
var currentPage = 0

# Player start play other collection
signal CollectionChanged
# Step changed
signal PlayerStepChanged

func _ready():
	player = get_node("PlayerTimer")

# Set kit to play
func setKit(kit):
	drumKit = kit
	
# Set track for playing
func setTrack(tr):
	track = tr
	setTempo(tr.getTempo())

# Set play tempo
func setTempo(tempo):
	player.wait_time = 60.0 / (tempo * FOUR)

# Create playlist for kit
func createPlaylist():
	playList.clear()
	pageCount = track.getCount()
	for x in range(0, pageCount):
		var coll = track.getPadCollection(x)
			
		var collSum = coll.getColSumm()
		for cl in collSum:
			playList.append(cl)
	
	listCount = len(playList)

# Start play
func play():
	step = 0
	currentPage = 0
	createPlaylist()
	player.start()

# Stop play
func stop():
	player.stop()

# On timer
func _on_PlayerTimer_timeout():
	var pattern = playList[currentPage * constants.PAD_COL_COUNT + step]	
	emit_signal("PlayerStepChanged", step)
	drumKit.play(pattern)
	step += 1
	
	if step >= constants.PAD_COL_COUNT:
		step = 0
		currentPage += 1
		if currentPage >= pageCount:
			currentPage = 0
		emit_signal("CollectionChanged", currentPage)

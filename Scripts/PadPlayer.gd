extends Node

# Timer player
var player
# Track to play
var track
# Kit to play
var kit

func _ready():
	player = get_node("PlayerTimer")

# Set kit to play
func setKit(kit):
	pass
	
# Set track for playing
func setTrack(track):
	pass

# Start play
func play():
	player.start()

# Stop play
func stop():
	player.stop()

# On timer
func _on_PlayerTimer_timeout():
	pass

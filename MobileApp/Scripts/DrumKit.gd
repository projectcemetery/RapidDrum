extends Reference

# Samples to play
var samples = []

# AudioStreamPlayer2D without parent does not play
var parentNode

# Constructor
func _init(node):
	parentNode = node
	
func newStream(name):
	var nstream = AudioStreamPlayer.new()
	var path = "res://Assets/%s" % name
	nstream.stream = load(path)	
	nstream.autoplay = false
	parentNode.add_child(nstream)
	return nstream
	
# Play kit pattern
func play(pattern):
	for i in range(0, len(pattern)):
		var need = pattern[i]
		if need:
			samples[i].play()

# Remove drum kit and all nodes
func remove():
	for sample in samples:
		sample.remove()

# Get kit list from disk
func getKitList():
	pass

# Load kit from disk
func loadKit(name):
	# TODO: load from kit file
	samples.append(newStream("rock-crash.wav"))
	samples.append(newStream("rock-tom1.wav"))
	samples.append(newStream("rock-tom2.wav"))
	samples.append(newStream("rock-tom3.wav"))
	samples.append(newStream("rock-hhopen.wav"))
	samples.append(newStream("rock-hhclosed.wav"))
	samples.append(newStream("rock-kick.wav"))
	samples.append(newStream("rock-snare.wav"))
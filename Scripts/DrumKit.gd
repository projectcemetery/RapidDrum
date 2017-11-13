extends Reference

var samples = []

# Constructor
func _init():
	samples.append(newStream("crash.wav"))
	samples.append(newStream("tom1.wav"))
	samples.append(newStream("tom2.wav"))
	samples.append(newStream("tom3.wav"))
	samples.append(newStream("openhat.wav"))
	samples.append(newStream("closedhat.wav"))
	samples.append(newStream("kick.wav"))
	samples.append(newStream("snare.wav"))
	
func newStream(name):
	var nstream = AudioStreamPlayer2D.new()
	return nstream
	
# Play kit pattern
func play(pattern):
	for i in range(0, len(pattern)):
		samples[i].play()
extends Reference

var samples = []

# AudioStreamPlayer2D without parent does not play
var parentNode

# Constructor
func _init(node):
	parentNode = node
	samples.append(newStream("CYCdh_Kurz01-Crash01.wav"))
	samples.append(newStream("CyCdh_K3Tom-01.wav"))
	samples.append(newStream("CyCdh_K3Tom-04.wav"))
	samples.append(newStream("CyCdh_K3Tom-05.wav"))
	samples.append(newStream("CYCdh_K2room_OpHat-01.wav"))
	samples.append(newStream("CYCdh_K6-ClHat.wav"))
	samples.append(newStream("CYCdh_Kurz05-Kick01.wav"))
	samples.append(newStream("CYCdh_K6-Snr02.wav"))
	
func newStream(name):
	var nstream = AudioStreamPlayer.new()
	var path = "res://Assets/%s" % name
	nstream.stream = load(path)
	parentNode.add_child(nstream)
	return nstream
	
# Play kit pattern
func play(pattern):
	for i in range(0, len(pattern)):
		var need = pattern[i]
		if need:
			samples[i].play()
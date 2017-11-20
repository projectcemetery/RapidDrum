extends Control

var constants = preload("res://Scripts/Constants.gd")

const MINIMAL_TEMPO = 60
const MAX_TEMPO = 160

# Current tempo
var tempo = constants.DEFAULT_TEMPO
# Label to show tempo
var tempoLabel

# On tempo changed
signal TempoChanged

func _ready():
	tempoLabel = get_node("ColorRect2/TempoValue")

# Update label text
func updateLabel():
	tempoLabel.text = str(tempo)

# Set tempo
func setTempo(v):
	tempo = int(v)
	updateLabel()

# Get tempo
func getTempo():
	return tempo

# On add tempo button down
func _on_AddTempoButton_button_down():
	tempo += 1
	if tempo > MAX_TEMPO:
		tempo = MAX_TEMPO
	else:
		updateLabel()
		emit_signal("TempoChanged", tempo)


func _on_SubTempoButton_button_down():
	tempo -= 1
	if tempo < MINIMAL_TEMPO:
		tempo = MINIMAL_TEMPO
	else:
		updateLabel()
		emit_signal("TempoChanged", tempo)

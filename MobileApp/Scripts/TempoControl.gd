extends Control

var constants = preload("res://Scripts/Constants.gd")

const MINIMAL_TEMPO = 60
const MAX_TEMPO = 160

# Current tempo
var tempo = constants.DEFAULT_TEMPO
# Label to show tempo
var tempoLabel
# Tempo slider
var tempoSlider

# On tempo changed
signal TempoChanged

func _ready():
	tempoLabel = get_node("TempoLed/TempoValue")
	tempoSlider = get_node("TempoSlider")

# Update label text
func updateUi():
	tempoLabel.text = str(tempo)
	tempoSlider.value = tempo

# Set tempo
func setTempo(v):
	tempo = int(v)
	updateUi()

# Get tempo
func getTempo():
	return tempo

# On add tempo button down
func _on_AddTempoButton_button_down():
	tempo += 1
	if tempo > MAX_TEMPO:
		tempo = MAX_TEMPO
	else:
		updateUi()
		emit_signal("TempoChanged", tempo)

# On substract button down
func _on_SubTempoButton_button_down():
	tempo -= 1
	if tempo < MINIMAL_TEMPO:
		tempo = MINIMAL_TEMPO
	else:
		updateUi()
		emit_signal("TempoChanged", tempo)

# On tempo slider change
func _on_TempoSlider_value_changed(value):
	tempo = value
	emit_signal("TempoChanged", value)
	updateUi()

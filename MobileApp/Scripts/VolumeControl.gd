extends TextureRect

var constants = preload("res://Scripts/Constants.gd")

# On volume change
signal VolumeChange

var volume = constants.DEFAULT_VOLUME

# On control ready
func _ready():
	pass

# On slider change
func _on_VolumeSlider_value_changed(value):
	volume = value
	emit_signal("VolumeChange", volume)

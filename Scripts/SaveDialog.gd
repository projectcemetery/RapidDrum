extends PopupDialog

# Default track name
const DEFAULT_TRACK_NAME = "My Preset"

# File name edit
var fileEdit

# On track save
signal SaveTrack

func _ready():
	fileEdit = get_node("FileEdit")
	fileEdit.set_text(DEFAULT_TRACK_NAME)

# On cancel button pressed
func _on_CancelButton_pressed():
	hide()

# On save button pressed
func _on_SaveButton_pressed():
	emit_signal("SaveTrack", fileEdit.get_text())

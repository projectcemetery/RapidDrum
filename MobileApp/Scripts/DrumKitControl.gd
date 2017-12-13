extends Control

# Drum kit select dialog
var drumKitDialog

# On node ready
func _ready():
	drumKitDialog = get_node("../Dialogs/DrumKitDialog")

# On select kit button pressed
func _on_SelectKitButton_pressed():
	drumKitDialog.show_modal()

# On select cancel pressed
func _on_CancelButton_pressed():
	drumKitDialog.hide()

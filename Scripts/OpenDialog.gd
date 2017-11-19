extends PopupDialog

# List view of presets
var listView

signal OpenTrack

func _ready():
	listView = get_node("ItemList")

# Set list
func setList(lst):
	listView.clear()
	for name in lst:
		listView.add_item(name)

# On cancel button press
func _on_CancelButton_pressed():
	hide()

# On open button
func _on_OpenButton_pressed():
	var selectedLst = listView.get_selected_items()
	if len(selectedLst) < 1:
		return
		
	var name = listView.get_item_text(selectedLst[0])
	emit_signal("OpenTrack", name)

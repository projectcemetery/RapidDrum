extends PopupDialog

# Default track name
const DEFAULT_TRACK_NAME = "My Preset"

# File name edit
var fileEdit
# List view
var listView

# On track save
signal SaveTrack
# On track delete
signal DeleteTrack

func _ready():
	listView = get_node("ItemList")
	fileEdit = get_node("FileEdit")
	fileEdit.set_text(DEFAULT_TRACK_NAME)

# Get selected item name
func getSelectedName():
	var selectedLst = listView.get_selected_items()
	if len(selectedLst) < 1:
		return null
		
	return listView.get_item_text(selectedLst[0])

# Set list
func setList(lst):
	listView.clear()
	for name in lst:
		listView.add_item(name)

# On cancel button pressed
func _on_CancelButton_pressed():
	hide()

# On save button pressed
func _on_SaveButton_pressed():
	emit_signal("SaveTrack", fileEdit.get_text())

# On item selected
func _on_ItemList_item_selected(index):
	var name = listView.get_item_text(index)
	fileEdit.set_text(name)

# On delete button pressed
func _on_DeleteButton_pressed():
	var name = getSelectedName()
	if name == null:
		return
	emit_signal("DeleteTrack", name)

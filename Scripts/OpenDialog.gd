extends PopupDialog

var listView

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

extends Control

var constants = preload("res://Scripts/Constants.gd")

# On page selected signal
signal PageChanged
# On page added
signal PageAdded
# On page aremoved
signal PageRemoved

# Current page index
var currentPage = 0
# Total page count
var pageCount = 1

func _ready():
	pass

# Add page
func addPage():
	pageCount += 1
	var name = "PageButton%s" % pageCount
	get_node(name).visible = true
	get_node(name).pressed = true

# Remove page
func removePage():
	var name = "PageButton%s" % pageCount
	var prevName = "PageButton%s" % (pageCount - 1)
	var node = get_node(name)
	var prevNode = get_node(prevName)
	node.visible = false
	prevNode.pressed = true
	pageCount -= 1

func _on_PageButton1_toggled(pressed):
	if pressed:
		currentPage = 0
		emit_signal("PageChanged", currentPage)

func _on_PageButton2_toggled( pressed ):
	if pressed:
		currentPage = 1
		emit_signal("PageChanged", currentPage)

func _on_PageButton3_toggled(pressed):
	if pressed:
		currentPage = 2
		emit_signal("PageChanged", currentPage)

func _on_PageButton4_toggled(pressed):
	if pressed:
		currentPage = 3
		emit_signal("PageChanged", currentPage)

# On add page
func _on_AddPageButton_pressed():	
	if pageCount >= constants.PAGE_COUNT:
		return
	addPage()
	emit_signal("PageAdded")

# On delete page
func _on_SubPageButton_pressed():
	if pageCount <= 1:
		return
	removePage()
	emit_signal("PageRemoved")

# Return current page
func getCurrentPage():
	return currentPage

# Return page count
func getCount():
	return pageCount

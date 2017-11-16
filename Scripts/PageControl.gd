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
# Node to block input
var blockerNode

# On ready
func _ready():
	blockerNode = get_node("Blocker")

# Get button name by page number 
func getButtonByPage(page):
	var name = "PageButton%s" % page
	return get_node(name)

# Add page
func addPage():
	pageCount += 1
	var node = getButtonByPage(pageCount)
	node.visible = true
	node.pressed = true

# Remove page
func removePage():
	var node = getButtonByPage(pageCount)
	var prevNode = getButtonByPage(pageCount - 1)
	node.visible = false
	prevNode.pressed = true
	pageCount -= 1
	
# Switch to page
func switchToPage(page):
	currentPage = page
	var node = getButtonByPage(page + 1)
	node.pressed = true
	emit_signal("PageChanged", currentPage)

# Return current page
func getCurrentPage():
	return currentPage

# Return page count
func getCount():
	return pageCount

# Block input
func unblock():
	blockerNode.visible = false

# Block input
func block():
	blockerNode.visible = true

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

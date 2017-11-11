extends Control

signal PageChanged

var currentPage = 1

func _ready():
	pass

func _on_PageButton1_toggled(pressed):
	if pressed:
		currentPage = 1
		emit_signal("PageChanged", currentPage)

func _on_PageButton2_toggled( pressed ):
	if pressed:
		currentPage = 2
		emit_signal("PageChanged", currentPage)


func _on_PageButton3_toggled( pressed ):
	if pressed:
		currentPage = 3
		emit_signal("PageChanged", currentPage)


func _on_PageButton4_toggled( pressed ):
	if pressed:
		currentPage = 4
		emit_signal("PageChanged", currentPage)

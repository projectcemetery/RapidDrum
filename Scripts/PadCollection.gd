extends Reference

# Pad collection

var constants = preload("res://Scripts/Constants.gd")

var grid = {}

signal PadChanged

func _init():
	for x in range(0, constants.PAD_COL_COUNT):
		var col = {}
		for y in range(0, constants.PAD_ROW_COUNT):
			col[y] = false
		grid[x] = col

# Set pad value
func setPad(x, y, pressed):
	grid[x][y] = pressed
	emit_signal("PadChanged", x, y)
	
# Get column values
func getCol(col):
	var res = []
	var column = grid[col]
	for y in range(0, constants.PAD_ROW_COUNT):
		res.append(column[y])
	return res
	
# Get summ of columns as list of booleans
func getColSumm():
	var res = []
	for x in range(0, constants.PAD_COL_COUNT):
		var colData = []
		var column = grid[x]
		for y in range(0, constants.PAD_ROW_COUNT):			
			colData.append(column[y])
		res.append(colData)
	return res
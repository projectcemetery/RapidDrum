extends Reference

# Pad collection

var constants = preload("res://Scripts/Constants.gd")

var grid = {}

func _init():
	for x in range(0, constants.PAD_COL_COUNT):
		var col = {}
		for y in range(0, constants.PAD_ROW_COUNT):
			col[y] = false
		grid[x] = col

# Set pad value
func setPad(col, row, pressed):
	grid[col][row] = pressed
	
# Get column values
func getCol(col):
	var res = []
	var column = grid[col]
	for y in range(0, constants.PAD_ROW_COUNT):
		res.append(column[y])
	return res
	
# Get row values
func getRow(row):
	pass
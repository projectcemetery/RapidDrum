extends Reference

# Pad collection

var constants = preload("res://Scripts/Constants.gd")

# Is collection empty
var isEmpty = true
# Filled pads
var filled = 0
# Pad grid
var grid = {}

# On pad changed signal
signal PadChanged

# Constructor
func _init():
	for x in range(0, constants.PAD_COL_COUNT):
		var col = {}
		for y in range(0, constants.PAD_ROW_COUNT):
			col[y] = false
		grid[x] = col

# Is collection has pads
func hasPads():
	return not isEmpty

# Set pad value
func setPad(x, y, pressed):
	grid[x][y] = pressed
	if pressed:
		filled += 1
		isEmpty = false
	else:
		filled -= 1
		
	if filled < 1:
		isEmpty = true
	
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

# Fill collection from
func fromDict(dict):
	grid = {}
	for k in dict.keys():
		var col = {}
		var dcol = dict[k]
		for c in dcol.keys():
			col[int(c)] = dcol[c]
		grid[int(k)] = col

# To dictionary
func toDict():
	return grid
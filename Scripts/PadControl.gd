extends TextureRect

var constants = preload("res://Scripts/Constants.gd")

# Padding beetwen pad
const PAD_PADDING = 4

# Texture for normal pad
var normalTexture
# Texture for pressed pad
var pressTexture
# Pad width and height
var padSize = 50

# Grid of pad
var grid = {}
# Current Pad collection
var padCollection

# On pad button pressed
func onPadPressed(sender, x, y):
	padCollection.setPad(x, y, sender.pressed)

# Create pad button
func createPadButton(x, y, width, height):
	var px = x * (padSize + PAD_PADDING)
	var py = y * (padSize + PAD_PADDING)
	
	var butt = TextureButton.new()
	butt.expand = true
	butt.toggle_mode = true
	butt.set_position(Vector2(px, py))
	butt.texture_normal = normalTexture
	butt.texture_pressed = pressTexture
	butt.set_size(Vector2(width, height))
	butt.connect("pressed", self, "onPadPressed", [butt, x, y])
	add_child(butt)
	return butt

# Create drum pad panel
func createPadPanel():
	for x in range(0, constants.PAD_COL_COUNT):
		for y in range(0, constants.PAD_ROW_COUNT):
			grid[y][x] = createPadButton(x, y, padSize, padSize)

# Init pad grid
func initGrid():
	for x in range(0, constants.PAD_COL_COUNT):
		var col = {}
		for y in range(0, constants.PAD_ROW_COUNT):
			col[y] = null
		grid[x] = col

func applyCollection(padColl):
	for x in range(0, constants.PAD_COL_COUNT):
		var column = padColl.getCol(x)
		for y in range(0, len(column)):
			grid[y][x].pressed = column[y]

# Set pad collection
func setPadCollection(padColl):
	padCollection = padColl
	applyCollection(padColl)

func _ready():
	initGrid()
	var size = get_size()
	padSize = round(size.x / (constants.PAD_COL_COUNT + 1) + 1)
	normalTexture = preload("res://Assets/PadButtonNormal.png")
	pressTexture = preload("res://Assets/PadButtonPressed.png")
	createPadPanel()

extends TextureRect

var constants = preload("res://Scripts/Constants.gd")

# Padding beetwen pad
const PAD_PADDING = 4

# Tick height
const TICK_HEIGHT = 20

# Texture for normal pad
var normalTexture
# Texture for pressed pad
var pressTexture
# Pad width and height
var padSize = 50

# Grid of pad
var grid = {}
# Ticks 
var ticks = []
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

# Create tick
func createTick(x):
	var px = x * (padSize + PAD_PADDING)
	var py = constants.PAD_ROW_COUNT * (padSize + PAD_PADDING) + PAD_PADDING
	var tick = TextureRect.new()
	tick.expand = true
	tick.texture = preload("res://Assets/TickNormal.png")
	tick.set_size(Vector2(padSize, TICK_HEIGHT))
	tick.set_position(Vector2(px, py))
	add_child(tick)
	ticks.append(tick)

# Clear tick activity
func clearTicks():
	for tick in ticks:
		tick.texture = preload("res://Assets/TickNormal.png")
	setActiveTick(0)

# Set active tick
func setActiveTick(x):
	var last = x - 1
	
	if last < 0:
		last = 0
	
	if last == 0:
		ticks[constants.PAD_COL_COUNT - 1].texture = preload("res://Assets/TickNormal.png")
	
	ticks[last].texture = preload("res://Assets/TickNormal.png")
	ticks[x].texture = preload("res://Assets/TickActive.png")

# Create drum pad panel
func createPadPanel():
	for x in range(0, constants.PAD_COL_COUNT):
		for y in range(0, constants.PAD_ROW_COUNT):
			grid[y][x] = createPadButton(x, y, padSize, padSize)
		createTick(x)
		
	# Set to start
	setActiveTick(0)

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

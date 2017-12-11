extends TextureButton

# Icon move size
const ICON_MOVE_Y = 8

# Icon node
var icon

func _ready():
	icon = get_node("Icon")

# On button down
func _on_button_down():
	icon.rect_position.y += ICON_MOVE_Y

# On button up
func _on_button_up():
	icon.rect_position.y -= ICON_MOVE_Y

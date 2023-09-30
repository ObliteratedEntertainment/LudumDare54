extends Control

@onready var texture_rect = $TextureRect

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED

func show_dragging(item: Item):
	visible = true
	texture_rect.texture = item.get_sprite().texture
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func hide_dragging():
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta):
	global_position = get_global_mouse_position()
	
	if Input.is_action_just_released("ui_click"):
		visible = false

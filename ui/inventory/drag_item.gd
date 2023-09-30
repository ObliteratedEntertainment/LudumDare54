extends Control

@onready var sprite_2d = $Sprite2D

var dragging_item: Item = null

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED

func show_dragging(item: Item):
	visible = true
	dragging_item = item
	sprite_2d.texture = item.sprite.texture
	#sprite_2d.position = item.item_center * -16.0 + Vector2(-8,-8)
	sprite_2d.rotation_degrees = dragging_item.slot_rotation
	sprite_2d.scale = Vector2.ONE*1.2
	#sprite_2d.size = item.sprite.texture.get_size() * 1.2
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func hide_dragging():
	visible = false
	dragging_item = null
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta):
	global_position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("item_rotate") and dragging_item != null:
		dragging_item.slot_rotation = (dragging_item.slot_rotation + 90) % 360
		sprite_2d.rotation_degrees += 90.0
		
		ItemManager.item_rotated.emit(dragging_item)

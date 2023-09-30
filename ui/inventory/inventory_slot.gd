extends TextureRect
class_name InventorySlot



signal started_dragging(Item)
signal ended_dragging()

signal slot_hovered(InventorySlot, Item)


@export var coord := Vector2i.ZERO

# Reference to your parent inventory
var inventory = null

var contains_item: Item = null

var displaying: Sprite2D = null

var original_modulation = null

# Called when the node enters the scene tree for the first time.
func _ready():
	original_modulation = self_modulate


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func is_filled() -> bool:
	return contains_item != null

func highlight():
	if contains_item == null:
		self_modulate = Color.CADET_BLUE + (Color.WHITE - original_modulation)
	else:
		if displaying != null:
			displaying.self_modulate = Color.DARK_RED
		self_modulate = Color.DARK_RED + (Color.WHITE - original_modulation)
		

func unhighlight():
	self_modulate = original_modulation
	if displaying != null:
		displaying.self_modulate = Color.WHITE

func set_item(item: Item, display: bool):
	contains_item = item
	
	
	if display:
		displaying = Sprite2D.new()
		displaying.texture = item.sprite.texture
		displaying.position = Vector2i(8,8)
		displaying.offset = item.sprite.offset
		displaying.rotation_degrees = item.slot_rotation
		displaying.z_index = 1
		
		add_child(displaying)

func remove_item(item: Item):
	print("remove from: ", name)
	if contains_item == item:
		contains_item = null
	
		if displaying != null:
			remove_child(displaying)

func _get_drag_data(at_position):
	
	if contains_item == null:
		return null
	
	var item := contains_item
	
	
	var data = {
		"item": item
	}
	
	inventory.remove_item(item)
	
	started_dragging.emit(item)
	
	
	
	return data

func _drop_data(at_position, data):
	
	if "item" not in data and data["item"] == null:
		return
	
	print("dropping item into slot: ", name)
	var item: Item = data["item"]
	
	var worked = inventory.try_item_at_slot(self, item)
	
	ended_dragging.emit()
	
func _can_drop_data(at_position, data):
	slot_hovered.emit(self, data["item"])
	return true

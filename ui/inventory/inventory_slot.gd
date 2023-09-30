extends TextureRect
class_name InventorySlot



signal started_dragging(Item)
signal ended_dragging()

signal slot_hovered(InventorySlot, Item)


@export var coord := Vector2i.ZERO

# Reference to your parent inventory
var inventory = null

var contains_item: Item = null

var displaying = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func is_filled() -> bool:
	return contains_item != null

func highlight():
	if contains_item == null:
		modulate = Color.CADET_BLUE
	else:
		modulate = Color.DARK_RED

func unhighlight():
	modulate = Color.WHITE

func remove_item():
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
	started_dragging.emit()
	
	
	inventory.remove_item(item)
	
	started_dragging.emit(item)
	
	
	
	return data

func _drop_data(at_position, data):
	
	if "item" not in data and data["item"] == null:
		return
	
	print("dropping item into slot: ", name)
	var item: Item = data["item"]
	
	var worked = inventory.try_item_at_slot(self, item)
	
	if worked:
		displaying = TextureRect.new()
		displaying.texture = item.get_sprite().texture
		displaying.z_index = 1
		
		add_child(displaying)
	
	ended_dragging.emit()
	
func _can_drop_data(at_position, data):
	slot_hovered.emit(self, data["item"])
	return true

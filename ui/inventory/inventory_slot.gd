extends TextureRect
class_name InventorySlot

# Inventory Slots are blocked for certain bag types
@export var blocked := false

@export var coord := Vector2i.ZERO

# Track if this slot contains part of an item. 
# This same item can be in multiple InventorySlots based on its item shape
var contains_item: Item = null

# Only one of the InventorySlots will be responsible for displaying the item even if it spans multiple slots
# The InventorySlot that displays the item will be the "center_slot" of the item
var displaying: Sprite2D = null

# Track the original modulation of the InventorySlot to give it its checkboard appearance even when we tweak modulation
var original_modulation = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if blocked:
		set_blocked()
	
	original_modulation = self_modulate
	original_modulation.a = 0.2
	self_modulate = original_modulation


func set_blocked():
	blocked = true
	modulate = Color(0,0,0,0)

func is_filled() -> bool:
	return contains_item != null or blocked

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

func _get_drag_data(_at_position):
	
	if contains_item == null:
		return null
	
	var item := contains_item
	var data = {
		"item": item
	}
	
	ItemManager.inventory_staged_remove.emit(item)
	ItemManager.item_dragging_started.emit(item)
	
	return data

func _drop_data(_at_position, data):
	
	if "item" not in data and data["item"] == null:
		return
	
	var item: Item = data["item"]
	
	
	ItemManager.inventory_slot_dropped.emit(self, item)
	ItemManager.item_dragging_stopped.emit(item, true)
	
func _can_drop_data(_at_position, data):
	var item = data["item"]
	ItemManager.inventory_slot_hovered.emit(self, item)
	return true

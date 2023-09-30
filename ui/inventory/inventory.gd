extends Control
class_name Inventory

signal started_dragging(Item)
signal ended_dragging()

var last_hover_slots = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var x = 0
	var y = 0
	
	for child in get_children():
		if child is InventorySlot:
			child.inventory = self
			child.coord = Vector2i(x,y)
			child.started_dragging.connect(start_drag_item)
			child.ended_dragging.connect(stop_drag_item)
			child.slot_hovered.connect(slot_hovered)
			
			# Grid is 10x6 (X by Y)
			x = (x + 1) %10
			if x == 0:
				y += 1


func slot_hovered(slot: InventorySlot, item: Item):
	
	if len(last_hover_slots) > 0:
		for hover_slot in last_hover_slots:
			hover_slot.unhighlight()
	
	last_hover_slots.clear()
		
	for item_block in item.cells:
		var hover_slot = _get_inventory_slot(slot.coord + item_block)
		if hover_slot == null:
			continue
		hover_slot.highlight()
		
		if hover_slot.contains_item != null:
			var more_item_slots = find_item_slots_for(hover_slot.contains_item)
			
			for item_slot in more_item_slots:
				item_slot.highlight()
				
			last_hover_slots.append_array(more_item_slots)
		
		last_hover_slots.append(hover_slot)
	

func start_drag_item(item: Item):
	print("inventory started dragging")
	started_dragging.emit(item)
	
func stop_drag_item():
	print("inventory stopped dragging")
	ended_dragging.emit()
	
	if len(last_hover_slots) > 0:
		for hover_slot in last_hover_slots:
			hover_slot.unhighlight()
	
	last_hover_slots.clear()


func find_item_slots_for(item: Item):
	
	var item_slots = []
	
	for child in get_children():
		if child is InventorySlot and child.contains_item == item:
			item_slots.append(child)
			
	return item_slots

func try_item_at_slot(slot: InventorySlot, item: Item) -> bool:
		
	for item_block in item.cells:
		var hover_slot = _get_inventory_slot(slot.coord + item_block)
		if hover_slot == null or hover_slot.is_filled():
			return false
	
	
	# If we none of the inventory slots are filled, lets set this item on them
	for item_block in item.cells:
		var hover_slot = _get_inventory_slot(slot.coord + item_block)
		hover_slot.contains_item = item
	
	return true
	

func _get_inventory_slot(coord: Vector2i) -> InventorySlot:
	
	for child in get_children():
		if child is InventorySlot and child.coord == coord:
			return child
	
	return null

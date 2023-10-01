extends Control
class_name Inventory

var last_slot: InventorySlot = null
var last_hover_slots = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var x = 0
	var y = 0
	
	ItemManager.item_dragging_stopped.connect(_on_stop_drag_item)
	
	ItemManager.item_rotated.connect(_item_rotated)
	ItemManager.inventory_slot_hovered.connect(_slot_hovered)
	
	ItemManager.inventory_slot_dropped.connect(try_item_at_slot)
	ItemManager.inventory_staged_remove.connect(remove_item)
	
	# Register all of the Inventory Slots
	for child in get_children():
		if child is InventorySlot:
			child.coord = Vector2i(x,y)
			
			# Grid is 9x5 (X by Y)
			x = (x + 1) %9
			if x == 0:
				y += 1


func try_item_at_slot(slot: InventorySlot, item: Item) -> bool:
	if not visible: 
		return false
		
	if not _check_can_fit(slot, item):
		ItemManager.inventory_rejected.emit(item)
		return false
	
	
	# If we none of the inventory slots are filled, lets set this item on them
	for item_block in item.get_item_cells():
		var hover_slot = _get_inventory_slot((slot.coord + item_block) - item.item_center)
		hover_slot.set_item(item, item_block == item.item_center)
	
	ItemManager.add_item(item)
	ItemManager.inventory_added.emit(item)
	
	return true


func remove_item(item: Item):
	if not visible: 
		return
	
	for slot in get_children():
		if slot is InventorySlot:
			slot.remove_item(item)
			
	ItemManager.remove_item(item)


func _item_rotated(item: Item):
	if not visible: 
		return
	_slot_hovered(last_slot, item)


func _check_can_fit(slot: InventorySlot, item: Item):
	
	for item_block in item.get_item_cells():
		var hover_slot = _get_inventory_slot((slot.coord + item_block) - item.item_center)
		if hover_slot == null or hover_slot.is_filled():
			return false
	
	return true

func _slot_hovered(slot: InventorySlot, item: Item):
	if not visible: 
		return
	
	if len(last_hover_slots) > 0:
		for hover_slot in last_hover_slots:
			hover_slot.unhighlight()
	
	last_hover_slots.clear()
	last_slot = slot
	
	var can_fit_fully = _check_can_fit(slot, item)
	
	for item_block in item.get_item_cells():
		var hover_slot = _get_inventory_slot((slot.coord + item_block) - item.item_center)
		if hover_slot == null:
			continue
		hover_slot.highlight(can_fit_fully)
		
		if hover_slot.contains_item != null:
			var more_item_slots = _find_item_slots_for(hover_slot.contains_item)
			
			for item_slot in more_item_slots:
				item_slot.highlight(can_fit_fully)
				
			last_hover_slots.append_array(more_item_slots)
		
		last_hover_slots.append(hover_slot)


func _on_stop_drag_item(item: Item,  is_inventory: bool):
	if not visible: 
		return
		
	_clear_hover()
	
	if not is_inventory:
		ItemManager.inventory_final_remove.emit(item)


func _clear_hover():
	if not visible: 
		return
	
	if len(last_hover_slots) > 0:
		for hover_slot in last_hover_slots:
			hover_slot.unhighlight()
	
	last_hover_slots.clear()


func _get_inventory_slot(coord: Vector2i) -> InventorySlot:
	
	for child in get_children():
		if child is InventorySlot and child.coord == coord:
			return child
	
	return null


func _find_item_slots_for(item: Item):
	
	var item_slots = []
	
	for child in get_children():
		if child is InventorySlot and child.contains_item == item:
			item_slots.append(child)
			
	return item_slots


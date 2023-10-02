extends Node2D

signal item_dragging_started(Item)
signal item_dragging_stopped(Item, is_inventory: bool)

signal inventory_slot_hovered(InventorySlot, Item)
signal inventory_slot_dropped(InventorySlot, Item)
signal inventory_added(Item)
signal inventory_rejected(Item)

signal inventory_staged_remove(Item)
signal inventory_final_remove(Item)

signal guild_inventory_hovered(Item)

signal item_dropped(Item, added_inventory: bool)

signal item_rotated(Item)

signal item_count_changed(count:int)

var active_inventory: Array[Item] = []


func add_item(item: Item):
	if item not in active_inventory:
		active_inventory.append(item)
		item_count_changed.emit(active_inventory.size())

func remove_item(item: Item):
	active_inventory.erase(item)
	item_count_changed.emit(active_inventory.size())

func has_item(item: Item):
	return item in active_inventory

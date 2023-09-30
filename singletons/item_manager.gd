extends Node2D

signal item_dragging_started(Item)
signal item_dragging_stopped(Item)

signal inventory_slot_hovered(InventorySlot, Item)
signal inventory_slot_dropped(InventorySlot, Item)
signal inventory_added(Item)

signal inventory_staged_remove(Item)
signal inventory_final_remove(Item) # TODO: remove is potentially only temporary, if it is readded to inventory this isn't called

signal guild_inventory_hovered(Item)

signal item_dropped(Item, added_inventory: bool)

signal item_rotated(Item)


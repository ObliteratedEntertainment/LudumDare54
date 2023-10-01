extends Control
class_name GuildInventory

const prefab_item_slot = preload("res://ui/guild_inventory/guild_item_slot.tscn")

@onready var h_flow_container = $MarginContainer/HFlowContainer

# Called when the node enters the scene tree for the first time.
func set_items(items):
	for item in items:
		var slot := prefab_item_slot.instantiate()
		slot.item = item.duplicate()
		h_flow_container.add_child(slot)

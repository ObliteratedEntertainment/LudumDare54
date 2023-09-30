extends Control
class_name GuildInventory

const prefab_item_slot = preload("res://ui/guild_inventory/guild_item_slot.tscn")

# List of Prefab Scene Items that are available in the guild inventory
@export var available_item_list = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for item in available_item_list:
		var slot := prefab_item_slot.instantiate()
		slot.packed_item = item

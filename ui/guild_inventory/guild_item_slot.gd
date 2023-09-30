extends Control
class_name GuildItemSlot

@export var packed_item: PackedScene = null

@onready var icon: TextureRect = $Icon


var item: Item = null

# Called when the node enters the scene tree for the first time.
func _ready():
	item = packed_item.instantiate()
	add_child(item)
	item.visible = false
	
	icon.texture = item.icon.texture


func _on_focus_entered():
	pass # Replace with function body.


func _on_focus_exited():
	pass # Replace with function body.


func _get_drag_data(_at_position):
	
	item.slot_rotation = 0
	var data = {
		"item": item
	}
	
	ItemManager.item_dragging_started.emit(item)
	
	return data

func _drop_data(_at_position, data):
	var dropped_item = data["item"]
	ItemManager.item_dragging_stopped.emit(dropped_item)
	
func _can_drop_data(_at_position, data):
	var dropped_item = data["item"]
	ItemManager.guild_inventory_hovered.emit(dropped_item)
	return true


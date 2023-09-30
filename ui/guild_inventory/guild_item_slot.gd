extends Control
class_name GuildItemSlot

@export var packed_item: PackedScene = null

@onready var icon: TextureRect = $Icon

@onready var color_rect = $ColorRect

var item: Item = null

# Called when the node enters the scene tree for the first time.
func _ready():
	item = packed_item.instantiate()
	add_child(item)
	item.visible = false
	
	icon.texture = item.icon.texture
	
	ItemManager.inventory_added.connect(_on_item_dropped)
	ItemManager.inventory_staged_remove.connect(_on_inv_item_removed)


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

func _on_inv_item_removed(removed_item: Item):
	if item == removed_item:
		visible = true

func _on_item_dropped(dropped_item: Item):
	if item == dropped_item:
		visible = false


func _on_mouse_entered():
	color_rect.self_modulate = Color(1,1,1,1)


func _on_mouse_exited():
	color_rect.self_modulate = Color(0,0,0,0)

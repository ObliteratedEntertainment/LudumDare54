extends Control
class_name GuildItemSlot

@onready var icon: Sprite2D = $Sprite2D

@onready var color_rect = $ColorRect

var item: Item = null

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(item)
	item.visible = false
	
	icon.texture = item.icon.texture
	icon.region_enabled = item.icon.region_enabled
	icon.region_rect = item.icon.region_rect
	
	ItemManager.inventory_added.connect(_on_item_dropped)
	ItemManager.inventory_rejected.connect(_on_inv_item_removed)
	ItemManager.inventory_final_remove.connect(_on_inv_item_removed)
	ItemManager.item_dragging_stopped.connect(_on_inv_item_removed)


func _get_drag_data(_at_position):
	var copied_item = item.duplicate()
	copied_item.visible = false
	add_child(copied_item)
	
	item.slot_rotation = 0
	var data = {
		"item": copied_item
	}
	
	ItemManager.item_dragging_started.emit(copied_item)
	#visible = false
	
	return data

func _drop_data(_at_position, data):
	var dropped_item = data["item"]
	ItemManager.item_dragging_stopped.emit(dropped_item, false)
	
func _can_drop_data(_at_position, data):
	var dropped_item = data["item"]
	ItemManager.guild_inventory_hovered.emit(dropped_item)
	return true

func _on_inv_item_removed(removed_item: Item):
	pass
	#if item == removed_item and not ItemManager.has_item(removed_item):
		#visible = true

func _on_item_dropped(dropped_item: Item):
	pass
	#if item == dropped_item:
		#visible = false


func _on_mouse_entered():
	color_rect.self_modulate = Color(1,1,1,1)


func _on_mouse_exited():
	color_rect.self_modulate = Color(0,0,0,0)

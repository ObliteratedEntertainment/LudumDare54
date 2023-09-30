extends Control
class_name GuildInventorySlot


signal started_dragging(item: Item)
signal ended_dragging()

@export var packed_item: PackedScene = null

@onready var icon: TextureRect = $Icon


var item: Item = null

# Called when the node enters the scene tree for the first time.
func _ready():
	item = packed_item.instantiate()
	add_child(item)
	item.visible = false
	
	icon.texture = item.get_icon().texture


func _on_focus_entered():
	pass # Replace with function body.


func _on_focus_exited():
	pass # Replace with function body.


func _get_drag_data(at_position):
	
	var data = {
		"item": item
	}
	
	started_dragging.emit(item)
	
	return data

func _drop_data(at_position, data):
	ended_dragging.emit()
	
func _can_drop_data(at_position, data):
	return true


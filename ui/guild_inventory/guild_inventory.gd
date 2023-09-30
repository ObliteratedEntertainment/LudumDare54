extends Control
class_name GuildInventory

signal started_dragging(Item)
signal ended_dragging()


# Called when the node enters the scene tree for the first time.
func _ready():
	
	for child in get_children():
		if child is GuildInventorySlot:
			child.started_dragging.connect(start_drag_item)
			child.ended_dragging.connect(stop_drag_item)


func start_drag_item(item: Item):
	started_dragging.emit(item)


func stop_drag_item():
	ended_dragging.emit()

extends Node2D
class_name Item

# These are the coordinates of space used by the item
@export var lore:String
@export var cells:Array[Vector2i]

@export var item_center: Vector2i = Vector2i.ZERO

@onready var stats = $Stats

@onready var icon: Sprite2D = $Icon
@onready var sprite: Sprite2D = $Sprite

@onready var slot_rotation := 0

func get_stats() -> Array:
	return stats.get_children()


func get_item_cells():
	
	if slot_rotation == 0:
		return cells
	else:
		var rotated_cells = []
		for slot in cells:
			var diff = slot - item_center
			var rotated = Vector2(diff.x, diff.y).rotated(deg_to_rad(slot_rotation))
			rotated_cells.append(item_center + Vector2i(roundi(rotated.x), roundi(rotated.y)))
		return rotated_cells


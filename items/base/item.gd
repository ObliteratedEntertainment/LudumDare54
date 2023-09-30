extends Node2D
class_name Item

# These are the coordinates of space used by the item
@export var lore:String
@export var cells:Array[Vector2i]

@onready var stats = $Stats

@onready var icon = $Icon
@onready var sprite = $Sprite

func get_stats() -> Array:
	return stats.get_children()

func get_icon() -> Sprite2D:
	return icon
	
func get_sprite() -> Sprite2D:
	return sprite

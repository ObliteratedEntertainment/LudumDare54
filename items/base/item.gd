extends Node2D

# These are the coordinates of space used by the item
@export var lore:String
@export var cells:Array[Vector2i]

@onready var stats = $Stats

func get_stats() -> Array:
	return stats.get_children()

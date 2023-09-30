extends Node2D

@export var text:String

# This is just a hint on how to get the next stage of lore (if any from this node)
func get_sub_lore() -> Array:
	# The name of each child node should be highlighted key words to click for the next bit of lore
	return get_children()

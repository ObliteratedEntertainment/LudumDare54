extends Node2D

@export var bg_move_speed := 10.0

@onready var map_1 = $Map1
@onready var map_2 = $Map2
@onready var wrap_point_left = $WrapPointLeft

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var move_distance = ceili(bg_move_speed *delta)
	
	# Move the map pieces
	map_1.position.x = map_1.position.x - move_distance
	map_2.position.x = map_2.position.x - move_distance
	
	var map1_end = map_1.position.x + (map_1.get_rect().size.x * map_1.scale.x)
	var map2_end = map_2.position.x + (map_2.get_rect().size.x * map_2.scale.x)
	
	# Shuffle back around if it looped
	if map1_end < wrap_point_left.position.x:
		map_1.position.x = map2_end
	if map2_end < wrap_point_left.position.x:
		map_2.position.x = map1_end

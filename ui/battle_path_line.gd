extends PathFollow2D

const prefab_dot = preload("res://sprites/map_dot.png")
@onready var line_holder = $"../LineHolder"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	generate_line.call_deferred()

func generate_line():
	
	loop = false
	progress_ratio = 0.0
	
	while progress_ratio < 1.0:
		
		progress += 16.0
		
		var dot = Sprite2D.new()
		dot.texture = prefab_dot
		dot.scale = Vector2.ONE * 2.0
		line_holder.add_child(dot)
		dot.global_position = global_position
		dot.self_modulate = Color(1,1,1,0) # all dots are invisible until the player is near them
		
	progress_ratio = 0.0
	

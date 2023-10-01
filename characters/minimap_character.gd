extends Sprite2D

@export var character_name: Character.CharacterType

@onready var character_animator = $CharacterAnimator

@onready var line_holder = $"../../LineHolder"
@onready var destination = $"../../../Destination"

# Called when the node enters the scene tree for the first time.
func _ready():
	if GameManager.character.character == character_name:
		visible = true
		
		destination.self_modulate = Color(1,1,1,0)

func arrived_destination():
	if GameManager.quest_successful:
		character_animator.play("success")
	else:
		character_animator.play("failed")
		

func _process(delta):
	if not visible:
		return
		
	fade_in_dots()
	
	destination.self_modulate = fade_distance(destination)

func fade_in_dots():
	if not visible:
		return
	
	for dot in line_holder.get_children():
		dot.self_modulate = fade_distance(dot)
	


func fade_distance(target: Node2D) -> Color:
	if is_equal_approx(target.self_modulate.a, 1.0):
		return target.self_modulate
	
	var distance_squared = global_position.distance_squared_to(target.global_position)
	
	var max_distance = 2000
	var min_distance = 100
	if distance_squared > 2000.0:
		return Color(1,1,1,0)
	
	var fade = inverse_lerp(max_distance, min_distance, clamp(distance_squared, min_distance, max_distance))
	
	return Color(1,1,1, fade)

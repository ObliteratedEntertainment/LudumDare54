extends Sprite2D

@export var character_name: Character.CharacterType
@export var quest_succeed := true

@onready var character_animator = $CharacterAnimator

# Called when the node enters the scene tree for the first time.
func _ready():
	if GameManager.character.character == character_name:
		visible = true

func arrived_destination():
	if quest_succeed:
		character_animator.play("success")
	else:
		character_animator.play("failed")
		

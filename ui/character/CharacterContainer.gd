extends Control

@onready var sprite_location = $SpriteLocation

@export var character:Character

var current_sprite:Sprite2D

func _ready():
	if character != null:
		set_character(character, 0)

func set_character(character:Character, state:int):
	if current_sprite != null:
		sprite_location.remove_child(current_sprite)
	self.character = character
	current_sprite = character.neutral_sprite
	current_sprite.frame_coords.x = state
	sprite_location.add_child(current_sprite)

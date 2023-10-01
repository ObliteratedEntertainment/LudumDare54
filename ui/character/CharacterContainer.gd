extends Control

@onready var sprite_location = $SpriteLocation
@onready var quest_text = $"../QuestContainer/LoreTextLabel"

@export var character:Character

var current_sprite:Sprite2D

func _ready():
	GameManager.character_changed.connect(set_character)
	character = GameManager.character
	if character != null:
		set_character(character, 0)

func set_character(character:Character, state:int):
	if current_sprite != null:
		sprite_location.remove_child(character)
	self.character = character
	sprite_location.add_child(character)
	quest_text.set_quest(character.get_quest())
	MusicManager.change_track(character.music_track_index)

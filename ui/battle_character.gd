extends Control

@onready var sprite_location = $SpriteLocation

# Called when the node enters the scene tree for the first time.
func _ready():
	
	set_character(GameManager.character)


func set_character(character: Character):
	sprite_location.add_child(character)
	MusicManager.change_track(character.music_track_index)
	character.disable_sprites()
	character.flip_h(true)
	
	if GameManager.quest_successful:
		character.success_sprite.visible = true
	else:
		character.failure_sprite.visible = true
		

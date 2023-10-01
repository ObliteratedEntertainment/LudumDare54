extends Control

@onready var sprite_location = $SpriteLocation


var character

# Called when the node enters the scene tree for the first time.
func _ready():
	
	set_character(GameManager.character)


func _exit_tree():
	# Release the character from the tree so they aren't cleared
	sprite_location.remove_child(self.character)
		
func set_character(character: Character):
	self.character = character
	sprite_location.add_child(character)
	MusicManager.change_track(character.music_track_index)
	character.disable_sprites()
	character.flip_h(true)
	
	if GameManager.quest_successful:
		character.success_sprite.visible = true
	else:
		character.failure_sprite.visible = true
		

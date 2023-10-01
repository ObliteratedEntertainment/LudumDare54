extends Control

@onready var sprite_location = $SpriteLocation
@onready var quest_text = $"../QuestContainer/LoreTextLabel"
@onready var animation = $AnimationPlayer

@export var character:Character

var quest_successful

func _ready():
	GameManager.character_changed.connect(set_character)
	character = GameManager.character
	if character != null:
		set_character(character, 0)
	GameManager.quest_accepted.connect(_quest_accepted)
	GameManager.result_accepted.connect(_result_accepted)

func set_character(character:Character, state:int):
	if character != null:
		sprite_location.remove_child(character)
	self.character = character
	quest_successful = null
	sprite_location.add_child(character)
	quest_text.set_quest(character.get_quest())
	MusicManager.change_track(character.music_track_index)
	character.disable_sprites()
	character.flip_h(true)
	character.neutral_sprite.visible = true
	animation.play("Arrive")

func _quest_accepted(success):
	quest_successful = success
	character.flip_h(false)
	animation.play("Leave")

func _result_accepted():
	character.flip_h(false)
	animation.play("Depart")

func character_arrived():
	GameManager.character_arrived.emit()
	animation.play("Idle")

func character_left():
	GameManager.character_mission_start.emit()
	character.disable_sprites()
	character.flip_h(true)
	if quest_successful == null:
		character.neutral_sprite.visible = true
	elif quest_successful:
		character.success_sprite.visible = true
	else:
		character.failure_sprite.visible = true
	animation.play("Return")
	
func character_return():
	GameManager.character_mission_end.emit()
	animation.play("Idle")

func character_departed():
	GameManager.character_departed.emit()

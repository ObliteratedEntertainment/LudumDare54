extends Control

@onready var sprite_location = $SpriteLocation
@onready var quest_selector = $"../QuestContainer/OptionButton"
@onready var animation = $AnimationPlayer

@export var character:Character

var quest_successful

func _ready():
	GameManager.character_changed.connect(set_character)
	var c = GameManager.character
	if c != null:
		call_deferred("set_character", c)
	GameManager.quest_accepted.connect(_quest_accepted)
	GameManager.result_accepted.connect(_result_accepted)

func _exit_tree():
	# Release the character from the tree so they aren't cleared
	if self.character != null:
		sprite_location.remove_child(self.character)

func set_character(character:Character):
	if self.character != null:
		sprite_location.remove_child(self.character)
	self.character = character
	quest_successful = null
	sprite_location.add_child(character)
	quest_selector.set_quests(character.get_quests())
	MusicManager.change_track(character.music_track_index)
	character.disable_sprites()
	character.flip_h(true)
	character.neutral_sprite.visible = true
	animation.play("Arrive")

func _quest_accepted(quest, success):
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

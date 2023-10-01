extends Node2D
class_name Character

@onready var neutral_sprite = $Neutral
@onready var success_sprite = $Success
@onready var failure_sprite = $Failure
@onready var sprites = [neutral_sprite, success_sprite, failure_sprite]

@onready var quest_node = $Quest
@onready var lore_node = $Lore

@export var music_track_index:int

func get_quest():
	return quest_node.get_child(0)

func get_lore():
	return lore_node.get_child(0)
	
func disable_sprites():
	for s in sprites:
		s.visible = false

func flip_h(b):
	for s in sprites:
		s.flip_h = b

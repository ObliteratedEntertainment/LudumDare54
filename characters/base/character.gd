extends Node2D
class_name Character

@onready var neutral_sprite = $Neutral
@onready var success_sprite = $Success
@onready var failure_sprite = $Failure
@onready var quest_node = $Quest
@onready var lore_node = $Lore

@export var music_track_index:int

func get_quest():
	return quest_node.get_child(0)

func get_lore():
	return lore_node.get_child(0)

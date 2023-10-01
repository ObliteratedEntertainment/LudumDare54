extends Node2D

const zofra_prefab = preload("res://characters/zofra.tscn")

signal character_changed

signal quest_accepted(bool)
signal result_accepted

signal character_arrived
signal character_mission_start
signal character_mission_end
signal character_departed

var character:Character
var state:int


func _ready():
	# Init first character
	character = zofra_prefab.instantiate()
	state = 0


func next():
	character_changed.emit(character, state)

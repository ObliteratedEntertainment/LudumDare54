extends Node2D

const zofra_prefab = preload("res://characters/zofra.tscn")
const t_prefab = preload("res://characters/tiberius.tscn")
const character_prefabs = [zofra_prefab, t_prefab]

signal character_changed

signal quest_accepted(bool)
signal result_accepted

signal character_arrived
signal character_mission_start
signal character_mission_end
signal character_departed

var character:Character
var index:int

func _ready():
	character_departed.connect(_character_departed)
	# Init first character
	index = 0
	_spawn_character()

func _spawn_character():
	character = character_prefabs[index].instantiate()

func _character_departed():
	character.queue_free()
	index = (index+1)%character_prefabs.size()
	_spawn_character()
	character_changed.emit(character)

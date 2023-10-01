extends Node2D

enum Scenes {
	MAIN_MENU,
	SHOP,
	BATTLE,
}

const zofra_prefab = preload("res://characters/zofra.tscn")
const tiberius_prefab = preload("res://characters/tiberius.tscn")
const goldie_prefab = preload("res://characters/goldie.tscn")
const character_prefabs = [zofra_prefab, tiberius_prefab, goldie_prefab]

signal character_changed

signal quest_accepted(bool)
signal result_accepted

signal character_arrived
signal character_mission_start
signal character_mission_end
signal character_departed

var characters:Array[Character]

var character:Character
var index:int

var active_scene := Scenes.MAIN_MENU

func _ready():
	character_departed.connect(_character_departed)
	# Init first character
	index = 0
	for c in character_prefabs:
		characters.append(c.instantiate())
	character = characters[0]

func _character_departed():
	index = (index+1)%characters.size()
	character = characters[index]
	character_changed.emit(character)

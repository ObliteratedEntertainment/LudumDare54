extends Node2D

const zofra_prefab = preload("res://characters/zofra.tscn")

signal character_changed

var character:Character
var state:int

func _ready():
	# Init first character
	character = zofra_prefab.instantiate()
	state = 0

func next():
	character_changed.emit(character, state)

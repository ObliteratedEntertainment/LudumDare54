extends Node
class_name ItemStats

enum Stat {
	ATTACK,
	DEFENSE,
	HOLY
}

@export var stat: Stat
@export var amount:int

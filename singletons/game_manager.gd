extends Node2D

enum Scenes {
	MAIN_MENU,
	SETTINGS,
	SHOP,
	BATTLE,
	GAME_OVER
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

var current_quest:Quest
var quest_successful

var active_scene := Scenes.MAIN_MENU

var reward_items = []

func _ready():
	quest_accepted.connect(_quest_accepted)
	character_departed.connect(_character_departed)
	# Init first character
	index = 0
	for c in character_prefabs:
		characters.append(c.instantiate())
	character = characters[index]

func _quest_accepted(quest, success):
	current_quest = quest
	quest_successful = success
	var rewards
	if success:
		rewards = quest.get_success_rewards()
	else:
		rewards = quest.get_failure_rewards()
	var items = []
	for r in rewards:
		if r is Item:
			var exists = false
			for i in reward_items:
				if i.icon == r.icon:
					exists = true
					break
			if !exists:
				reward_items.append(r)

func _character_departed():
	index = (index+1)%characters.size()
	character = characters[index]
	current_quest = null
	quest_successful = null
	character_changed.emit(character)

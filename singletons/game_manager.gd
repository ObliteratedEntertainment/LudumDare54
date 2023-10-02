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

signal game_complete

var characters:Array[Character]

var character:Character
var index:int

var current_quest:Quest
var quest_successful

var active_scene := Scenes.MAIN_MENU

var reward_items = []

func _ready():
	quest_accepted.connect(_quest_accepted)
	
	# Init first character
	index = 0
	for c in character_prefabs:
		
		var node = c.instantiate()
		characters.append(node)
		
		# Quickly add and remove to fully ready the character object
		add_child(node)
		remove_child(node)
		
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

func character_departed() -> bool:
	
	var checked_characters = 0
	
	while checked_characters < characters.size():
		checked_characters += 1
		
		index = (index+1)%characters.size()
		
		
		character = characters[index]
		
		#var test_added = false
		#if character.get_parent() == null:
			#test_added = true
			#add_child(character)
		
		var available := false
		for quest in character.get_quests():
			available = available or not quest.completed
		
		#if test_added:
			#remove_child(character)
		
		if available:
			print("Character has unfinished quest available: ", character)
			current_quest = null
			quest_successful = null
			#character_changed.emit(character)
			return false
	
	# If we couldn't find any characters with unfinished quests, we finished the game!
	game_complete.emit()
	return true

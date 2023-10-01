extends Control

@onready var accept_button = $QuestAcceptButton
@onready var lore_text = $LoreTextLabel
@onready var inventory = $"../DragAndDropContainer/GuildInventory"

var selected_quest:Quest

func _ready():
	accept_button.disabled = true
	GameManager.character_mission_end.connect(_mission_end)
	
	select_quest.call_deferred()

func _mission_end():
	visible = true

func select_quest():
	for quest in GameManager.character.get_quests():
		if not quest.completed:
			selected_quest = quest
			lore_text.set_quest(selected_quest)
			var items = selected_quest.get_base_items()
			for r in GameManager.reward_items:
				var exists = false
				for i in items:
					if i.icon == r.icon:
						exists = true
						break
				if !exists:
					items.append(r)
			inventory.set_items(items)
			accept_button.disabled = false
			break

func _on_quest_accept_button_pressed():
	var quest = selected_quest

	var current_inventory_stats = {}
	
	for item in ItemManager.active_inventory:
		for stats in item.get_stats():
			if stats.stat in current_inventory_stats:
				current_inventory_stats[stats.stat] += stats.amount
			else:
				current_inventory_stats[stats.stat] = stats.amount

	var passed_quest := true
	print(current_inventory_stats)
	
	for req_stat in quest.get_requirements():
		if req_stat.stat not in current_inventory_stats:
			passed_quest = false
		elif current_inventory_stats[req_stat.stat] < req_stat.amount:
			passed_quest = false
	
	if passed_quest:
		print("Passed Quest!")
		quest.completed = true
	else:
		print("Failed Quest!")
	
	visible = false
	accept_button.disabled = true
	selected_quest = null
	GameManager.quest_accepted.emit(quest, passed_quest)

extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quest_accept_button_pressed():
	var quest = GameManager.character.get_quest()

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
	else:
		print("Failed Quest!")
	
	GameManager.quest_accepted.emit(passed_quest)

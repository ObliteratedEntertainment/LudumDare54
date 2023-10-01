extends Node2D

var region_lore = {}

func _ready():
	GameManager.quest_accepted.connect(_quest_accepted)

func _quest_accepted(success):
	var quest:Quest = GameManager.character.get_quest()
	var region_type = quest.region
	if !(region_type in region_lore):
		region_lore[region_type] = []
	var lore_array = region_lore[region_type]
	var rewards
	if success:
		rewards = quest.get_success_rewards()
	else:
		rewards = quest.get_failure_rewards()
	for r in rewards:
		if r is Lore:
			var found = false
			for l:Lore in lore_array:
				if l.text == r.text:
					# Already have it
					found = true
					break
			if !found:
				lore_array.append(r)

extends ColorRect

@onready var lore_text = $LoreTextLabel

func _ready():
	var rewards
	var quest := GameManager.current_quest
	# TODO: Use this to change the button from happy to sad?
	var success = GameManager.quest_successful
	if success:
		rewards = quest.get_success_rewards()
	else:
		rewards = quest.get_failure_rewards()
	for r in rewards:
		if r is Lore:
			lore_text.add_lore_text(r)
			break
	# TODO: Gather and display reward items

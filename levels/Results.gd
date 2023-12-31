extends ColorRect

@onready var inventory = $"../DragAndDropContainer/GuildInventory"
@onready var lore_text = $LoreTextLabel

func _ready():
	var quest := GameManager.current_quest
	# TODO: Use this to change the button from happy to sad?
	var success = GameManager.quest_successful
	var rewards
	if success:
		rewards = quest.get_success_rewards()
	else:
		rewards = quest.get_failure_rewards()
	# Display the lore
	for r in rewards:
		if r is Lore:
			lore_text.add_lore_text(r)
			break
	# Gather and display reward items
	var items = []
	for r in rewards:
		if r is Item:
			items.append(r)
	inventory.set_items(items)

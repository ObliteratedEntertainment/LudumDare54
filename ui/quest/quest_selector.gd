extends OptionButton

@onready var quest_container = $".."

var quests

func set_quests(qs:Array):
	clear()
	self.quests = qs
	var c = 0
	var picked = false
	for q:Quest in qs:
		add_item(q.name)
		if !picked && !q.completed:
			select(c)
			picked = true
		c += 1
	if !picked:
		select(0)
	if selected > -1:
		_on_item_selected(selected)

func _on_item_selected(index):
	quest_container.select_quest(quests[index])

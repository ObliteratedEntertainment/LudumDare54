extends Label

@onready var accept_button = $"../QuestAcceptButton"

const template = "#/$ minimum"
var min

func _ready():
	ItemManager.item_count_changed.connect(_count_changed)
	accept_button.visible = false

func set_minimum(min):
	self.min = min
	_count_changed(ItemManager.active_inventory.size())

func _count_changed(count):
	if min != null:
		text = template.replace("$", str(min)).replace("#", str(count))
		visible = count < min
		accept_button.visible = !visible

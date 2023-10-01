extends HFlowContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	for item in ItemManager.active_inventory:
		var control_container = MarginContainer.new()
		control_container.custom_minimum_size = Vector2.ONE * 32.0
		
		var icon = Sprite2D.new()
		icon.texture = item.icon.texture
		icon.region_enabled = item.icon.region_enabled
		icon.region_rect = item.icon.region_rect
		icon.scale = Vector2.ONE * 2.0
		icon.centered = false
		
		control_container.add_child(icon)
		add_child(control_container)


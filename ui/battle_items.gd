extends HFlowContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	for item in ItemManager.active_inventory:
		var sprite = Sprite2D.new()
		sprite.texture = item.icon
		sprite.scale = Vector2.ONE * 2.0
		
		add_child(sprite)


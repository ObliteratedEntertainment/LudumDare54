extends Control
class_name SceneManagement

const scene_main_menu = preload("res://levels/main_menu_scene.tscn")
const scene_battle    = preload("res://levels/battle_container.tscn")
const scene_shop      = preload("res://levels/shop_scene.tscn")

@onready var screen_wipe = $ScreenWipe

var current_scene

func _ready():
	load_scene()


func load_scene():
	if current_scene != null:
		remove_child(current_scene)
		current_scene = null
	
	match GameManager.active_scene:
		GameManager.Scenes.MAIN_MENU:
			current_scene = scene_main_menu.instantiate()
			current_scene.scene_leaving.connect(_on_leave_main_menu)
			print("added main menu")
		GameManager.Scenes.SHOP:
			current_scene = scene_shop.instantiate()
			current_scene.scene_leaving.connect(_on_leave_shop)
			print("Added shop scene")
		GameManager.Scenes.BATTLE:
			current_scene = scene_battle.instantiate()
			current_scene.scene_leaving.connect(_on_leave_battle)
	
	add_child(current_scene)
	
	if screen_wipe.obscuring:
		screen_wipe.show_scene()


func _on_screen_wipe_scene_hidden():
	load_scene()


func _on_screen_wipe_scene_showing():
	pass # Replace with function body.

func _on_leave_main_menu():
	GameManager.active_scene = GameManager.Scenes.SHOP
	
	screen_wipe.hide_scene()
	
func _on_leave_shop():
	GameManager.active_scene = GameManager.Scenes.BATTLE
	
	screen_wipe.hide_scene()
	
func _on_leave_battle():
	GameManager.active_scene = GameManager.Scenes.SHOP
	
	screen_wipe.hide_scene()
	

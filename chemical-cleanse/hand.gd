extends Node2D

@onready var item_icon: Sprite2D = $Item_icon

var can_drop = true

var item : Dictionary
var item_count = 0 

func _physics_process(delta):
	global_position = get_global_mouse_position()

func add_item(new_item, count):
	item = new_item
	item_count = count
	item_icon.texture = item["inv_icon"]

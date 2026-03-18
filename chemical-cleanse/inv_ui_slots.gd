extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var hand: Node2D = $"../../../../../hand"

var my_index: int = 0
var inv: Inv = preload("res://assets/Items/playerinv.tres")

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func update(slot: InvSlot):
	if !slot.item:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture

func _gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if inv.slots[my_index].item != null:
				item_visual.visible = false

func _get_drag_data(at_position):
	if inv.slots[my_index].item == null:
		return null
	var preview = TextureRect.new()
	preview.texture = inv.slots[my_index].item.texture
	preview.size = Vector2(32, 32)
	set_drag_preview(preview)
	return {"from_index": my_index}

func _can_drop_data(at_position, data):
	return data is Dictionary and data.has("from_index")

func _drop_data(at_position, data):
	inv.move(data["from_index"], my_index)

func _notification(what):
	if what == NOTIFICATION_DRAG_END:
		if inv.slots[my_index].item != null:
			item_visual.visible = true
			

func remove_item(slot_num):
	var slot = inv.slots[slot_num.x][slot_num.y]
	if slot.item !={}:
		if hand.item =={}:
			hand.add_item(slot.item ,1)

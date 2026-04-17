extends Panel
@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/Label
var my_index: int = 0
@export var inv: Inv = preload("res://assets/Items/playerinv.tres")
var is_dragging: bool = false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func update(slot: InvSlot):
	if !slot.item:
		item_visual.visible = false
		amount_text.visible = false 
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		amount_text.visible = true
		amount_text.text = str(slot.amount)

func _gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if inv.slots[my_index].item != null:
				is_dragging = false  
		if !event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if !is_dragging:
				item_visual.visible = inv.slots[my_index].item != null

func _get_drag_data(_at_position):
	if inv.slots[my_index].item == null:
		return null
	is_dragging = true
	item_visual.visible = false
	var preview = TextureRect.new()
	preview.texture = inv.slots[my_index].item.texture
	preview.size = Vector2(32, 32)
	preview.pivot_offset = preview.size / 2
	var holder = Control.new()
	holder.add_child(preview)
	preview.position = -preview.size / 2
	set_drag_preview(holder)
	return {"from_index": my_index, "from_inv": inv}

func _can_drop_data(_at_position, data):
	var result = data is Dictionary and data.has("from_index") and data.has("from_inv")
	return result

func _drop_data(_at_position, data):
	var from_inv = data["from_inv"]
	if from_inv == inv:
		inv.move(data["from_index"], my_index)
	else:
		var item = from_inv.slots[data["from_index"]].item
		var amount = from_inv.slots[data["from_index"]].amount
		inv.slots[my_index].item = item
		inv.slots[my_index].amount = amount
		from_inv.remove(data["from_index"])
		inv.emit_signal("update")
		from_inv.emit_signal("update")

func _notification(what):
	if what == NOTIFICATION_DRAG_END:
		if inv.slots[my_index].item != null:
			item_visual.visible = true

func highlight(active: bool):
	if active:
		modulate = Color(0.7, 0.7, 0.7, 1)
	else:
		modulate = Color(1, 1, 1, 1)

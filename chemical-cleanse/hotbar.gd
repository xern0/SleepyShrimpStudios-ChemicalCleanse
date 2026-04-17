extends Panel
var selected_slot: int = 0
var slots: Array = []
var hotbar_inv: Inv = preload("res://assets/Items/hotbar.tres")
@onready var hbox = $HBoxContainer

func _ready():
	for child in hbox.get_children():
		slots.append(child)
	hotbar_inv.update.connect(update_slots)
	for i in range(slots.size()):
		slots[i].my_index = i
		slots[i].inv = hotbar_inv
	update_slots()
	_select_slot(0)

func update_slots():
	for i in range(min(hotbar_inv.slots.size(), slots.size())):
		slots[i].update(hotbar_inv.slots[i])

func _input(event):
	for i in slots.size():
		if event.is_action_pressed("slot_%d" % (i + 1)):
			_select_slot(i)
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_select_slot((selected_slot - 1 + slots.size()) % slots.size())
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_select_slot((selected_slot + 1) % slots.size())

func _select_slot(index: int):
	slots[selected_slot].highlight(false)
	selected_slot = index
	slots[selected_slot].highlight(true)
	_equip_item(index)

func _equip_item(index: int):
	var item = hotbar_inv.slots[index].item
	Eventbus.equip(item)

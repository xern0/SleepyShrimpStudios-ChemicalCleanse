extends Control

@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
var inv: Inv = preload("res://assets/Items/playerinv.tres")
var is_open = false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	for slot in inv.slots:
		slot.item = null
		slot.amount = 0
	inv.update.connect(update_slots)
	close_inventory()
	for i in range(slots.size()):
		slots[i].my_index = i

func update_slots():
	print("updating slots")
	for u in range(min(inv.slots.size(), slots.size())):
		slots[u].update(inv.slots[u])

func _input(event):
	if event.is_action_pressed("inventory"):
		if is_open:
			close_inventory()
		else:
			open_inventory()

func open_inventory():
	visible = true
	is_open = true
	get_tree().paused = true

func close_inventory():
	visible = false
	is_open = false
	get_tree().paused = false

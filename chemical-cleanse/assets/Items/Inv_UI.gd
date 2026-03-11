extends Control

@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
var inv: Inv = preload("res://assets/Items/playerinv.tres")
var is_open = false

func _ready():
	inv.update.connect(update_slots)
	close()

func update_slots():
	print("updating slots")
	for u in range(min(inv.slots.size(), slots.size())):
		slots[u].update(inv.slots[u])

func _process(_delta):
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			open()

func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false

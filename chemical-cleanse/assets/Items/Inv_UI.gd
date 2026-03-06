extends Control

@onready var inv: Inv = preload("res://assets/Items/playerinv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

func _ready():
	update_slots()
	close()


func update_slots(): 
	for u in range(min(inv.items.size(), slots.size())):
		slots[u].update(inv.items[u])

func _process(_delta):
	if Input.is_action_just_pressed("inventory"):
		print("u")
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

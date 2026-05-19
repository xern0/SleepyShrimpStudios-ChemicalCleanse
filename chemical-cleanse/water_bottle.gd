extends Area2D

@export var item: InvItem
@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	interactable.Interact = _on_interact

func _on_interact():
	if sprite_2d.frame == 0:
		sprite_2d.frame = false
		interactable.is_Interactable = false 
		print("Gained a water bottle")
		var inv = preload("res://assets/Items/playerinv.tres")
		var item = preload("res://Recipes/Water_Bottle.tres")  
		inv.insert(item)
		queue_free()

var is_interactable := true
var interact_name := "E"

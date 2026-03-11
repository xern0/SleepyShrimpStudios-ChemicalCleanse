extends Area2D

@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D
 
func _ready() -> void:
	interactable.Interact = _on_interact

func _on_interact():
	if sprite_2d.frame == 0:
		sprite_2d.frame = 1
		interactable.is_Interactable = false 
		print("Gained a bottle")
		var inv = preload("res://assets/Items/playerinv.tres")
		var item = preload("res://assets/Items/bottle.tres")  
		inv.insert(item)
		queue_free()

var is_interactable := true
var interact_name := "E"

extends Control

@onready var logo = $AnimatedSprite2D

func _ready():
	logo.play("logo")
	logo.speed_scale = 1.7



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")

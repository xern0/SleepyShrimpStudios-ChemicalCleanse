class_name Table
extends Area2D

@onready var crafting_ui = $CraftingUI
var is_interactable : bool = false

func _ready() -> void:
	crafting_ui.hide()

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		is_interactable = true

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		is_interactable = false
		crafting_ui.hide()

func _input(event: InputEvent) -> void:
	if is_interactable and event.is_action_pressed("interact"):
		crafting_ui.visible = !crafting_ui.visible

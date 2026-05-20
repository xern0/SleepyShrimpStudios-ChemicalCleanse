extends Area2D
class_name Dumpster

@export var item_drop_scene: PackedScene = null
@export var items_to_spawn: Array[PackedScene] = []
@onready var interactable: Area2D = $Interactable
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Node2D = $Sprite0001Recovered

var has_been_opened: bool = false

func _ready() -> void:
	interactable.Interact = _on_interact
	animation_player.stop()
	print("Children: ", get_children())

func _on_interact():
	if has_been_opened:
		return
	
	has_been_opened = true
	print("Opened dumpster!")
	animation_player.play("open")
	await animation_player.animation_finished
	print("Dumpster opened!")
	
	spawn_random_items()

func spawn_random_items() -> void:
	var spawn_count = randi_range(2, 4)
	
	# Find the sprite by getting all children and checking names at runtime
	var spawn_origin = Vector2.ZERO
	for child in get_children():
		if child is Node2D:
			spawn_origin = child.global_position
			break
	for i in range(spawn_count):
		var random_item_scene = items_to_spawn[randi() % items_to_spawn.size()]
		var spawned_item = random_item_scene.instantiate()
		get_parent().add_child(spawned_item)
		spawned_item.global_position = Vector2(spawn_origin.x + (i * 40) - 40, spawn_origin.y - 20)
func drop_item(item: InvItem, amount: int = 1) -> void:
	if item_drop_scene == null:
		print("No item drop scene assigned to dumpster!")
		return
	
	if animation_player.has_animation("open") and animation_player.current_animation != "open":
		animation_player.play("open")
	
	var dropped_item = item_drop_scene.instantiate()
	get_parent().add_child(dropped_item)
	dropped_item.global_position = global_position
	dropped_item.item = item
	dropped_item.amount = amount
	print("Dropped into dumpster: ", item.name, " x", amount)
	
	await get_tree().create_timer(1.0).timeout
	if animation_player.has_animation("close"):
		animation_player.play("close")

var is_interactable := true
var interact_name := "E"

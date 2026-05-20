extends Area2D

@export var Interact_name: String = ""
@export var is_Interactable: bool = true

var Interact: Callable = func(): 
	pass

func _ready() -> void:
	print("Interactable ready, is_Interactable: ", is_Interactable)

func _input(event: InputEvent) -> void:
	# Check if E key is pressed (keycode 69 = E)
	if event is InputEventKey and event.pressed and event.keycode == KEY_E:
		print("E pressed!")
		
		# Just check overlapping areas - simpler and more reliable
		var overlapping = get_overlapping_areas()
		print("Overlapping areas: ", overlapping)
		
		# If anything is overlapping, assume it's the player
		if is_Interactable and overlapping.size() > 0:
			print("Interact called!")
			Interact.call()
			get_tree().root.set_input_as_handled()
		else:
			print("Not interactable or nothing overlapping")

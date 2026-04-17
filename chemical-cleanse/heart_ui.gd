extends CanvasLayer

@onready var hurtbox: hurtbox = $".."

const Heart_size: int = 2
const heart_full = preload("res://assets/Health asset.png")
const heart_half = preload("res://assets/Health asset half.png")
const heart_empty = preload("res://assets/Health asset  dead.png")

@onready var hearts_container: HBoxContainer = $hearts
#19:37 in video https://youtu.be/vBJVoQDd31o?si=KRXstkvaDClNlDQU
func _ready() -> void:
	if hurtbox:
		hurtbox.health_changed.connect(_update_health)
		_update_health(hurtbox.healthpoints)
		
	
func _update_health(new_health: int) -> void:
	var hearts = hearts_container.get_children()
	var max_hearts = len(hearts)
	var full = int(new_health / Heart_size)
	var half = 1 if (new_health % Heart_size) > 0 else 0
	var empty = max_hearts - (full + half)
	
	#update full hearts
	for i in full:
		hearts[i].texture = heart_full
	#update half hearts
	if half: 
		hearts[full].texture = heart_half
	#update empty hearts
	for i in empty:
		hearts[len(hearts) - 1 - i].texture = heart_empty

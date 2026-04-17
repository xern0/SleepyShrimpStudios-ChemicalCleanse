extends CharacterBody2D
@onready var fred: Sprite2D = $fred
@onready var roll: Sprite2D = $roll
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var hand_sprite: Sprite2D = $fred/HandSprite

@export var inv:Inv


const PLAYER_TEMP_DOWN = preload("uid://cdjwdydjod4i7")
const PLAYER_TEMP_LEFT = preload("uid://oap8ffx0kggf")
const PLAYER_TEMP_RIGHT = preload("uid://c7fwbygop2vja")
const PLAYER_TEMP = preload("uid://rkm5abtixqql")
const PLAYER_TEMP_IDLE = preload("uid://2moox4unp1jl")
const PLAYER_TEMP_ROLL = preload("uid://rognx6bw0y7o")
const PLAYER_TEMP_RUN = preload("uid://bpdhx0w15yeb0")

var normal_speed := 600
var roll_speed := 1200
var run_speed := 900
var max_speed := normal_speed
var last_direction := Vector2.RIGHT
var facing_right := true



func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down",)
	velocity = input_direction * max_speed
	if input_direction != Vector2.ZERO:
		last_direction = input_direction.normalized()

func _physics_process(_delta):
	_update_hand()
	get_input()
	_update_hand_layer()
	move_and_slide()
	fred.set_texture(PLAYER_TEMP_IDLE)
	if Input.is_action_pressed("right"):
		fred.set_texture(PLAYER_TEMP_RIGHT)
		facing_right = true
	elif Input.is_action_pressed("left"):
		fred.set_texture(PLAYER_TEMP_LEFT)
		facing_right = false
	elif Input.is_action_pressed("up"):
		fred.set_texture(PLAYER_TEMP)
	elif Input.is_action_pressed("down"):
		fred.set_texture(PLAYER_TEMP_DOWN)
		
	if Input.is_action_pressed("run"):
		fred.set_texture(PLAYER_TEMP_RUN)
		max_speed = run_speed
	if Input.is_action_just_released("run"):
		max_speed = normal_speed


	if Input.is_action_just_pressed("roll"):
		max_speed = roll_speed
		get_node("timer").start()
		$fred.visible = false
		$roll.visible = true
		hand_sprite.visible = false



func _on_timer_timeout() -> void:
	max_speed = normal_speed
	$fred.visible = true
	$roll.visible = false
	max_speed = normal_speed
	$fred.visible = true
	$roll.visible = false
	if Eventbus.current_item != null:  
		hand_sprite.visible = true


func _on_hurtbox_died() -> void:
	pass # Replace with function body.


func _on_hurtbox_hurt() -> void:
	pass # Replace with function body.

func collect(item):
	inv.insert(item)

func _ready():
	hand_sprite.visible = false
	Eventbus.item_equipped.connect(_on_item_equipped)
	hand_sprite.z_index = -1
	print(hand_sprite.z_index)
func _on_item_equipped(item):
	if item == null:
		hand_sprite.visible = false
	else:
		hand_sprite.visible = true
		hand_sprite.texture = item.texture
		hand_sprite.scale = Vector2(0.3, 0.3)
		hand_sprite.position = Vector2(20, 0) 

func _update_hand_position():
	if !hand_sprite.visible:
		return
	var offset := Vector2.ZERO
	if abs(last_direction.x) > abs(last_direction.y):
		if last_direction.x > 0:
			offset = Vector2(20, 0) 
			hand_sprite.flip_h = false
		else:
			offset = Vector2(-20, 0) 
			hand_sprite.flip_h = true
	else:
		if last_direction.y > 0:
			offset = Vector2(0, 20) 
		else:
			offset = Vector2(0, -20)
	hand_sprite.position = offset
	_update_hand_position()

func _update_hand():
	if !hand_sprite.visible:
		return
	if facing_right:
		hand_sprite.position = Vector2(20, 0)
		hand_sprite.flip_h = false
	else:
		hand_sprite.position = Vector2(-20, 0)
		hand_sprite.flip_h = true

func _update_hand_layer():
	if !hand_sprite.visible:
		return
	if last_direction.y < 0:  
		fred.z_index = -1
	elif last_direction.y > 0: 
		fred.z_index = 1

extends CharacterBody2D
@onready var fred: Sprite2D = $fred
@onready var roll: Sprite2D = $roll
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

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


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down",)
	velocity = input_direction * max_speed

func _physics_process(_delta):
	get_input()
	move_and_slide()
	fred.set_texture(PLAYER_TEMP_IDLE)
	if Input.is_action_pressed("right"):
		fred.set_texture(PLAYER_TEMP_RIGHT)
	elif Input.is_action_pressed("left"):
		fred.set_texture(PLAYER_TEMP_LEFT)
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



func _on_timer_timeout() -> void:
	max_speed = normal_speed
	$fred.visible = true
	$roll.visible = false


func _on_hurtbox_died() -> void:
	pass # Replace with function body.


func _on_hurtbox_hurt() -> void:
	pass # Replace with function body.

extends CharacterBody2D
@onready var fred: Sprite2D = $fred
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

const PLAYER_TEMP_DOWN = preload("uid://cdjwdydjod4i7")
const PLAYER_TEMP_LEFT = preload("uid://oap8ffx0kggf")
const PLAYER_TEMP_RIGHT = preload("uid://c7fwbygop2vja")
const PLAYER_TEMP = preload("uid://rkm5abtixqql")
const PLAYER_TEMP_IDLE = preload("uid://2moox4unp1jl")
const PLAYER_TEMP_ROLL = preload("uid://rognx6bw0y7o")

@export var speed = 600
@export var roll_speed = 1000

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down",)
	velocity = input_direction * speed

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
		

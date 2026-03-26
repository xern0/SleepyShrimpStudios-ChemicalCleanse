extends CharacterBody2D
@onready var fred: Sprite2D = $fred
@onready var roll: Sprite2D = $roll
@onready var fred_anim: AnimatedSprite2D = $fred_anim
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var attack_down: AnimatedSprite2D = $melee_attack_stuff/attack_down
@onready var attack_up: AnimatedSprite2D = $melee_attack_stuff/attack_up
@onready var attack_right: AnimatedSprite2D = $melee_attack_stuff/attack_right
@onready var attack_left: AnimatedSprite2D = $melee_attack_stuff/attack_left



const PLAYER_TEMP = preload("uid://rkm5abtixqql")
const PLAYER_TEMP_ROLL = preload("uid://rognx6bw0y7o")
const PLAYER_TEMP_RUN = preload("uid://bpdhx0w15yeb0")

var normal_speed := 500
var roll_speed := 1200
var run_speed := 900
var max_speed := normal_speed


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * max_speed

func _physics_process(_delta):
	get_input()
	move_and_slide()
	if Input.is_action_pressed("up") and Input.is_action_pressed("left"):
		$fred_anim.play("walk_up_left")
	elif Input.is_action_pressed("up") and Input.is_action_pressed("right"):
		$fred_anim.play("walk_up_right")
	elif Input.is_action_pressed("down") and Input.is_action_pressed("right"):
		$fred_anim.play("walk_down_right")
	elif Input.is_action_pressed("down") and Input.is_action_pressed("left"):
		$fred_anim.play("walk_down_left")
	elif Input.is_action_pressed("right"):
		$fred_anim.play("walk_right")
	elif Input.is_action_pressed("left"):
		$fred_anim.play("walk_left")
	elif Input.is_action_pressed("up"):
		$fred_anim.play("walk_up")
	elif Input.is_action_pressed("down"):
		$fred_anim.play("walk_down")
	elif  velocity.is_zero_approx():
		$fred_anim.play("idle")

		
	if Input.is_action_pressed("run"):
		fred.set_texture(PLAYER_TEMP_RUN)
		max_speed = run_speed
	if Input.is_action_just_released("run"):
		max_speed = normal_speed
		
	if Input.is_action_just_pressed("attack down"):
		$melee_attack_stuff/attack_down.visible = true
		$melee_attack_stuff/attack_down.play("attack_down")
		$melee_attack_stuff/workingenemyhitbox/CollisionShape2D.disabled = false
		InputMap.action_erase_events("attack left")
		InputMap.action_erase_events("attack right")
		InputMap.action_erase_events("attack up")
		await get_tree().create_timer(0.35).timeout
		$melee_attack_stuff/attack_down.visible = false
		$melee_attack_stuff/workingenemyhitbox/CollisionShape2D.disabled = true
	elif Input.is_action_just_pressed("attack up"):
		$melee_attack_stuff/attack_up.visible = true
		$melee_attack_stuff/attack_up.play("attack_up")
		$melee_attack_stuff/workingenemyhitbox2/CollisionShape2Dup.disabled = false
		await get_tree().create_timer(0.35).timeout
		$melee_attack_stuff/attack_up.visible = false
		$melee_attack_stuff/workingenemyhitbox2/CollisionShape2Dup.disabled = true
	elif Input.is_action_just_pressed("attack left"):
		$melee_attack_stuff/attack_left.visible = true
		$melee_attack_stuff/attack_left.play("attack_left")
		$melee_attack_stuff/workingenemyhitbox4/CollisionShape2Dleft.disabled = false
		await get_tree().create_timer(0.35).timeout
		$melee_attack_stuff/attack_left.visible = false
		$melee_attack_stuff/workingenemyhitbox4/CollisionShape2Dleft.disabled = true
	elif Input.is_action_just_pressed("attack right"):
		$melee_attack_stuff/attack_right.visible = true
		$melee_attack_stuff/attack_right.play("attack_right")
		$melee_attack_stuff/workingenemyhitbox3/CollisionShape2Dright.disabled = false
		await get_tree().create_timer(0.35).timeout
		$melee_attack_stuff/attack_right.visible = false
		$melee_attack_stuff/workingenemyhitbox3/CollisionShape2Dright.disabled = true


	if Input.is_action_just_pressed("roll"):
		max_speed = roll_speed
		get_node("timer").start()
		$roll.visible = true



func _on_timer_timeout() -> void:
	max_speed = normal_speed
	$roll.visible = false


func _on_hurtbox_died() -> void:
	pass # Replace with function body.


func _on_hurtbox_hurt() -> void:
	pass # Replace with function body.

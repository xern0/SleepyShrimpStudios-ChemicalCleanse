extends CharacterBody2D
@onready var fred: Sprite2D = $fred
#@onready var roll: Sprite2D = $roll
@onready var fred_anim: AnimatedSprite2D = $fred_anim
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var attack_down: AnimatedSprite2D = $melee_attack_stuff/attack_down
@onready var attack_up: AnimatedSprite2D = $melee_attack_stuff/attack_up
@onready var attack_right: AnimatedSprite2D = $melee_attack_stuff/attack_right
@onready var attack_left: AnimatedSprite2D = $melee_attack_stuff/attack_left
#@onready var enemy: CharacterBody2D = $"../enemy"
@onready var hand_sprite: Sprite2D = $fred/HandSprite
#@onready var enemy: CharacterBody2D = $"."
@onready var blinking: AnimationPlayer = $blinking





@export var inv:Inv




const PLAYER_TEMP_RUN = preload("uid://bpdhx0w15yeb0")
const PLAYER_TEMP_ROLL = preload("uid://cjrny7jutk8gr")

var normal_speed := 500
var roll_speed := 1200
var run_speed := 900
var no_speed := 0
var max_speed := normal_speed
var last_direction := Vector2.RIGHT
var facing_right := true

	
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * max_speed

func _physics_process(_delta):
	_update_hand()
	get_input()
	_update_hand_layer()
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
		#fred.set_texture(PLAYER_TEMP_RUN)
		max_speed = run_speed
	if Input.is_action_just_released("run"):
		max_speed = normal_speed
		
	if Input.is_action_just_pressed("attack down"):
		if $melee_attack_stuff/attack_up.is_playing():
			return
		if $melee_attack_stuff/attack_left.is_playing():
			return
		if $melee_attack_stuff/attack_right.is_playing():
			return
		if $melee_attack_stuff/attack_down.is_playing():
			return
		if $fred_Roll.is_playing():
			return
		$melee_attack_stuff/attack_down.visible = true
		$melee_attack_stuff/attack_down.play("attack_down")
		$melee_attack_stuff/workingenemyhitbox/CollisionShape2D.disabled = false
		await get_tree().create_timer(0.35).timeout
		$melee_attack_stuff/attack_down.visible = false
		$melee_attack_stuff/workingenemyhitbox/CollisionShape2D.disabled = true
	elif Input.is_action_just_pressed("attack up"):
		if $melee_attack_stuff/attack_up.is_playing():
			return
		if $melee_attack_stuff/attack_left.is_playing():
			return
		if $melee_attack_stuff/attack_right.is_playing():
			return
		if $melee_attack_stuff/attack_down.is_playing():
			return
		if $fred_Roll.is_playing():
			return
		$melee_attack_stuff/attack_up.visible = true
		$melee_attack_stuff/attack_up.play("attack_up")
		$melee_attack_stuff/workingenemyhitbox2/CollisionShape2Dup.disabled = false
		await get_tree().create_timer(0.35).timeout
		$melee_attack_stuff/attack_up.visible = false
		$melee_attack_stuff/workingenemyhitbox2/CollisionShape2Dup.disabled = true
	elif Input.is_action_just_pressed("attack left"):
		if $melee_attack_stuff/attack_up.is_playing():
			return
		if $melee_attack_stuff/attack_left.is_playing():
			return
		if $melee_attack_stuff/attack_right.is_playing():
			return
		if $melee_attack_stuff/attack_down.is_playing():
			return
		if $fred_Roll.is_playing():
			return
		$melee_attack_stuff/attack_left.visible = true
		$melee_attack_stuff/attack_left.play("attack_left")
		$melee_attack_stuff/workingenemyhitbox4/CollisionShape2Dleft.disabled = false
		await get_tree().create_timer(0.35).timeout
		$melee_attack_stuff/attack_left.visible = false
		$melee_attack_stuff/workingenemyhitbox4/CollisionShape2Dleft.disabled = true
	elif Input.is_action_just_pressed("attack right"):
		if $melee_attack_stuff/attack_up.is_playing():
			return
		if $melee_attack_stuff/attack_left.is_playing():
			return
		if $melee_attack_stuff/attack_right.is_playing():
			return
		if $melee_attack_stuff/attack_down.is_playing():
			return
		if $fred_Roll.is_playing():
			return
		$melee_attack_stuff/attack_right.visible = true
		$melee_attack_stuff/attack_right.play("attack_right")
		$melee_attack_stuff/workingenemyhitbox3/CollisionShape2Dright.disabled = false
		await get_tree().create_timer(0.35).timeout
		$melee_attack_stuff/attack_right.visible = false
		$melee_attack_stuff/workingenemyhitbox3/CollisionShape2Dright.disabled = true


	if Input.is_action_just_pressed("roll"):
		if $fred_Roll.is_playing():
			return
		if $Death.is_playing():
			return
		max_speed = roll_speed
		get_node("timer").start()
		$fred_Roll.play("Roll")
		$fred_Roll.visible = true
		$fred_anim.visible = false
		hand_sprite.visible = false




func _on_timer_timeout() -> void:
	max_speed = normal_speed
	$fred_anim.visible = true
	$fred_Roll.visible = false
	#max_speed = normal_speed
	#$fred_anim.visible = true
	#$fred_Roll.visible = false
	if Eventbus.current_item != null:  
		hand_sprite.visible = true




func _on_hurtbox_hurt() -> void:
	print("ow")
	#var knockback_direction = (enemy.global_position - global_position).normalized()
	#enemy.apply_knockback(knockback_direction, 1750.0, 0.1)
	print("kb")
	blinking.play("HurtBlink")
	await get_tree().create_timer(0.75).timeout
	blinking.play("RESET")
	
func _on_hurtbox_died() -> void:
	print("ded")
	max_speed = no_speed
	fred_anim.visible = false
	$Death.visible = true
	$hurtbox/CollisionShape2D.set_deferred("disabled", true)
	$Death.play("scary_death")
	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene.call_deferred()



func collect(item):
	inv.insert(item)

func _ready():
	blinking.play("RESET")
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

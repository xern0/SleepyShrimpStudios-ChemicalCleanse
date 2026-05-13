extends CharacterBody2D
class_name Enemy

@onready var hit_box_area: Area2D = %hitbox
@onready var raycasts_node: Node2D = %RayCast2D
@onready var target = $"../fred" # Assumes Fred is a sibling node
@onready var _raycasts: Node2D = get_node_or_null("%RayCast2D")

@export var speed: float = 300.0
@export var avoidance_strength := 21000.0

var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0

func _ready() -> void:
	# Setup RayCast exceptions
	for raycast in raycasts_node.get_children():
		if raycast is RayCast2D:
			raycast.add_exception(self)
			
	# Scene reload on player touch
	hit_box_area.body_entered.connect(func(body: Node) -> void:
		if body.name == "fred": # Or use 'if body is Player:'
			get_tree().reload_current_scene.call_deferred()
	)

func _physics_process(delta: float) -> void:
	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= delta
	else:
		# 1. Calculate basic Chase Direction
		var target_pos = target.global_position
		var chase_direction = global_position.direction_to(target_pos)
		
		# 2. Add Avoidance Force (using your RayCast logic)
		var avoidance = calculate_avoidance_force()
		
		# 3. Combine and Apply Velocity
		# We use delta for avoidance because it's usually a large force
		var movement_velocity = chase_direction * speed
		velocity = movement_velocity + (avoidance * delta)

	# Movement execution
	move_and_slide()
	
	# Visuals and Rotations
	update_animations()

func update_animations() -> void:
	# Flip sprite based on movement direction
	if velocity.x != 0:
		$enemy_anim.flip_h = velocity.x < 0 # Adjust based on your sprite's default facing
	
	# Rotate Raycasts to face movement or player
	if velocity.length() > 10.0:
		var target_angle = velocity.angle()
		raycasts_node.rotation = lerp_angle(raycasts_node.rotation, target_angle, 0.1)

func apply_knockback(direction: Vector2, force: float, duration: float) -> void:
	knockback = direction * force
	knockback_timer = duration

func _on_enemyhurtbox_enemydied() -> void:
	$enemy_anim.visible = false
	$cleansedenemy.visible = true
	hit_box_area.set_deferred("monitoring", false)
	$CollisionShape2D.set_deferred("disabled", true)
	speed = 0
	await get_tree().create_timer(1.5).timeout
	queue_free()

func _on_enemyhurtbox_enemy_hurt() -> void:
	# Fixed: Calculate direction from Fred to the Enemy for the stun push
	var push_dir = (global_position - target.global_position).normalized()
	apply_knockback(push_dir, 200.0, 0.2)
	print("Enemy stunned")

func calculate_avoidance_force() -> Vector2:
	var avoidance_force := Vector2.ZERO
	for raycast in raycasts_node.get_children():
		if raycast is RayCast2D and raycast.is_colliding():
			var collision_point = raycast.get_collision_point()
			var dist = raycast.global_position.distance_to(collision_point)
			var ray_length = raycast.target_position.length()
			
			# Stronger force the closer the obstacle is
			var intensity = 1.0 - (dist / ray_length)
			var dir_away = (raycast.global_position - collision_point).normalized()
			avoidance_force += dir_away * avoidance_strength * intensity
			
	return avoidance_force

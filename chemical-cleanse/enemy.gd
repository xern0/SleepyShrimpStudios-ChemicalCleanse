extends CharacterBody2D
class_name Enemy

@onready var Hitbox: hitbox = $hitbox
@onready var tergent = $"../fred"
@onready var enemybody: CharacterBody2D = $"."
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0
var speed = 300
var separation_distance = 30.0

func _ready() -> void:
	$default.play()
	add_to_group("enemy")  # Add to group for separation
	if nav_agent:
		nav_agent.path_desired_distance = 12.0
		nav_agent.target_desired_distance = 25.0
		nav_agent.avoidance_enabled = true
		nav_agent.radius = 8.0

func _physics_process(_delta):
	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= _delta
		if knockback_timer <= 0.0:
			knockback = Vector2.ZERO
	else:
		if nav_agent:
			# SPREAD OUT TARGET - Don't all chase the exact same spot
			var target_pos = tergent.global_position
			var spread = get_spread_offset()
			target_pos += spread
			
			nav_agent.target_position = target_pos
			
			if not nav_agent.is_navigation_finished():
				var next_pos = nav_agent.get_next_path_position()
				var direction = (next_pos - global_position).normalized()
				velocity = direction * speed
			else:
				velocity = Vector2.ZERO
		else:
			var direction = (tergent.position - position).normalized()
			velocity = direction * speed
	
	# SEPARATION - Push away from nearby enemies
	var nearby_enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in nearby_enemies:
		if enemy != self:
			var distance = global_position.distance_to(enemy.global_position)
			if distance < separation_distance and distance > 0:
				var push_direction = (global_position - enemy.global_position).normalized()
				velocity += push_direction * (separation_distance - distance) * 0.5
	
	$enemy_anim.flip_h = velocity.x > 0
	move_and_slide()
	Hitbox.set_active(true)

# Spread out enemies around the target instead of all going to same spot
func get_spread_offset() -> Vector2:
	var enemies = get_tree().get_nodes_in_group("enemy")
	var my_index = enemies.find(self)
	var angle = (my_index as float / max(enemies.size(), 1)) * TAU
	var spread_distance = 60.0
	return Vector2(cos(angle), sin(angle)) * spread_distance

func apply_knockback(direction: Vector2, force: float, knockback_duration: float) -> void:
	knockback = direction * force
	knockback_timer = knockback_duration

func _on_enemyhurtbox_enemydied() -> void:
	$enemy_anim.visible = false
	$cleansedenemy.visible = true
	$hitbox.set_deferred("monitoring", false)
	$CollisionShape2D.set_deferred("disabled", true)
	$enemyhurtbox/CollisionShape2D.set_deferred("disabled", true)
	speed = 0
	$clean.play()
	$default.stop()
	$cleansedfx.emitting = true
	await get_tree().create_timer(1.5).timeout
	call_deferred("queue_free")

func _on_enemyhurtbox_enemyhurt() -> void:
	var stun = (global_position - global_position).normalized()
	enemybody.apply_knockback(stun, 0.0, 0.2)
	$hurt.play()
	$mophit.play()
	$hitfx.emitting = true
	print("nmestun")

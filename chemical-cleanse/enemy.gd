extends CharacterBody2D
@onready var enemy: Sprite2D = $enemy
@onready var Hitbox: hitbox = $hitbox
@onready var tergent=$"../fred"
@onready var fred: CharacterBody2D = $"."
@onready var enemybody: CharacterBody2D = $"."
var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0


var speed=300
	
func _physics_process (_delta):
	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= _delta
		if knockback_timer <= 0.0:
			knockback = Vector2.ZERO
	else:
		var direction=(tergent.position-position).normalized()
		velocity=direction * speed
	#look_at(tergent.position)
	move_and_slide()
	Hitbox.set_active(true)
	

func apply_knockback(direction: Vector2, force: float, knockback_duration: float) -> void:
	knockback = direction * force
	knockback_timer = knockback_duration
	
func _on_enemyhurtbox_enemydied() -> void:
	$enemy.visible = false
	$cleansedenemy.visible = true
	$hitbox.set_deferred("monitoring", false)
	$CollisionShape2D.set_deferred("disabled", true)
	speed = 0
	await get_tree().create_timer(1.5).timeout
	call_deferred("queue_free")
	
func _on_enemyhurtbox_enemyhurt() -> void:
	#stun using reused kb stuff
	var stun = (global_position - global_position).normalized()
	enemybody.apply_knockback(stun, 0.0, 0.2)
	print("nmestun")

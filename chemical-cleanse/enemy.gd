extends CharacterBody2D
@onready var enemy: Sprite2D = $enemy
@onready var Hitbox: hitbox = $hitbox
@onready var tergent=$"../fred"
@onready var fred: CharacterBody2D = $"."
@onready var enemybody: CharacterBody2D = $"."
#var knockback: Vector2 = Vector2.ZERO
#var knockback_timer: float = 0.0


var speed=300
	
func _physics_process (_delta):
	var direction=(tergent.position-position).normalized()
	velocity=direction * speed
	#look_at(tergent.position)
	move_and_slide()
	Hitbox.set_active(true)

#func apply_knockback(direction: Vector2, force: float, knockback_duration: float) -> void:
	#knockback = direction * force
	#knockback_timer = knockback_duration
	
func _on_enemyhurtbox_enemydied() -> void:
	$enemy.visible = false
	$cleansedenemy.visible = true
	
	speed = 0
	await get_tree().create_timer(1.5).timeout
	call_deferred("queue_free")
	
func _on_enemyhurtbox_enemyhurt() -> void:
	pass # Replace with function body.

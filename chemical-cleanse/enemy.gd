extends CharacterBody2D
@onready var enemy: Sprite2D = $enemy
@onready var Hitbox: hitbox = $hitbox
@onready var tergent=$"../fred"

var speed=300
	
func _physics_process (_delta):
	var direction=(tergent.position-position).normalized()
	velocity=direction * speed
	look_at(tergent.position)
	move_and_slide()
	Hitbox.set_active(true)


func _on_enemyhurtbox_enemydied() -> void:
	$enemy.visible = false
	$cleansedenemy.visible = true
	#Hitbox.call_deferred("queue_free")
	speed = 0
	await get_tree().create_timer(1.5).timeout
	call_deferred("queue_free")
	
func _on_enemyhurtbox_enemyhurt() -> void:
	pass # Replace with function body.

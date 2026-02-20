extends CharacterBody2D

@onready var hitbox: hitbox = $hitbox
@onready var tergent=$"../fred"
var speed=200
func _physics_process (_delta):
	var direction=(tergent.position-position).normalized()
	velocity=direction * speed
	look_at(tergent.position)
	move_and_slide()
	hitbox.set_active(true)

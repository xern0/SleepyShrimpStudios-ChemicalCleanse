extends Area2D

class_name enemyhurtbox
signal enemyhurt()
signal enemydied()

@export var enemy:Enemy
@export var enemyhealthpoints:= 3

func enemy_get_damage(value: int, damageSourceNode: Node2D):
	enemyhealthpoints -= value
	
	enemyhurt.emit()
	var knockback_direction = (enemy.global_position - damageSourceNode.global_position).normalized()
	enemy.apply_knockback(knockback_direction, 1200.0, 0.1)
	
	if enemyhealthpoints <= 0:
		enemydied.emit()
		
		

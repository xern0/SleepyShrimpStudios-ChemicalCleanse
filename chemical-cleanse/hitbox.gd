extends Area2D
class_name hitbox

@export var enemy:Enemy
func _ready() -> void:
	set_active(false)
	
func set_active(boolean: bool):
	for child in get_children():
		if child is not CollisionShape2D: continue
		
		child.disabled = not boolean

func _on_area_entered(area: Area2D) -> void:
	if area is hurtbox:
		print("hit player")
		area.get_damage(1)
		var knockback_direction = (enemy.global_position - area.global_position).normalized()
		enemy.apply_knockback(knockback_direction, 1750.0, 0.1)
		
	

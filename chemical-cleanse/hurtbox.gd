extends Area2D
class_name hurtbox
signal hurt()
signal died()
signal on_health_changed(new_health: int)

@export var healthpoints:= 6
var isHurt: bool = false


func get_damage(value: int):
	if isHurt: return 
	healthpoints -= value
	hurt.emit()
	emit_signal("on_health_changed", healthpoints)
	isHurt = true
	await get_tree().create_timer(0.75).timeout
	isHurt = false
	if healthpoints <= 0:
		died.emit()
		#get_tree().reload_current_scene.call_deferred()

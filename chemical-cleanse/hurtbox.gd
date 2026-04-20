extends Area2D
class_name hurtbox
signal hurt()
signal died()
signal on_health_changed(new_health: int)

@export var healthpoints:= 6



func get_damage(value: int):
	healthpoints -= value
	hurt.emit()
	emit_signal("on_health_changed", healthpoints)
	if healthpoints <= 0:
		died.emit()
		#get_tree().reload_current_scene.call_deferred()

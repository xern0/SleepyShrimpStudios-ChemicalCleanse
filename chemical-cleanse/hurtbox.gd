extends Area2D
class_name hurtbox
signal hurt()
signal died()
signal health_changed(new_health: int)

@export var healthpoints:= 6
@onready var heart_ui: CanvasLayer = $"heart ui"



func get_damage(value: int):
	healthpoints -= value
	hurt.emit()
	emit_signal("health_changed", healthpoints)
	heart_ui._update_health(healthpoints)
	if healthpoints <= 0:
		died.emit()
		get_tree().reload_current_scene.call_deferred()

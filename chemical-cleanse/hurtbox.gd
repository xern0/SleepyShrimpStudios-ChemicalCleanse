extends Area2D

class_name hurtbox
signal hurt()
signal died()

@export var healthpoints:= 1

func get_damage(value: int):
	healthpoints -= value
	
	hurt.emit()
	
	if healthpoints <= 0:
		died.emit()

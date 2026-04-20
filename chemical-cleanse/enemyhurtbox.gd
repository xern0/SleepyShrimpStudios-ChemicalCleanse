extends Area2D

class_name enemyhurtbox
signal enemyhurt()
signal enemydied()

@export var enemyhealthpoints:= 3

func enemy_get_damage(value: int):
	enemyhealthpoints -= value
	
	enemyhurt.emit()
	
	if enemyhealthpoints <= 0:
		enemydied.emit()
		
		

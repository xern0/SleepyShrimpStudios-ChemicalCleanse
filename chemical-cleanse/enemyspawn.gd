extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rand = RandomNumberGenerator.new()
	var enemy_scene = load("res://enemyfix.tscn")
	var screen_size = get_viewport().get_visible_rect().size
	
	for i in range(0,10):
		var enemy = enemy_scene.instantiate()
		rand.randomize()
		var x = rand.randf_range(0,screen_size.x)
		rand.randomize()
		var y = rand.randf_range(0,screen_size.y)
		enemy.position.y = y
		enemy.position.x = x 
		add_child(enemy)

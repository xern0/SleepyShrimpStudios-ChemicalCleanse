extends Node2D

var rand = RandomNumberGenerator.new()
var enemy_scene = preload("res://enemyfix.tscn")
var screen_size: Vector2
var spawn_count = 5

func _ready() -> void:
	screen_size = get_viewport().get_visible_rect().size
	$Timer.timeout.connect(_on_timer_timeout)
	spawn_group() 

func _on_timer_timeout() -> void:
	spawn_group()

func spawn_group() -> void:
	for i in range(spawn_count):
		var enemy = enemy_scene.instantiate()
		var x = rand.randf_range(0, screen_size.x)
		var y = rand.randf_range(0, screen_size.y)
		enemy.position = Vector2(x, y)
		add_child(enemy)

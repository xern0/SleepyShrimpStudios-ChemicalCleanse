extends CanvasLayer


@onready var logo = $AnimatedSprite2D

func _ready():
	logo.play("main menu")
	logo.speed_scale = 1.7

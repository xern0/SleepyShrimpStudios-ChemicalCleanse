extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var sb = StyleBoxFlat.new()
	add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color("ffbc21ff")

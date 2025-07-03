extends SubViewport

func _ready():
	if OS.has_feature("mobile"):
		get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS
		size_2d_override = Vector2(2960/6, 1440/6)
		size_2d_override_stretch = true
		DisplayServer.screen_set_orientation(DisplayServer.SCREEN_SENSOR_LANDSCAPE)

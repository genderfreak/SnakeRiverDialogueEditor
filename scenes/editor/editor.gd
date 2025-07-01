extends Control

var font_sizes: Dictionary = {
	0: 18,
	200: 32,
	400: 54
}

func _ready():
	var dpi = DisplayServer.screen_get_dpi()
	var keys = font_sizes.keys()
	keys.reverse()
	for key in keys:
		if dpi > key:
			theme.set_default_font_size(font_sizes[key])
			break

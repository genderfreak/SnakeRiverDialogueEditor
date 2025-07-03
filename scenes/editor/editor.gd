extends Control

#var font_sizes: Dictionary = {
	#0: 18,
	#200: 32,
	#400: 54
#}

#func _ready():
	##if OS.has_feature("mobile"):
		#get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS
		#get_viewport().size = Vector2(2960/8, 1440/8)
		##DisplayServer.screen_set_orientation(DisplayServer.SCREEN_PORTRAIT)
	#var dpi = DisplayServer.screen_get_dpi()
	#var keys = font_sizes.keys()
	#keys.reverse()
	#for key in keys:
		#if dpi > key:
			#theme.set_default_font_size(font_sizes[key])
			#break

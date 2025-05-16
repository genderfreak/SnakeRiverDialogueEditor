extends Button

@export var popup: PopupMenu

func __on_pressed():
	popup.position=get_parent().get_global_mouse_position()
	popup.size=Vector2(0,0)
	popup.popup()

extends Node

@export var popup: Node

func _ready():
	get_parent().gui_input.connect(_gui_input)

func _gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed() \
	and event.button_index == MOUSE_BUTTON_RIGHT:
		get_viewport().set_input_as_handled()
		popup.position=get_parent().get_global_mouse_position()
		popup.size=Vector2(0,0)
		popup.popup()

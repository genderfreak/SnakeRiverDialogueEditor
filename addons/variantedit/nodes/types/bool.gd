extends EditableField

@export var child: CheckBox

func get_value():
	return child.button_pressed

func set_value(new_value):
	child.set_pressed(new_value)

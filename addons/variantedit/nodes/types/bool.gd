extends EditableField

@export var child: CheckBox

func _ready():
	child.pressed.connect(value_changed.emit)

func get_value():
	return child.button_pressed

func set_value(new_value):
	child.set_pressed(new_value)

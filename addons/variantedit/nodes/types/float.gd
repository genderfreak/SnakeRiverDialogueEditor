extends EditableField

@export var child: SpinBox

func _ready():
	child.value_changed.connect(value_changed.emit)

func get_value():
	return float(child.value)

func set_value(new_value):
	child.set_value(new_value)

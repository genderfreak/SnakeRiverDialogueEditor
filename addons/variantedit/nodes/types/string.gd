extends EditableField

@export var child: TextEdit

func _ready():
	child.text_changed.connect(value_changed.emit)

func get_value():
	return str(child.text)

func set_value(new_value):
	child.set_text(new_value)

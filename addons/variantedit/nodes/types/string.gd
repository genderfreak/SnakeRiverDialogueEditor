extends EditableField

@export var child: TextEdit

func get_value():
	return str(child.text)

func set_value(new_value):
	child.set_text(new_value)

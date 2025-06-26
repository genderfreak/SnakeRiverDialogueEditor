extends EditableField

@export var values: VBoxContainer
@export var add_item_button: Button

var array_item = preload("res://addons/variantedit/nodes/types/subscenes/array_item.tscn")

func _ready():
	add_item_button.pressed.connect(add_array_item)

func get_value():
	var array = []
	for i in values.get_children():
		array.append(i.get_value())
	return array

func set_value(array: Array):
	for i in values.get_children():
		i.queue_free()
	for i in array:
		var new_array_item = add_array_item()
		new_array_item.set_value(i)

func add_array_item():
	var new_item = array_item.instantiate()
	values.add_child(new_item)
	return new_item

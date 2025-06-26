extends HBoxContainer

var var_edit
@export var remove_button: Button

signal remove_self

func _ready():
	var_edit = load("res://addons/variantedit/nodes/variant_edit.tscn").instantiate()
	add_child(var_edit)
	move_child(var_edit, 0)
	remove_button.pressed.connect(queue_free)

func get_value():
	return(var_edit.get_value())

func set_value(new_value):
	var_edit.change_type(typeof(new_value))
	var_edit.set_value_and_update_visuals(new_value)

@icon("res://addons/variantedit/icon.svg")
extends HBoxContainer
class_name VariantEdit

var __value: Variant = null
var __type: Variant.Type = TYPE_NIL

@onready var change_type_button: TypeSelectionButton = $ChangeTypeButton
@onready var edit_container: Control = $EditableControl
var edit_node: EditableField

var edit_scenes = {
	TYPE_NIL: preload("res://addons/variantedit/nodes/types/Nil.tscn"),
	TYPE_BOOL: preload("res://addons/variantedit/nodes/types/bool.tscn"),
	TYPE_INT: preload("res://addons/variantedit/nodes/types/int.tscn"),
	TYPE_FLOAT: preload("res://addons/variantedit/nodes/types/float.tscn"),
	TYPE_STRING: preload("res://addons/variantedit/nodes/types/String.tscn"),
	TYPE_STRING_NAME: preload("res://addons/variantedit/nodes/types/StringName.tscn"),
	TYPE_ARRAY: preload("res://addons/variantedit/nodes/types/Array.tscn"),
}

func _ready():
	change_type_button.type_changed.connect(change_type)
	change_type(__type)

func get_value():
	update_value()
	return __value

func update_value():
	__value = edit_node.get_value()

func set_value(new_value, do_change_type=true):
	if do_change_type: change_type(typeof(new_value))
	__value=new_value
	edit_node.set_value(__value)

func get_type():
	return __type

func change_type(new_type: Variant.Type):
	__type = new_type
	if edit_node: edit_node.queue_free()
	edit_node = edit_scenes[new_type].instantiate()
	edit_container.add_child(edit_node)
	update_value()

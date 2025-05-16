@icon("res://addons/variantedit/icon.svg")
extends HBoxContainer
class_name VariantEdit

var value: Variant = null
var type: Variant.Type = TYPE_NIL

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
}

func _ready():
	change_type_button.type_changed.connect(change_type)
	change_type(type)

func update_value(_new_value=null):
	value = edit_node.get_value()

func set_value_and_update_visuals(new_value):
	value=new_value
	edit_node.set_value(value)

func change_type(new_type: Variant.Type):
	type = new_type
	if edit_node: edit_node.queue_free()
	edit_node = edit_scenes[new_type].instantiate()
	edit_container.add_child(edit_node)
	edit_node.value_changed.connect(update_value)
	update_value()

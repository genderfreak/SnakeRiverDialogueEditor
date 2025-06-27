extends PanelContainer

@export var key_edit: Node
@export var var_edit: VariantEdit

@export var menu_button: MenuButton

var __right_click_menu_scene: PackedScene = preload("res://scenes/editor/right_click_menu.tscn")
var right_click_menu: Node
var field_popup: PopupMenu

var popup_items = [
	["Remove Field", delete_self]
]

signal remove_field(field)

func _ready():
	field_popup = menu_button.get_popup()
	for entry in popup_items:
		field_popup.add_item(entry[0])
	field_popup.index_pressed.connect(func (idx: int):popup_items[idx][1].call())
	right_click_menu = __right_click_menu_scene.instantiate()
	right_click_menu.popup = field_popup
	add_child(right_click_menu)

## Return a key: value pair
func save() -> Dictionary:
	if not get_key(): push_warning("Key in %s is empty!" % self)
	return {get_key(): get_value()}

## Return the key
func get_key():
	return StringName(key_edit.text)

## Return the value
func get_value():
	return var_edit.get_value()

## Return the type
func get_type():
	return var_edit.get_type()

## Set the var edit's type
func set_type(type: Variant.Type):
	var_edit.change_type(type)

## Set key and change visual instance
func set_key(key: String):
	key_edit.text=StringName(key)

## Set the value of the field
func set_value(value: Variant):
	var_edit.set_value(value)

## Send a signal requesting deletion
func delete_self():
	remove_field.emit(self)

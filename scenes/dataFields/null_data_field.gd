extends Control
class_name NullDataField

var __key_node_scene: PackedScene = preload("res://scenes/dataFields/dataFieldScenes/field_key_edit.tscn")
var __key_node: Node
var key: String = ""
var value = null
var __right_click_menu_scene: PackedScene = preload("res://scenes/right_click_menu.tscn")
var right_click_menu
var __field_popup_scene: PackedScene = preload("res://scenes/dataFields/dataFieldScenes/field_popup.tscn")
var field_popup

var field_type

signal remove_field(field)

func _ready():
	# Right click stuff
	field_popup = __field_popup_scene.instantiate()
	right_click_menu = __right_click_menu_scene.instantiate()
	add_child(field_popup)
	right_click_menu.popup = field_popup
	add_child(right_click_menu)
	field_popup.remove_field.connect(delete_self)
	# Key node
	__key_node = __key_node_scene.instantiate()
	add_child(__key_node)
	move_child(__key_node,0)
	__key_node.text_changed.connect(func(): key=__key_node.text)

## Return a key: value pair
func save() -> Dictionary:
	if not key: push_warning("Key in %s is empty!" % self)
	return {key: value}

## Return the key
func get_key():
	return key

## Return the value
func get_value():
	return value

## Set key and change visual instance
func set_key(new_key: String):
	key=new_key
	__key_node.text=key

## Send a signal requesting deletion
func delete_self():
	remove_field.emit(self)

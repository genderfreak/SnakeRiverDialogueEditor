extends PopupMenu

@export var json_flow_node: PackedScene = preload("res://scenes/json_node.tscn")

var popup_items = [
	["Add JSON Flow Node", add_json_flow_node_clicked]
]

func _ready():
	for entry in popup_items:
		add_item(entry[0])
	id_pressed.connect(func (idx: int):popup_items[idx][1].call())

func add_json_flow_node_clicked():
	var instance = json_flow_node.instantiate()
	get_parent().add_child(instance)
	instance.position_offset = (get_parent().get_local_mouse_position() + get_parent().scroll_offset) / get_parent().zoom

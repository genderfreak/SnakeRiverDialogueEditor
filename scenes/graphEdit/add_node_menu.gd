extends PopupMenu

@export var json_flow_node: PackedScene = preload("res://scenes/graphNodes/json_node.tscn")
@export var template_picker: PackedScene = preload("res://scenes/templateRegistry/template_picker.tscn")

@onready var graph_edit = get_parent()

var popup_items = [
	["Add JSON Flow Node", add_json_flow_node_clicked],
	["Add node from template...", add_from_template_clicked],
]

func _ready():
	for entry in popup_items:
		add_item(entry[0])
	id_pressed.connect(func (idx: int):popup_items[idx][1].call())

func add_json_flow_node_clicked():
	graph_edit.add_node()

func add_from_template_clicked():
	var picker = template_picker.instantiate()
	add_child(picker)
	picker.popup()
	picker.position = get_parent().get_global_mouse_position() - Vector2(picker.size/2) + Vector2(0,100)
	picker.template_picked.connect(template_picked)

func template_picked(template):
	graph_edit.add_node(Globals.template_registry.get_template_data(template),template)

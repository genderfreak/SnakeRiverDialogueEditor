extends Node

var data_field_scenes: Array[PackedScene] = [
	preload("res://scenes/dataFields/text_data_field.tscn"),
	preload("res://scenes/dataFields/bool_data_field.tscn"),
	preload("res://scenes/dataFields/int_data_field.tscn"),
	preload("res://scenes/dataFields/null_data_field.tscn"),
]

## Dictionary of node names and their respective scene files
var data_fields: Dictionary = {}

var flow_node := preload("res://scenes/json_node.tscn")

func _ready():
	for entry in data_field_scenes:
		data_fields.set(entry.resource_path.get_file().replace(".tscn", "").capitalize(), entry)

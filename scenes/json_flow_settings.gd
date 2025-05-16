extends Node

var data_field_scn: PackedScene = preload("res://scenes/key_value_edit.tscn")

var flow_node := preload("res://scenes/json_node.tscn")

var template_registry = TemplateRegistry.new()

#func _ready():
	#for entry in data_field_scenes:
		#data_fields.set(entry.resource_path.get_file().replace(".tscn", "").capitalize(), entry)

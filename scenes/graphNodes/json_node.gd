extends GraphNode

class_name JSONFlowNode

@export var add_field_button: Node
@export var output_editor: Node

var output_label_scn: PackedScene = preload("res://scenes/graphNodes/output_label.tscn")

var output_labels: Array = []
var outputs: Array = []

var fields: Array = []

signal name_changed(instance, old_name, new_name)

func _ready():
	change_name(name)
	add_field_button.pressed.connect(add_field)
	output_editor.output_change_request.connect(_output_change_request)
	add_output()

## Add a field to the fields list, return the field
func add_field(grab_focus=true):
	var field = JSONFlowSettings.data_field_scn.instantiate()
	%Properties.add_child(field)
	fields.append(field)
	field.remove_field.connect(remove_field)
	if grab_focus: field.key_edit.grab_focus.call_deferred()
	return field

## Remove a field
func remove_field(field: Node):
	fields.erase(field)
	field.queue_free()

## Set output slot to to_node (not typed but should be a json node or null)
func set_output(from_port: int, to_node):
	outputs[from_port] = to_node

func _output_change_request(add: bool):
	if add: add_output()
	else: remove_output()

## Add an output slot
func add_output():
	var new_label = output_label_scn.instantiate()
	new_label.text=str(len(output_labels))
	add_child(new_label)
	move_child(new_label, len(output_labels))
	set_slot_enabled_right(len(output_labels),true)
	output_labels.append(new_label)
	outputs.append(null)

## Remove an output slot
func remove_output():
	get_parent().disconnect_all(name,outputs.size()-1)
	outputs.pop_back()
	remove_child(output_labels.pop_back())
	set_slot_enabled_right(len(output_labels),false)

## Change node's name. Update title text to match.
func change_name(new_name):
	name_changed.emit(self, name, new_name)
	name = new_name
	title = name

## Return a dictionary of elements to save to a file
func save() -> Dictionary:
	var dict = {}
	dict.merge({"graph_data": get_graph_data()})
	## If outputs isn't empty, add an array of outputs with names to dict
	if not outputs.is_empty():
		var output_names = []
		for i in outputs:
			if i:
				output_names.append(i.name)
		dict.merge({"outputs": output_names})
	if not fields.is_empty():
		var fields_dict = {}
		var fields_meta_dict = {}
		for f in fields:
			fields_dict.set(f.get_key(),f.get_value())
			fields_meta_dict.set(f.get_key(),f.get_type())
		dict.merge({"fields": fields_dict})
		dict.merge({"fields_meta": fields_meta_dict})
	return dict

func __await_ready_then_do(node, callable):
	await node.ready
	callable.call()

## Load properties from a dictionary of elements, return outputs to be connected or empty dict if none to connect
func load_from(dict: Dictionary) -> Array:
	size.x = dict["graph_data"]["size"]["x"]
	size.y = dict["graph_data"]["size"]["y"]
	position_offset.x = dict["graph_data"]["position_offset"]["x"]
	position_offset.y = dict["graph_data"]["position_offset"]["y"]
	if dict.has("fields"):
		for f in dict["fields"]:
			var field = add_field(false) # keyvalue edit
			field.set_type(dict["fields_meta"][f])
			if dict["fields"][f]:
				field.set_value(dict["fields"][f])
			field.set_key(f)
	return dict["outputs"] if dict.has("outputs") else []

## Returns data used to recreate the node graph
func get_graph_data() -> Dictionary:
	return { "size": {"x":size.x,"y":size.y},
	"position_offset": {"x": position_offset.x, "y": position_offset.y},}

func _on_resize_request(new_size: Vector2) -> void:
	size=new_size

extends GraphEdit

@export var json_flow_node: PackedScene = preload("res://scenes/json_node.tscn")

func _ready():
	Locator.graph_edit = self
	connection_request.connect(_on_connection_request)
	disconnection_request.connect(_on_disconnection_request)

func add_node(data: Dictionary = {}, node_name: String = "", pos: Variant = false):
	var instance = json_flow_node.instantiate()
	add_child(instance)
	if data:
		instance.load_from(data)
	if node_name:
		instance.change_name(node_name)
	instance.name_changed.connect(__on_name_changed)
	if pos is Vector2:
		instance.position_offset = (pos + scroll_offset) / zoom
	else:
		instance.position_offset = (get_local_mouse_position() + scroll_offset) / zoom

## Called when a child's name is changed, reconnects connections
## Has a bug that causes old connections to keep drawing until moved, not sure how to fix, but its not a big deal
func __on_name_changed(instance, old_name, new_name):
	for node in get_inputting_nodes(old_name):
		connect_json_node(node["from_node"],node["from_port"],new_name,node["to_port"])

## Returns a list of nodes connected to from_node in from_port
func get_nodes_connected_to(from_node: StringName, from_port: int):
	var array = []
	for node in connections:
		if node.from_node == from_node and node.from_port == from_port:
			array.append({"to_node": node.to_node,"to_port": node.to_port})
	return array

## Returns a list of nodes that input to_node
func get_inputting_nodes(to_node: StringName):
	var array = []
	for node in connections:
		if node.to_node == to_node:
			array.append(node)
	return array

func _on_connection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	if get_connection_count(from_node, from_port):
		for node in get_nodes_connected_to(from_node,from_port):
			disconnect_node(from_node,from_port,node.to_node,node.to_port)
	connect_json_node(from_node,from_port,to_node,to_port)

func _on_disconnection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	disconnect_json_node(from_node,from_port,to_node,to_port)

func connect_json_node(from_node: StringName, from_port: int, to_node: StringName, to_port: int):
	get_node(NodePath(from_node)).set_output(from_port, get_node(NodePath(to_node)))
	connect_node(from_node,from_port,to_node,to_port)

func disconnect_json_node(from_node: StringName, from_port: int, to_node: StringName, to_port: int):
	get_node(NodePath(from_node)).set_output(from_port, null)
	disconnect_node(from_node,from_port,to_node,to_port)

func save_to_file(path: String):
	var dict = {}
	for child in get_children():
		if child is JSONFlowNode:
			dict[child.name] = child.save()
	var file = FileAccess.open(path,FileAccess.WRITE)
	file.store_string(JSON.stringify(dict, "  "))
	file.close()
	Locator.toaster.toast("File saved as %s" % path)

func load_from_file(path: String):
	clear_graph()
	var file = FileAccess.open(path,FileAccess.READ)
	var json = JSON.new()
	var err = json.parse(file.get_as_text())
	if err==OK:
		if json.data is Dictionary:
			pass
		else:
			push_warning("JSON failure, laugh at this user! (unexpected data type %s)" % type_string(typeof(json.data)))
	else:
		push_warning("JSON Parse Error: " + json.get_error_message(), " at line ", json.get_error_line())
	var to_connect = {}
	for new_name in json.data:
		var new_node = JSONFlowSettings.flow_node.instantiate()
		new_node.name = new_name
		add_child(new_node)
		to_connect.set(new_node.name, new_node.load_from(json.data[new_name]))
	for from_node in to_connect:
		var cnt = 0
		for to_node in to_connect[from_node]:
			if cnt>0:
				get_node(str(from_node)).add_output()
			connect_json_node(from_node, cnt, to_node, 0)
			cnt+=1

func clear_graph():
	for i in get_children():
		if i is GraphNode:
			i.queue_free()
			i.name = "__FREED_NODE"
	clear_connections()

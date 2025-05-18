extends GraphEdit

@export var json_flow_node: PackedScene = preload("res://scenes/json_node.tscn")

func _ready():
	connection_request.connect(_on_connection_request)
	disconnection_request.connect(_on_disconnection_request)

func add_node(data: Dictionary = {}, node_name: String = ""):
	var instance = json_flow_node.instantiate()
	add_child(instance)
	if data:
		instance.load_from(data)
	if node_name:
		instance.change_name(node_name)
	instance.position_offset = (get_local_mouse_position() + scroll_offset) / zoom

func get_nodes_connected_to(from_node: StringName, from_port: int):
	var array = []
	for node in connections:
		if node.from_node == from_node and node.from_port == from_port:
			array.append({"to_node": node.to_node,"to_port": node.to_port})
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

func load_from_file(path: String):
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

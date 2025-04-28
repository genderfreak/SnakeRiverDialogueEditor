extends GraphEdit


func _ready():
	connection_request.connect(_on_connection_request)
	disconnection_request.connect(_on_disconnection_request)

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
	pass

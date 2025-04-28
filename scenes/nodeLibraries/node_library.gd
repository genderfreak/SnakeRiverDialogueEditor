extends Resource

class_name NodeLibrary

## A list of all nodes in the library by name: packed scene.
@export var nodes: = {}

## Take a node name and return an instance of it.
func get_instance_of(key: String):
	assert(key in nodes)
	var node = nodes[key]
	node.instantiate()

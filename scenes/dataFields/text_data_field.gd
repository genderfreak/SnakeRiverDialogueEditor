extends NullDataField

class_name TextDataField

@export var __value_node: Node

func _ready() -> void:
	super._ready()
	__value_node.text_changed.connect(func(): value=__value_node.text)
	value = ""

func set_value(new_value: String):
	value=new_value
	__value_node.text=value

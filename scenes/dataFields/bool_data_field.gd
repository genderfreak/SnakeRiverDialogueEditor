extends NullDataField

class_name BoolDataField

@export var __value_node: Node

func _ready() -> void:
	super._ready()
	__value_node.toggled.connect(func(new): value=new)
	value = false

func set_value(new_value: bool):
	value=new_value
	__value_node.button_pressed=value

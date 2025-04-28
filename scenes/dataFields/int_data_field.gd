extends NullDataField

class_name IntDataField

@export var __value_node: Node

func _ready() -> void:
	super._ready()
	__value_node.value_changed.connect(func(new): value=int(new))
	value = 0

func set_value(new_value: int):
	value=new_value
	__value_node.text=value

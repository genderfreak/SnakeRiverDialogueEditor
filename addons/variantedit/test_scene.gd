extends Control

@export var vbox: Node
@export var button: Node
@export var print_button: Node

var scn := preload("res://addons/variantedit/nodes/variant_edit.tscn")

func _ready():
	button.pressed.connect(func(): vbox.add_child(scn.instantiate()))
	print_button.pressed.connect(print_all)

func print_all():
	for i in vbox.get_children():
		print(i.get_value())

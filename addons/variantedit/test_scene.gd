extends Control

@export var vbox: Node
@export var button: Node

var scn := preload("res://addons/variantedit/nodes/variant_edit.tscn")

func _ready():
	button.pressed.connect(func(): vbox.add_child(scn.instantiate()))

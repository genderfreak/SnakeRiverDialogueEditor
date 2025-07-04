extends Node

var template_registry := TemplateRegistry.new()

#func _ready():
	#template_registry.load_registry_from_file("res://demo_saves/templates.json")

func clear_template_registry():
	template_registry = TemplateRegistry.new()

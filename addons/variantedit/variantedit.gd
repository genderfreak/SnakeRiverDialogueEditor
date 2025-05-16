@tool
extends EditorPlugin


func _enter_tree() -> void:
	#add_custom_type("VariantEdit", "HBoxContainer", preload("nodes/variant_edit.gd"), preload("icon.svg"))
	pass

func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	pass

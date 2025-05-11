extends Window

@export var item_container: Node
var item_scene: PackedScene = preload("res://scenes/templateRegistry/template_manager_item.tscn")

var template_registry = Globals.template_registry

func _ready():
	update_template_list()

func update_template_list():
	for child in item_container.get_children():
		child.queue_free()
	for template in template_registry.get_templates():
		var item = item_scene.instantiate()
		item.label.text = "%s\n\t[color=grey]%s[/color]" % [template, template_registry.get_template_data(template)["fields"]]
		item_container.add_child(item)
		item.template_key = template
		item.remove_button.pressed.connect(remove_template.bind(item))

func remove_template(node: Node):
	template_registry.remove_template(node.template_key)
	node.queue_free()

func _on_close_requested() -> void:
	queue_free()

func _on_save_pressed() -> void:
	_save_as_popup()

func _on_load_pressed() -> void:
	_load_popup()

func _on_clear_pressed() -> void:
	template_registry.clear_templates()
	update_template_list()

func _create_file_popup() -> FileDialog:
	var file_popup = FileDialog.new()
	file_popup.add_filter("*.json; Dialogue System Templates File")
	file_popup.access = FileDialog.ACCESS_FILESYSTEM
	file_popup.show_hidden_files=true
	file_popup.use_native_dialog=true
	return file_popup

func _save_as_popup():
	var file_popup = _create_file_popup()
	add_child(file_popup)
	file_popup.popup_centered_ratio()
	file_popup.file_selected.connect(template_registry.save_registry_to_file)

func _load_popup():
	var file_popup = _create_file_popup()
	file_popup.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	add_child(file_popup)
	file_popup.popup_centered_ratio()
	file_popup.file_selected.connect(template_registry.load_registry_from_file)
	if not template_registry.load_finished.is_connected(update_template_list):
		template_registry.load_finished.connect(update_template_list)
	

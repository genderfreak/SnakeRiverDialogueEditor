extends Resource

class_name TemplateRegistry

var templates: Dictionary = {}

signal load_finished

func _init():
	pass

## Saves a template with name and data
func save_template(name, data):
	templates.set(name, data)

## Returns a dictionary of templates
func get_templates() -> Dictionary:
	return templates

## Returns template data
func get_template_data(name):
	return templates[name]

## Removes template with name
func remove_template(name) -> bool:
	return templates.erase(name)

## Clears all templates
func clear_templates() -> void:
	templates = {}

func save_registry_to_file(path: String):
	var file = FileAccess.open(path,FileAccess.WRITE)
	file.store_string(JSON.stringify(templates, "  "))
	file.close()

func load_registry_from_file(path: String):
	var file = FileAccess.open(path,FileAccess.READ)
	var json = JSON.new()
	var err = json.parse(file.get_as_text())
	if err==OK:
		if json.data is Dictionary:
			templates = json.data
		else:
			push_warning("JSON failure, laugh at this user! (unexpected data type %s)" % type_string(typeof(json.data)))
	else:
		push_warning("JSON Parse Error: " + json.get_error_message(), " at line ", json.get_error_line())
	load_finished.emit()

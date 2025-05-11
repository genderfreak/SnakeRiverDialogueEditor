extends AcceptDialog

## Dialog for selecting templates from a TemplateRegistry.
##
## Emits template_picked with a key, or emits confirmed when the dialog is closed without
## picking a template. Always emits 

@export var template_registry: TemplateRegistry = Globals.template_registry
@export var button_container: Node

@export var close_on_pick: bool = true

signal template_picked(template)

func _ready():
	template_picked.connect(__template_picked)
	for template in template_registry.get_templates():
		var button = Button.new()
		button.alignment=HORIZONTAL_ALIGNMENT_LEFT
		button.autowrap_mode=TextServer.AUTOWRAP_WORD
		button.text = "%s\n%s" % [template, template_registry.get_template_data(template)["fields"]]
		button_container.add_child(button)
		button.pressed.connect(template_picked.emit.bind(template))

func __template_picked(template):
	if close_on_pick: get_ok_button().pressed.emit()

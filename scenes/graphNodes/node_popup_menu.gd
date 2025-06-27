extends PopupMenu

var popup_items = [
	["Remove node", remove_node_popup],
	["Change name", change_name_popup],
	["Save as template", save_as_template],
]

var name_popup_scn = preload("res://scenes/graphNodes/name_popup.tscn")

func _ready():
	for entry in popup_items:
		add_item(entry[0])
	id_pressed.connect(func (idx: int):popup_items[idx][1].call())

## Show a popup to confirm if the user wants to remove the node
func remove_node_popup():
	var dialog = ConfirmationDialog.new()
	dialog.dialog_text="Are you sure you want to delete this node?"
	dialog.confirmed.connect(get_parent().queue_free)
	dialog.canceled.connect(dialog.queue_free)
	dialog.confirmed.connect(dialog.queue_free)
	dialog.dialog_autowrap = true
	dialog.size=Vector2(200,100)
	dialog.position=get_parent().get_global_mouse_position()-(Vector2(dialog.size)*Vector2(0.5,0.5))
	add_child(dialog)
	dialog.popup()

func change_name_popup():
	var name_popup = name_popup_scn.instantiate()
	add_child(name_popup)
	name_popup.line_edit.text=get_parent().name
	name_popup.position=get_parent().get_global_mouse_position()-(Vector2(name_popup.size)*Vector2(0.5,0.5))
	name_popup.confirmed.connect(change_name_popup_confirmed.bind(name_popup))
	name_popup.canceled.connect(name_popup.queue_free)
	name_popup.popup()

func change_name_popup_confirmed(name_popup):
	get_parent().change_name(name_popup.line_edit.text)
	name_popup.queue_free()

func save_as_template():
	Globals.template_registry.save_template(get_parent().name,get_parent().save())

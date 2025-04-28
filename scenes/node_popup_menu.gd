extends PopupMenu

var popup_items = [
	["Remove node", remove_node_popup]
]

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

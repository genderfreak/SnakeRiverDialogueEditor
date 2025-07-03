extends MenuBar

@export var graph_edit: GraphEdit

var template_manager: PackedScene = preload("res://scenes/templateRegistry/template_manager.tscn")

var options = {
	"File": [
		["New", _new_popup],
		["Save", _save_popup],
		["Save as", _save_as_popup],
		["Load", _load_popup],
		["Manage templates", open_template_manager],
	],
	#"Edit": [
	#],
	"About": [
		["About Snake River", open_about_window],
	]
}

var current_save_path: String = ""

func _ready():
	for entry in options:
		var popup_menu = PopupMenu.new()
		popup_menu.name = entry
		add_child(popup_menu)
		for menu_item in options[entry]:
			popup_menu.add_item(menu_item[0])
		popup_menu.id_pressed.connect(func (idx: int):options[entry][idx][1].call())

func _create_file_popup() -> FileDialog:
	var popup = FileDialog.new()
	popup.add_filter("*.json; Dialogue System File")
	popup.access = FileDialog.ACCESS_FILESYSTEM
	popup.show_hidden_files=true
	popup.use_native_dialog=true
	return popup

func _new_popup():
	var dialog = ConfirmationDialog.new()
	dialog.dialog_text = "Clear the current graph?"
	add_child(dialog)
	dialog.popup_centered()
	dialog.canceled.connect(func (): dialog.queue_free())
	dialog.confirmed.connect(func (): graph_edit.clear_graph(); current_save_path="")
	dialog.confirmed.connect(func (): dialog.queue_free())

func _save_popup():
	if current_save_path:
		graph_edit.save_to_file(current_save_path)
	else:
		_save_as_popup()

func _save_as_popup():
	var popup = _create_file_popup()
	add_child(popup)
	popup.popup_centered_ratio()
	popup.file_selected.connect(graph_edit.save_to_file)
	popup.file_selected.connect(func (new_val): current_save_path = new_val)
	popup.canceled.connect(popup.queue_free)
	popup.file_selected.connect(func(_var): popup.queue_free())

func _load_popup():
	var popup = _create_file_popup()
	popup.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	add_child(popup)
	popup.popup_centered_ratio()
	popup.file_selected.connect(_on_load_file_selected)
	popup.canceled.connect(popup.queue_free)
	popup.file_selected.connect(func(_var): popup.queue_free())

func _on_load_file_selected(file):
	graph_edit.load_from_file(file)
	current_save_path = file

func open_template_manager():
	var window: Window = template_manager.instantiate()
	add_child(window)
	window.popup_centered()

func open_about_window():
	var window = load("res://scenes/about/about.tscn").instantiate()
	add_child(window)
	window.close_requested.connect(window.queue_free)

extends MenuBar

@export var graph_edit: GraphEdit

var options = {
	"File": [
		["Save", _save_popup],
		["Save as", _save_as_popup],
		["Load", _save_as_popup]
	],
	"Edit": [
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

func _load_popup():
	var popup = _create_file_popup()
	popup.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	add_child(popup)
	popup.popup_centered_ratio()
	popup.file_selected.connect(graph_edit.load_from_file)

extends MenuButton

var popup = get_popup()

signal add_field(packed_scene)

func _ready():
	for key in JSONFlowSettings.data_fields:
		popup.add_item(key)
	popup.id_pressed.connect(_popup_pressed)

func _popup_pressed(id):
	add_field.emit(popup.get_item_text(id))

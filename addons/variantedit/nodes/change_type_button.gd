extends MenuButton
class_name TypeSelectionButton

const ALLOWED_TYPES: Array = [
	TYPE_NIL,
	TYPE_BOOL,
	TYPE_INT,
	TYPE_FLOAT,
	TYPE_STRING,
	TYPE_STRING_NAME,
]

@export var type: Variant.Type = ALLOWED_TYPES[0] as Variant.Type

signal type_changed(type)

func _ready():
	assert(type in ALLOWED_TYPES)
	var popup = get_popup()
	for t in ALLOWED_TYPES:
		popup.add_icon_item(load("res://addons/variantedit/icons/%s.svg" % type_string(t)),type_string(t),t)
	popup.id_pressed.connect(__on_id_pressed)

func __on_id_pressed(id):
	type_changed.emit(id as Variant.Type)

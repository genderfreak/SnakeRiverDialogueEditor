extends PopupMenu

var popup_items = [
	["Remove Field", remove_field_pressed]
]

signal remove_field

func _ready():
	visible=false
	for entry in popup_items:
		add_item(entry[0])
	id_pressed.connect(func (idx: int):popup_items[idx][1].call())

func remove_field_pressed():
	remove_field.emit()

extends HBoxContainer

@export var minus: Node
@export var plus: Node
@export var text = "Out"
@export var label: Node

## Emitted when one of the buttons is pressed. If false, minus, if true, plus
signal output_change_request(increase)

func _ready():
	label.text = text
	minus.pressed.connect(output_change_request.emit.bind(false))
	plus.pressed.connect(output_change_request.emit.bind(true))

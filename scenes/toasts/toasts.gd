extends MarginContainer

@export var vbox: Node

var _toast_node = preload("res://scenes/toasts/toast.tscn")

func _ready():
	Locator.toaster = self

func toast(text):
	var new_toast = _toast_node.instantiate()
	new_toast.set_text(text)
	vbox.add_child(new_toast)
	var timer = get_tree().create_timer(2)
	timer.timeout.connect(tween_node_out.bind(new_toast))

func tween_node_out(node):
	var tween: Tween = node.create_tween()
	tween.tween_property(node, "modulate:a", 0.0, 1)
	tween.tween_callback(node.queue_free)

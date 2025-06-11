@tool
extends Button
class_name WordEntry

@export var label : String = "词条"

func _ready() -> void:
	%Label.text = label
	pressed.connect(_on_button_pressed)
	
func set_label(in_label: String) -> void:
	label = in_label
	%Label.text = label
	
func _on_button_pressed():
	print('word_entry clicked')

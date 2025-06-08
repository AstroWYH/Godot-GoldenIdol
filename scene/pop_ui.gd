extends Control
class_name PopUI

@onready var pop_ui : NinePatchRect = %PopUIRect
@onready var close_btn : TextureButton = %CloseBtn

func _ready():
	close_btn.pressed.connect(_on_close_pressed)
	
func _on_close_pressed() -> void :
	print("关闭pop ui")
	pop_ui.hide()

extends Control
class_name PopUI

@onready var close_btn : TextureButton = %CloseBtn

func _ready():
	close_btn.pressed.connect(_on_close_pressed)
	
func _on_close_pressed() -> void :
	print("关闭pop ui")
	self.hide()

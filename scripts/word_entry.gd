extends Button

func _ready() -> void:
	self.pressed.connect(_on_button_pressed)
	
func _on_button_pressed():
	print('word_entry clicked')

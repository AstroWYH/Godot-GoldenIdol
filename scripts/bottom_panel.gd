extends Control

@onready var back_button : Button = %BackButton
@onready var portrait_button : TextureButton = %PortaitButton

signal sig_toggle_popui
signal sig_toggle_portrait_ui

func _ready():
	back_button.pressed.connect(_on_back_button_pressed)
	portrait_button.pressed.connect(_on_portrait_button_pressed)

func _on_back_button_pressed():
	print("button按钮被点击")
	emit_signal("sig_toggle_popui")
	
func _on_portrait_button_pressed():
	emit_signal("sig_toggle_portrait_ui")

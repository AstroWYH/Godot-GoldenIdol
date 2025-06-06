extends Button

@onready var welcome_ui : NinePatchRect = %WelcomeUI

func _ready():
    pressed.connect(_on_button_pressed)

func _on_button_pressed():
    print("按钮被点击了！")
    # welcome_ui.visible = not welcome_ui.visible
    var tween = create_tween()
    if welcome_ui.visible:
        tween.tween_property(welcome_ui, "modulate:a", 0.0, 0.3)
        tween.tween_callback(welcome_ui.hide)  # 动画完成后隐藏
    else:
        welcome_ui.modulate.a = 0.0  # 初始透明
        welcome_ui.show()
        tween.tween_property(welcome_ui, "modulate:a", 1.0, 0.3)
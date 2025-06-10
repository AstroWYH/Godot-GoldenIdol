extends Button

@onready var welcome_ui : NinePatchRect = %WelcomeUI
@onready var explore_panel = %ExplorePanel

func _ready():
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	print("按钮被点击了！")
	# welcome_ui.visible = not welcome_ui.visible
	explore_panel.visible = not explore_panel.visible
	
	var tween = create_tween()
	if welcome_ui.visible:
		tween.tween_property(welcome_ui, "modulate:a", 0.0, 0.3)
		tween.tween_callback(welcome_ui.hide)  # 动画完成后隐藏
	else:
		welcome_ui.modulate.a = 0.0  # 初始透明
		welcome_ui.show()
		tween.tween_property(welcome_ui, "modulate:a", 1.0, 0.3)
		
		## 临时实例化popui测试
		## 1. 预加载场景资源（确保路径正确）
		#var popui_scene = preload("res://scene/pop_ui.tscn")
		## 2. 实例化场景
		#var popui_instance = popui_scene.instantiate()
		## 3. 添加到场景树
		## 通常添加到当前场景的根节点或特定父节点
		#get_tree().current_scene.add_child(popui_instance)
		## 4. （可选）设置位置或其他初始化
		#popui_instance.position = Vector2(100, 100)  # 如果是Control节点用 rect_position

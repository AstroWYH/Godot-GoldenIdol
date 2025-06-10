extends Control
class_name PopUI

@onready var close_btn : TextureButton = %CloseBtn
#@onready var text = $PopUIRect/MarginContainer/Text # 从根节点往后写
#@onready var text = get_node("PopUIRect/MarginContainer/Text") # 等价上面
@onready var text = %Text

func _ready():
	close_btn.pressed.connect(_on_close_pressed)
	text.meta_clicked.connect(_on_meta_clicked)
	
func _on_close_pressed() -> void :
	print("关闭pop ui")
	self.hide()
	
func _on_meta_clicked(meta):
	if typeof(meta) == TYPE_STRING and meta.begins_with("event://"):
		var event_name = meta.replace("event://", "")
		match event_name:
			"open_popup": # 使用meta_to_text哈希表映射open_popup->点击的文案
				FloatMessage.show_float_message("你点击了打开弹窗的链接")
				# 在这里测试wordentry飞行到word_bottom_panel
				
			"do_something":
				print("执行其他操作")
			_:
				print("未知事件：", event_name)
	elif typeof(meta) == TYPE_STRING and meta.begins_with("https"):
		print("打开网站")
		OS.shell_open(meta)

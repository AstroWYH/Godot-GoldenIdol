extends Control
class_name PopUI

@onready var close_btn : TextureButton = %CloseBtn
#@onready var text = $PopUIRect/MarginContainer/Text # 从根节点往后写
#@onready var text = get_node("PopUIRect/MarginContainer/Text") # 等价上面
@onready var text = %Text
var WordEntryScene = preload("res://scene/word_entry.tscn")
var grid_container = null

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
				GFloatMessage.show_float_message("你点击了打开弹窗的链接")
				# 在这里测试wordentry飞行到word_bottom_panel
				# 实例化 WordEntry
				grid_container = GGameUi.world_bottom_container
				var word_entry = WordEntryScene.instantiate()
				add_child(word_entry)
				# 设置均匀分布到 grid 里
				word_entry.size_flags_horizontal = Control.SIZE_EXPAND_FILL
				# 设置初始位置为鼠标点击位置
				word_entry.get_node("%Label").text = '新词条'
				word_entry.global_position = get_global_mouse_position()
				# 计算目标位置（例如 GridContainer 的中心或下一个可用位置）
				# 计算目标位置：GridContainer 的下一个可用位置
				var columns = grid_container.columns  # 获取 GridContainer 的列数
				var child_count = grid_container.get_child_count()  # 当前子节点数量
				var next_index = child_count  # 下一个插入的索引
				var row = next_index / columns  # 计算行号
				var col = next_index % columns  # 计算列号
				var cell_size = grid_container.size / columns  # 估算每个格子的大小（近似）
				#var target_position = grid_container.global_position + Vector2(
					#col * cell_size.x + cell_size.x / 2,  # X 坐标：列位置 + 格子宽度的一半
					#row * cell_size.y + cell_size.y / 2   # Y 坐标：行位置 + 格子高度的一半
				#)
				var target_position = grid_container.global_position # 暂时就用这个位置吧
				# 创建动画
				var tween = create_tween()
				tween.tween_property(word_entry, "global_position", target_position, 0.5)
				tween.tween_callback(_on_animation_finished.bind(word_entry))
			"do_something":
				print("执行其他操作")
			_:
				print("未知事件：", event_name)
	elif typeof(meta) == TYPE_STRING and meta.begins_with("https"):
		print("打开网站")
		OS.shell_open(meta)
		
func _on_animation_finished(word_entry: Node):
	# 动画完成后，将 WordEntry 重新绑定到 GridContainer
	word_entry.reparent(grid_container)
	#word_entry.queue_free()
	#grid_container.add_child(word_entry)
	# 可选：重置本地位置以适应 GridContainer 的自动布局
	# word_entry.position = Vector2.ZERO

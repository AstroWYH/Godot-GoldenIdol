@tool
extends ClueBaseUI
class_name ClueTextUI

@onready var clue_panel := %CluePanel
@onready var text = %RichText

func _ready():
	text.meta_clicked.connect(_on_meta_clicked)
	text.text = GClueData.get_clue_data(chapter, id, GClueData.lang).get('data').get("text")
	mouse_filter = Control.MOUSE_FILTER_STOP  # 必须拦截事件
	global_position = get_global_mouse_position()

func _input(event: InputEvent) -> void:
	#print("_unhandled_input event: ", event)
	if event is InputEventMouseButton and event.pressed:
		var mouse_pos = get_global_mouse_position()
		# 鼠标右键点击：无论在哪，直接关闭
		if event.button_index == MOUSE_BUTTON_RIGHT:
			queue_free()
			return
		# 鼠标左键点击 UI 外部时关闭
		if event.button_index == MOUSE_BUTTON_LEFT:
			if not clue_panel.get_global_rect().has_point(mouse_pos):
				queue_free()

# 获取点击的词条
func _on_meta_clicked(meta):
	var word_prefix = "word://"
	if typeof(meta) == TYPE_STRING and meta.begins_with(word_prefix):
		var word = meta.replace(word_prefix, "")
		var word_id = meta.replace(word_prefix, "")
		var label_text = GClueData.get_clue_data(chapter, id, GClueData.lang).get('data').get("entries").get(word_id)
		# 实例化word_entry
		var grid_container = GGameUi.world_bottom_container
		var word_entry = GPreload.word_entry_res.instantiate()
		GGameUi.main_ui.add_child(word_entry) # 先暂时添加到当前场景树 否则看不到
		#word_entry.size_flags_horizontal = Control.SIZE_EXPAND_FILL # 关键 否则最后在容器里不均匀
		word_entry.set_label(label_text)
		word_entry.global_position = get_global_mouse_position()
		# 临时新增一个透明 word_entry_copy 用于确定目标位置
		var word_entry_copy = word_entry.duplicate()
		word_entry_copy.modulate = Color(1, 1, 1, 0)
		grid_container.add_child(word_entry_copy)
		var child_count = grid_container.get_child_count()
		var last_child = grid_container.get_child(child_count - 1)
		await get_tree().process_frame  # 关键 等到下一帧开始之前（process_frame） 子控件的位置才更新完成
		var target_position = last_child.global_position
		word_entry_copy.queue_free()
		# fly to target
		word_entry.fly(grid_container, target_position)

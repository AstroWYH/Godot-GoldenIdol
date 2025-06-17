@tool
extends ClueBaseUI
class_name ClueTextUI

@onready var text = %RichText
var clicked_words := {}
var wave_effect = preload("res://scripts/wave_under_line_effect.gd").new()

func _ready():
	content_layer = %ContentLayer
	clue_panel = %CluePanel
	type = GEnum.EClueUIType.Text
	super._ready()
	super.set_clue_panel(clue_panel)
	text.meta_clicked.connect(_on_meta_clicked)
	text.text = clue_data.get('data').get("text")
	mouse_filter = Control.MOUSE_FILTER_STOP  # 必须拦截事件
	global_position = get_global_mouse_position()
	super.set_red_points()
	# 波浪效果
	#text.install_effect(wave_effect)
	#wave_effect.enabled = true

# 获取点击的词条
func _on_meta_clicked(meta):
	var word_prefix = "word://"
	if typeof(meta) == TYPE_STRING and meta.begins_with(word_prefix):
		var word_id = meta.replace(word_prefix, "") # PERSON_1

		# 防止重复点击
		if clicked_words.has(word_id): return
		clicked_words[word_id] = true

		var label_text = clue_data.get('data').get("entries").get(word_id)
		# 实例化word_entry
		var grid_container = GGameUI.word_bottom_panel
		var word_entry = GPreload.word_entry_res.instantiate()
		GGameUI.main_ui.add_child(word_entry) # 先暂时添加到当前场景树 否则看不到
		#word_entry.size_flags_horizontal = Control.SIZE_EXPAND_FILL # 关键 否则最后在容器里不均匀
		word_entry.set_word_entry_info(label_text, GEnum.EWordPlace.Bottom)
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

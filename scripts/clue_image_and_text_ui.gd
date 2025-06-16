#@tool
extends ClueBaseUI
class_name ClueImageAndTextUI

func _ready():
	content_layer = %ContentLayer
	clue_panel = %CluePanel
	type = GEnum.EClueUIType.ImgText
	super._ready()
	super.set_clue_panel(clue_panel)

	var data = clue_data.get("data")
	# 添加图片块
	for image_data in data.get("images"):
		var tex = load(image_data.path)
		var texture_rect = TextureRect.new()
		texture_rect.texture = tex
		texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		texture_rect.stretch_mode = TextureRect.STRETCH_SCALE
		texture_rect.size = image_data.size # 这行不能写在前面 否则size会被重置
		texture_rect.position = image_data.position
		content_layer.add_child(texture_rect)

	# 添加文本块
	for text_block in data.get("text_blocks"):
		var label = RichTextLabel.new()
		label.bbcode_enabled = true
		label.text = text_block.text
		label.size = text_block.size
		label.position = text_block.position
		label.add_theme_font_size_override("normal_font_size", 24)
		label.meta_clicked.connect(_on_meta_clicked)
		content_layer.add_child(label)

	## 添加红点
	super.set_red_points()

	mouse_filter = Control.MOUSE_FILTER_STOP
	self.set_anchors_preset(PRESET_CENTER) # 默认居中显示 只设size
	self.size = clue_data.get("size")

func _on_meta_clicked(meta):
	var word_prefix = "word://"
	if typeof(meta) == TYPE_STRING and meta.begins_with(word_prefix):
		var word_id = meta.replace(word_prefix, "")
		var label_text = clue_data.get('data').get("entries").get(word_id)

		var grid_container = GGameUi.world_bottom_container
		var word_entry = GPreload.word_entry_res.instantiate()
		GGameUi.main_ui.add_child(word_entry)
		word_entry.set_label(label_text)
		word_entry.global_position = get_global_mouse_position()

		# 创建透明控件作为飞行目标
		var word_entry_copy = word_entry.duplicate()
		word_entry_copy.modulate = Color(1, 1, 1, 0)
		grid_container.add_child(word_entry_copy)
		await get_tree().process_frame
		var target_position = word_entry_copy.global_position
		word_entry_copy.queue_free()

		word_entry.fly(grid_container, target_position)

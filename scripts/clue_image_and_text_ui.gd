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
		var text = RichTextLabel.new()
		var wave_effect = GPreload.wave_effect.new()
		text.install_effect(wave_effect)
		text.set_meta_underline(false)
		text.bbcode_enabled = true
		text.text = text_block.text
		text.size = text_block.size
		text.position = text_block.position
		text.add_theme_font_size_override("normal_font_size", 24)
		text.meta_clicked.connect(_on_meta_clicked)
		content_layer.add_child(text)

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

		var grid_container = GGameUI.word_bottom_panel
		var word_entry = GPreload.word_entry_res.instantiate()
		GGameUI.main_ui.add_child(word_entry)
		word_entry.set_word_entry_info(label_text, GEnum.EWordPlace.Bottom)
		word_entry.global_position = get_global_mouse_position()

		# 创建透明控件作为飞行目标
		var word_entry_copy = word_entry.duplicate()
		word_entry_copy.modulate = Color(1, 1, 1, 0)
		grid_container.add_child(word_entry_copy)
		await get_tree().process_frame
		var target_position = word_entry_copy.global_position
		word_entry_copy.queue_free()

		word_entry.fly(grid_container, target_position)

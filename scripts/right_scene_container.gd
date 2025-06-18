extends Control

@export var chapter = 1

@onready var container : VBoxContainer = %VBox

func set_chapter(in_chapter : int):
	chapter = in_chapter

func _ready():
	update_container()

func update_container():
	for child in container.get_children(): # 先全部清空
		child.queue_free()

	var scene_arr : Array = GDataScene.get_chapter(chapter)
	# 添加scene_item
	for data in scene_arr:
		var item := create_scene_item(data)

func create_scene_item(data : Dictionary) -> Control:
	var item := GPreload.scene_item_res.instantiate()
	container.add_child(item) # 立即触发ready

	# 添加图片
	for image_data in data.get("images"):
		var tex = load(image_data.path)
		var texture_rect = TextureRect.new()
		texture_rect.texture = tex
		texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		texture_rect.stretch_mode = TextureRect.STRETCH_SCALE
		texture_rect.size = image_data.size # 这行不能写在前面 否则size会被重置
		texture_rect.position = image_data.position
		item.content_layer.add_child(texture_rect)

	# 添加文本
	for text_block in data.get("text_blocks").get(GSetting.lang):
		var text = RichTextLabel.new()
		text.bbcode_enabled = true
		text.fit_content = true # size可能不够大，暂时设fit_content来解决
		text.text = text_block.text
		text.size = text_block.size
		text.position = text_block.position
		text.add_theme_font_size_override("normal_font_size", GSetting.right_scene_font_size)
		item.content_layer.add_child(text)

	# 添加word_entry
	for entry_data in data.get("entries").get(GSetting.lang):
		var entry := GPreload.word_entry_res.instantiate()
		entry.set_word_entry_info(entry_data.text, GEnum.EWordPlace.RightScene)
		entry.position = entry_data.position
		#entry.toggle_label_visibility(false) # 默认不展示 玩家匹配时展示
		item.content_layer.add_child(entry)

	return item

extends HFlowContainer

@export var chapter = 1

func set_chapter(in_chapter : int):
	chapter = in_chapter

func _ready():
	update_container()

# 主逻辑：将带占位符的句子渲染为可点击节点+文字
func update_container():
	var container = self
	for child in container.get_children(): # 先全部清空
		child.queue_free()

	var pattern := r"\[([A-Z_0-9]+)\]"  # 允许占位符包含数字，如 PERSON_1
	var regex := RegEx.new()
	regex.compile(pattern)
	var text : String = GDataStory.get_story_data(chapter).get('sentence')
	var start := 0
	for result in regex.search_all(text):
		var match_start := result.get_start()
		var match_end := result.get_end()
		var key := result.get_string(1)  # 取出 KEY，比如 PERSON_1、ITEM_2，1代表不要[]
		if match_start > start:
			var plain_text := text.substr(start, match_start - start)
			# 添加文字
			container.add_child(create_label(plain_text))
		# 添加词条
		container.add_child(create_wordentry(key))
		start = match_end
	if start < text.length():
		var remaining_text := text.substr(start)
		# 添加文字
		container.add_child(create_label(remaining_text))

func create_label(text: String) -> Label:
	var label := Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", GSetting.left_story_font_size)
	return label

func create_wordentry(key: String) -> Control:
	var entry := GPreload.word_entry_res.instantiate()
	var story_data: Dictionary = GDataStory.get_story_data(chapter)
	var entry_info : String = story_data["entries"].get(key)
	entry.set_word_entry_info(entry_info, GEnum.EWordPlace.LeftStory)
	entry.toggle_label_visibility(false) # 默认不展示 玩家匹配时展示
	return entry

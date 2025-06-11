extends HFlowContainer

# 本地化数据暂时直接写在字典里，不用外部json读取
var localization_data := {
	"zh": {
		"sentence": "因此，[PERSON]便在[ITEM]中下了毒。",
		"entries": {
			"PERSON": "凶手",
			"ITEM": "酒杯"
		}
	},
	"en": {
		"sentence": "Therefore, poison was placed by [PERSON] in the [ITEM].",
		"entries": {
			"PERSON": "the culprit",
			"ITEM": "the wine glass"
		}
	}
}

@export var font_size := 26

# 示例调用：你可以在 _ready() 或按钮点击后触发
func _ready():
	var lang := "zh"  # 或 "en"
	var sentence: String = localization_data[lang]["sentence"]
	parse_text_to_nodes(self, sentence, lang)

# 主逻辑：将带占位符的句子渲染为可点击节点+文字
func parse_text_to_nodes(container: FlowContainer, text: String, locale: String) -> void:
	for child in container.get_children():
		child.queue_free() # 标记子节点删除，安全移除
	
	var pattern := r"\[([A-Z_]+)\]"  # 正则：匹配大写字母加下划线的占位符，例如 [PERSON]
	var regex := RegEx.new()
	regex.compile(pattern)

	var start := 0
	for result in regex.search_all(text):
		var match_start := result.get_start()
		var match_end := result.get_end()
		var key := result.get_string(1)  # 拿到括号里的 KEY，比如 PERSON、ITEM

		# 插入占位符之前的纯文本
		if match_start > start:
			var plain_text := text.substr(start, match_start - start)
			container.add_child(create_label(plain_text))

		# 插入 WordEntry 控件
		container.add_child(create_wordentry(key, locale))
		start = match_end

	# 插入最后一段纯文本
	if start < text.length():
		var remaining_text := text.substr(start)
		container.add_child(create_label(remaining_text))

# 工具函数：创建普通 Label
func create_label(text: String) -> Label:
	var lbl := Label.new()
	lbl.text = text
	lbl.add_theme_font_size_override("font_size", font_size)
	return lbl

# 工具函数：实例化 WordEntry（你已有的按钮+Label组合）
func create_wordentry(key: String, locale: String) -> Control:
	var entry := preload("res://scene/word_entry.tscn").instantiate()
	var placeholder := get_placeholder_for_key(key, locale)
	entry.set_label(placeholder)
	return entry

# 查找当前语言下占位词对应的显示文本
func get_placeholder_for_key(key: String, locale: String) -> String:
	return localization_data[locale]["entries"].get(key, "???")

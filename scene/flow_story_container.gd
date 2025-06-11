extends HFlowContainer

# 本地化数据暂时直接写在字典里，不用外部json读取
var localization_data := {
	"zh": {
		"sentence": "在[PLACE1]，[PERSON1]把毒药放入了[ITEM1]，而[PERSON2]则在[PLACE2]偷走了[ITEM2]。",
		"entries": {
			"PERSON1": "仆人甲",
			"PERSON2": "仆人乙",
			"ITEM1": "红酒",
			"ITEM2": "毒药瓶",
			"PLACE1": "餐厅",
			"PLACE2": "书房"
		}
	},
	"en": {
		"sentence": "At the [PLACE1], [PERSON1] put the poison into the [ITEM1], while [PERSON2] stole the [ITEM2] in the [PLACE2].",
		"entries": {
			"PERSON1": "Servant A",
			"PERSON2": "Servant B",
			"ITEM1": "wine",
			"ITEM2": "poison vial",
			"PLACE1": "dining room",
			"PLACE2": "study"
		}
	}
}

@export var font_size := 26

func _ready():
	var lang := "zh"  # 或 "en"
	var sentence: String = localization_data[lang]["sentence"]
	parse_text_to_nodes(self, sentence, lang)

# 主逻辑：将带占位符的句子渲染为可点击节点+文字
func parse_text_to_nodes(container: FlowContainer, text: String, locale: String) -> void:
	for child in container.get_children():
		child.queue_free()
	
	var pattern := r"\[([A-Z_0-9]+)\]"  # 允许占位符包含数字，如 PERSON1
	var regex := RegEx.new()
	regex.compile(pattern)

	var start := 0
	for result in regex.search_all(text):
		var match_start := result.get_start()
		var match_end := result.get_end()
		var key := result.get_string(1)  # 取出 KEY，比如 PERSON1、ITEM2

		if match_start > start:
			var plain_text := text.substr(start, match_start - start)
			container.add_child(create_label(plain_text))

		container.add_child(create_wordentry(key, locale))
		start = match_end

	if start < text.length():
		var remaining_text := text.substr(start)
		container.add_child(create_label(remaining_text))

func create_label(text: String) -> Label:
	var lbl := Label.new()
	lbl.text = text
	lbl.add_theme_font_size_override("font_size", font_size)
	return lbl

func create_wordentry(key: String, locale: String) -> Control:
	var entry := preload("res://scene/word_entry.tscn").instantiate()
	var placeholder := get_placeholder_for_key(key, locale)
	entry.set_label(placeholder)
	entry.toggle_label_visibility(false)
	entry.word_type = GEnum.EWordPlace.FlowStory
	return entry

func get_placeholder_for_key(key: String, locale: String) -> String:
	return localization_data[locale]["entries"].get(key, "???")

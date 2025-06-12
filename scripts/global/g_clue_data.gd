extends Node

var lang := 'zh'
# 结构：chapter -> id -> lang -> {text, entries}
var clues := {
	1: {
		1: {
			"zh": {
				"text": "唉，[u][url=word://PERSON_1]摩根[/url][/u]先生，[u][url=word://PERSON_2]艾琳[/url][/u]小姐说她看到他手上拿着[u][url=word://ITEM_1]酒杯[/url][/u]，有人在[u][url=word://PLACE_1]图书馆[/url][/u]发现了[u][url=word://ITEM_2]毒药瓶[/url][/u]，最后他还被看见出现在[u][url=word://PLACE_2]厨房[/url][/u]。",
				"entries": {
					"PERSON_1": "摩根",
					"PERSON_2": "艾琳",
					"ITEM_1": "酒杯",
					"ITEM_2": "毒药瓶",
					"PLACE_1": "图书馆",
					"PLACE_2": "厨房"
				}
			},
			"en": {
				"text": "Ah, [u][url=word://PERSON_1]Morgan[/url][/u], I didn't expect it would come to this. Miss [u][url=word://PERSON_2]Irene[/url][/u] said she saw him holding a [u][url=word://ITEM_1]wine glass[/url][/u], and someone found a [u][url=word://ITEM_2]poison bottle[/url][/u] in the [u][url=word://PLACE_1]library[/url][/u]. He was last seen in the [u][url=word://PLACE_2]kitchen[/url][/u].",
				"entries": {
					"PERSON_1": "Morgan",
					"PERSON_2": "Irene",
					"ITEM_1": "wine glass",
					"ITEM_2": "poison bottle",
					"PLACE_1": "library",
					"PLACE_2": "kitchen"
				}
			}
		},

		2: {
			"zh": {
				"text": "当[u][url=word://PERSON_3]理查德[/url][/u]打开[u][url=word://ITEM_3]密信[/url][/u]后，他立刻冲向[u][url=word://PLACE_3]地下室[/url][/u]，而[u][url=word://PERSON_4]艾米[/url][/u]则偷偷躲在[u][url=word://PLACE_4]阁楼[/url][/u]里。",
				"entries": {
					"PERSON_3": "理查德",
					"PERSON_4": "艾米",
					"ITEM_3": "密信",
					"PLACE_3": "地下室",
					"PLACE_4": "阁楼"
				}
			},
			"en": {
				"text": "When [u][url=word://PERSON_3]Richard[/url][/u] opened the [u][url=word://ITEM_3]secret note[/url][/u], he rushed to the [u][url=word://PLACE_3]basement[/url][/u], while [u][url=word://PERSON_4]Amy[/url][/u] was secretly hiding in the [u][url=word://PLACE_4]attic[/url][/u].",
				"entries": {
					"PERSON_3": "Richard",
					"PERSON_4": "Amy",
					"ITEM_3": "secret note",
					"PLACE_3": "basement",
					"PLACE_4": "attic"
				}
			}
		}
	}
}

func get_clue_data(chapter: int, id: int, lang: String = "zh") -> Dictionary:
	if clues.has(chapter) and clues[chapter].has(id):
		if clues[chapter][id].has(lang):
			return clues[chapter][id][lang]
		else:
			push_warning("语言 '%s' 不存在，返回中文作为默认语言。" % lang)
			return clues[chapter][id].get("zh", {})
	else:
		push_error("未找到章节 %s 中的线索 ID %s" % [chapter, id])
		return {}

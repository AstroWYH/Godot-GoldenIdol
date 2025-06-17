extends Node
class_name GPortraitData

var portrait_data := {
	1: {
		1: {  # chapter 1, id 1
			"portrait_img": "res://asset/btn_0000_close_idle.png",
			"name": {
				"zh": { "first": "甘", "last": "澄澄" },
				"en": { "first": "Gan", "last": "Chengcheng" }
			}
		},
		2: {
			"portrait_img": "res://asset/phrase_red.png",
			"name": {
				"zh": { "first": "李", "last": "秋水" },
				"en": { "first": "Li", "last": "QiuShui" }
			}
		}
	},
	2: {
		1: {
			"portrait_img": "res://asset/indicator1.png",
			"name": {
				"zh": { "first": "赵", "last": "四海" },
				"en": { "first": "Zhao", "last": "Sihai" }
			}
		}
	}
}

# 获取头像路径
func get_portrait_img(chapter: int, id: int) -> String:
	return portrait_data.get(chapter, {}).get(id, {}).get("portrait_img", "")

# 获取本地化的姓名（first + last 合成）
func get_full_name(chapter: int, id: int, lang: String = "zh") -> String:
	lang = GSetting.lang
	var name_data = portrait_data.get(chapter, {}).get(id, {}).get("name", {}).get(lang, {})
	var first = name_data.get("first", "")
	var last = name_data.get("last", "")
	return first + last

# 分别获取姓或名
func get_first_name(chapter: int, id: int, lang: String = "zh") -> String:
	lang = GSetting.lang
	return portrait_data.get(chapter, {}).get(id, {}).get("name", {}).get(lang, {}).get("first", "")

func get_last_name(chapter: int, id: int, lang: String = "zh") -> String:
	lang = GSetting.lang
	return portrait_data.get(chapter, {}).get(id, {}).get("name", {}).get(lang, {}).get("last", "")

# 获取某一章节的所有数据（角色信息列表）
func get_chapter_data(chapter: int, lang: String = "zh") -> Array:
	var chapter_data = []
	if portrait_data.has(chapter):
		for id in portrait_data[chapter].keys():
			var character_data = {
				"id": id,
				"portrait_img": get_portrait_img(chapter, id),
				"full_name": get_full_name(chapter, id, lang),
				"first_name": get_first_name(chapter, id, lang),
				"last_name": get_last_name(chapter, id, lang)
			}
			chapter_data.append(character_data)
	return chapter_data

extends Node

var story_data := {
	1: {
		"zh": {
			"sentence": "在[PLACE_1]，[PERSON_1]把毒药放入了[ITEM_1]，而[PERSON_2]则在[PLACE_2]偷走了[ITEM_2]。",
			"entries": {
				"PERSON_1": "仆人甲",
				"PERSON_2": "仆人乙",
				"ITEM_1": "红酒",
				"ITEM_2": "毒药瓶",
				"PLACE_1": "餐厅",
				"PLACE_2": "书房"
			}
		},
		"en": {
			"sentence": "At the [PLACE_1], [PERSON_1] put the poison into the [ITEM_1], while [PERSON_2] stole the [ITEM_2] in the [PLACE_2].",
			"entries": {
				"PERSON_1": "Servant A",
				"PERSON_2": "Servant B",
				"ITEM_1": "wine",
				"ITEM_2": "poison vial",
				"PLACE_1": "dining room",
				"PLACE_2": "study"
			}
		}
	},
	2: {
		"zh": {
			"sentence": "[PERSON_1]在[PLACE_1]发现了[ITEM_1]，并把它交给了[PERSON_2]。",
			"entries": {
				"PERSON_1": "女仆丽莎",
				"PERSON_2": "管家亨利",
				"ITEM_1": "金盒子",
				"PLACE_1": "花园"
			}
		},
		"en": {
			"sentence": "[PERSON_1] found the [ITEM_1] in the [PLACE_1], and handed it over to [PERSON_2].",
			"entries": {
				"PERSON_1": "Maid Lisa",
				"PERSON_2": "Butler Henry",
				"ITEM_1": "golden box",
				"PLACE_1": "garden"
			}
		}
	}
}

func get_story_data(chapter: int, lang: String = "zh") -> Dictionary:
	lang = GSetting.lang
	if story_data.has(chapter) and story_data[chapter].has(lang):
		var info = story_data[chapter][lang]
		return {
				"sentence": info.get("sentence"),
				"entries": info.get("entries"),
			}
	return {}

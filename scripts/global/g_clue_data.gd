extends Node

# 语言总开关
var lang := 'zh'
var clues := {
	1: {
		# 1-1: 纯文本
		1: {
			"type": "text",
			"clue_info": {
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
			}
		},

		# 1-2: 纯图片
		2: {
			"type": "image",
			"clue_info": {
				"zh": {
					"images": [
						{
							"path": "res://assets/images/photo1.png",
							"size": Vector2(150, 150),
							"position": Vector2(100, 80),
						},
						{
							"path": "res://assets/images/photo2.png",
							"size": Vector2(100, 100),
							"position": Vector2(300, 200),
						}
					]
				},
				"en": {
					"images": [
						{
							"path": "res://assets/images/photo1.png",
							"size": Vector2(150, 150),
							"position": Vector2(100, 80),
						},
						{
							"path": "res://assets/images/photo2.png",
							"size": Vector2(100, 100),
							"position": Vector2(300, 200),
						}
					]
				}
			}
		},

		# 1-3: 图文混合
		3: {
			"type": "text_image",
			"size": Vector2(600, 600),
			"position": Vector2(0, 0),
			"clue_info": {
				"zh": {
					"images": [
						{
							"path": "res://asset/startup.png",
							"size": Vector2(400, 400),
							"position": Vector2(0, 0),
						},
						{
							"path": "res://asset/phrase_red.png",
							"size": Vector2(40, 40),
							"position": Vector2(60, 300),
						}
					],
					"text_blocks": [
						{
							"text": "这是关键的一封信，[u][url=word://ITEM_3]密信[/url][/u]的内容可能揭示了真相。",
							"size": Vector2(200, 100),
							"position": Vector2(80, 40)
						}
					],
					"entries": {
						"ITEM_3": "密信"
					},
				},
				"en": {
					"images": [
						{
							"path": "res://asset/startup.png",
							"size": Vector2(60, 60),
							"position": Vector2(200, 120),
						},
						{
							"path": "res://asset/phrase_red.png",
							"size": Vector2(40, 40),
							"position": Vector2(60, 300),
						}
					],
					"text_blocks": [
						{
							"text": "This is a crucial letter. The content of the [u][url=word://ITEM_3]secret note[/url][/u] may reveal the truth.",
							"size": Vector2(200, 100),
							"position": Vector2(80, 40)
						}
					],
					"entries": {
						"ITEM_3": "secret note"
					},
				}
			},
			"red_points": [
				{
					"chapter": 1,
					"id": 1,
					"position": Vector2(20, 20)
				},
				{
					"chapter": 1,
					"id": 2,
					"position": Vector2(50, 50)
				}
			],
		},

		# 1-4: 纯图片
		4: {
			"type": "image",
			"clue_info": {
				"zh": {
					"images": [
						{
							"path": "res://assets/images/knife_blood.png",
							"position": Vector2(180, 160),
							"size": Vector2(120, 120)
						}
					]
				},
				"en": {
					"images": [
						{
							"path": "res://assets/images/knife_blood_en.png",
							"position": Vector2(180, 160),
							"size": Vector2(120, 120)
						}
					]
				}
			}
		}
	}
}

func get_clue_data(chapter: int, id: int, lang: String = "zh") -> Dictionary:
	if clues.has(chapter) and clues[chapter].has(id):
		var base = clues[chapter][id]
		var clue_info = base.get("clue_info", {})
		if clue_info.has(lang):
			return {
				"type": base.get("type"),
				"size": base.get("size"),
				"position": base.get("position"),
				"data": clue_info[lang],
				"red_points": base.get("red_points"),
			}
	return {}

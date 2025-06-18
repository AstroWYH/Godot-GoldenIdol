extends Node

var clues := {
	1: {
		# 1-1: 纯文本
		1: {
			"type": 1,
			"clue_info": {
				"zh": {
					"text": "唉，[mywave][url=word://PERSON_2]摩根[/url][/mywave]先生，[mywave][url=word://PERSON_2]艾琳[/url][/mywave]小姐说她看到他手上拿着[mywave][url=word://ITEM_1]酒杯[/url][/mywave]，有人在[mywave][url=word://PLACE_1]图书馆[/url][/mywave]发现了[mywave][url=word://ITEM_2]毒药瓶[/url][/mywave]，最后他还被看见出现在[mywave][url=word://PLACE_2]厨房[/url][/mywave]。",
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
					"text": "Ah, [mywave][url=word://PERSON_1]Morgan[/url][/mywave], I didn't expect it would come to this. Miss [mywave][url=word://PERSON_2]Irene[/url][/mywave] said she saw him holding a [mywave][url=word://ITEM_1]wine glass[/url][/mywave], and someone found a [mywave][url=word://ITEM_2]poison bottle[/url][/mywave] in the [mywave][url=word://PLACE_1]library[/url][/mywave]. He was last seen in the [mywave][url=word://PLACE_2]kitchen[/url][/mywave].",
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
			"red_points": [
				{
					"type": 2,
					"chapter": 1,
					"id": 4,
					"position": Vector2(20, 20)
				},
			],
		},

		# 1-2: 纯图片
		2: {
			"type": 2,
			"size": Vector2(200, 200),
			"clue_info": {
				"zh": {
					"images": [
						{
							"path": "res://asset/btn_0000_close_idle.png",
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
				},
			},
			"red_points": [
				{
					"type": 1,
					"chapter": 1,
					"id": 1,
					"position": Vector2(20, 20)
				},
				{
					"type": 2,
					"chapter": 1,
					"id": 4,
					"position": Vector2(50, 50)
				}
			],
		},

		# 1-3: 图文混合
		3: {
			"type": 3,
			"size": Vector2(600, 600),
			"position": Vector2(0, 0),
			"clue_info": {
				"zh": {
					"images": [
						{
							"path": "res://asset/startup.png",
							"size": Vector2(50, 50),
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
							"text": "这是关键的一封信，[mywave][url=word://ITEM_3]密信[/url][/mywave]的内容可能揭示了真相。",
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
							"text": "This is a crucial letter. The content of the [mywave][url=word://ITEM_3]secret note[/url][/mywave] may reveal the truth.",
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
					"type": 1,
					"chapter": 1,
					"id": 1,
					"position": Vector2(20, 20)
				},
				{
					"type": 2,
					"chapter": 1,
					"id": 2,
					"position": Vector2(50, 50)
				}
			],
		},

		# 1-4: 纯图片
		4: {
			"type": 2,
			"size": Vector2(400, 400),
			"clue_info": {
				"zh": {
					"images": [
						{
							"path": "res://asset/Golden.png",
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
	lang = GSetting.lang
	if clues.has(chapter) and clues[chapter].has(id):
		var base = clues[chapter][id]
		var clue_info = base.get("clue_info")
		if clue_info.has(lang):
			return {
				"type": base.get("type"),
				"size": base.get("size"),
				"position": base.get("position"),
				"data": clue_info[lang],
				"red_points": base.get("red_points"),
			}
	return {}

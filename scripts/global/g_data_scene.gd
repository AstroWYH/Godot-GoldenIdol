extends Node

var scene_data := {
	1: [
		{ # 1
			"size": Vector2(600, 600),
			"position": Vector2(0, 0),
			"images": [
				{
					"path": "res://asset/startup.png",
					"size": Vector2(60, 60),
					"position": Vector2(200, 120)
				},
				{
					"path": "res://asset/phrase_red.png",
					"size": Vector2(40, 40),
					"position": Vector2(60, 300)
				}
			],
			"text_blocks": {
				"zh": [
					{
						"text": "这是关键的一封信",
						"size": Vector2(200, 100),
						"position": Vector2(80, 40)
					},
					{
						"text": "你是谁",
						"size": Vector2(200, 100),
						"position": Vector2(80, 140)
					}
				],
				"en": [
					{
						"text": "This is a crucial letter",
						"size": Vector2(200, 100),
						"position": Vector2(80, 40)
					},
					{
						"text": "Who are you",
						"size": Vector2(200, 100),
						"position": Vector2(80, 140)
					}
				]
			},
			"entries": {
				"zh": [
					{
						"text": "仆人甲",
						"position": Vector2(80, 40)
					},
					{
						"text": "红酒",
						"position": Vector2(180, 40)
					}
				],
				"en": [
					{
						"text": "Servant A",
						"position": Vector2(80, 40)
					},
					{
						"text": "wine",
						"position": Vector2(180, 40)
					}
				]
			}
		}, # 2
		{
			"size": Vector2(600, 600),
			"position": Vector2(0, 0),
			"images": [
				{
					"path": "res://asset/startup.png",
					"size": Vector2(80, 80),
					"position": Vector2(150, 150)
				},
				{
					"path": "res://asset/phrase_red.png",
					"size": Vector2(30, 30),
					"position": Vector2(300, 200)
				}
			],
			"text_blocks": {
				"zh": [
					{
						"text": "他去过图书馆。",
						"size": Vector2(200, 100),
						"position": Vector2(100, 50)
					}
				],
				"en": [
					{
						"text": "He visited the library.",
						"size": Vector2(200, 100),
						"position": Vector2(100, 50)
					}
				]
			},
			"entries": {
				"zh": [
					{
						"text": "图书馆",
						"position": Vector2(100, 50)
					}
				],
				"en": [
					{
						"text": "Library",
						"position": Vector2(100, 50)
					}
				]
			}
		}
	]
}

# 获取 某章节 某场景
func get_chapter_scene(chapter: int, index: int) -> Dictionary:
	if scene_data.has(chapter):
		var scenes = scene_data[chapter]
		if index >= 0 and index < scenes.size():
			return scenes[index]
	return {}

# 获取 某章节 所有场景数组
func get_chapter(chapter: int) -> Array:
	if scene_data.has(chapter):
		return scene_data[chapter]
	return []

# 获取 某章节 所有场景数组大小
func get_chapter_size(chapter: int) -> int:
	if scene_data.has(chapter):
		return scene_data[chapter].size()
	return 0

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
	for data in scene_arr:
		var item := create_scene_item(data)

func create_scene_item(data : Dictionary) -> Control:
	var item := GPreload.scene_item_res.instantiate()
	container.add_child(item) # 立即触发ready

	for image_data in data.get("images"):
		var tex = load(image_data.path)
		var texture_rect = TextureRect.new()
		texture_rect.texture = tex
		texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		texture_rect.stretch_mode = TextureRect.STRETCH_SCALE
		texture_rect.size = image_data.size # 这行不能写在前面 否则size会被重置
		texture_rect.position = image_data.position
		item.content_layer.add_child(texture_rect)

	return item

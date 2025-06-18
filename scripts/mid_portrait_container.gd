extends Control

@export var chapter = 1
@export var id = 1

@onready var container : GridContainer = %Gird

func set_chapter(in_chapter : int):
	chapter = in_chapter

func _ready():
	update_container()

func update_container():
	for child in container.get_children(): # 先全部清空
		child.queue_free()

	var portrait_data : Array = GDataPortrait.get_chapter_data(chapter)
	for data in portrait_data:
		var card := create_portrait(data)

func create_portrait(data : Dictionary) -> Control:
	var card := GPreload.portrait_card_res.instantiate()
	# 先添加到场景树，触发ready，让img等成员有效
	container.add_child(card) # 会立即触发ready，所以不能用await card.ready，已经触发了，等不到的
	card.img = data.get('portrait_img')
	card.first_name.set_word_entry_info(data.get('first_name'), GEnum.EWordPlace.MidPortrait)
	card.first_name.toggle_label_visibility(false) # 默认不显示
	card.last_name.set_word_entry_info(data.get('last_name'), GEnum.EWordPlace.MidPortrait)
	card.last_name.toggle_label_visibility(false)
	return card

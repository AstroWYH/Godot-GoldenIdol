extends TextureButton

@export var panel_type : GEnum.EClueUIType = GEnum.EClueUIType.Text # 1 纯文字 2 纯图片 3 文字+图片 三种不同类型的clue_ui
@export var chapter : int = -1
@export var id : int = -1

func set_info(in_chapter: int, in_id: int):
	chapter = in_chapter
	id = in_id

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed():
	var ui = null
	match panel_type:
		GEnum.EClueUIType.Text:
			ui = GPreload.clue_text_res.instantiate()
		GEnum.EClueUIType.Img:
			ui = GPreload.clue_image_res.instantiate()
		GEnum.EClueUIType.ImgText:
			ui = GPreload.clue_image_and_text_res.instantiate()
		_: return
	ui.global_position = get_global_mouse_position()
	ui.set_info(chapter, id)
	GGameUi.main_ui.add_child(ui)

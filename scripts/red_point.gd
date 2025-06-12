extends TextureButton

@export var panel_type : GEnum.EClueUIType = GEnum.EClueUIType.Text # 0 纯文字 1 纯图片 2 文字+图片 三种不同类型的panel
@export var chapter : int = -1
@export var id : int = -1

var clue_text_ui_scene = preload("res://scene/clue_text_ui.tscn")

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed():
	if panel_type == GEnum.EClueUIType.Text: # 纯文字 clue_ui
		var clue_text_ui = clue_text_ui_scene.instantiate()
		clue_text_ui.global_position = get_global_mouse_position()
		clue_text_ui.set_info(chapter, id)
		GGameUi.main_ui.add_child(clue_text_ui)

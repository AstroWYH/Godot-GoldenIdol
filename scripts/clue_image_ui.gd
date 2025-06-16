# 图片没有文本信息，有可能带红点

extends ClueBaseUI
class_name ClueImageUI

@onready var img = %Img
#@onready var margin_container = %MarginContainer

func center_control(control: Control, size: Vector2) -> void:
	control.set_anchors_preset(Control.PRESET_CENTER)
	control.set_offset(SIDE_LEFT, 0)
	control.set_offset(SIDE_RIGHT, 0)
	control.set_offset(SIDE_TOP, 0)
	control.set_offset(SIDE_BOTTOM, 0)
	control.pivot_offset = Vector2.ZERO
	control.size = size

func _ready():
	content_layer = %ContentLayer
	clue_panel = %CluePanel
	type = GEnum.EClueUIType.Img
	super._ready()
	super.set_clue_panel(clue_panel)

	var image_data = clue_data.get("data").get("images")[0] # 应该只用一张图片
	#self.set_anchors_preset(PRESET_CENTER) # 默认居中显示 只设size
	#self.size = clue_data.get("size")
	center_control(clue_panel, clue_data.get("size"))
	var tex = load(image_data.path)
	img.texture = tex
	img.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	img.stretch_mode = TextureRect.STRETCH_SCALE

	super.set_red_points()

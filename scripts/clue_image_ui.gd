# 图片没有文本信息，有可能带红点

extends ClueBaseUI
class_name ClueImageUI

@onready var img = %Img

# 生成新实例后，不居中，重新手动刷新锚点才会居中。此为gpt给的方案
func center_control(control: Control, size: Vector2):
	control.set_anchors_preset(PRESET_CENTER) # 默认居中显示 只设size
	control.size = clue_data.get("size")
	control.anchor_left = 0.5
	control.anchor_right = 0.5
	control.anchor_top = 0.5
	control.anchor_bottom = 0.5

	control.offset_left = -size.x / 2
	control.offset_right = size.x / 2
	control.offset_top = -size.y / 2
	control.offset_bottom = size.y / 2

func _ready():
	content_layer = %ContentLayer
	clue_panel = %CluePanel
	type = GEnum.EClueUIType.Img
	super._ready()
	super.set_clue_panel(clue_panel)

	var image_data = clue_data.get("data").get("images")[0] # 应该只用一张图片
	center_control(clue_panel, clue_data.get("size"))
	var tex = load(image_data.path)
	img.texture = tex
	img.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	img.stretch_mode = TextureRect.STRETCH_SCALE

	super.set_red_points()

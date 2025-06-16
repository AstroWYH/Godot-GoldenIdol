extends Control
class_name ClueBaseUI

var type: GEnum.EClueUIType = GEnum.EClueUIType.Text
var chapter: int = -1
var id: int = -1
var clue_panel = null
var clue_data = null
var content_layer = null

static var opened_ui_stack: Array = []

func set_info(in_chapter: int, in_id: int):
	chapter = in_chapter
	id = in_id

func set_clue_panel(in_clue_panel : Control):
	clue_panel = in_clue_panel

func _ready():
	opened_ui_stack.append(self)
	clue_data = GClueData.get_clue_data(chapter, id, GClueData.lang)
	content_layer.mouse_filter = Control.MOUSE_FILTER_IGNORE # 这是必须的 否则content layer会阻挡一些点击事件

func set_red_points():
	# 添加红点
	var red_points = clue_data.get("red_points")
	if red_points:
		for point_data in red_points:
			var red_point = GPreload.red_point_res.instantiate()
			red_point.set_red_point_info(point_data.get('type'), point_data.get('chapter'), point_data.get('id'))
			red_point.position = point_data.get('position')
			content_layer.add_child(red_point)

func _exit_tree():
	opened_ui_stack.erase(self)

func _input(event: InputEvent): # 需要保证子类实例同时接收input时，opened_ui_stack还没来得及erase，默认是这样的
	if opened_ui_stack.back() != self:
		# 不是最上层UI，不处理关闭
		return

	if event is InputEventMouseButton and event.pressed:
		var mouse_pos = get_global_mouse_position()
		# 鼠标右键点击：无论在哪，直接关闭
		if event.button_index == MOUSE_BUTTON_RIGHT:
			queue_free()
			return
		# 鼠标左键点击 UI 外部时关闭
		if event.button_index == MOUSE_BUTTON_LEFT:
			if not clue_panel.get_global_rect().has_point(mouse_pos):
				queue_free()

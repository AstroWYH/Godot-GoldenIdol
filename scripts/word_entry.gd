@tool
extends Button
class_name WordEntry

@onready var label = %Label
@export var extern_label : String = "词条" # 暂时不用

var b_can_drag : bool = true
var b_dragging : bool = false
var b_use_editor_label = true
var word_key := ""  # 用于标识词条类型，如 PERSON、ITEM、PLACE
var word_type: GEnum.EWordPlace = GEnum.EWordPlace.Bottom
var real_text = null # 正确的词条
var bottom_id = -1 # 词条都来自于底部，从clue_ui获取的词条，应当赋予bottom_id；此外，explore_ui的bottom_id应在被drag时赋值

func _ready() -> void:
	pressed.connect(on_button_pressed)
	#if b_use_editor_label: # 处理editor里直接放置到场景中的word_entry，方便测试，后期会废弃
		#label.text = extern_label
		#real_text = extern_label
		#bottom_id = GSetting.word_entry_bottom_id + 1
		#GGameUI.word_bottom_panel.add_entry(bottom_id, self)

func on_button_pressed():
	print('word_entry clicked')

func set_word_entry_info(in_label: String, in_type: GEnum.EWordPlace) -> void:
	b_use_editor_label = false
	word_type = in_type
	real_text = in_label
	%Label.text = in_label # 这里不用%会出错，因为外面调set_word_entry_info时，还没执行ready
	if word_type == GEnum.EWordPlace.Bottom: # 默认只有clue_ui赋值
		bottom_id = GSetting.word_entry_bottom_id + 1
		GGameUI.word_bottom_panel.add_entry(bottom_id, self) # 底部都注册到word_panel管理

func get_label_visibility() -> bool:
	return label.visible

# 控制词条的文字显隐 此时词条框始终显示
func toggle_label_visibility(b_show: bool) -> void:
	if b_show:
		%Label.show()
	else:
		%Label.hide()

func toggle_entry_visibility(b_show: bool):
	modulate.a = 1 if b_show else 0

func set_key(key: String): # 目前没起作用
	word_key = key

# 拖拽 在bottom, left, mid, right之间拖放
# drag source
func _get_drag_data(position):
	# 创建拖动数据
	b_can_drag = get_label_visibility() # 词条可见才允许拖动
	if b_can_drag:
		var drag_preview := duplicate()  # 简单方式：拖动图像就是自身的副本
		set_drag_preview(drag_preview)
		b_dragging = true
		if word_type == GEnum.EWordPlace.Bottom:
			toggle_entry_visibility(false) # 开始拖拽，底部词条，需隐藏整个entry
		else:
			toggle_label_visibility(false) # 开始拖拽，explore词条，只需隐藏label
		return {
			"key": word_key,
			"text": label.text,
			"bottom_id": bottom_id,
			"word_type": word_type,
			"info": self, # 全部信息
		}
	else:
		return null

# drag source
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	# 不能把其他面板的词条，拖放到bottom面板；如果想回bottom面板，直接拖到任意位置释放，则会回到对应bottom_id的位置
	if word_type == GEnum.EWordPlace.Bottom:
		return false
	return true

# drag target, data 为 drag source
# 2种可能：1）底部 到 explore; 2）explore 到 explore
func _drop_data(at_position: Vector2, data: Variant) -> void:
	b_dragging = false
	if data.word_type == GEnum.EWordPlace.Bottom:
		data.info.toggle_entry_visibility(true) # 如果source来自底部，底部复原显示
		label.text = data.text
		toggle_label_visibility(true)
		bottom_id = data.bottom_id
	elif get_label_visibility(): # 如果source不来自底部，如果target可见，则表示交换
		var tmp_text = label.text
		label.text = data.text
		data.info.label.text = tmp_text
		data.info.toggle_label_visibility(true)
	else: # 如果source不来自底部，如果target不可见，表示赋值
		label.text = data.text
		toggle_label_visibility(true)
	if data.text == real_text:
		GFloatMessage.show("你放入了正确的词条")

# 用于接收 拖拽失败
func _notification(what): # 全部UI都会接收通知 所以用b_dragging拦截自己
	if what == NOTIFICATION_DRAG_END and b_dragging:
		b_dragging = false
		if !get_viewport().gui_is_drag_successful():
			if word_type == GEnum.EWordPlace.Bottom: # 底部拖拽失败，回到底部显示
				toggle_entry_visibility(true)
			else:
				toggle_label_visibility(false) # explore拖拽失败，隐藏自身label，并找到对应bottom_id的底部显示
				var bottom_entry = GGameUI.word_bottom_panel.get_entry(bottom_id)
				bottom_entry.toggle_entry_visibility(true)

# 飞行 从clue_ui飞向bottom
func fly(target_container: Container, target_pos: Vector2):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT) # 落地时变慢
	tween.tween_property(self, "global_position", target_pos, 1)
	tween.tween_callback(_on_fly_finished.bind(target_container))

func _on_fly_finished(target_container: Container):
	# 动画完成后，将 WordEntry 重定向到 target_container
	self.reparent(target_container)

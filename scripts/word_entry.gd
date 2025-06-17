@tool
extends Button
class_name WordEntry

@onready var label = %Label
@export var extern_label : String = "词条" # 暂时不用

var b_can_drag : bool = true
var b_use_editor_label = true
var word_key := ""  # 用于标识词条类型，如 PERSON、ITEM、PLACE
var word_type: GEnum.EWordPlace = GEnum.EWordPlace.Bottom

func _ready() -> void:
	pressed.connect(on_button_pressed)
	if b_use_editor_label:
		label.text = extern_label

func on_button_pressed():
	print('word_entry clicked')

func set_label(in_label: String) -> void:
	b_use_editor_label = false
	%Label.text = in_label # 这里不用%会出错，因为外面调set_label时，还没执行ready

# 控制词条的文字显隐 此时词条框始终显示
func toggle_label_visibility(b_show: bool) -> void:
	if b_show:
		%Label.show()
	else:
		%Label.hide()

func set_key(key: String):
	word_key = key

# 拖拽
func _get_drag_data(position):
	# 创建拖动数据
	if b_can_drag:
		var drag_preview := duplicate()  # 简单方式：拖动图像就是自身的副本
		set_drag_preview(drag_preview)
		var drag_data := {
			"key": word_key,
			"text": label.text
		}
		return drag_data
	else:
		return null

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if word_type == GEnum.EWordPlace.Bottom:
		return false
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if data.text == label.text:
		toggle_label_visibility(true)

# 飞行
func fly(target_container: Container, target_pos: Vector2):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT) # 落地时变慢
	tween.tween_property(self, "global_position", target_pos, 1)
	tween.tween_callback(_on_fly_finished.bind(target_container))

func _on_fly_finished(target_container: Container):
	# 动画完成后，将 WordEntry 重定向到 target_container
	self.reparent(target_container)

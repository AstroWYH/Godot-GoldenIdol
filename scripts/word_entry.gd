@tool
extends Button
class_name WordEntry

@onready var label = %Label
@export var extern_label : String = "词条" # 暂时不用

var b_can_drag : bool = true
var word_key := ""  # 用于标识词条类型，如 PERSON、ITEM、SITE

func _ready() -> void:
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	print('word_entry clicked')

func set_label(in_label: String) -> void:
	%Label.text = in_label # 这里不用%会出错，因为外面调set_label时，还没执行ready
	
func set_key(key: String):
	word_key = key

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
	return true
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	data

extends Control

@onready var bottom_panel = $BottomPanel
@onready var pop_ui = $PopUI
@onready var portrait_ui = $PortraiUI
@onready var world_bottom_panel = %WordBottomPanel.get_node('Grid')
@onready var explore_panel = %ExplorePanel
@onready var switch_btn = %SwitchBtn

var animation_duration: float = 0.3  # 动画时长（秒）
var original_size: Vector2  # 存储原始大小
var original_pos: Vector2  # 存储原始大小

func _ready():
	bottom_panel.sig_toggle_popui.connect(_on_toggle_pop_ui)
	bottom_panel.sig_toggle_portrait_ui.connect(_on_toggle_portarit_ui)
	GGameUi.world_bottom_container = world_bottom_panel
	switch_btn.pressed.connect(_on_switch)
	# 记录 explore_panel 的原始pos
	original_pos = -explore_panel.position

func _on_toggle_pop_ui():
	pop_ui.visible = !pop_ui.visible
	
func _on_toggle_portarit_ui():
	portrait_ui.visible = !portrait_ui.visible
	
func _on_switch():
	var tween = create_tween()
	if explore_panel.visible:
		# 关闭动画：从顶部向下压缩
		tween.tween_property(explore_panel, "position:y", original_pos.y, animation_duration).set_ease(Tween.EASE_OUT)
		tween.tween_callback(explore_panel.hide)
	else:
		# 打开动画：从底部向上拉伸
		explore_panel.show()
		explore_panel.position.y = original_pos.y
		tween.tween_property(explore_panel, "position:y", 0.0, animation_duration).set_ease(Tween.EASE_OUT)

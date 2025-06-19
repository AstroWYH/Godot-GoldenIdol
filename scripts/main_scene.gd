extends Control

@onready var bottom_panel = $BottomPanel
@onready var pop_ui = $PopUI
@onready var portrait_ui = $PortraiUI
@onready var world_bottom_panel = %WordBottomPanel.get_node('Grid') # 用%更好
@onready var explore_panel = %ExplorePanel
@onready var switch_btn = %SwitchBtn

var explore_animation_duration: float = 0.3  # 动画时长（秒）
var explore_original_size: Vector2  # 存储原始大小

func _ready():
	GGameUI.main_ui = self
	GGameUI.word_bottom_panel = world_bottom_panel
	GGameUI.explore_panel = explore_panel
	switch_btn.pressed.connect(_on_switch)
	# 记录 explore_panel 的原始size
	explore_original_size = explore_panel.size # editor数据为939

func _on_switch():
	var tween = create_tween()
	if explore_panel.visible:
		# 关闭动画：从顶部向下压缩
		tween.tween_property(explore_panel, "position:y", explore_original_size.y, explore_animation_duration).set_ease(Tween.EASE_OUT)
		tween.tween_callback(explore_panel.hide)
	else:
		# 打开动画：从底部向上拉伸
		explore_panel.show()
		explore_panel.position.y = explore_original_size.y
		tween.tween_property(explore_panel, "position:y", 0.0, explore_animation_duration).set_ease(Tween.EASE_OUT)
	GAudioMgr.play_se("button_open")

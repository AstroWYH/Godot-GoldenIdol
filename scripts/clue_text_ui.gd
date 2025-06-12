@tool
extends NinePatchRect
class_name ClueTextUI

@onready var text = %RichText
var WordEntryScene = preload("res://scene/word_entry.tscn")
var grid_container = null
var chapter : int = -1
var id : int = -1

#var localization_data := {
	#"zh": {
		#"text": "唉，[u][url=word://PERSON_1]摩根[/url][/u]先生，[u][url=word://PERSON_2]艾琳[/url][/u]小姐说她看到他手上拿着[u][url=word://ITEM_1]酒杯[/url][/u]，有人在[u][url=word://PLACE_1]图书馆[/url][/u]发现了[u][url=word://ITEM_2]毒药瓶[/url][/u]，最后他还被看见出现在[u][url=word://PLACE_2]厨房[/url][/u]。",
		#"entries": {
			#"PERSON_1": "摩根",
			#"PERSON_2": "艾琳",
			#"ITEM_1": "酒杯",
			#"ITEM_2": "毒药瓶",
			#"PLACE_1": "图书馆",
			#"PLACE_2": "厨房"
		#}
	#},
	#"en": {
		#"text": "Ah, [u][url=word://PERSON_1]Morgan[/url][/u], I didn't expect it would come to this. Miss [u][url=word://PERSON_2]Irene[/url][/u] said she saw him holding a [u][url=word://ITEM_1]wine glass[/url][/u], and someone found a [u][url=word://ITEM_2]poison bottle[/url][/u] in the [u][url=word://PLACE_1]library[/url][/u]. He was last seen in the [u][url=word://PLACE_2]kitchen[/url][/u].",
		#"entries": {
			#"PERSON_1": "Morgan",
			#"PERSON_2": "Irene",
			#"ITEM_1": "wine glass",
			#"ITEM_2": "poison bottle",
			#"PLACE_1": "library",
			#"PLACE_2": "kitchen"
		#}
	#}
#}

func set_info(in_chapter: int, in_id: int):
	chapter = in_chapter
	id = in_id

func _ready():
	text.meta_clicked.connect(_on_meta_clicked)
	#text.text = localization_data[GClueData.lang]["text"]
	text.text = GClueData.get_clue_data(chapter, id, GClueData.lang).get("text", "")
	mouse_filter = Control.MOUSE_FILTER_STOP  # 必须拦截事件

func _input(event: InputEvent) -> void:
	#print("_unhandled_input event: ", event)
	if event is InputEventMouseButton and event.pressed:
		var mouse_pos = get_global_mouse_position()
		# 鼠标右键点击：无论在哪，直接关闭
		if event.button_index == MOUSE_BUTTON_RIGHT:
			queue_free()
			return
		# 鼠标左键点击 UI 外部时关闭
		if event.button_index == MOUSE_BUTTON_LEFT:
			if not self.get_global_rect().has_point(mouse_pos):
				queue_free()

func _on_meta_clicked(meta):
	var word_prefix = "word://"
	if typeof(meta) == TYPE_STRING and meta.begins_with(word_prefix):
		# 获取点击的词条
		var word = meta.replace(word_prefix, "")
		var word_id = meta.replace(word_prefix, "")
		#var label_text = localization_data[GClueData.lang]["entries"].get(word_id, "???")
		var label_text = GClueData.get_clue_data(chapter, id, GClueData.lang).get("entries", {}).get(word_id, "???")
		# 实例化word_entry
		grid_container = GGameUi.world_bottom_container
		var word_entry = WordEntryScene.instantiate()
		add_child(word_entry) # 先暂时添加到当前场景树 否则看不到
		#word_entry.size_flags_horizontal = Control.SIZE_EXPAND_FILL # 关键 否则最后在容器里不均匀
		word_entry.set_label(label_text)
		word_entry.global_position = get_global_mouse_position()
		# 临时新增一个透明 wordentry
		var word_entry_copy = word_entry.duplicate()
		word_entry_copy.modulate = Color(1, 1, 1, 0)
		grid_container.add_child(word_entry_copy)
		var child_count = grid_container.get_child_count()
		var last_child = grid_container.get_child(child_count - 1)
		await get_tree().process_frame  # 关键 等到下一帧开始之前（process_frame） 子控件的位置才更新完成
		var target_position = last_child.global_position
		word_entry_copy.queue_free()
		# 飞行动画
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE)  # or Tween.TRANS_SINE
		tween.set_ease(Tween.EASE_OUT)      # 落地时变慢
		tween.tween_property(word_entry, "global_position", target_position, 1)
		tween.tween_callback(_on_animation_finished.bind(word_entry))
	elif typeof(meta) == TYPE_STRING and meta.begins_with("https"):
		print("测试打开网站")
		OS.shell_open(meta)

func _on_animation_finished(word_entry: Node):
	# 动画完成后，将 WordEntry 重定向到 GridContainer
	word_entry.reparent(grid_container)

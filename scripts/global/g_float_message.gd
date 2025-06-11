extends Node

func show(text: String, duration: float = 2.0):
	var popup = PopupPanel.new()
	var label = Label.new()
	label.text = text
	popup.add_child(label)
	get_tree().root.add_child(popup)  # 添加到场景根节点
	
	popup.popup_centered(Vector2(150, 25))
	await get_tree().create_timer(duration).timeout
	popup.queue_free()

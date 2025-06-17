extends RichTextEffect
class_name WaveUnderlineEffect

var shader_material: Shader = preload("res://shader/wave_word_line.gdshader").duplicate()
var enabled := true

func _process_custom_fx(char_fx: CharFXTransform):
	#return false

	if not enabled:
		return false

	# 在字符下方画波浪线
	var position = char_fx.rect_position
	var size = char_fx.rect_size

	# 调整位置，使波浪在下方偏一点
	var wave_rect = Rect2(position.x, position.y + size.y + 1.5, size.x, 3)

	# 画一个矩形，使用 shader
	char_fx.draw_rect(wave_rect, shader_material)

	return false

## wave_under_line_effect.gd
#extends RichTextEffect
#class_name WaveUnderlineEffect
#
#var speed := 5.0
#var amplitude := 2.0
#var thickness := 1.5
#
#func _process_custom_fx(char_fx: CharFXTransform):
	## 计算波浪偏移
	#var wave = sin(char_fx.character * 0.1 + char_fx.elapsed_time * speed) * amplitude
#
	## 在字符下方绘制波浪线
	#var underline = Rect2(
		#char_fx.rect_position.x,
		#char_fx.rect_position.y + char_fx.rect_size.y + wave,
		#char_fx.rect_size.x,
		#thickness
	#)
	#char_fx.draw_rect(underline, Color.RED)
#
	#return true  # 保持原始字符不变

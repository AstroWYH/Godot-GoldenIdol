# WavelineEffect.gd
extends RichTextEffect
class_name WaveLineEffect

#var shader:= preload("res://shader/wave_line.gdshader").duplicate()
var shader_material = preload("res://shader/wave_line.tres").duplicate()

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	#var shader_material := ShaderMaterial.new()
	#shader_material.shader = shader
	var pos = char_fx.rect_position
	var size = char_fx.rect_size

	# 在字符底部绘制波浪线（不改变字符位置！）
	var underline_height := 6.0
	var underline_y_offset = size.y + 2.0
	var rect := Rect2(pos.x, pos.y + underline_y_offset, size.x, underline_height)

	char_fx.draw_rect(rect, shader_material)
	return false

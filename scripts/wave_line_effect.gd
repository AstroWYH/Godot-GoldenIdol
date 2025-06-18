# WavelineEffect.gd
extends RichTextEffect
class_name WaveLineEffect

# 加载shader 方式1
#var shader: ShaderMaterial = null
#if shader == null:
	#shader = ShaderMaterial.new()
	#shader.shader = preload("res://path/to/wave_line.gdshader")

# 加载shader 方式2
# 先创建ShaderMaterial资源，把wave_line.gdshader拖进去
# ShaderMaterial才能使用，gdshader只是代码，还不能用
#var shader_material = preload("res://shader/wave_line.tres").duplicate()

var bbcode = "mywave"
static var b_enable : bool = false # 这必须是全局，否则外面没法设b_enable成功，属于godot的特性

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	if !b_enable:
		return true

	# 设置红色字符
	char_fx.color = Color(1.0, 0.2, 0.2)

	# 模拟波浪抖动：上下偏移
	var amplitude := 1.5  # 波幅（上下多少像素）
	var frequency := 5.0  # 波频（速度快慢）
	var offset := sin(char_fx.elapsed_time * frequency + float(char_fx.relative_index)) * amplitude
	char_fx.offset.y += offset

	# 启用该字符效果
	return true

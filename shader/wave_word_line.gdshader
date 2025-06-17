shader_type canvas_item;

uniform float time : hint_range(0.0, 10.0) = 0.0;
uniform vec4 wave_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform float wave_amplitude = 5.0;
uniform float wave_frequency = 0.1;
uniform bool enabled = true;
uniform float underline_position = 0.9; // 位置控制 (0-1)

void fragment() {
    if (!enabled) {
        discard;
    }
    
    // 获取当前像素的UV坐标 (0-1范围)
    vec2 uv = UV;
    
    // 计算波浪Y值 (-1到1之间)
    float wave = sin(uv.x * wave_frequency * 100.0 + time * 5.0) * wave_amplitude;
    
    // 将波浪值映射到0-1范围
    float wave_pos = (wave + 1.0) * 0.1;
    
    // 检测是否在波浪线范围内
    if (uv.y > underline_position - wave_pos && 
        uv.y < underline_position + wave_pos) {
        COLOR = wave_color;
    } else {
        COLOR = texture(TEXTURE, uv); // 保持原有纹理
    }
}
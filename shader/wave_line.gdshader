// res://wave_line.shader
shader_type canvas_item;

void fragment() {
    float wave = sin(UV.x * 40.0 + TIME * 10.0) * 0.3;
    float alpha = smoothstep(0.0, 0.1, 0.5 - abs(UV.y - (0.5 + wave)));
    COLOR = vec4(1.0, 0.0, 0.0, alpha); // 红色波浪
}
shader_type canvas_item;
render_mode blend_mix;

uniform vec2 uv_scale = vec2(1.0);

void fragment() {
	COLOR = texture(TEXTURE, uv_scale * UV);
}

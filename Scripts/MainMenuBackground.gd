extends TextureRect

@export var uv_u_scale = 1.0
@export var uv_v_scale = 1.0

func _ready():
	var uv_u = (get_rect().size.x / texture.get_width()) * uv_u_scale
	var uv_v = (get_rect().size.y / texture.get_height()) * uv_v_scale
	material.set_shader_parameter("uv_scale", Vector2(uv_u, uv_v))

shader_type canvas_item;

uniform float opacidad : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    COLOR = texture(TEXTURE, UV);
    COLOR.a *= opacidad;  // Ajusta la opacidad
}

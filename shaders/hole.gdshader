shader_type canvas_item;
uniform float raio: hint_range(0.0, 1, 0.1) = 0.6;

void fragment() {
	vec2 centro = vec2(0.5);
	float df = distance(UV, centro);
	float alpha = step(raio,df);
	COLOR = vec4( vec3(COLOR.r,COLOR.g,COLOR.b), alpha);
}

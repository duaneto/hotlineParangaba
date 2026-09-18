shader_type canvas_item;

uniform float scanline_strength : hint_range(0.0, 1.0) = 0.18;
uniform float noise_strength : hint_range(0.0, 1.0) = 0.08;
uniform float distortion : hint_range(0.0, 0.1) = 0.015;
uniform float flicker_strength : hint_range(0.0, 0.2) = 0.04;

float random(vec2 uv)
{
	return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment()
{
	vec2 uv = UV;

	// Pequena distorção horizontal
	float wave = sin(uv.y * 35.0 + TIME * 4.0) * distortion;
	uv.x += wave;

	// Linhas horizontais de CRT
	float scanlines = sin(uv.y * 900.0) * scanline_strength;

	// Ruído digital
	float noise = random(
		vec2(
			uv.x * 1000.0 + TIME * 10.0,
			uv.y * 1000.0
		)
	);

	// Pequena oscilação de brilho
	float flicker = sin(TIME * 18.0) * flicker_strength;

	float effect = 1.0;
	effect -= scanlines;
	effect += (noise - 0.5) * noise_strength;
	effect += flicker;

	COLOR = vec4(vec3(effect), 0.35);
}
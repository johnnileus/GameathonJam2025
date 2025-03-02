shader_type spatial;

uniform float alert_progress : hint_range(0.0, 1.0); // How much of the mark is filled
uniform sampler2D icon_mask;

uniform vec3 fill_col;
uniform vec3 alert_col;
uniform vec3 back_col;

void fragment() {
	float mask = texture(icon_mask, UV).r;
	
	if (mask <= 0.2) {discard;}
	
	vec3 col;
	
	if (1. - UV.y < alert_progress) {
		col = fill_col;
	} else {
		col = back_col;
	}
	
	if (alert_progress == 1.0) {
		col = alert_col;
	}
	if (alert_progress == 0.0) {
		ALPHA = 0.0;
	} else {
		ALPHA = mask;
	}
	
	ALBEDO = col;
	EMISSION = col;
}
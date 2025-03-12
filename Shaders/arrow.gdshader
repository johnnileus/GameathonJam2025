shader_type canvas_item;

uniform sampler2D arrow_mask;
uniform float alert_progress : hint_range(0.0, 1.0); // How much of the mark is filled

uniform vec4 fill_col;
uniform vec4 alert_col;
uniform vec4 back_col;

void fragment() {
    float mask = texture(arrow_mask, UV).r;
	if (mask <= 0.2) {discard;}

	vec4 col = vec4(1.0);
	col.r = alert_progress;

	float sdf = abs((UV.x - 0.5)/.5);
	if (sdf > alert_progress) {
		col = back_col;
	} else {
		col = fill_col;
	}

		if (alert_progress == 1.0) {
		col = alert_col;
	}
	if (alert_progress == 0.0) {
		col.w = 0.0;
	} else {
		col.w = mask;
	}

    COLOR = col;
}
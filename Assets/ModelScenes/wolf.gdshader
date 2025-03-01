shader_type spatial;

uniform sampler2D texture_albedo;
uniform sampler2D texture_alpha;

void fragment() {
    ALBEDO = texture(texture_albedo, UV).rgb;
    ALPHA = texture(texture_alpha, UV).r;

}
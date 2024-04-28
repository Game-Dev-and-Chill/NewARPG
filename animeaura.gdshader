shader_type spatial;
//render_mode cull_disabled, depth_draw_never, unshaded;

// Parameters for the outline
uniform vec4 outline_color : source_color = vec4(0.5, 0.5, 0.5, 1.0);
uniform float outline_width : hint_range(0.001, 0.03) = 0.005;

// Vertex function to transform the vertex positions
void vertex() {
    // Calculate normal and vertex position in view space
    vec3 norm = normalize(NORMAL);
    vec3 vertex_pos = VERTEX;

    // Offset vertex along the normal
    VERTEX += norm * outline_width;
}

// Fragment function to apply the color
void fragment() {
    ALBEDO = outline_color.rgb;
    ALPHA = outline_color.a;
}
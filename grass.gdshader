shader_type spatial;

uniform sampler2D grass_texture: repeat_enable;
uniform float scale;
varying vec2 GlobalPosition;

vec4 hash4( vec2 p ) { 
    return fract(sin(vec4( 1.0+dot(p,vec2(37.0,17.0)), 
                        2.0+dot(p,vec2(11.0,47.0)),
                        3.0+dot(p,vec2(41.0,29.0)),
                        4.0+dot(p,vec2(23.0,31.0))))*103.0); 
}

float sum(vec3 v) {
	return v.x + v.y + v.z;
}

vec3 textureNoTile(sampler2D samp, vec2 uv) {
	// sample variation pattern    
	float k = texture(samp, vec2(0.005 * uv.x, 0.0)).x; // cheap (cache friendly) lookupa  
	
	// compute index    
	float index = k * 8.0;
	float i = floor(index);
	float f = fract(index);
	
	// offsets for the different virtual patterns    
	vec2 offa = sin(vec2(3.0, 7.0) * (i + 0.0)); // can replace with any other hash    
	vec2 offb = sin(vec2(3.0, 7.0) * (i + 1.0)); // can replace with any other hash    
	
	// compute derivatives for mip-mapping    
	vec2 dx = dFdx(uv), dy = dFdy(uv);
	
	// sample the two closest virtual patterns    
	vec3 cola = textureGrad(samp, uv + offa, dx, dy).rgb;
	vec3 colb = textureGrad(samp, uv + offb, dx, dy).rgb;
	
	
	
	// interpolate between the two virtual patterns    
	return mix(cola, colb, smoothstep(0.2, 0.8, f - 0.1 * sum(cola - colb)));
}

void vertex() {
    GlobalPosition = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xz;
}

float random(vec2 uv){
    return round(fract(sin(dot(uv.xy, vec2(12.9898,78.233)))*43758.5453123)*3.0);
}

void fragment() {
    vec2 MapUV = GlobalPosition/vec2(scale);
    vec3 color = textureNoTile(grass_texture, MapUV);
    ALBEDO = color.rgb;

    float rotationIndex = random(MapUV);
    float rotationAngle = rotationIndex * 90.0;
    vec3 eulerRotation = vec3(0.0, rotationAngle, 0.0);
    //NORMAL = normalize(eulerRotation * NORMAL);
}
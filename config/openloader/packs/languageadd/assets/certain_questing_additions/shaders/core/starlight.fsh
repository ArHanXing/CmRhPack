#version 330

#define parallaxIntensity 5.0

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform vec2 size;
uniform vec2 scrollOffset;
uniform vec2 scrollSize;
uniform float time;
uniform float zoom;

in vec2 texCoord0;
out vec4 fragColor;

uint hash(uint x) { x += (x << 10u); x ^= (x >> 6u); x += (x << 3u); x ^= (x >> 11u); x += (x << 15u); return x; }
uint hash(uvec2 v) { return hash(v.x ^ hash(v.y)); }
float floatConstruct(uint m) { const uint ieeeMantissa = 0x007FFFFFu; const uint ieeeOne = 0x3F800000u; m &= ieeeMantissa; m |= ieeeOne; float f = uintBitsToFloat(m); return f - 1.0; }
float random(vec2 v) { return floatConstruct(hash(floatBitsToUint(v))); }
vec2 random2(vec2 v) { return vec2(floatConstruct(hash(floatBitsToUint(v))), floatConstruct(hash(floatBitsToUint(v * 2.0)))) * 2.0 - 1.0; }
float noise(vec2 st) { vec2 i = floor(st); vec2 f = fract(st); vec2 u = f * f * (3.0 - 2.0 * f); return mix(mix(dot(random2(i + vec2(0.0, 0.0)), f - vec2(0.0, 0.0)), dot(random2(i + vec2(1.0, 0.0)), f - vec2(1.0, 0.0)), u.x), mix(dot(random2(i + vec2(0.0, 1.0)), f - vec2(0.0, 1.0)), dot(random2(i + vec2(1.0, 1.0)), f - vec2(1.0, 1.0)), u.x), u.y) * 0.5 + 0.5; }
float fbm(vec2 p) { float v = 0.0; float a = 0.5; for (int i = 0; i < 4; i++) { v += a * noise(p); p = p * 2.0; a *= 0.5; } return v; }

void main() {
    vec2 fragCoord = texCoord0 * size;
    vec2 center = size / 2.0;
    float scale = zoom / 16.0;
    vec2 relative = fragCoord - center; relative /= scale;
    vec2 zoomed_frag = relative + center;
    vec2 base_uv = zoomed_frag / size;
    float aspect = size.x / size.y; base_uv.x *= aspect;
    vec2 zoomed_uv = base_uv;

    vec2 scrollPos = vec2(0.0);
    if (scrollSize.x > 0.0) scrollPos.x = scrollOffset.x / scrollSize.x;
    if (scrollSize.y > 0.0) scrollPos.y = scrollOffset.y / scrollSize.y;

    // Deep grey-purple base
    fragColor = vec4(0.08, 0.07, 0.13, 1.0);

    // Rotating starfield effect
    float angle = time * 0.02;
    mat2 rot = mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
    vec2 rot_uv = rot * (zoomed_uv - 0.5) + 0.5;

    // Soft nebula bands
    vec2 neb_uv = rot_uv * 2.5 + scrollPos * 0.005 * parallaxIntensity / scale;
    float neb = fbm(neb_uv);
    vec4 nebColor = mix(vec4(0.25, 0.2, 0.4, 1.0), vec4(0.6, 0.5, 0.8, 1.0), neb);
    fragColor += nebColor * neb * 0.5;

    // Stars
    vec4 stars = vec4(0.0);
    for (float starsize = 3.5; starsize > 0.0; starsize -= 0.4) {
        float cellsize = starsize * 110.0;
        float ratio = starsize / cellsize;
        float c1 = random(vec2(starsize)) * 500.0;
        float c2 = 40.0 * starsize;
        vec2 coord = zoomed_frag + vec2(c1, c1) + scrollPos * vec2(c2, c2) * parallaxIntensity / scale;
        // apply rotation to star layer
        coord = rot * coord;
        vec2 luv = mod(coord, cellsize) / cellsize;
        vec2 cell = floor(coord / cellsize);
        float r1 = random(cell + vec2(1.0));
        float r2 = random(cell);
        vec2 col = luv - clamp(vec2(r1, r2), ratio, 1.0 - ratio);
        col /= ratio * 0.7;
        float lensq = dot(col, col);
        float core = exp(-lensq * 2.0);
        float glow = 1.0 / (1.0 + lensq * 5.0);
        float intensity = core + 0.3 * glow;
        // twinkle
        intensity *= 0.8 + 0.2 * sin(time * 5.0 + cell.x * 10.0);
        // star color tint
        vec3 starCol = mix(vec3(0.9, 0.9, 1.0), vec3(0.7, 0.6, 1.0), random(cell));
        stars += vec4(starCol * intensity, 1.0);
    }
    fragColor += stars * 0.9;
}
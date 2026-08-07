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

// --- Noise Functions (same as default) ---
uint hash(uint x) {
    x += (x << 10u);
    x ^= (x >> 6u);
    x += (x << 3u);
    x ^= (x >> 11u);
    x += (x << 15u);
    return x;
}
uint hash(uvec2 v) { return hash(v.x ^ hash(v.y)); }
float floatConstruct(uint m) {
    const uint ieeeMantissa = 0x007FFFFFu;
    const uint ieeeOne = 0x3F800000u;
    m &= ieeeMantissa;
    m |= ieeeOne;
    float f = uintBitsToFloat(m);
    return f - 1.0;
}
float random(vec2 v) { return floatConstruct(hash(floatBitsToUint(v))); }
vec2 random2(vec2 v) {
    return vec2(
        floatConstruct(hash(floatBitsToUint(v))),
        floatConstruct(hash(floatBitsToUint(v * 2.0)))
    ) * 2.0 - 1.0;
}
float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(
        mix(dot(random2(i + vec2(0.0, 0.0)), f - vec2(0.0, 0.0)),
            dot(random2(i + vec2(1.0, 0.0)), f - vec2(1.0, 0.0)), u.x),
        mix(dot(random2(i + vec2(0.0, 1.0)), f - vec2(0.0, 1.0)),
            dot(random2(i + vec2(1.0, 1.0)), f - vec2(1.0, 1.0)), u.x),
        u.y
    ) * 0.5 + 0.5;
}

float fbm(vec2 p) {
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(100.0);
    for (int i = 0; i < 4; i++) {
        v += a * noise(p);
        p = p * 2.0 + shift + time * 0.01;
        a *= 0.5;
    }
    return v;
}

void main() {
    // Coordinates setup
    vec2 fragCoord = texCoord0 * size;
    vec2 center = size / 2.0;
    float scale = zoom / 16.0;
    vec2 relative = fragCoord - center;
    relative /= scale;
    vec2 zoomed_frag = relative + center;
    vec2 base_uv = zoomed_frag / size;
    float aspect = size.x / size.y;
    base_uv.x *= aspect;
    vec2 zoomed_uv = base_uv;

    // Scroll
    vec2 scrollPos = vec2(0.0);
    if (scrollSize.x > 0.0) scrollPos.x = scrollOffset.x / scrollSize.x;
    if (scrollSize.y > 0.0) scrollPos.y = scrollOffset.y / scrollSize.y;

    // Deep purple void
    fragColor = vec4(0.03, 0.01, 0.08, 1.0);

    // Nebula clouds (purple/magenta)
    vec2 nebula_uv = zoomed_uv * 3.0 + vec2(time * 0.008, time * 0.004) + scrollPos * 0.02 * parallaxIntensity / scale;
    float nebula = fbm(nebula_uv);
    vec4 nebulaCol = mix(vec4(0.2, 0.05, 0.3, 1.0), vec4(0.5, 0.1, 0.6, 1.0), nebula);
    fragColor += nebulaCol * nebula * 0.6;

    // End particles (floating dots)
    vec4 particles = vec4(0.0);
    for (float layer = 4.0; layer > 0.0; layer -= 0.8) {
        float cellsize = layer * 80.0;
        float ratio = layer / cellsize;
        float c1 = random(vec2(layer)) * 300.0;
        float c2 = 30.0 * layer;
        vec2 coord = zoomed_frag + vec2(c1, c1) + scrollPos * vec2(c2, c2) * parallaxIntensity / scale;
        vec2 luv = mod(coord, cellsize) / cellsize;
        vec2 cell = floor(coord / cellsize);
        float r1 = random(cell + vec2(1.0));
        float r2 = random(cell);
        vec2 col = luv - clamp(vec2(r1, r2), ratio, 1.0 - ratio);
        col /= ratio * 0.7;
        float lensq = dot(col, col);
        float particle = exp(-lensq * 3.0);
        // subtle twinkling
        particle *= 0.6 + 0.4 * sin(time * 3.0 + cell.x * 10.0 + cell.y * 20.0);
        particles += vec4(vec3(0.8, 0.4, 1.0) * particle, 1.0);
    }
    fragColor += particles * 0.8;
}
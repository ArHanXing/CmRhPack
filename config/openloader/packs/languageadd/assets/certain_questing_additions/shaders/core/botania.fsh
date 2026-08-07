#version 330

#define parallaxIntensity 4.0

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

    // Deep forest green
    fragColor = vec4(0.02, 0.05, 0.02, 1.0);

    // Vine / leaf patterns
    vec2 leaf_uv = zoomed_uv * 4.0 + scrollPos * 0.015 * parallaxIntensity / scale;
    float leaf = noise(leaf_uv);
    leaf += 0.5 * noise(leaf_uv * 2.0 + time * 0.01);
    vec4 leafColor = mix(vec4(0.05, 0.15, 0.05, 1.0), vec4(0.2, 0.5, 0.1, 1.0), leaf);
    fragColor += leafColor * 0.6;

    // Glowing petals / spores
    vec4 petals = vec4(0.0);
    for (float s = 2.0; s > 0.0; s -= 0.5) {
        float cellsize = s * 90.0;
        float ratio = s / cellsize;
        float c1 = random(vec2(s)) * 350.0;
        float c2 = 20.0 * s;
        vec2 coord = zoomed_frag + vec2(c1, c1) + scrollPos * vec2(c2, c2) * parallaxIntensity / scale;
        // gentle floating motion
        coord += vec2(sin(time * 0.5 + coord.y * 0.2), cos(time * 0.7 + coord.x * 0.2)) * 5.0;
        vec2 luv = mod(coord, cellsize) / cellsize;
        vec2 cell = floor(coord / cellsize);
        float r1 = random(cell + vec2(1.0));
        float r2 = random(cell);
        vec2 col = luv - clamp(vec2(r1, r2), ratio, 1.0 - ratio);
        col /= ratio * 0.7;
        float lensq = dot(col, col);
        float petal = exp(-lensq * 4.0);
        // varied colors
        vec3 petalColor = mix(vec3(0.8, 0.2, 0.8), vec3(0.2, 0.9, 0.3), random(cell + 10.0));
        petals += vec4(petalColor * petal, 1.0);
    }
    fragColor += petals * 0.7;

    // Fireflies
    vec2 ff_uv = zoomed_uv * 2.0 + scrollPos * 0.03 * parallaxIntensity / scale;
    float ff = noise(ff_uv + time * 0.2) * noise(ff_uv * 3.0 - time * 0.3);
    fragColor += vec4(0.6, 1.0, 0.3, 1.0) * ff * 0.4;
}
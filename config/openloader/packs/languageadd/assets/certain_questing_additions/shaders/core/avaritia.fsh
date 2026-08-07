#version 330
#define parallaxIntensity 5.0

uniform mat4 ModelViewMat; uniform mat4 ProjMat; uniform vec2 size;
uniform vec2 scrollOffset; uniform vec2 scrollSize; uniform float time; uniform float zoom;
in vec2 texCoord0; out vec4 fragColor;

uint hash(uint x) { x += (x << 10u); x ^= (x >> 6u); x += (x << 3u); x ^= (x >> 11u); x += (x << 15u); return x; }
uint hash(uvec2 v) { return hash(v.x ^ hash(v.y)); }
float floatConstruct(uint m) { const uint ieeeMantissa = 0x007FFFFFu; const uint ieeeOne = 0x3F800000u; m &= ieeeMantissa; m |= ieeeOne; return uintBitsToFloat(m) - 1.0; }
float random(vec2 v) { return floatConstruct(hash(floatBitsToUint(v))); }
vec2 random2(vec2 v) { return vec2(floatConstruct(hash(floatBitsToUint(v))), floatConstruct(hash(floatBitsToUint(v * 2.0)))) * 2.0 - 1.0; }
float noise(vec2 st) { vec2 i = floor(st); vec2 f = fract(st); vec2 u = f * f * (3.0 - 2.0 * f); return mix(mix(dot(random2(i + vec2(0.0, 0.0)), f - vec2(0.0, 0.0)), dot(random2(i + vec2(1.0, 0.0)), f - vec2(1.0, 0.0)), u.x), mix(dot(random2(i + vec2(0.0, 1.0)), f - vec2(0.0, 1.0)), dot(random2(i + vec2(1.0, 1.0)), f - vec2(1.0, 1.0)), u.x), u.y) * 0.40 + 0.02; }

// 色相转换函数用于彩虹渐变
vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}
float cosmos(vec2 uv) { vec2 pos = vec2(1.0 * uv); return (noise(pos) + 0.5 * noise(pos * 2.0) + 0.25 * noise(pos * 4.0) + 0.125 * noise(pos * 8.0)) / 1.875; }

void main() {
    vec2 fragCoord = texCoord0 * size; vec2 center = size / 2.0; float scale = zoom / 16.0;
    vec2 relative = (fragCoord - center) / scale; vec2 zoomed_uv = (relative + center) / size;
    zoomed_uv.x *= (size.x / size.y);
    
    vec2 scrollPos = vec2(0.0);
    if (scrollSize.x > 0.0) scrollPos.x = scrollOffset.x / scrollSize.x;
    if (scrollSize.y > 0.0) scrollPos.y = scrollOffset.y / scrollSize.y;
    
    fragColor = vec4(0.0, 0.0, 0.02, 1.0); // 纯黑底色
    
    // 域扭曲宇宙星云
    vec2 cosmo_uv = zoomed_uv + (scrollPos * 0.01 * parallaxIntensity) / scale;
    float n = cosmos(cosmo_uv + vec2(time * 0.05, 0.0));
    // 基于时间和UV计算色相，生成动态彩虹色
    vec3 rainbow = hsv2rgb(vec3(time * 0.1 + cosmo_uv.x + cosmo_uv.y, 0.8, 1.0));
    fragColor += clamp(vec4(rainbow, 1.0) * n * 1.2, 0.0, 1.0);
    
    // 密集的彩色星海
    vec4 stars = vec4(0.0);
    for (float starsize = 4.0; starsize > 0.0; starsize -= 0.3) { // 增加循环密度 (步长0.3)
        float cellsize = starsize * 80.0; float ratio = starsize / cellsize;
        float c1 = random(vec2(starsize)) * 500.0; float c2 = 50.0 * starsize;
        
        vec2 coord = (relative + center) + vec2(c1, c1) + (scrollPos * vec2(c2, c2) * parallaxIntensity) / scale;
        vec2 luv = mod(coord, cellsize) / cellsize; vec2 cell = floor(coord / cellsize);
        float r1 = random(cell + vec2(1.0)); float r2 = random(cell);
        
        vec2 col = luv - clamp(vec2(r1, r2), ratio, 1.0 - ratio); col /= ratio * 0.7;
        float lensq = dot(col, col); float core = exp(-lensq * 1.5); float glow = 1.0 / (1.0 + lensq * 2.0);
        float intensity = core + 0.4 * glow;
        
        // 让星星自身带有不同的色相
        vec3 starColor = hsv2rgb(vec3(r1 * 5.0 + time * 0.2, 0.6, 1.0));
        stars += vec4(starColor * intensity, 1.0);
    }
    fragColor += stars;
}
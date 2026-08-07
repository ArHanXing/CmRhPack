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
float smoke(vec2 uv) { vec2 pos = vec2(2.0 * uv); return (noise(pos) + 0.5 * noise(pos * 2.0) + 0.25 * noise(pos * 4.0)) / 1.75; }

void main() {
    vec2 fragCoord = texCoord0 * size; vec2 center = size / 2.0; float scale = zoom / 16.0;
    vec2 relative = (fragCoord - center) / scale; vec2 zoomed_uv = (relative + center) / size;
    zoomed_uv.x *= (size.x / size.y);
    
    vec2 scrollPos = vec2(0.0);
    if (scrollSize.x > 0.0) scrollPos.x = scrollOffset.x / scrollSize.x;
    if (scrollSize.y > 0.0) scrollPos.y = scrollOffset.y / scrollSize.y;
    
    // 基础颜色：暗红地狱岩色
    fragColor = vec4(0.15, 0.02, 0.0, 1.0);
    
    // 热浪烟雾 (垂直向上的扰动)
    vec2 smoke_uv = zoomed_uv + (scrollPos * 0.01 * parallaxIntensity) / scale;
    smoke_uv.y += time * 0.02; // 烟雾向上
    smoke_uv.x += sin(smoke_uv.y * 10.0 + time) * 0.05; // 热扭曲
    fragColor += clamp(vec4(0.6, 0.1, 0.0, 1.0) * smoke(smoke_uv), 0.0, 1.0);
    
    // 飘散的灰烬 (火星)
    vec4 embers = vec4(0.0);
    for (float starsize = 3.0; starsize > 0.5; starsize -= 0.5) {
        float cellsize = starsize * 100.0; float ratio = starsize / cellsize;
        float c1 = random(vec2(starsize)) * 500.0; float c2 = 50.0 * starsize;
        
        vec2 coord = (relative + center) + vec2(c1, c1) + (scrollPos * vec2(c2, c2) * parallaxIntensity) / scale;
        coord.y += time * 30.0 * starsize; // 快速向上
        coord.x += sin(time * 2.0 + coord.y * 0.01) * 15.0; // 火星的不规则晃动
        
        vec2 luv = mod(coord, cellsize) / cellsize; vec2 cell = floor(coord / cellsize);
        float r1 = random(cell + vec2(1.0)); float r2 = random(cell);
        
        vec2 col = luv - clamp(vec2(r1, r2), ratio, 1.0 - ratio); col /= ratio * 0.7;
        float lensq = dot(col, col);
        float core = exp(-lensq * 3.0); 
        float intensity = core; // 移除光晕，让灰烬更锐利
        
        // 橘黄色带有一点闪烁
        float flicker = sin(time * 10.0 + r1 * 100.0) * 0.5 + 0.5;
        embers += vec4(vec3(intensity) * vec3(1.0, 0.5 * flicker, 0.0), 1.0);
    }
    fragColor += embers;
}
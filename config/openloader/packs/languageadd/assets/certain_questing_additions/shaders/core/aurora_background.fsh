#version 330

// 视差强度
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

// --- 基础数学与噪声函数 ---
uint hash(uint x) {
    x += (x << 10u); x ^= (x >> 6u); x += (x << 3u); x ^= (x >> 11u); x += (x << 15u); return x;
}
uint hash(uvec2 v) { return hash(v.x ^ hash(v.y)); }

float floatConstruct(uint m) {
    const uint ieeeMantissa = 0x007FFFFFu; const uint ieeeOne = 0x3F800000u;
    m &= ieeeMantissa; m |= ieeeOne; return uintBitsToFloat(m) - 1.0;
}

float random(vec2 v) { return floatConstruct(hash(floatBitsToUint(v))); }
vec2 random2(vec2 v) {
    return vec2(floatConstruct(hash(floatBitsToUint(v))), floatConstruct(hash(floatBitsToUint(v * 2.0)))) * 2.0 - 1.0;
}

float noise(vec2 st) {
    vec2 i = floor(st); vec2 f = fract(st); vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(mix(dot(random2(i + vec2(0.0, 0.0)), f - vec2(0.0, 0.0)), dot(random2(i + vec2(1.0, 0.0)), f - vec2(1.0, 0.0)), u.x),
               mix(dot(random2(i + vec2(0.0, 1.0)), f - vec2(0.0, 1.0)), dot(random2(i + vec2(1.0, 1.0)), f - vec2(1.0, 1.0)), u.x), u.y) * 0.40 + 0.02;
}

// 分形星云函数
float nebulaNoise(vec2 uv) {
    vec2 pos = vec2(2.0 * uv);
    return (noise(pos) + 0.5 * noise(pos * 2.0) + 0.25 * noise(pos * 4.0)) / 1.75;
}

void main() {
    // --- 1. 坐标与缩放 ---
    vec2 fragCoord = texCoord0 * size;
    vec2 center = size / 2.0;
    float scale = zoom / 16.0;
    
    vec2 relative = (fragCoord - center) / scale;
    vec2 zoomed_uv = (relative + center) / size;
    zoomed_uv.x *= (size.x / size.y);
    
    // --- 2. 滚动偏移 ---
    vec2 scrollPos = vec2(0.0);
    if (scrollSize.x > 0.0) scrollPos.x = scrollOffset.x / scrollSize.x;
    if (scrollSize.y > 0.0) scrollPos.y = scrollOffset.y / scrollSize.y;
    
    // --- 3. 基础天际调色 (环境光提亮) ---
    // 【修改点】使用渐变色替代纯暗色。下方偏亮紫，上方偏深蓝。
    vec3 skyBottom = vec3(0.1, 0.15, 0.3); // 更亮的底部环境光
    vec3 skyTop = vec3(0.02, 0.05, 0.12);
    vec3 baseSky = mix(skyBottom, skyTop, zoomed_uv.y);
    fragColor = vec4(baseSky, 1.0);
    
    // --- 4. 极光星云 (大范围弥漫与高爆光) ---
    vec2 aurora_uv = zoomed_uv + (scrollPos * 0.02 * parallaxIntensity) / scale;
    aurora_uv.x -= time * 0.02; 
    aurora_uv.y += sin(aurora_uv.x * 3.0 + time * 0.2) * 0.05; 
    
    float nIntensity = nebulaNoise(aurora_uv);
    
    // 【修改点】大幅放宽极光的显示范围！0.0 就开始显色，0.5 就达到最高亮度
    float auroraMask = smoothstep(0.0, 0.5, nIntensity);
    float ambientGlow = nIntensity * 0.5; // 给整个星空增加一层淡淡的基础星云雾气
    
    // 【修改点】全面拉高极光的 RGB 基础明度
    vec3 colorGreen = vec3(0.2, 1.0, 0.7); // 更明亮的青绿色
    vec3 colorPurple = vec3(0.9, 0.4, 1.0); // 更明亮的粉紫色
    
    float mixFactor = sin(zoomed_uv.x * 2.0 + time * 0.5) * 0.5 + 0.5;
    vec3 finalAuroraColor = mix(colorGreen, colorPurple, mixFactor);
    
    // 【修改点】亮度倍率提升至 2.5 倍，并加上环境雾气
    vec3 renderAurora = finalAuroraColor * (auroraMask * 2.5 + ambientGlow);
    fragColor += clamp(vec4(renderAurora, 1.0), 0.0, 1.0);
    
    // --- 5. 正常的璀璨群星 (提亮与放大) ---
    vec4 stars = vec4(0.0);
    
    for (float starsize = 3.0; starsize > 0.0; starsize -= 0.5) {
        float cellsize = starsize * 100.0;
        float ratio = starsize / cellsize;
        
        float c1 = random(vec2(starsize)) * 500.0;
        float c2 = 40.0 * starsize;
        
        vec2 coord = (relative + center) + vec2(c1, c1) + (scrollPos * vec2(c2, c2) * parallaxIntensity) / scale;
        
        vec2 luv = mod(coord, cellsize) / cellsize;
        vec2 cell = floor(coord / cellsize);
        
        float r1 = random(cell + vec2(1.0));
        float r2 = random(cell);
        
        vec2 col = luv - clamp(vec2(r1, r2), ratio, 1.0 - ratio);
        col /= ratio * 0.8; // 【修改点】稍微让星星显得更大一点
        
        float lensq = dot(col, col);
        
        float core = exp(-lensq * 15.0);      // 星核
        float glow = 0.8 * exp(-lensq * 3.0); // 【修改点】增加外围光晕的亮度
        
        float twinkle = sin(time * 3.0 + r1 * 100.0) * 0.4 + 0.6;
        float intensity = (core + glow) * twinkle;
        
        vec3 starColor = mix(vec3(0.95, 0.98, 1.0), vec3(0.8, 0.9, 1.0), r2);
        // 【修改点】整体提高星星的亮度权重
        stars += vec4(starColor * intensity * 1.5, 1.0); 
    }
    
    fragColor += stars;
}
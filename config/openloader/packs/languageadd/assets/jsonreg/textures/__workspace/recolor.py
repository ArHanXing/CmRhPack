# stolen from deepseek
# 换色罢了

# python recolor.py <目标颜色> [目录路径] [-r 递归查找]
# eg. python recolor.py FF0000 换成FF0000

import sys
import os
import glob
from PIL import Image
import colorsys
import numpy as np

def getFileName(origin_name,target_color,ext):
    return f"{origin_name}_{target_color}{ext}"
# 这个是自定义的


def hex_to_rgb(hex_color):
    """将16进制颜色代码转换为RGB元组"""
    hex_color = hex_color.lstrip('#')
    if len(hex_color) != 6:
        raise ValueError("颜色代码必须是6位16进制数（例如：FF5733）")
    
    r = int(hex_color[0:2], 16)
    g = int(hex_color[2:4], 16)
    b = int(hex_color[4:6], 16)
    
    return (r, g, b)

def rgb_to_hsv(rgb):
    """RGB转换为HSV（返回0-1范围的值）"""
    r, g, b = [x / 255.0 for x in rgb]
    h, s, v = colorsys.rgb_to_hsv(r, g, b)
    return h, s, v

def hsv_to_rgb(hsv):
    """HSV转换为RGB"""
    h, s, v = hsv
    r, g, b = colorsys.hsv_to_rgb(h, s, v)
    return (int(r * 255), int(g * 255), int(b * 255))

def is_grayscale_image(image, threshold=10):
    """检查图像是否主要是灰度的"""
    if image.mode == 'L':
        return True
    
    # 转换为RGB以便分析
    rgb_image = image.convert('RGB')
    pixels = np.array(rgb_image)
    
    # 计算每个像素的R、G、B差异
    diff = np.max(pixels, axis=2) - np.min(pixels, axis=2)
    
    # 如果大部分像素的颜色差异很小，则认为是灰度图
    grayscale_ratio = np.sum(diff < threshold) / diff.size
    
    return grayscale_ratio > 0.9  # 90%以上像素是灰度的

def recolor_grayscale_image(image, target_color_hex, intensity_preserve=0.7):
    """为灰度图像重新着色，保持明暗关系"""
    # 转换目标颜色
    target_rgb = hex_to_rgb(target_color_hex)
    target_h, target_s, target_v = rgb_to_hsv(target_rgb)
    
    # 转换为RGBA以便处理透明度
    if image.mode != 'RGBA':
        rgba_image = image.convert('RGBA')
    else:
        rgba_image = image
    
    # 转换为灰度图像获取亮度信息
    if image.mode != 'L':
        grayscale = image.convert('L')
    else:
        grayscale = image
    
    # 创建新图像
    new_image = Image.new("RGBA", image.size)
    new_pixels = new_image.load()
    old_pixels = rgba_image.load()
    gray_pixels = grayscale.load()
    
    width, height = image.size
    
    for y in range(height):
        for x in range(width):
            pixel = old_pixels[x, y]
            
            # 处理透明度
            if len(pixel) == 4:
                r, g, b, a = pixel
            else:
                r, g, b = pixel
                a = 255
            
            # 跳过完全透明像素
            if len(pixel) == 4 and a == 0:
                new_pixels[x, y] = (0, 0, 0, 0)
                continue
            
            # 获取灰度亮度（0-255）
            gray_value = gray_pixels[x, y] / 255.0
            
            # 根据灰度值调整目标颜色的明度和饱和度
            # 保持色调为目标色调
            new_h = target_h
            
            # 根据灰度值调整饱和度
            if gray_value < 0.3:  # 暗部
                new_s = target_s * 0.6
            elif gray_value > 0.7:  # 亮部
                new_s = target_s * 0.4
            else:  # 中间调
                new_s = target_s * 0.8
            
            # 调整明度：根据灰度值插值
            new_v = gray_value * intensity_preserve + target_v * (1 - intensity_preserve)
            
            # 限制值在合理范围
            new_s = max(0.0, min(1.0, new_s))
            new_v = max(0.1, min(1.0, new_v))
            
            # 转换回RGB
            new_rgb = hsv_to_rgb((new_h, new_s, new_v))
            
            # 保持原始透明度
            new_pixels[x, y] = (*new_rgb, a)
    
    return new_image

def recolor_color_image(image, target_color_hex):
    """为彩色图像重新着色，保持明暗度，只改变色相"""
    # 转换目标颜色
    target_rgb = hex_to_rgb(target_color_hex)
    target_h, target_s, target_v = rgb_to_hsv(target_rgb)
    
    # 计算原图的有效像素的平均色调
    pixels = image.load()
    width, height = image.size
    
    hues = []
    sats = []
    vals = []
    
    for y in range(height):
        for x in range(width):
            pixel = pixels[x, y]
            
            if len(pixel) == 4:
                r, g, b, a = pixel
                if a == 0:
                    continue
            else:
                r, g, b = pixel
            
            h, s, v = rgb_to_hsv((r, g, b))
            
            # 只收集有一定饱和度的像素（非灰度）
            if s > 0.1:
                hues.append(h)
                sats.append(s)
                vals.append(v)
    
    if not hues:  # 如果没有彩色像素，按灰度处理
        return recolor_grayscale_image(image, target_color_hex)
    
    # 计算平均色调、饱和度和明度
    avg_hue = sum(hues) / len(hues)
    avg_sat = sum(sats) / len(sats)
    avg_val = sum(vals) / len(vals)
    
    # 创建新图像
    new_image = Image.new("RGBA", image.size)
    new_pixels = new_image.load()
    
    for y in range(height):
        for x in range(width):
            pixel = pixels[x, y]
            
            if len(pixel) == 4:
                r, g, b, a = pixel
                has_alpha = True
            else:
                r, g, b = pixel
                a = 255
                has_alpha = False
            
            # 跳过完全透明像素
            if has_alpha and a == 0:
                new_pixels[x, y] = (0, 0, 0, 0)
                continue
            
            # 将RGB转换为HSV
            h, s, v = rgb_to_hsv((r, g, b))
            
            # 计算色调偏移量
            hue_shift = target_h - avg_hue
            
            # 应用色调偏移
            new_h = (h + hue_shift) % 1.0
            
            # 调整饱和度：基于原图平均饱和度和目标饱和度的关系
            if s > 0:  # 只调整有颜色的像素
                new_s = s * (target_s / avg_sat) if avg_sat > 0 else target_s
                new_s = max(0.0, min(1.0, new_s))
            else:
                new_s = s
            
            # 保持原始明度，但稍微调整以匹配目标明度
            new_v = v * (target_v / avg_val) if avg_val > 0 else v
            new_v = max(0.1, min(1.0, new_v))
            
            # 转换回RGB
            new_rgb = hsv_to_rgb((new_h, new_s, new_v))
            
            # 保持原始透明度
            if has_alpha:
                new_pixels[x, y] = (*new_rgb, a)
            else:
                new_pixels[x, y] = new_rgb
    
    return new_image

def process_single_image(input_file, target_color):
    """处理单个图像文件"""
    try:
        # 打开图像
        image = Image.open(input_file)
        
        # 检查是否是灰度图像
        is_grayscale = is_grayscale_image(image)
        
        if is_grayscale:
            new_image = recolor_grayscale_image(image, target_color)
        else:
            new_image = recolor_color_image(image, target_color)
        
        # 生成输出文件名
        name, ext = os.path.splitext(input_file)
        output_file = getFileName(name,target_color,ext)
        
        # 保存图像
        new_image.save(output_file, 'PNG')
        
        return True, output_file, None
    except Exception as e:
        return False, input_file, str(e)

def find_png_files(directory=None, recursive=True):
    """查找PNG文件"""
    if directory is None:
        directory = os.getcwd()
    
    if recursive:
        # 递归查找所有子目录中的PNG文件
        pattern = os.path.join(directory, "**", "*.png")
        png_files = glob.glob(pattern, recursive=True)
    else:
        # 只查找当前目录的PNG文件
        pattern = os.path.join(directory, "*.png")
        png_files = glob.glob(pattern)
    
    return png_files

def main():
    if len(sys.argv) != 2:
        print("用法: python recolor_all.py <目标颜色(16进制)>")
        print("示例: python recolor_all.py FF5733")
        print("\n可选: 您也可以指定搜索目录和递归选项")
        print("完整用法: python recolor_all.py <目标颜色> [目录路径] [-r/--recursive]")
        print("示例: python recolor_all.py FF0000 ./textures -r")
        sys.exit(1)
    
    target_color = sys.argv[1].upper()
    
    # 检查是否有额外的参数
    directory = os.getcwd()  # 默认当前目录
    recursive = True         # 默认递归搜索
    
    if len(sys.argv) > 2:
        for arg in sys.argv[2:]:
            if arg.lower() in ['-r', '--recursive']:
                recursive = True
            elif arg.lower() in ['-nr', '--no-recursive']:
                recursive = False
            elif os.path.isdir(arg):
                directory = arg
            else:
                print(f"警告: 忽略未知参数: {arg}")
    
    try:
        # 验证颜色代码
        hex_to_rgb(target_color)
    except ValueError as e:
        print(f"错误: {e}")
        print("颜色代码必须是6位16进制数，例如: FF5733, 00FF00, 0000FF")
        sys.exit(1)
    
    print("=" * 60)
    print(f"目标颜色: #{target_color}")
    print(f"搜索目录: {directory}")
    print(f"递归搜索: {'是' if recursive else '否'}")
    print("=" * 60)
    
    # 查找所有PNG文件
    print("正在查找PNG文件...")
    png_files = find_png_files(directory, recursive)
    
    if not png_files:
        print(f"在目录 '{directory}' 中未找到PNG文件")
        sys.exit(0)
    
    print(f"找到 {len(png_files)} 个PNG文件:")
    for i, file in enumerate(png_files, 1):
        rel_path = os.path.relpath(file, directory)
        print(f"  {i:3d}. {rel_path}")
    
    print("\n开始处理...")
    print("-" * 60)
    
    # 处理每个文件
    success_count = 0
    error_count = 0
    
    for i, input_file in enumerate(png_files, 1):
        rel_path = os.path.relpath(input_file, directory)
        print(f"处理 [{i}/{len(png_files)}]: {rel_path}...", end=" ")
        
        success, output_file, error = process_single_image(input_file, target_color)
        
        if success:
            print("✓ 完成")
            success_count += 1
        else:
            print(f"✗ 失败: {error}")
            error_count += 1
    
    # 输出统计信息
    print("=" * 60)
    print("处理完成!")
    print(f"成功: {success_count} 个文件")
    print(f"失败: {error_count} 个文件")
    
    if success_count > 0:
        print(f"\n处理后的文件已保存，文件名格式: 原文件名_{target_color}.png")
        print("例如: item.png -> item_FF5733.png")

if __name__ == "__main__":
    main()
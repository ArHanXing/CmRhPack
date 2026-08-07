#!/usr/bin/env python3
# 完全由DeepSeek Reasoner输出！
import os
import sys
import shutil
from PIL import Image

def validate_hex_color(color_str: str) -> tuple:
    """验证并解析6位十六进制颜色字符串，返回(r, g, b)"""
    if len(color_str) != 6 or not all(c in "0123456789abcdef" for c in color_str):
        raise ValueError("颜色格式错误，应为6位十六进制字符串 (rrggbb)")
    r = int(color_str[0:2], 16)
    g = int(color_str[2:4], 16)
    b = int(color_str[4:6], 16)
    return r, g, b

def recolor_image(image_path: str, target_rgb: tuple) -> Image.Image:
    """对灰度图进行上色，保留Alpha通道"""
    img = Image.open(image_path).convert("RGBA")
    datas = img.getdata()
    target_r, target_g, target_b = target_rgb
    new_data = []
    for item in datas:
        gray = item[0]  # 假设原图是灰度图，R=G=B
        new_r = int((gray / 255.0) * target_r)
        new_g = int((gray / 255.0) * target_g)
        new_b = int((gray / 255.0) * target_b)
        new_data.append((new_r, new_g, new_b, item[3]))
    new_img = Image.new("RGBA", img.size)
    new_img.putdata(new_data)
    return new_img

def process_fluid_material(name: str, state: bool, color_hex: str):
    """流体材质处理主函数"""
    # 解析颜色
    try:
        target_rgb = validate_hex_color(color_hex)
    except ValueError as e:
        print(f"PY: {e}")
        sys.exit(1)

    # 确定材质前缀
    prefix = "thick" if state else "thin"

    # 路径设置
    script_dir = os.path.dirname(os.path.abspath(__file__))
    source_dir = os.path.join(script_dir, "material_set", "fluid")
    output_dir = os.path.join(script_dir, "textures", "fluid")

    # 确保输出目录存在
    os.makedirs(output_dir, exist_ok=True)

    # 需要处理的文件对：(源文件名基, 目标文件名基, 纹理类型)
    files_to_process = [
        (f"{prefix}_fluid_flow", f"{name}_flow", "flow"),
        (f"{prefix}_fluid_still", f"{name}_still", "still")
    ]

    for src_base, dst_base, tex_type in files_to_process:
        src_png = os.path.join(source_dir, f"{src_base}.png")
        src_mcmeta = os.path.join(source_dir, f"{src_base}.png.mcmeta")
        dst_png = os.path.join(output_dir, f"{dst_base}.png")
        dst_mcmeta = os.path.join(output_dir, f"{dst_base}.png.mcmeta")

        # 处理主纹理
        if not os.path.isfile(src_png):
            print(f"PY: 警告：源纹理不存在 {src_png}")
            continue

        print(f"PY: 处理 {tex_type} 纹理: {src_base}.png -> {dst_base}.png")
        try:
            colored_img = recolor_image(src_png, target_rgb)
            colored_img.save(dst_png)
            print(f"PY: 保存纹理: {dst_base}.png")
        except Exception as e:
            print(f"PY: 错误：处理纹理失败 {src_png}: {e}")
            continue

        # 复制.mcmeta文件（如果存在）
        if os.path.isfile(src_mcmeta):
            shutil.copy2(src_mcmeta, dst_mcmeta)
            print(f"PY: 复制元数据: {dst_base}.png.mcmeta")

    print("PY: 处理完成！文件已输出到 textures/fluid/ 目录")

def main():
    """命令行入口"""
    if len(sys.argv) != 4:
        print("PY: 用法: python script.py <name> <state> <color>")
        print("PY:   name  : 流体名称（例如 lava）")
        print("PY:   state : 1 表示 thick, 0 表示 thin")
        print("PY:   color : 6位十六进制颜色值（例如 ff0000）")
        sys.exit(1)

    name = sys.argv[1].strip()
    state_arg = sys.argv[2].strip()
    color_hex = sys.argv[3].strip().lower()

    # 解析state
    if state_arg == "1":
        state = True   # thick
    elif state_arg == "0":
        state = False  # thin
    else:
        print("PY: 错误：state 必须为 1 (thick) 或 0 (thin)")
        sys.exit(1)

    # 调用处理函数
    process_fluid_material(name, state, color_hex)

if __name__ == "__main__":
    main()
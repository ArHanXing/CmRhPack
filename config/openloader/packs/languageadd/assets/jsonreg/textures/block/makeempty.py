#!/usr/bin/env python3
"""
generate_white_texture.py

用法：
    python generate_white_texture.py <文件名>

说明：
    在当前目录下生成一个 16x16 像素的纯白 PNG 图片。
    如果文件名不包含 .png 扩展名，会自动添加。
"""

import sys
import os
from PIL import Image

def main():
    if len(sys.argv) != 2:
        print("错误：请提供一个文件名。")
        print(f"用法: {sys.argv[0]} <文件名>")
        sys.exit(1)

    name = sys.argv[1]
    # 如果文件名没有 .png 后缀，则自动添加
    if not name.lower().endswith('.png'):
        name += '.png'

    # 创建 16x16 纯白 RGB 图像
    img = Image.new('RGB', (16, 16), color=(255, 255, 255))

    # 保存到当前目录
    img.save(name)
    print(f"已生成纯白图片: {os.path.abspath(name)}")

if __name__ == "__main__":
    main()
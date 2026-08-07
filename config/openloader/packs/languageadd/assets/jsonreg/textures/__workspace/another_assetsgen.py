# 完全由DeepSeek Reasoner输出！
import os
import shutil
from PIL import Image

def main():
    # 定义路径
    material_set_dir = "material_set"
    script_dir = os.path.dirname(os.path.abspath(__file__))
    material_set_path = os.path.join(script_dir, material_set_dir)
    
    # 步骤1: 列出所有材质类别（排除__models）
    print("PY: 材质类别：")
    categories = []
    for item in os.listdir(material_set_path):
        item_path = os.path.join(material_set_path, item)
        if os.path.isdir(item_path) and item != "__models":
            categories.append(item)
            print(f"PY: - {item}")
    
    # 用户选择材质类别
    material_type = input().strip()
    
    # 步骤2: 列出该材质类别下的所有子材质
    material_dir = os.path.join(material_set_path, material_type)
    if not os.path.isdir(material_dir):
        print(f"PY: 错误：材质类别 '{material_type}' 不存在")
        return
    
    # 收集所有子材质基础名（忽略大小写）
    base_names = set()
    png_files = [f for f in os.listdir(material_dir) if f.lower().endswith('.png')]
    
    for f in png_files:
        name = os.path.splitext(f)[0]  # 移除.png
        name_lower = name.lower()
        
        # 处理带后缀的文件
        if name_lower.endswith('_overlay'):
            base_name = name_lower[:-8]
            base_names.add(base_name)
        elif name_lower.endswith('_secondary'):
            base_name = name_lower[:-10]
            base_names.add(base_name)
        else:
            base_names.add(name_lower)
    
    base_names = sorted(base_names)
    
    # 输出子材质列表
    print("PY: 检测到子材质：")
    for name in base_names:
        print(f"PY: - {name}")
    
    # 用户选择子材质
    selection = input().split()
    n = int(selection[0])
    selected_submaterials = selection[1:1+n]
    
    # 验证选择的子材质
    invalid = [name for name in selected_submaterials if name.lower() not in base_names]
    if invalid:
        print(f"PY: 错误：无效的子材质 {', '.join(invalid)}")
        return
    
    # 用户输入颜色
    print("PY: 色相：")
    color_str = input().strip().lower()
    if len(color_str) != 6 or not all(c in "0123456789abcdef" for c in color_str):
        print("PY: 错误：颜色格式应为6位十六进制字符串 (rrggbb)")
        return
    
    try:
        target_r = int(color_str[0:2], 16)
        target_g = int(color_str[2:4], 16)
        target_b = int(color_str[4:6], 16)
    except ValueError:
        print("PY: 错误：无效的颜色值")
        return
    
    # 为每个子材质获取新名称
    new_names = {}
    for submat in selected_submaterials:
        new_name = input(f"PY: 正在处理 {submat} 更名为? ").strip()
        new_names[submat] = new_name
    
    # 定义输出目录
    texture_subdir = "fluid" if material_type == "fluid" else "item"
    
    # 创建输出目录（只需要纹理目录，模型目录不再需要）
    os.makedirs(os.path.join(script_dir, "textures", texture_subdir), exist_ok=True)
    
    # 处理每个选中的子材质
    for submat in selected_submaterials:
        new_name = new_names[submat]
        print(f"PY: 处理子材质: {submat} -> {new_name}")
        
        # ---- 1. 处理主纹理（无后缀）：上色并保存，保留图像对象用于后续叠加 ----
        main_png_filename = f"{submat}.png"
        main_png_path = None
        for f in png_files:
            if f.lower() == main_png_filename.lower():
                main_png_path = os.path.join(material_dir, f)
                break
        
        if not main_png_path or not os.path.exists(main_png_path):
            print(f"  警告：未找到主纹理 {main_png_filename}，跳过")
            continue
        
        # 上色处理主纹理
        img = Image.open(main_png_path).convert("RGBA")
        datas = img.getdata()
        new_data = []
        for item in datas:
            gray = item[0]
            new_r = int((gray / 255.0) * target_r)
            new_g = int((gray / 255.0) * target_g)
            new_b = int((gray / 255.0) * target_b)
            new_data.append((new_r, new_g, new_b, item[3]))
        
        colored_main = Image.new("RGBA", img.size)
        colored_main.putdata(new_data)
        
        # 保存上色后的主纹理
        new_main_filename = f"{new_name}.png"
        new_main_path = os.path.join(script_dir, "textures", texture_subdir, new_main_filename)
        colored_main.save(new_main_path)
        print(f"  保存纹理: {new_main_filename}")
        
        # 复制主纹理的mcmeta（如果存在）
        main_mcmeta_filename = f"{submat}.png.mcmeta"
        for f in os.listdir(material_dir):
            if f.lower() == main_mcmeta_filename.lower():
                src = os.path.join(material_dir, f)
                dst = os.path.join(script_dir, "textures", texture_subdir, f"{new_name}.png.mcmeta")
                shutil.copy2(src, dst)
                print(f"  复制元数据: {os.path.basename(dst)}")
                break
        
        # ---- 2. 处理 _overlay 和 _secondary 变体：不涂色，直接叠加 ----
        for suffix in ["_overlay", "_secondary"]:
            variant_filename = f"{submat}{suffix}.png"
            variant_path = None
            for f in png_files:
                if f.lower() == variant_filename.lower():
                    variant_path = os.path.join(material_dir, f)
                    break
            
            if not variant_path or not os.path.exists(variant_path):
                continue
            
            # 打开原始变体（保持原样，不做颜色变换）
            variant_img = Image.open(variant_path).convert("RGBA")
            
            # 叠加到上色后的主纹理上
            # 复制一份上色主纹理，避免修改原对象（后续可能还要用于其他变体）
            combined = colored_main.copy()
            combined.paste(variant_img, (0, 0), variant_img)
            
            # 保存叠加结果
            new_variant_filename = f"{new_name}{suffix}.png"
            new_variant_path = os.path.join(script_dir, "textures", texture_subdir, new_variant_filename)
            combined.save(new_variant_path)
            print(f"  保存纹理（叠加）: {new_variant_filename}")
            
            # 复制变体的mcmeta（如果有）
            variant_mcmeta_filename = f"{submat}{suffix}.png.mcmeta"
            for f in os.listdir(material_dir):
                if f.lower() == variant_mcmeta_filename.lower():
                    src = os.path.join(material_dir, f)
                    dst = os.path.join(script_dir, "textures", texture_subdir, f"{new_name}{suffix}.png.mcmeta")
                    shutil.copy2(src, dst)
                    print(f"  复制元数据: {os.path.basename(dst)}")
                    break
    
    print("PY: 处理完成！文件已输出到 textures/ 目录")

if __name__ == "__main__":
    main()
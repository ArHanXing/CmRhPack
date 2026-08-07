# 完全由qwen3输出！
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
    model_subdir = "fluid" if material_type == "fluid" else "item"
    
    # 创建输出目录
    os.makedirs(os.path.join(script_dir, "textures", texture_subdir), exist_ok=True)
    os.makedirs(os.path.join(script_dir, "models", model_subdir), exist_ok=True)
    
    # 处理每个选中的子材质
    for submat in selected_submaterials:
        new_name = new_names[submat]
        print(f"PY: 处理子材质: {submat} -> {new_name}")
        
        # 处理所有变体（主图、overlay、secondary）
        for suffix in ["", "_overlay", "_secondary"]:
            # 构建PNG文件名（大小写不敏感处理）
            png_filename = f"{submat}{suffix}.png"
            png_path = None
            for f in png_files:
                if f.lower() == png_filename.lower():
                    png_path = os.path.join(material_dir, f)
                    break
            
            if not png_path or not os.path.exists(png_path):
                continue
            
            # 上色处理
            img = Image.open(png_path)
            img = img.convert("RGBA")
            datas = img.getdata()
            new_data = []
            
            for item in datas:
                # 灰度值（取R通道，因为是灰度图）
                gray = item[0]
                # 计算新颜色（保持alpha通道）
                new_r = int((gray / 255.0) * target_r)
                new_g = int((gray / 255.0) * target_g)
                new_b = int((gray / 255.0) * target_b)
                new_data.append((new_r, new_g, new_b, item[3]))
            
 # 保存新PNG
            new_img = Image.new("RGBA", img.size)
            new_img.putdata(new_data)
            new_png_filename = f"{new_name}{suffix}.png"
            new_png_path = os.path.join(script_dir, "textures", texture_subdir, new_png_filename)
            new_img.save(new_png_path)
            print(f"  保存纹理: {new_png_filename}")
            
            # 处理MCmeta文件
            mcmeta_filename = f"{submat}{suffix}.png.mcmeta"
            for f in os.listdir(material_dir):
                if f.lower() == mcmeta_filename.lower():
                    src = os.path.join(material_dir, f)
                    dst = os.path.join(script_dir, "textures", texture_subdir, f"{new_name}{suffix}.png.mcmeta")
                    shutil.copy2(src, dst)
                    print(f"  复制元数据: {os.path.basename(dst)}")
                    break
        
        # 处理模型文件
        model_dir = os.path.join(material_set_path, "__models", material_type)
        model_filename = f"{submat}.json"
        model_path = None
        
        if os.path.isdir(model_dir):
            for f in os.listdir(model_dir):
                if f.lower() == model_filename.lower():
                    model_path = os.path.join(model_dir, f)
                    break
        
        if model_path and os.path.exists(model_path):
            new_model_filename = f"{new_name}.json"
            dst = os.path.join(script_dir, "models", model_subdir, new_model_filename)
            shutil.copy2(model_path, dst)
            print(f"  复制模型: {new_model_filename}")
    
    print("PY: 处理完成！文件已输出到 textures/ 和 models/ 目录")

if __name__ == "__main__":
    main()

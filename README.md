# 本整合包由 AI 生成。
作者宣布自己几乎没有在开发中提供正向内容。

# CmRhPack
不会告诉你`CmRh`是`锔铑`的意思。嗯，玩了这个包并吃下了这一坨， ~~你就变成了赤石界巨佬~~

核心：Minecraft 1.21.1, **Fabric 0.19.5**。
## 开发或游玩
在 PCL 中下载一个命名为`CmRhPack`的 1.21.1+Fabric 0.19.5 版本，然后直接将本仓库复制过去。

同时你也可以导入 release 中的稳定版本 mrpack 包（if exist）
## 阶段与内容
这个整合包是基于 Oritech 和 TechReborn 的 ~~超稀有高版本 Fabric 科技包！~~（
- **Tier1** EarlyStage，TR炼钢，Oritech末影化合物，TR基础机器，TR石油线，T1主机，T2电路板，精致存储，Botania符文祭坛，Affinity物质收获炉，杜鹃仪式。
- **Tier2** 白铜线圈，工业高炉，T2马达，镍铬合金线圈，精密组装，改良并行机器，昶铂线圈，虚空矿机，Aff生魂融合，Bot泰拉钢，精灵门，泰拉钢机器外壳，永恒星光，金红石处理/钨处理，原子锻炉，硅晶圆，环氧树脂，T2电路主机，T3电路板。
- **Tier3** 末地，硅岩处理，硅岩/凯金线圈，太空电梯，三钛线圈，聚苯并咪唑，异星生物培养，盖亚魂锭 -> 盖亚魂灵处理，戴森云，海森堡补偿器，稳定盖亚魂锭，DTPF，无尽锭，超导线圈，Tier3主机，**Neko Technology**，**无尽贪婪**。
## 鸣谢
- 猫窝翻转宇宙服务器的大家，发现了大量随着时间出现的bug！
- `CrystalNeko` 开发的 `JustARod`
- 许多自定义材质来源于 [GT Refreshed](https://modrinth.com/resourcepack/gregtech-refreshed)！
- 许多自定义材质来源于 [GT Leisure](https://www.mcmod.cn/modpack/769.html)！
- 本包使用了来自 `That_DogNugget` 大佬的 Affinity 汉化包！
- 本包默认使用 `wil` 佬的 AE2 GUI 材质包，部分新AE风格UI材质亦来源于 `Xingluo` 的 AE2 1.21 GUI Expansion 材质包！
- 本包部分外来数据包经由 OpenLoader 全局加载，目前包含「更改试炼密室生成维度：永恒星光」（作者 `如果`）！
- 部分材质出自 [光谱世界](https://github.com/DaFuqs/Spectrum)
## Bug & Mod Config
- **单人时建议启用 Java25+ 并在 JVM 参数中填写 `--add-modules=jdk.incubator.vector` 来启用 SIMD 地形生成优化。**
- `Fuji` 模组是仅单人游玩时需要的，加入服务器时，确保**你已经将其关闭！**
- 作者的电脑上，一次冷启动预期在 ~45s 左右
- 本包**自带矿透**且建议使用矿透来获得更好的体验
- /rtpback指令不会生效，建议使用/back
- 由于Fabric和RS的indev特性，一切关于存储与传输内容都可能会比较不稳定
- **服务器玩家，对cpu0有信心的可以移除 `c2me-engine` 游玩，并建议减少不同mod之间在存储上的混用**
- 多人游戏下CrT可能无法正确显示Tooltip
- 超立方体**不建议用于能量传输**（曾经出现过和TR线缆连接后崩服的bug）。**若需要使用，确保不要使用「同时输入输出」的选项，可能会导致连接的线缆无限和超立方体互换电能导致崩服！**
- 不兼容加速渲染
## 主要魔改
- 半个专家包，主线难度可能略难于ATM9。
- 移除了很多轮椅，例如碳粉复制单元、空单元蒸馏柴油、堆叠裂变堆主机复制发电量
- 格雷风格矿脉生成和原版生成同时存在，且矿脉生成固定，不需要找
- 早期加入了 EarlyStage，例如燧石工具等，不再能空手砍树
- TR和OR融合的早期科技
- 每个阶段都加入了马达、传送带、机械臂等机械零件
- 新小机器：车床、碎岩机、数字型采矿机
- 完全重构的统一矿物处理链路，最终可达12倍线（虽然很昂贵就是了）
- 更加优秀的OR/TR兼容性
- 完全重构的石化线制造聚乙烯、聚四氟乙烯、环氧树脂、聚苯并咪唑，还有生物发酵逃课塑料
- 更复杂的电路板合成
- 虚空世界，家园维度
- 石化发电链路，又是一个平衡难题
- 更好的 Jade 兼容，在HUD里即可获得机器的IO、并行、耗时等数据
- 并行大机器，所有的TR配方、部分OR配方都获得了16并行的多方块机器来提高产能
- 移植 GT5 的线圈热量系统的工业高炉，随着热量变化获得时间减成
- Affinity $\times$ Botania 轻度融合的魔法线，**允许魔力互传**、能量互用、更多兼容性配方
- 完全重构的核燃料系统以及重新平衡的裂变反应堆，包含新堆元件──热回收口，新机器──同位素离心机
- 虚空采矿机，支持主要矿物，甚至是下界残骸
- 永恒星光──试炼密室也被移动到了这里，包含新矿物──金红石及其特别处理
- 末地──获得硅岩以及新的处理线路
### Also See...
[HanXingReborn](https://github.com/ArHanXing/HanXingReborn), 为本整合包定制的 Tech Reborn 版本

[cmrh-affinity](https://github.com/ArHanXing/cmrh-affinity), 为本整合包定制的 Affinity 版本

[Oritech-CmRhTweak](https://github.com/ArHanXing/Oritech-cmrh), 为本整合包定制的 Oritech 版本

[OR裂变堆规划器](https://arhanxing.github.io/Oritech-cmrh/)，为本整合包定制的 Oritech Reactor Planner

## 服务端mod
- Ledger 类似于CoreProtect，查熊
- EasyAuth 账号系统
```
JDK: Temurin 26
-server -XX:+UseStringDeduplication -XX:+UseCompactObjectHeaders -XX:+UnlockDiagnosticVMOptions -XX:+EnableX86ECoreOpts  -Dlog4j2.formatMsgNoLookups=true -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1
```
不要更新
- 钠相关
- EMI/JEI相关
- owo-lib
- 稳态
- fast noise（引入无谓配置库zconfig）
- more culling

打包：
- 删除 `fuji/backup` `fuji/cache` `fuji/modules/home`
- 调回快捷键 N 和 Q
- 移除 ctgui
- 移除 voxy 自编译版本

---
# 我们的一生皆是征途！

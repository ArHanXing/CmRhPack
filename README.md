# CmRhPack
不会告诉你`CmRh`是`锔铑`的意思。嗯，玩了这个包并吃下了这一坨， ~~你就变成了赤石界巨佬~~

核心：Minecraft 1.21.1, **Fabric 0.19.2**。
## 开发或游玩
在PCL中下载一个命名为`CmRhPack`的1.21.1+Fabric 0.19.2版本，然后直接将本仓库(或者release的source-code.zip)复制过去。

同时你也可以导入 release 中的稳定版本 mrpack
## 阶段与内容
这个整合包是基于 Oritech 和 TechReborn 的 ~~超稀有高版本 Fabric 科技包！~~（
- Tier 0 捡石头，挖矿，基础积累。
- Tier1 EarlyStage，TR炼钢，Oritech基础机器，末影化合物，TR基础机器，TR石油线，T1主机/T2电路板，精致存储，Botania符文祭坛，Affinity物质收获炉，杜鹃仪式。
- Tier2 白铜线圈，工业高炉，T2马达，镍铬合金线圈，精密组装，改良并行机器，昶铂线圈，虚空矿机，Aff生魂融合，Bot泰拉钢，精灵门，泰拉钢机器外壳，永恒星光，金红石/钨处理，原子锻炉，硅晶圆，环氧树脂，T2电路主机/T3电路板。
- Tier3 末地，硅岩处理，硅岩/凯金线圈，聚变反应堆，PBI，太空电梯，三钛线圈，异星生物培养，盖亚魂锭 -> 盖亚魂灵处理，海森堡补偿器，硅岩反应堆，稳定盖亚魂锭，DTPF，无尽锭，超导线圈，T3主机。
## 鸣谢
- 猫窝翻转宇宙服务器的大家，发现了大量随着时间出现的bug！
- `CrystalNeko` 开发的 `JustARod`
- 许多自定义材质来源于 [GT Refreshed](https://modrinth.com/resourcepack/gregtech-refreshed)！
- 许多自定义材质来源于 [GT Leisure](https://www.mcmod.cn/modpack/769.html)！
- 本包默认内置了 `That_DogNugget` 大佬的 Affinity 汉化包，以及 `wil` 的 AE2 GUI 材质包！部分新AE风格UI材质亦来源于 Xingluo 的 AE21.21GUIExpansion for 1.20.1 材质包！
## Bug
- 由于Fabric和RS的indev特性，一切存储与传输内容都可能会比较不稳定。~~已经使用[某暴力防崩mod](https://www.mcmod.cn/class/10051.html)优化~~
- **服务器玩家，对cpu0有信心的可以移除 `c2me-engine` 游玩，并建议减少不同mod之间在存储上的混用**
- 多人游戏下CrT无法正确显示Tooltip
- /rtpback指令不会生效，建议使用/back
- 超立方体**不建议用于能量传输**（曾经出现过和TR线缆连接后崩服的bug）。
## 关于Mods与配置
请你使用**你能找到的版本最高的Java**，因为Java26对G1GC做出了优化（
单人游戏就把 Fuji 打开，**多人就关掉**，该mod相当于EssentialX插件（进入服务器使用会报错）。
### 可选客户端mod
**在游玩前建议选择你需要的mod**，包含美化、可选优化、调试功能等。
它们在mod目录里以 `!` 开头标识。

- Modern UI 提供字体优化
- Memory Usage Title 在标题栏显示内存占用
- FerriteCore 用帧率换内存占用降低许多
- Inventory Sorter 轻量的物品栏整理
- freecam 灵魂出窍
- visual keys 键盘形式的可视化按键绑定，十分有用
- spark 火花/性能监视

另外，不兼容加速渲染.
### 服务端mod
- Ledger 类似于CoreProtect，查熊
- EasyAuth 账号系统
- PlayerNameTweak 允许中文名

```
JDK: Temurin 26
-server -XX:+UseStringDeduplication -XX:+UseCompactObjectHeaders -XX:+UnlockDiagnosticVMOptions -XX:+EnableX86ECoreOpts  -Dlog4j2.formatMsgNoLookups=true -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1
```
# 不要更新
# 钠相关，EMI/JEI相关，owo-lib，稳态，fast noise（引入配置库）


### Also See...
[HanXingReborn](https://github.com/ArHanXing/HanXingReborn), 为本整合包定制的 Tech Reborn 版本

[cmrh-affinity](https://github.com/ArHanXing/cmrh-affinity), 为本整合包定制的 Affinity 版本
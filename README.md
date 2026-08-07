# CmRhPack
不会告诉你`CmRh`是`锔铑`的意思。嗯，玩了这个包并吃下了这一坨， ~~你就变成了赤石界巨佬~~

核心：Minecraft 1.21.1, **Fabric 0.19.2**。
## 开发或游玩
在PCL中下载一个命名为`CmRhPack`的1.21.1+Fabric 0.19.2版本，然后直接将本仓库(或者release的source-code.zip)复制过去。

同时你也可以导入 release 中的稳定版本 mrpack
## 阶段与内容
这个整合包是基于 Oritech 和 TechReborn 的 ~~超稀有高版本 Fabric 科技包！~~（
- Tier 0 捡石头，挖矿，基础积累。
- Tier 1 锻铁和炼钢，Oritech锻造机，T1机械外壳与电路，塑料与石化产线/聚乙烯，末影激光臂，精致存储。
- Tier 2 纳米套，原子锻造（激光蚀刻），虚空采矿，星光探索，环氧树脂/聚苯并咪唑，T2/3电路与外壳，硅岩处理，粒子加速器，末地探索，UU物质，钷处理。
- Tier 3 TR聚变堆，量子套，龙处理，无尽奇点和无尽锭。
## 鸣谢
- 猫窝翻转宇宙服务器的大家，发现了大量随着时间出现的bug！
- `CrystalNeko` 开发的 `JustARod`
- 许多自定义材质来源于 [GT Refreshed](https://modrinth.com/resourcepack/gregtech-refreshed)！
- 许多材质来源于 [GT Leisure](https://www.mcmod.cn/modpack/769.html)！
- 本包默认内置了 `That_DogNugget` 大佬的 Affinity 汉化包，以及 `wil` 的 AE2 GUI 材质包！部分新AE风格UI材质亦来源于 Xingluo 的 AE21.21GUIExpansion for 1.20.1 材质包！
## Bug
- 由于Fabric和RS的indev特性，一切存储与传输内容都可能会比较不稳定。~~已经使用[某暴力防崩mod](https://www.mcmod.cn/class/10051.html)优化~~
- **服务器玩家，对cpu0有信心的可以移除 `c2me-engine` 游玩，并建议减少不同mod之间在存储上的混用**
- 多人游戏下CrT无法正确显示Tooltip
- 进入游戏时（似乎）不能将窗口放在后台
- Affinity的仪式很有可能因神秘原因无法进行
- /rtpback指令不会生效，建议使用/back
- 超立方体**不建议用于能量传输**（曾经出现过和TR线缆连接后崩服的bug）。
## 关于Mods与配置
请你使用**你能找到的版本最高的Java**，因为Java26对G1GC做出了优化（
单人游戏就把 Fuji 打开，**多人就关掉**，该mod相当于EssentialX插件（进入服务器使用会报错）。
### 可选客户端mod
**在游玩前建议选择你需要的mod**，包含美化、可选优化、调试功能等。
它们在mod目录里以 `!` 开头标识。

- Modern UI 提供字体优化
- JEIAsync 默认关闭，具有 async 后缀的那一个。该模组加速EMI配方重载，但是**会导致不可预知的Bug（例如重载后进不去服务器），谨慎使用！**
- Memory Usage Title 在标题栏显示内存占用
- FerriteCore 用帧率换内存占用降低许多
- Inventory Sorter 轻量的物品栏整理
- freecam 灵魂出窍
- visual keys 键盘形式的可视化按键绑定，十分有用
- sparkle 火花/性能监视
- ctgui CrT工作台配方快速编辑

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
# 钠相关，EMI/JEI相关，owo-lib，稳态


### Also See...
[HanXingReborn](https://github.com/ArHanXing/HanXingReborn), 为本整合包定制的 Tech Reborn 版本
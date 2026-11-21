# 本整合包由 AI 生成。
作者宣布自己几乎没有在开发中提供正向内容。

# 整合包不再活跃更新
学好真实化学比加几个自动化挑战有用多了。

# CmRhPack
不会告诉你 `CmRh` 是 `锔铑` 的意思。嗯，玩了这个包并吃下了这一坨， ~~你就变成了赤石界巨佬~~

核心：Minecraft 1.21.1, **Fabric 0.20.1**。

## 开发或游玩
在 PCL 中下载一个命名为 `CmRhPack` 的 1.21.1+Fabric 0.20.1 版本，然后直接将本仓库复制过去。

同时你也可以导入 release 中的稳定版本 mrpack 包（如果有的话）

## 阶段与内容
这个整合包是基于 Oritech 和 TechReborn 的 ~~超稀有高版本 Fabric 科技包！~~（
- **Tier1** EarlyStage，TR炼钢，Oritech末影化合物，TR基础机器，TR石油线，T1主机，T2电路板，精致存储，Botania符文祭坛，Affinity物质收获炉，杜鹃仪式。
- **Tier2** 白铜线圈，工业高炉，T2马达，镍铬合金线圈，精密组装，改良并行机器，昶铂线圈，虚空矿机，Aff生魂融合，Bot泰拉钢，精灵门，泰拉钢机器外壳，永恒星光，金红石处理/钨处理，盖亚守护者，原子锻炉，硅晶圆，环氧树脂，T2电路主机，太空电梯T1。
- **Tier3** 硅岩处理，T3电路板，硅岩/凯金线圈，太空电梯T2，三钛线圈，聚苯并咪唑，戴森云，EHOF/空间翘曲器，暗物质，极限超导线圈，Tier3主机，**Neko Technology**，**无尽贪婪**。

## Bug & Mod Config
- **单人时建议启用 Java25+ 并在 JVM 参数中填写 `--add-modules=jdk.incubator.vector` 来启用 SIMD 地形生成优化。**
- `Fuji` 模组是仅单人游玩时需要的，加入服务器时，确保**你已经将其关闭！**
- 作者的电脑上，一次冷启动预期在 ~45s 左右。如果后台比较多可能在60s左右，耐心等待喵
- 本包**自带矿透**且建议使用矿透来获得更好的体验
- /rtpback指令不会生效，建议使用/back
- 由于Fabric和RS的indev特性，一切关于存储与传输内容都可能会比较不稳定
- **服务器玩家，对cpu0有信心的可以移除 `c2me-engine` 游玩，并建议减少不同mod之间在存储上的混用**
- 多人游戏下CrT可能无法正确显示Tooltip
- 超立方体**不建议用于能量传输**（曾经出现过和TR线缆连接后崩服的bug）。**若需要使用，确保不要使用「同时输入输出」的选项，可能会导致连接的线缆无限和超立方体互换电能导致崩服！**
- 不兼容加速渲染

### 其他组分
以上或者以下的项目，都来源于 AI 生成

[HanXingReborn](https://github.com/ArHanXing/HanXingReborn), 为本整合包定制的 Tech Reborn 版本

[cmrh-affinity](https://github.com/ArHanXing/cmrh-affinity), 为本整合包定制的 Affinity 版本

[Oritech-CmRhTweak](https://github.com/ArHanXing/Oritech-cmrh), 为本整合包定制的 Oritech 版本

[OR裂变堆规划器](https://arhanxing.github.io/Oritech-cmrh/)，为本整合包定制的 Oritech 核电规划器

[Ez2Rs](https://github.com/ArHanXing/ez2rs), 一个 Refined Storage 2 的拓展，主要加入 AE2WTLib 以及部分附属的QOL功能

[InGameInfo XML Port Edition](https://github.com/ArHanXing/InGameInfoXML-fabric)，复活了 InGameInfo XML，感谢 ZomGraves 此前的 neoforge 复活代码

## 鸣谢
- 猫窝翻转宇宙服务器的大家，发现了大量随着时间出现的bug！
- `CrystalNeko` 开发的 `JustARod`
- 许多自定义材质来源于 [GT Refreshed](https://modrinth.com/resourcepack/gregtech-refreshed)！
- 许多自定义材质来源于 [GT Leisure](https://www.mcmod.cn/modpack/769.html)！
- 来自 `That_DogNugget` 大佬的 Affinity 汉化包！
- 本包默认使用 `wil` 佬的 AE2 GUI 材质包，部分新AE风格UI材质亦来源于 `Xingluo` 的 AE2 1.21 GUI Expansion 材质包！
- 「更改试炼密室生成维度：永恒星光」（作者 `如果`）！
- 部分材质出自 [光谱世界](https://github.com/DaFuqs/Spectrum)

---

建议的 Java 参数（4GB内存）
```
JRE: Temurin 26
-server -XX:+UseG1GC -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:+PerfDisableSharedMem -XX:+UseCompactObjectHeaders -XX:+UseStringDeduplication -XX:MaxGCPauseMillis=150 -XX:G1HeapRegionSize=4M --add-modules=jdk.incubator.vector
```

不要更新
- 钠相关
- EMI/JEI相关
- owo-lib
- 稳态
- fast noise（引入无谓配置库zconfig）
- more culling
- RS2, RFS

打包：
- 删除 `fuji/backup` `fuji/cache` `fuji/modules/home`
- 调回快捷键 N 和 Q
- 移除 ctgui
- 移除 voxy 自编译版本
- 移除 workspace 的贴图
- 压缩 openloader 内的资源包，减小体积

## 服务端mod
- Ledger 类似于CoreProtect，查熊
- EasyAuth 账号系统
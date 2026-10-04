"""Oritech 反应堆模型：忠实复刻 `ReactorControllerBlockEntity.serverTick()`。

来源（**字节码 + 上游源码交叉验证**，非照抄模组文档）：
  · 上游 Rearth/Oritech 分支 1.21 的 ReactorControllerBlockEntity.java
  · 本包 mods/oritech-fabric-1.21.1-1.3.0-cmrh-preview.jar 反汇编核对
  · config/oritech-common.toml [reactor] 段

⚠️ 三个最容易搞错、且本模块已修正的点：

  1. **邻居是 4 邻（上下左右），不是 8 邻。**
     `getNeighborsInBounds` 只 add `(-1,0) (0,1) (1,0) (0,-1)`，`new HashSet<>(4)`。
     ⇒ 一根棒的 P 上限 = 内部脉冲 + 4 × 4 = 28（四联），**P=36 不可达**。

  2. **热量与冷却是"每层"（2D 剖面）量纲，与堆叠高度无关。**
     `componentHeats` 是 `HashMap<Vector2i, Integer>`；高度只乘【电量】与【耗料】。
     ⇒ 高度是纯吞吐倍率，效率中性（除非开了 heatHeightSlope）。

  3. **堆芯总脉冲 ≠ 棒数 × 单棒最大值。**
     只有中心棒能达到最大 P，边缘棒邻居更少 ⇒ 必须【逐棒求和】。
     例：十字 5 棒的 P 是 [28,16,16,16,16] = 92，不是 5×28=140（脚本曾高估 1.52×）。

`serverTick` 的原始结构（原地单缓冲遍历 HashMap）：

    for (entry : activeComponents) {
        componentHeat = componentHeats.get(pos)          // 读
        if (棒)   { 算 P；componentHeat += heatCreated }
        if (热管) { 从更热的邻居吸热 }
        if (吸收器){ 每个邻居 -= 16 }
        if (散热口){ 只对最热的那个邻居 -= min(h/100+4, h) }
        if (回收口){ 每个邻居 -= min(8, h) }
        componentHeats.put(pos, componentHeat)           // 写回
    }

注意是**原地**更新：先处理的组件会立刻影响后处理组件看到的邻居热。
HashMap 的迭代序因此有影响（二阶效应，稳态基本一致，但本模块用稳定序近似）。
"""
from __future__ import annotations

from dataclasses import dataclass, field

# ---------------------------------------------------------------- 常量

RF_PER_PULSE = 64

#: 棒型 -> (棒数, 内部脉冲)。取自 BlockContent 构造参数。
ROD_TYPES: dict[str, tuple[int, int]] = {
    "rod1": (1, 1),    # REACTOR_ROD
    "rod2": (2, 4),    # REACTOR_DOUBLE_ROD
    "rod4": (4, 12),   # REACTOR_QUAD_ROD
}

REFLECTOR = "reflector"
PIPE = "pipe"
VENT = "vent"
ABSORBER = "absorber"
RECOVERY = "recovery"

ROD_KINDS = frozenset(ROD_TYPES)
COOLING_KINDS = frozenset({VENT, ABSORBER, RECOVERY})

#: 4 邻（正交）。**不是 8 邻** —— 这是本包核电文档最大的历史错误来源。
NEIGHBORS_4 = ((-1, 0), (1, 0), (0, -1), (0, 1))


@dataclass
class ReactorConfig:
    """对应 config/oritech-common.toml 的 [reactor] 段（默认值）。"""

    rf_per_pulse: int = 64
    absorber_rate: int = 16
    vent_base_rate: int = 4
    vent_relative_rate: int = 100
    max_heat: int = 2000
    max_unstable_ticks: int = 600
    recovery_rate: int = 8
    rf_per_heat: int = 2
    heat_height_slope: float = 0.0

    def heat_height_mult(self, height: int) -> float:
        """`heatHeightMult()`：1.0 + (height-1)*slope，下限 0.01。"""
        return max(0.01, 1.0 + (height - 1) * self.heat_height_slope)


DEFAULT = ReactorConfig()

# ---------------------------------------------------------------- 剖面

Grid = dict[tuple[int, int], str]


def neighbors(grid: Grid, pos: tuple[int, int]) -> list[tuple[int, int]]:
    """`getNeighborsInBounds`：只返回【在剖面内】的 4 邻。"""
    x, y = pos
    return [(x + dx, y + dy) for dx, dy in NEIGHBORS_4 if (x + dx, y + dy) in grid]


def pulse_of(grid: Grid, pos: tuple[int, int]) -> int:
    """单根棒的 P：内部脉冲 + Σ(邻棒棒数) + Σ(反射器 -> 本棒棒数)。"""
    kind = grid.get(pos)
    if kind not in ROD_TYPES:
        return 0
    own_rods, internal = ROD_TYPES[kind]
    total = internal
    for n in neighbors(grid, pos):
        nk = grid[n]
        if nk in ROD_TYPES:
            total += ROD_TYPES[nk][0]      # 邻棒送【它自己】的棒数
        elif nk == REFLECTOR:
            total += own_rods              # 反射器送【本棒】的棒数
    return total


def heat_of(pulses: int) -> int:
    """`(pulses / 2) * pulses + 4`，整数除法。"""
    return (pulses // 2) * pulses + 4


def pulses_by_rod(grid: Grid) -> dict[tuple[int, int], int]:
    """逐棒 P。**必须逐棒求和**，不能拿棒数乘最大值。"""
    return {p: pulse_of(grid, p) for p in grid if grid[p] in ROD_TYPES}


def max_pulse(kind: str) -> int:
    """该棒型在 4 邻下的理论最大 P（4 个邻居全是四联棒）。"""
    _, internal = ROD_TYPES[kind]
    return internal + 4 * ROD_TYPES["rod4"][0]


# ---------------------------------------------------------------- 堆芯统计


@dataclass
class CoreStats:
    rods: int
    total_pulses: int
    rf_per_tick: int          # 每层
    heat_per_tick: int        # 每层
    pulses: dict = field(default_factory=dict)
    kinds: list = field(default_factory=list)

    @property
    def rf_per_heat(self) -> float:
        return self.rf_per_tick / self.heat_per_tick if self.heat_per_tick else 0.0

    def rf_per_tick_at(self, height: int) -> int:
        return self.rf_per_tick * height

    def rf_per_tick_capped(self, height: int, ports: int = 1, port_cap: int = 32768) -> int:
        """实际可输出：`outputEnergy()` 里 `maxRatePerSlot` 是【逐端口】应用的。"""
        return min(self.rf_per_tick_at(height), ports * port_cap)

    def rods_per_hour(self, capacity: int, height: int = 1) -> float:
        """耗料只跟【棒数】和高度有关，与 P 无关 —— 这是核电最重要的性质。

        每根棒方块每 tick 吃 `rodCount * height`；燃料丸容量 = 配方 time。
        ⇒ 该棒烧完一颗丸需 `time / rodCount` tick，每小时吃 `72000*rodCount/time` 颗。
        整堆按【逐棒】求和（不同棒型的 rodCount 不同）。
        """
        ticks_per_hour = 72000
        return sum(
            ticks_per_hour * ROD_TYPES[kind][0] * height / capacity
            for kind in self.kinds
        )


def core_stats(grid: Grid) -> CoreStats:
    """堆芯的每层电/热。**逐棒求和**（不可用棒数 × 最大值）。"""
    by_rod = pulses_by_rod(grid)
    tp = sum(by_rod.values())
    return CoreStats(
        rods=len(by_rod),
        total_pulses=tp,
        rf_per_tick=tp * RF_PER_PULSE,
        heat_per_tick=sum(heat_of(p) for p in by_rod.values()),
        pulses=by_rod,
        kinds=[grid[p] for p in by_rod],
    )


# ---------------------------------------------------------------- 模拟


@dataclass
class SimResult:
    steady_heat: float
    melted: bool
    ticks: int
    peak_heat: float


def simulate(
    grid: Grid,
    height: int = 1,
    cfg: ReactorConfig = DEFAULT,
    max_ticks: int = 20000,
    stable_ticks: int = 200,
) -> SimResult:
    """逐 tick 复刻 serverTick 的热演化，返回稳态最高热。

    用于回答「这个剖面能不能压住热」——这是 4 邻下最关键的可行性判据。
    """
    mult = cfg.heat_height_mult(height)
    heat: dict[tuple[int, int], int] = {p: 0 for p in grid}
    order = list(grid.keys())          # 稳定序近似 HashMap 迭代序
    unstable = 0
    peak = 0.0
    stable = 0
    last = None

    for tick in range(max_ticks):
        for pos in order:
            kind = grid[pos]
            ch = heat[pos]

            if kind in ROD_TYPES:
                ch += int(heat_of(pulse_of(grid, pos)) * mult)

            elif kind == PIPE:
                for n in neighbors(grid, pos):
                    nh = heat[n]
                    if nh <= ch:
                        continue
                    diff = nh - ch
                    gain = min(diff // 4 + 10, diff)
                    heat[n] = nh - gain
                    ch += gain

            elif kind == ABSORBER:
                # 源码无下限钳制：neighborHeat -= ABSORBER_RATE 可以变负
                for n in neighbors(grid, pos):
                    if heat[n] <= 0:
                        continue
                    heat[n] = heat[n] - cfg.absorber_rate

            elif kind == VENT:
                cand = neighbors(grid, pos)
                if cand:
                    hot = max(cand, key=lambda n: heat[n])
                    nh = heat[hot]
                    if nh > 0:
                        removed = min(
                            nh // cfg.vent_relative_rate + cfg.vent_base_rate, nh
                        )
                        heat[hot] = nh - removed

            elif kind == RECOVERY:
                for n in neighbors(grid, pos):
                    nh = heat[n]
                    if nh <= 0:
                        continue
                    heat[n] = nh - min(cfg.recovery_rate, nh)

            heat[pos] = ch

        hottest = max(heat.values()) if heat else 0
        peak = max(peak, hottest)
        over = hottest / mult > cfg.max_heat

        if over:
            # ⚠️ 超温时【不能】走下面的"稳定即退出"捷径：
            # 热量可能稳定在一个 > maxHeat 的平衡点，那仍然会在 600 tick 后熔毁。
            unstable += 1
            if unstable > cfg.max_unstable_ticks:
                return SimResult(hottest, True, tick, peak)
            stable = 0
        else:
            unstable = 0
            if hottest == last:
                stable += 1
                if stable >= stable_ticks:
                    break
            else:
                stable = 0
        last = hottest

    return SimResult(max(heat.values()) if heat else 0, False, tick, peak)


# ---------------------------------------------------------------- 典型堆芯

def _rect(w: int, h: int, kind: str = "rod4") -> Grid:
    return {(x, y): kind for x in range(w) for y in range(h)}


def _ring(inner: Grid, pad: int = 1, kind: str = REFLECTOR) -> Grid:
    xs = [p[0] for p in inner]
    ys = [p[1] for p in inner]
    g = dict(inner)
    for x in range(min(xs) - pad, max(xs) + pad + 1):
        for y in range(min(ys) - pad, max(ys) + pad + 1):
            if (x, y) not in g:
                g[(x, y)] = kind
    return g


#: 4 邻下**真正可达**的堆芯（不含任何 8 邻产物）
CANONICAL_CORES: dict[str, Grid] = {
    "单根四联": {(0, 0): "rod4"},
    "十字 5 棒": {(0, 0): "rod4", (1, 0): "rod4", (-1, 0): "rod4",
                  (0, 1): "rod4", (0, -1): "rod4"},
    "2x2 四联": _rect(2, 2),
    "3x3 四联": _rect(3, 3),
    "4x4 四联": _rect(4, 4),
    "5x5 四联": _rect(5, 5),
    "3x3 四联 + 反射器": _ring(_rect(3, 3)),
}


if __name__ == "__main__":
    print("4 邻下各棒型的理论 P 上限：")
    for k in ROD_TYPES:
        print(f"  {k}: {max_pulse(k)}")
    print()
    print(f"{'堆芯':22} {'棒':>3} {'总P':>5} {'RF/t(每层)':>11} {'热(每层)':>9} {'RF/heat':>8}")
    for name, g in CANONICAL_CORES.items():
        s = core_stats(g)
        print(f"{name:22} {s.rods:3} {s.total_pulses:5} {s.rf_per_tick:11,} "
              f"{s.heat_per_tick:9,} {s.rf_per_heat:8.2f}")

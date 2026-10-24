# HateNeko

**KittenN（探月编程 / KN）作品 → LÖVE 11.5 的编译器与运行时。**

当前版本 **`0.2.0`**：核心运行时、Python 编译器、回归测试、单作品打包链路已可用；
硬件/在线 AI 类积木、真机视觉/音频/触摸验收仍在进行中。

## 快速开始

环境：Python 3、Lua 5.1、LuaJIT、LÖVE 11.5（真机/桌面运行需要）。

**一条命令搞定：作品名即可，不用写路径**（把 `.bcmkn` 放进 `bcmkn/`，名字就是作品名）：

```sh
# 仓库根目录
./kn build mywork        # bcmkn/mywork.bcmkn → works/mywork.lua → builds/mywork.love
./kn build               # 不给名字：用 conf.lua 里的 STARTUP.work
./kn build mywork --key-sim --diag    # 屏幕键盘默认显示 + 真机取证
./kn build mywork --force             # 强制重新编译
./kn build mywork -o /tmp/mywork.love # 自定义输出
./kn list                # 看有哪些 bcmkn / 编译产物 / 已有包

# 也可以分步（player/ 内或任意目录都行）
python3 player/tools/kn.py compile mywork   # 只编译 → works/mywork.lua
python3 player/tools/kn.py pack mywork      # 只打包 → builds/mywork.love

# 跑起来：用 LÖVE 打开 player/（conf.lua 的 STARTUP.work 换成作品名，或直接跑打包好的 .love）
love player
```

作品参数也可以写路径：`./kn build bcmkn/mywork.bcmkn`、`./kn pack works/mywork.lua`。

`--key-sim`：包内键盘面板（WASD/方向键）默认显示；**右上角 KEY 开关**随时切换显隐。
`--diag`：写入 `diag.on`，真机逐帧取证。

兼容旧写法（仍然可用）：

```sh
sh player/tools/pack.sh bcmkn/mywork.bcmkn ../builds/mywork.love   # 源文件 + 输出
sh player/tools/pack.sh ../builds/mywork.love --work=mywork        # 已编译作品 + 输出
python3 player/tools/build_love.py bcmkn/mywork.bcmkn              # 输出 builds/mywork.love
python3 -m kntl.compile mywork                                     # 默认写 works/mywork.lua
```

回归测试（必须 lua5.1 + luajit）：

```sh
sh player/tests/all.sh
```

## 目录

```
player/                 可运行的工程根（love . 的目录）
  main.lua conf.lua     LÖVE 入口与启动配置
  kntl/                 Python 编译器（.bcmkn → works/*.lua）
  rt/                   Lua 运行时（原语/调度/宿主/命中/绘制）
  At/                   AtLua：变量/列表监视器、控制台、DBG、屏幕按键
  kn_spec/              块规格表（由官方 bundle 生成）
  tests/                回归测试与 fixtures（lua5.1 + luajit）
  tools/                编译/打包/构建/性能工具
  docs/                 移植审计、专题文档、NOTES（长期记忆）
  works/                编译产物；works/assets 为素材（LÖVE 要求相对路径）
  archive/              旧版本包、legacy、开发探针
builds/                 构建产物（.love），不进源码包
reference/              官方 bundle / analysis / atlua（只读参考，不参与运行）
archive/                开发日志、备份、历史 works、重复文件归档
release/                对外发布（demo 包、源码包、SHA256SUMS）
```

> 目录职责变更（2026-10-24）：`player/dist/` → `builds/`；`git/` 整仓快照 → `archive/snapshots/`；
> `NOTES.md` → `player/docs/NOTES.md`；`archive/backups/backup/*` 拍平为 `archive/backups/*`。

## 当前能力与边界

- 语义：文本 UTF-16、JS 数字/布尔/比较/取模、列表、公式计算、点击/按键状态机、
  音频等待、`sync_tell` 同线程内联（过程原子性）。
- 性能：`now`、`perf_extreme`、k3t V2 均有 headless 基准；
  k3t V2 在 `wait 0.1` 下约 4fps（官方 2fps）。
- 离线不支持：micro:bit / CatBit / 魔棒 / 机器人 / 人脸/人体/物体识别 / 摄像头 / 在线 AI /
  排行榜等，编译期会打印清单并写入 `M.unsupported_blocks`；运行期不会假装已实现。
- 本机（Termux）没有 LÖVE，绘制/GPU/触摸/音频仍需真机验收。

## 0.2.0 发布内容

- `release/HateNeko-0.2.0/HateNeko-0.2.0-source.zip`：必要项目代码（运行时代码、编译器、
  测试、工具、文档、全部作品的编译产物与演示作品素材）；不含 `reference/` 官方原始 bundle、
  `archive/` 与 `now` 的 190MB 素材。
- `release/HateNeko-0.2.0/HateNeko-0.2.0-demo.love`：可直接运行的演示包（`nodevm`，含屏幕按键，
  右上角 KEY 可切换显示/隐藏）。
- `release/HateNeko-0.2.0/RELEASE.md` / `SHA256SUMS`：发布说明与校验和。

## 文档

- [player/README.md](player/README.md)：运行时/编译器/打包的完整说明
- [player/docs/NOTES.md](player/docs/NOTES.md)：长期移植记忆与坑位记录（先读 §1/§3）
- [player/docs/](player/docs/)：领域审计、坐标、单位、构建等专题

## 版本

`0.2.0`（见 `VERSION`、`CHANGELOG.md`）。

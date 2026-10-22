# HateNeko

**KittenN（探月编程 / KN）作品 → LÖVE 11.5 的编译器与运行时。**

当前为 **测试版本 `0.1.0-test.1`**：核心运行时、Python 编译器、回归测试、单作品打包链路已可用；
硬件/在线 AI 类积木、真机视觉/音频/触摸验收仍在进行中。

## 快速开始

环境：Python 3、Lua 5.1、LuaJIT、LÖVE 11.5（真机/桌面运行需要）。

```sh
cd player

# 1. 编译作品（素材会下载到 works/assets）
python3 -m kntl.compile /path/to/work.bcmkn works/mywork.lua

# 2. 让播放器加载它：把 conf.lua 的 STARTUP.work 改成 "mywork"
#    然后用 LÖVE 打开 player/ 目录
love .

# 3. 打包成单作品 .love（含 At/、只收该作品素材闭包）
sh tools/pack.sh dist/mywork.love --work=mywork

# 4. 跑回归（必须 lua5.1 + luajit）
sh tests/all.sh
```

`--key-sim` 可在包内开启屏幕方向键/WASD 等按键，例如：

```sh
sh tools/pack.sh dist/mywork-mobile.love --work=mywork --key-sim
```

## 目录

```
player/                 可运行的工程根
  main.lua conf.lua     LÖVE 入口与启动配置
  kntl/                 Python 编译器（.bcmkn → works/*.lua）
  rt/                   Lua 运行时（原语/调度/宿主/命中/绘制）
  At/                   AtLua：变量/列表监视器、控制台、DBG、屏幕按键
  kn_spec/              块规格表（由官方 bundle 生成）
  tests/                回归测试与 fixtures（lua5.1 + luajit）
  tools/                编译/打包/构建/性能工具
  docs/                 移植审计与子文档
  works/                编译产物；works/assets 为素材
  dist/                 当前发布用 .love
  archive/              旧版本包、legacy、开发探针
reference/              官方 bundle / analysis / atlua（只读参考，不参与运行）
archive/                开发日志、备份、历史 works
```

## 当前能力与边界

- 语义：文本 UTF-16、JS 数字/布尔/比较/取模、列表、公式计算、点击/按键状态机、
  音频等待、`sync_tell` 同线程内联（过程原子性）。
- 性能：`now`、`perf_extreme`、k3t V2 均有 headless 基准；
  k3t V2 在 `wait 0.1` 下约 4fps（官方 2fps）。
- 离线不支持：micro:bit / CatBit / 魔棒 / 机器人 / 人脸/人体/物体识别 / 摄像头 / 在线 AI /
  排行榜等，编译期会打印清单并写入 `M.unsupported_blocks`；运行期不会假装已实现。
- 本机（Termux）没有 LÖVE，绘制/GPU/触摸/音频仍需真机验收。

## 测试版本内容

- 源码包：不含 `player/works/assets` 大素材与 `reference/` 官方原始 bundle；
  演示作品 `template3d_0243` 的 10 个素材已附在 `player/works/assets/`。
- `HateNeko-0.1.0-test1-demo.love`：可直接运行的演示包（含屏幕按键）。

## 文档

- [player/README.md](player/README.md)：运行时/编译器/打包的完整说明
- [player/NOTES.md](player/NOTES.md)：长期移植记忆与坑位记录
- [player/docs/](player/docs/)：领域审计、坐标、单位、构建等专题

## 版本

`0.1.0-test.1`（见 `VERSION`、`CHANGELOG.md`）。

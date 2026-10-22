# Changelog

## 0.1.0-test.1 — 2026-10-23

首个 HateNeko 项目测试版本。

### 运行时 / 语义
- KittenN `.bcmkn` → Lua 编译器（Python）与 LÖVE 11.5 运行时。
- JS 数字转字符串、文本 UTF-16、`convert_type`、列表索引、公式计算、JS 取模/逻辑。
- 点击/按键动作状态机，`sync_tell` 按官方语义改为同线程内联，修复 render 过程中间态。
- 音频等待轮询、文本特效阻塞、图片印章特效、背景 NONE 适配、失焦释放输入。

### 工程 / 测试
- `sh tests/all.sh`：57 个测试文件 × lua5.1/luajit，Lua 783 项/VM + Python 159 项，0 失败。
- 原语注册表 + schema 覆盖门；硬件/AI 块显式离线清单。
- 单作品打包：必带 `At/`，只收作品素材闭包，支持 `--key-sim`。
- 性能优化：效果画布池、alpha 采样、克隆候选缓存、k3t V2 常量表/运行时快路径。
- 代码结构整理：开发日志/备份归档到 `archive/`，官方参考到 `reference/`，
  发布包到 `player/dist/`，旧包/探针到 `player/archive/`。

### 已知限制
- 硬件/在线 AI 类积木不支持；绘制/GPU/触摸/音频需真机验收。
- 源码包不包含 `player/works/assets` 大素材，需按作品重新编译/同步。

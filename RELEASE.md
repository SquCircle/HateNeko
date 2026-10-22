# HateNeko 0.1.0-test.1（项目测试版）

## 内容

- `player/`：可运行工程（Python 编译器 + Lua 运行时 + AtLua + 测试/工具/文档）。
  - `player/conf.lua` 已默认加载 `template3d_0243` 演示作品。
  - 演示作品的 10 个素材已放入 `player/works/assets/`。
- `HateNeko-0.1.0-test1-demo.love`：同一演示作品的 LÖVE 单文件包（含屏幕按键）。
- 源码包**不包含**其它作品的 190MB 素材；需要时在 `player/` 内重新编译作品同步素材。

## 运行源码演示

```sh
cd player
love .
```

## 回归

完整回归需要完整 `works/assets`（开发工作区有）：

```sh
cd player
sh tests/all.sh
```

精简环境可先跑：

```sh
lua5.1 tests/semantics_p1_test.lua
lua5.1 tests/sync_tell_test.lua
lua5.1 tests/registry_test.lua
```

## 版本

`0.1.0-test.1`，见 `VERSION` / `CHANGELOG.md`。

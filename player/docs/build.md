# 构建与工具链

## 语言划分（重要）

| 部分 | 语言 | 职责 |
|---|---|---|
| **编译器** `kntl/` | **Python** | 作品 JSON → Lua 模块；**下载并校验全部素材** |
| 运行时 `rt/` | **Lua** | 只负责执行编译产物（调度/绘制/输入/音频） |
| 宿主 `main.lua` | Lua | LÖVE 主循环 |
| 工具 `tools/` | Python / sh | 预编译、打包、审计 |

历史上 `kntl/` 曾是 Lua（1021 行），已迁到 `legacy/compiler-lua/` 仅作参考；
新编译器输出与原实现**逐字节一致**（14 个测试作品里除"多变量声明"一处改进外全一致）。

## 常用命令

```sh
# 编译一个作品（自动补齐素材，缺一个就报错退出）
python3 -m kntl.compile tests/fixtures/now.bcmkn works/now.lua

# 不带素材（只生成 Lua）
python3 -m kntl.compile tests/fixtures/now.bcmkn works/now.lua --no-assets

# 预编译测试作品 → tests/fixtures/compiled/*.lua（测试链依赖它）
python3 tools/precompile.py

# 全量回归（Python 预编译 + Lua5.1/LuaJIT 各跑一遍）
sh tests/all.sh

# 打包成 .love
sh tools/pack.sh
```

## 素材规则

- 落地文件名：`<assets_dir>/assets/<id>.<ext>`
- `ext` 取 URL **去掉 ?query 后**的扩展名（如 `.../abc?imageView` → 无扩展名 → 默认 `png`）
- 编译期会把缺失素材全部下载（12 并发、每个重试 3 次），**校验失败即编译失败**

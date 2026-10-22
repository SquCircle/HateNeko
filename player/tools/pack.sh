#!/bin/sh
# 打包 .love：先刷新构建指纹，再打 zip
# 用法：sh tools/pack.sh [输出路径] [--work=作品名] [--all-works] [--diag]
#   默认按 conf.lua 的 STARTUP.work 打**单作品**包（只收该作品素材 + 必带 At/）
#   --work=名   指定作品；--all-works 全量（体积巨大，仅调试）
#   --diag      打"真机取证"包（多一个 diag.on 标记，启动即把日志/截图写进 probe_out/）
set -e
cd "$(dirname "$0")/.."
out="${1:-knplayer.love}"
if [ $# -gt 0 ]; then shift; fi
python3 tools/gen_build.py >/dev/null
python3 tools/pack.py "$out" "$@"

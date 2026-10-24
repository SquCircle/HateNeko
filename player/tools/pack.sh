#!/bin/sh
# 打包 .love（兼容入口）。
#
# 推荐直接用一站式工具（作品名即可，不用写路径）：
#   python3 tools/kn.py build atkn            # 编译 + 打包 → <仓库>/builds/atkn.love
#   python3 tools/kn.py build atkn --key-sim --diag
#
# 本脚本支持的写法：
#   sh tools/pack.sh atkn                     # 作品名 → builds/atkn.love
#   sh tools/pack.sh atkn --key-sim
#   sh tools/pack.sh <作品.bcmkn>             # 先编译再打包
#   sh tools/pack.sh <输出.love> --work=作品   # 旧写法：只打包
set -e
cd "$(dirname "$0")/.."

case "${1:-}" in
  "")
    exec python3 tools/kn.py pack
    ;;
  *.love|*.LOVE)
    # 旧写法：第一个参数是输出路径（可配 --work=作品名）
    exec python3 tools/pack.py "$@"
    ;;
  *.bcmkn|*.BCMKN)
    # 1 个或 2 个位置参数（源文件 [输出.love]）都交给 build_love.py 兼容处理
    exec python3 tools/build_love.py "$@"
    ;;
esac
exec python3 tools/kn.py pack "$@"

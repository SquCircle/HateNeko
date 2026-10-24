#!/bin/sh
# 编译 works 目录下的作品（全部由 Python 编译期完成；Lua 只保留运行时）
cd "$(dirname "$0")/.." || exit 1
set -e
for w in tests/fixtures/now.bcmkn tests/fixtures/new2.bcmkn; do
  [ -f "$w" ] || continue
  name=$(basename "$w" .bcmkn)
  echo "== $name =="
  python3 -m kntl.compile "$w" "works/$name.lua"
done

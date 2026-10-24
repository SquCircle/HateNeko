#!/usr/bin/env python3
"""从块目录生成 rt/schema.lua（阶段 4：原语注册表的参数 schema 与覆盖清单）。

用法：
    python3 tools/gen_schema.py            # 读 kn_spec/block_catalog.json
    python3 tools/gen_schema.py --check     # 只检查是否过期（CI/测试用）

生成的表：
  S.args[type]       = { 参数名… }        -- 块目录里的参数（用于调试期参数名校验/覆盖报告）
  S.events[type]     = true               -- 事件帽
  S.compiler[type]   = true               -- 编译期构造（循环/过程参数/break）
  S.unsupported[type]= "原因"             -- 离线不支持（在线服务/硬件）
  S.known_extra[type]= true               -- 运行期存在但目录里没有的历史块/内部别名
  S.catalog_size
"""
import argparse
import json
import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)
from kntl import support  # noqa: E402

CATALOG = os.path.join(ROOT, "kn_spec", "block_catalog.json")
OUT = os.path.join(ROOT, "rt", "schema.lua")


def lua_q(s):
    # 参数名只含 ASCII 标识符/少量符号；用 %q 的 Python 等价
    return '"' + str(s).replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n") + '"'


def generate():
    with open(CATALOG, encoding="utf-8") as f:
        cat = json.load(f)
    args, events, unsupported = {}, {}, {}
    for t, spec in cat.items():
        names = [a.get("name") for a in (spec.get("args") or []) if a.get("name")]
        args[t] = names
        if spec.get("isEvent"):
            events[t] = True
        r = support.unsupported_reason(t)
        if r:
            unsupported[t] = r
    lines = [
        "-- 自动生成（tools/gen_schema.py），请勿手改",
        "local S = {}",
        "S.catalog_size = %d" % len(cat),
        "",
        "S.args = {",
    ]
    for t in sorted(args):
        lines.append("  [%s] = { %s }," % (lua_q(t), ", ".join(lua_q(x) for x in args[t])))
    lines.append("}")
    lines.append("")
    lines.append("S.events = {")
    for t in sorted(events):
        lines.append("  [%s] = true," % lua_q(t))
    lines.append("}")
    lines.append("")
    lines.append("S.compiler = {")
    for t in sorted(support.COMPILER_TYPES):
        lines.append("  [%s] = true," % lua_q(t))
    lines.append("}")
    lines.append("")
    lines.append("S.unsupported = {")
    for t in sorted(unsupported):
        lines.append("  [%s] = %s," % (lua_q(t), lua_q(unsupported[t])))
    lines.append("}")
    lines.append("")
    lines.append("S.known_extra = {")
    for t in sorted(support.KNOWN_EXTRA):
        lines.append("  [%s] = true," % lua_q(t))
    lines.append("}")
    lines.append("")
    lines.append("return S")
    return "\n".join(lines) + "\n"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--check", action="store_true")
    args = ap.parse_args()
    src = generate()
    if args.check:
        old = open(OUT, encoding="utf-8").read() if os.path.exists(OUT) else ""
        if old != src:
            print("rt/schema.lua 已过期，请运行 python3 tools/gen_schema.py", file=sys.stderr)
            return 1
        print("rt/schema.lua 与块目录一致")
        return 0
    with open(OUT, "w", encoding="utf-8") as f:
        f.write(src)
    print("已生成 rt/schema.lua（%d 个块类型）" % src.count("  ["))
    return 0


if __name__ == "__main__":
    sys.exit(main())

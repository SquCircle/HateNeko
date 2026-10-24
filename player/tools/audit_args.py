#!/usr/bin/env python3
"""参数键核对：**不猜**——直接从 .bcmkn 里读出每个积木真实的 inputs/fields 键，
再和 rt/impl/*.lua 里实际读取的 args.<key> 对照，列出不一致。

背景：Blockly 的键名各块不同（math_number 用 NUM/TEXT，appearance_of_sprite 用
sprite/appearance，列表块用 list/list_index/item…），凭印象写实现会静默失效。
这个脚本让"数据说该用什么键"成为唯一依据。

用法：
    python3 tools/audit_args.py            # 生成 docs/args_audit.md + 打印摘要
    python3 tools/audit_args.py --verbose
"""
import argparse
import glob
import json
import os
import re
import sys
from collections import defaultdict

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, "docs", "args_audit.md")

READ_RE = re.compile(r"args\.([A-Za-z_][A-Za-z0-9_]*)|args\[\s*[\"']([A-Za-z_][A-Za-z0-9_]*)[\"']\s*\]")


def walk_blocks(node, out):
    if isinstance(node, dict):
        t = node.get("type")
        if t:
            out.append(node)
        for v in node.values():
            walk_blocks(v, out)
    elif isinstance(node, list):
        for v in node:
            walk_blocks(v, out)


def collect_from_work(path, data):
    """→ {block_type: {"in": set(keys), "f": set(keys)}}"""
    blocks = []
    walk_blocks(data, blocks)
    for t, v in (data.get("actors") or {}).items():
        if isinstance(v, dict):
            walk_blocks(v.get("nekoBlockJsonList"), blocks)
    for t, v in (data.get("scenes") or {}).items():
        if isinstance(v, dict):
            walk_blocks(v.get("nekoBlockJsonList"), blocks)
    for p in (data.get("procedures") or {}).get("proceduresDict", {}).values():
        if isinstance(p, dict):
            walk_blocks(p.get("nekoBlockJsonList"), blocks)
    agg = defaultdict(lambda: {"in": set(), "f": set(), "n": 0})
    for b in blocks:
        e = agg[b["type"]]
        e["n"] += 1
        for k in (b.get("inputs") or {}):
            e["in"].add(k)
        for k in (b.get("fields") or {}):
            e["f"].add(k)
    return agg


def collect_impl_reads():
    """→ {block_type: set(keys)}；实现按 `function M.<type>` 分块"""
    reads = defaultdict(set)
    misc = set()      # 顶层局部辅助函数（audio_key/list_of/delta_of…）里的读取
    for path in glob.glob(os.path.join(ROOT, "rt", "impl", "*.lua")):
        src = open(path, encoding="utf-8", errors="ignore").read()
        # 按 `function M.xxx(` 切分
        cur = None
        buf = []
        for line in src.splitlines():
            m = re.match(r"\s*function\s+M\.([A-Za-z_][A-Za-z0-9_]*)\s*\(", line)
            if m:
                if cur:
                    reads[cur].update(buf)
                cur, buf = m.group(1), []
                # 单行函数体也要扫（function M.x(...) ... end 写在一行的情况）
                for mm in READ_RE.finditer(line[m.end():]):
                    buf.append(mm.group(1) or mm.group(2))
            elif cur is not None:
                for mm in READ_RE.finditer(line):
                    buf.append(mm.group(1) or mm.group(2))
            else:
                for mm in READ_RE.finditer(line):
                    misc.add(mm.group(1) or mm.group(2))
        if cur:
            reads[cur].update(buf)
    # 别名：M.x = M.y
    for path in glob.glob(os.path.join(ROOT, "rt", "impl", "*.lua")):
        src = open(path, encoding="utf-8", errors="ignore").read()
        for a, b in re.findall(r"^\s*M\.([A-Za-z0-9_]+)\s*=\s*M\.([A-Za-z0-9_]+)\s*$", src, re.M):
            if b in reads:
                reads[a] |= reads[b]
    return reads, misc


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--verbose", action="store_true")
    a = ap.parse_args()

    data = defaultdict(lambda: {"in": set(), "f": set(), "n": 0})
    for path in sorted(glob.glob(os.path.join(ROOT, "tests", "fixtures", "*.bcmkn*"))):
        try:
            w = json.load(open(path, encoding="utf-8"))
        except Exception:
            continue
        for t, e in collect_from_work(path, w).items():
            data[t]["in"] |= e["in"]
            data[t]["f"] |= e["f"]
            data[t]["n"] += e["n"]

    reads, misc = collect_impl_reads()
    # 辅助函数里的读取（list_of/delta_of/audio_key…）挂在别的函数名下，
    # 所以"某块没读某键"要按**全文件并集**判，避免假阳性
    all_reads = set(misc)
    for ks in reads.values():
        all_reads |= ks
    lines = ["# 参数键审计（数据 vs 实现）", "",
             "数据来源：`tests/fixtures/*.bcmkn` 里每个积木真实的 inputs/fields 键。",
             "实现来源：`rt/impl/*.lua` 里 `args.<key>` 的读取。", ""]
    warn = 0
    for t in sorted(data):
        if t not in reads:
            continue
        keys = data[t]["in"] | data[t]["f"]
        missing = sorted(k for k in keys if k not in all_reads)
        # 选择器类键（item/type/OP/…）经常只是没在本作品出现，不算问题
        if missing:
            warn += 1
            lines.append("## `%s`（%d 次）" % (t, data[t]["n"]))
            lines.append("- 数据里有、实现没读：`%s`" % "`, `".join(missing))
            if a.verbose:
                lines.append("- 实现读了：`%s`" % "`, `".join(sorted(reads[t])))
            lines.append("")
    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    open(OUT, "w", encoding="utf-8").write("\n".join(lines) + "\n")
    print("审计写入 %s" % os.path.relpath(OUT, ROOT))
    print("有差异的块：%d" % warn)
    for line in lines[4:]:
        if line.startswith("## ") or line.startswith("- 数据"):
            print(" ", line)


if __name__ == "__main__":
    sys.exit(main())

#!/usr/bin/env python3
"""从 KittenN 编辑器 bundle 重建块规格表（kn_spec/block_catalog.json）。

背景：编译器（kntl/）需要 {块类型: {args, isEvent}} 规格表，历史上是从编辑器产物
里抽出来的、放在仓库外（/workspace/kn_spec/）。仓库自包含后改成从 bundle 生成。

数据来源（编辑器静态资源，无需联网）：
  <bundle>/static/js/main.*.js
    · 内嵌的 .d.ts 块 ABI：`/** #message … #callee x */ export type t = (args) => void;`
      —— 给出每个块类型的**参数名**（callee 名 = 参数所属块类型，除非注释里 #callee 覆盖）
    · webpack 模块 89464 里的**事件块数组** —— 给出 isEvent

用法：
    python3 tools/gen_block_catalog.py                 # bundle 在 ../reference/bundle
    python3 tools/gen_block_catalog.py --bundle=… --out=…
"""
import argparse
import glob
import json
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WSP = os.path.dirname(ROOT)
DEFAULT_BUNDLE = os.path.join(WSP, "reference", "bundle")
if not os.path.isdir(DEFAULT_BUNDLE):
    DEFAULT_BUNDLE = os.path.join(WSP, "bundle")  # 兼容旧布局
DEFAULT_OUT = os.path.join(ROOT, "kn_spec", "block_catalog.json")

# 事件块：编辑器里 hat（无上一个连接点、能启动脚本）的块类型。
# 取自 bundle 里的事件数组；另一些历史名字由 kntl/spec.py 的 EVENT_FALLBACK 兜底。
EVENT_MARK = r'r=\["on_running_group_activated"'


# .d.ts 里已经没有、但现存作品仍在用的老块（编辑器侧已移除）。
# 参数按作品里的实际用法补：tests/fixtures/*.bcmkn 有真实调用点。
LEGACY_BLOCKS = {
    # 取模：inputs A / B 都是 math_number
    "math_modulo": [{"name": "A", "type": "number"}, {"name": "B", "type": "number"}],
    # 收到广播/碰撞时携带的内容：值本身放在 fields.TEXT
    "self_listen_value": [],
    # 「公式计算」：input 槽是一段文本公式（1+2*3）；rt 侧见 op_sensing.calculate
    "calculate": [{"name": "input", "type": "text"}],
    # 「计时器值」：无参数（rt 里是 timer 的别名）
    "get_timer": [],
    # 旧版「播放的声音」影子下拉（0.18）：作为输入时编译成 audio_id 字面量
    "get_play_audio": [{"name": "audio_id", "type": "text"}],
    # 旧版「重置计时器」：无参数（rt 里已有 reset_timer）
    "reset_timer": [],
}


def _js_string_literal(src, start):
    """从 src[start] 处的开引号起，取一个 JS 双引号字符串字面量并解码。"""
    assert src[start] == '"'
    i = start + 1
    out = []
    while i < len(src):
        c = src[i]
        if c == "\\":
            e = src[i + 1]
            if e == "u":
                out.append(chr(int(src[i + 2:i + 6], 16)))
                i += 6
                continue
            if e == "n":
                out.append("\n")
            elif e == "r":
                out.append("\r")
            elif e == "t":
                out.append("\t")
            elif e == "x":
                out.append(chr(int(src[i + 2:i + 4], 16)))
                i += 4
                continue
            else:  # \" \' \\ 以及其它转义：原样取
                out.append(e)
            i += 2
            continue
        if c == '"':
            return "".join(out), i + 1
        out.append(c)
        i += 1
    raise ValueError("未闭合的 JS 字符串字面量")


def extract_dts(src):
    """取出编辑器内嵌的 .d.ts 文本。

    bundle 里它是 `(0,o.E8)("…\\n…")` 这种模板字符串；模块 id/压缩字母可能变，
    所以定位策略是「找 #message 所在的字符串字面量并解码」，不依赖变量名。
    """
    pos = src.find("#message")
    if pos < 0:
        raise SystemExit("bundle 里没有找到 #message（.d.ts 块 ABI）")
    # 从 #message 往回找到包含它的字符串开引号
    i = pos
    while i >= 0 and src[i] != '"':
        i -= 1
    if i < 0:
        raise SystemExit("没找到 #message 所在的字符串字面量")
    text, _ = _js_string_literal(src, i)
    if "export type" not in text:
        raise SystemExit("解出的文本不是 .d.ts（缺 export type）")
    return text


def extract_event_blocks(src):
    """取事件块数组（webpack 里 `r=[ "on_running_group_activated", … ]`）。"""
    i = src.find('r=["on_running_group_activated"')
    if i < 0:
        # 压缩后可能没有空格/变量名不同：退化成直接找数组字面量
        i = src.find('["on_running_group_activated"')
        if i < 0:
            raise SystemExit("bundle 里没有找到事件块数组")
    j = i + src[i:].find("[")
    # 逐字符扫到配平的 ]
    depth = 0
    k = j
    while k < len(src):
        c = src[k]
        if c == '"':
            _, k = _js_string_literal(src, k)
            continue
        if c == "[":
            depth += 1
        elif c == "]":
            depth -= 1
            if depth == 0:
                k += 1
                break
        k += 1
    arr_text = src[j:k]
    # 数组里只有字符串字面量，逐个解出来
    names = []
    p = 0
    while True:
        q = arr_text.find('"', p)
        if q < 0:
            break
        s, p = _js_string_literal(arr_text, q)
        names.append(s)
    return names


def _split_params(params):
    """按顶层逗号切参数（类型里可能有 <'a', 'b'>，也有换行）。"""
    out, buf, depth = [], [], 0
    for ch in params:
        if ch in "<([{":
            depth += 1
        elif ch in ">)]}":
            depth -= 1
        if ch == "," and depth == 0:
            out.append("".join(buf))
            buf = []
        else:
            buf.append(ch)
    if "".join(buf).strip():
        out.append("".join(buf))
    return [p.strip() for p in out if p.strip()]


PARAM_RE = re.compile(r"^([A-Za-z_$][\w$]*)\s*\??\s*:\s*(.+)$", re.S)
DECL_HEAD_RE = re.compile(r"export type\s+([A-Za-z_$][\w$]*)\s*=\s*\(")
COMMENT_START = "/**"


def _match_paren(text, start):
    """text[start] == '('，返回配平的 ')' 下标（跳过字符串字面量）。"""
    depth = 0
    i = start
    quote = None
    while i < len(text):
        c = text[i]
        if quote:
            if c == "\\":
                i += 2
                continue
            if c == quote:
                quote = None
        elif c in "'\"`":
            quote = c
        elif c == "(":
            depth += 1
        elif c == ")":
            depth -= 1
            if depth == 0:
                return i
        i += 1
    return -1


def parse_dts(text):
    """`/** … */ export type t = (a: A, b: B) => void;` → [(callee, [args])]

    参数表按括号配平取（类型里可能有 `DO: () => void` 这种嵌套括号），
    紧接着的 `=>` 用来确认这是函数类型而不是别名。
    """
    out = []
    pos = 0
    while True:
        m = DECL_HEAD_RE.search(text, pos)
        if not m:
            break
        name = m.group(1)
        lp = m.end() - 1
        rp = _match_paren(text, lp)
        if rp < 0:
            break
        params = text[lp + 1:rp]
        pos = rp + 1
        tail = text[pos:pos + 8].lstrip()
        if not tail.startswith("=>"):
            continue
        # 紧跟在 `export type` 前面的注释块
        cs = text.rfind(COMMENT_START, 0, m.start())
        ce = text.find("*/", cs + len(COMMENT_START)) if cs >= 0 else -1
        comment = text[cs + len(COMMENT_START):ce] if ce > 0 and ce < m.start() else ""
        callee = name
        mc = re.search(r"#callee\s+([A-Za-z_$][\w$]*)", comment)
        if mc:
            callee = mc.group(1)
        elif "#message" not in comment:
            # 没有 #message 也没有 #callee：不是块 ABI（内部类型别名），跳过
            continue
        args = []
        for p in _split_params(params):
            p = p.strip()
            if p.startswith("..."):
                continue  # 变参（如 ...CHOICE: any[]）在 JSON 里是可变槽位，无固定参数名
            mp = PARAM_RE.match(p)
            if not mp:
                continue
            typ = mp.group(2).strip()
            # 语句槽（C 形块的 SUBSTACK）在块定义里是 input_statement，不是参数；
            # .d.ts 里表现为函数类型 `DO: () => void`，标记成 input_statement 以便 collect_args 跳过。
            if re.match(r"^\(.*\)\s*=>", typ, re.S):
                typ = "input_statement"
            args.append({"name": mp.group(1), "type": typ})
        out.append((name, args, callee))
    return out


def build(bundle_dir):
    paths = sorted(glob.glob(os.path.join(bundle_dir, "static", "js", "main.*.js")))
    paths = [p for p in paths if not p.endswith(".map")]
    if not paths:
        raise SystemExit("没找到 %s/static/js/main.*.js" % bundle_dir)
    # 多个 main.*.js 时取最大（最新完整包）
    path = max(paths, key=os.path.getsize)
    src = open(path, encoding="utf-8", errors="ignore").read()
    dts = extract_dts(src)
    events = extract_event_blocks(src)

    catalog = {}
    for name, args, callee in parse_dts(dts):
        entry = catalog.setdefault(name, {"args": [], "isEvent": False})
        if callee and callee != name:
            entry["callee"] = callee
        # 同一个 callee 可能有多条（不同编辑器块映射到同一 callee）→ 参数取并集
        have = {a["name"] for a in entry["args"]}
        for a in args:
            if a["name"] not in have:
                entry["args"].append(a)
                have.add(a["name"])
    for name, args in LEGACY_BLOCKS.items():
        entry = catalog.setdefault(name, {"args": [], "isEvent": False})
        have = {a["name"] for a in entry["args"]}
        for a in args:
            if a["name"] not in have:
                entry["args"].append(a)
                have.add(a["name"])
    for e in events:
        if e not in catalog:
            catalog[e] = {"args": [], "isEvent": True}
        else:
            catalog[e]["isEvent"] = True
    return path, catalog, dts, events


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--bundle", default=os.environ.get("KN_BUNDLE") or DEFAULT_BUNDLE)
    ap.add_argument("--out", default=DEFAULT_OUT)
    ap.add_argument("--dump-dts", default=None, help="把解出的 .d.ts 另存一份便于对照")
    a = ap.parse_args()

    path, catalog, dts, events = build(a.bundle)
    if a.dump_dts:
        os.makedirs(os.path.dirname(os.path.abspath(a.dump_dts)), exist_ok=True)
        open(a.dump_dts, "w", encoding="utf-8").write(dts)
    os.makedirs(os.path.dirname(os.path.abspath(a.out)), exist_ok=True)
    with open(a.out, "w", encoding="utf-8") as f:
        json.dump(catalog, f, ensure_ascii=False, indent=1, sort_keys=True)
        f.write("\n")
    print("来源：%s" % os.path.relpath(path, ROOT))
    print("块规格：%d 条（事件块 %d）→ %s" % (len(catalog), sum(1 for v in catalog.values() if v["isEvent"]), a.out))
    return 0


if __name__ == "__main__":
    sys.exit(main())

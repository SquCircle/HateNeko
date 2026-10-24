#!/usr/bin/env python3
"""逐 domain 对照审计：把官方引擎的 domain 函数表，与 knplayer 运行时的原语实现逐一比对。

数据来源：
  /workspace/analysis/domain_fns_pretty.txt   官方引擎的 domain 表（{name:function(t,e,i,o){…}}）
  /workspace/analysis/block_defs_pretty.txt   （若有）积木定义/字段映射
  knplayer/rt/impl/*.lua                      我们的运行时原语
输出： knplayer/docs/domain_audit.md

分类：
  MISSING   官方有、我们没有（会以"未实现块"降级）
  STUB      我们有，但是空实现 / 恒返回常量（多半还没做）
  BOTH      两边都有（需要人工比对语义；这里给出官方实现片段便于对照）
"""
import os, re, sys, glob

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WSP = os.path.dirname(ROOT)
DOMAIN = os.path.join(WSP, 'analysis', 'domain_fns_pretty.txt')
OUT = os.path.join(ROOT, 'docs', 'domain_audit.md')


# 内部运算符表（不是独立积木）
OP_TABLE = set('''EQ NEQ LT LTE GT GTE AND OR
ROUND ROUNDUP ROUNDDOWN EVEN ODD PRIME WHOLE POSITIVE NEGATIVE DIVISIBLE_BY
SIN ASIN COS ACOS TAN ATAN ROOT ABS NEG LN LOG10 EXP POW10 ADD MINUS MULTIPLY DIVIDE POWER
TRUE FALSE'''.split())


def parse_official(path):
    """解析 {name:function(t,e,i,o){...}, ...} → [(name, body)]"""
    if not os.path.exists(path):
        print('缺少', path)
        return []
    s = open(path, encoding='utf-8', errors='replace').read()
    # 先按"缩进最浅的一层"确定 domain 表的顶层键（dump 是 pretty-print，层级可靠）
    # dump 是折行文本：直接全文找 `name:function(t,e,i,o)` 形式（domain 表的约定签名），
    # 并排除 `xxx.yyy:function` 这类属性与方法
    entries = []
    for m in re.finditer(r'(?<![\w$.])([A-Za-z_$][A-Za-z0-9_$]*)\s*:\s*function\s*\(\s*(t\s*,\s*e\s*,\s*i\s*,\s*o|t)\s*\)\s*\{', s):
        entries.append((0, m))
    out = []
    for indent, m in entries:
        name = m.group(1)
        if name.startswith('__'):
            continue  # TypeScript 运行时辅助函数，不是积木
        # 这些是 logic_compare / math_arithmetic / math_trig 等**内部运算符子表**，
        # 不是独立积木（我们的实现里它们就在那几个原语内部），审计时排除
        if name in OP_TABLE:
            continue
        name = m.group(1)
        # 从 { 起配平括号取 body
        i = m.end() - 1
        depth = 0
        j = i
        while j < len(s):
            c = s[j]
            if c == '{':
                depth += 1
            elif c == '}':
                depth -= 1
                if depth == 0:
                    break
            j += 1
        body = s[i:j + 1]
        if len(body) < 2000:  # 过滤掉超长的打包函数
            out.append((name, body))
    seen, uniq = set(), []
    for n, b in out:
        if n in seen:
            continue
        seen.add(n)
        uniq.append((n, b))
    return uniq


def parse_mine_runtime():
    """加载运行时，dump 真实可用的原语表（含运行期别名）"""
    import subprocess
    code = (
        'package.path="./?.lua;"..package.path;'
        'local rt=require("rt.init");'
        'local names={};'
        'local rt=require("rt.init"); local f=rt.impl or {}; for k in pairs(f) do names[#names+1]=k end;'
        'table.sort(names);print(table.concat(names,"\n"))'
    )
    try:
        out = subprocess.run(['lua5.1', '-e', code], cwd=ROOT, capture_output=True, text=True, timeout=60)
        names = [l.strip() for l in out.stdout.splitlines() if l.strip()]
        if names:
            return {n: ('(runtime)', n) for n in names}
    except Exception as e:
        print('运行期 dump 失败:', e)
    return {}


def parse_mine():
    """收集 rt/impl/*.lua 里导出的原语名与实现片段（离线兜底）"""
    mine = {}
    for p in sorted(glob.glob(os.path.join(ROOT, 'rt', 'impl', '*.lua'))):
        s = open(p, encoding='utf-8', errors='replace').read()
        # function M.xxx(self, args…) … end    /    M.xxx = function…
        for m in re.finditer(r'function\s+M\.([A-Za-z0-9_]+)\s*\(([^)]*)\)', s):
            start = m.start()
            mine.setdefault(m.group(1), (os.path.basename(p), s[start:start + 260].replace('\n', ' ')))
        for m in re.finditer(r'M\.([A-Za-z0-9_]+)\s*=\s*function', s):
            start = m.start()
            mine.setdefault(m.group(1), (os.path.basename(p), s[start:start + 200].replace('\n', ' ')))
    return mine


def is_stub(frag):
    f = frag.split(')', 1)[-1]
    f = f.replace('end', '').strip()
    return f in ('', 'return', 'return false', 'return 0', 'return nil', 'return ""',
                 'return true', 'return self', '--') or f.startswith('-- ')


def main():
    official = parse_official(DOMAIN)
    mine = parse_mine_runtime() or parse_mine()
    print(f'官方 domain 函数 {len(official)} 个；我的原语 {len(mine)} 个')

    missing, stubs, both = [], [], []
    for name, body in official:
        if name not in mine:
            missing.append((name, body))
        else:
            f, frag = mine[name]
            (stubs if is_stub(frag) else both).append((name, f, frag, body))

    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    with open(OUT, 'w', encoding='utf-8') as fh:
        fh.write('# domain 函数对照审计\n\n')
        fh.write(f'官方 domain 表：{len(official)} 个函数；knplayer 原语：{len(mine)} 个\n\n')
        fh.write(f'- **MISSING**（官方有、我们没有）：{len(missing)}\n')
        fh.write(f'- **STUB**（我们有但只是空壳）：{len(stubs)}\n')
        fh.write(f'- **BOTH**（都有，需比对语义）：{len(both)}\n\n')

        fh.write('## MISSING\n\n')
        for name, body in missing:
            fh.write(f'### `{name}`\n```js\n{body[:400]}\n```\n\n')

        fh.write('## STUB\n\n')
        for name, f, frag, body in stubs:
            fh.write(f'### `{name}`  ({f})\n- 我的：`{frag[:200]}`\n- 官方：\n```js\n{body[:400]}\n```\n\n')

        fh.write('## BOTH（需人工比对语义）\n\n')
        for name, f, frag, body in both:
            fh.write(f'### `{name}`  ({f})\n- 我的：`{frag[:200]}`\n- 官方：\n```js\n{body[:300]}\n```\n\n')

    print(f'MISSING {len(missing)} / STUB {len(stubs)} / BOTH {len(both)} → {OUT}')
    print('MISSING:', ', '.join(n for n, _ in missing[:40]))
    print('STUB:', ', '.join(n for n, _, _, _ in stubs[:40]))


if __name__ == '__main__':
    main()

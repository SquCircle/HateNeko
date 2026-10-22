#!/usr/bin/env python3
"""把 knplayer 打包成 .love（zip，改后缀）。

用法：
    python3 tools/pack.py [输出路径] [--work=名称] [--key-sim] [--all-works] [--diag] [--draw-dump] [--b1-probe]

发布包的默认规则（阶段 0 修正）：
  * **单作品**：默认只打 conf.lua 里 STARTUP.work 指定的那一个作品（可用 --work=名称 覆盖）；
    同时只收该作品真正引用的素材（M.assets / M.audios 的 id 闭包）。
    --all-works 才恢复"所有 works/*.lua + 全部素材并集"的旧行为（体积巨大，仅调试用）。
  * **必须包含 At/**：AtLua 是变量/列表 monitor、控制台、DBG 面板、屏幕按键的依赖；
    旧脚本漏了它，按旧脚本打的包会静默退化成"无 UI"。
  * **conf.lua 现改现塞**：包内 STARTUP.work 会被改写为所选作品，不改仓库文件。
默认输出 <仓库>/knplayer.love
"""
import os
import re
import sys
import zipfile

root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
raw_args = sys.argv[1:]
flags = [a for a in raw_args if a.startswith('--')]
pos = [a for a in raw_args if not a.startswith('--')]
DIAG = '--diag' in flags
DRAW_DUMP = '--draw-dump' in flags
B1_PROBE = '--b1-probe' in flags
ALL_WORKS = '--all-works' in flags
KEY_SIM = '--key-sim' in flags
work_opt = None
for a in flags:
    if a.startswith('--work='):
        work_opt = a.split('=', 1)[1]
if work_opt is None and '--work' in flags:
    i = raw_args.index('--work')
    if i + 1 < len(raw_args):
        work_opt = raw_args[i + 1]
        if work_opt in pos:
            pos.remove(work_opt)
out = pos[0] if pos else os.path.join(root, 'knplayer.love')
tmp = out + '.tmp'   # 先写临时文件，校验通过再原子改名（避免别人读到半截包 → CRC 错）

# ---------------------------------------------------------------- conf / 作品选择
conf_path = os.path.join(root, 'conf.lua')
with open(conf_path, encoding='utf-8') as f:
    conf_src = f.read()
m = re.search(r'\bwork\s*=\s*"([^"]*)"', conf_src)
conf_work = m.group(1) if m else None
work = work_opt or conf_work
if not work:
    print('ERROR: 未能从 conf.lua 读出 STARTUP.work，请用 --work=名称 指定', file=sys.stderr)
    raise SystemExit(2)
work_file = os.path.join(root, 'works', work + '.lua')
if not os.path.isfile(work_file):
    print('ERROR: 作品产物不存在：works/%s.lua（先编译）' % work, file=sys.stderr)
    raise SystemExit(2)

# 包内 conf.lua：改写 STARTUP.work
if m:
    conf_out = conf_src[:m.start(1)] + work + conf_src[m.end(1):]
else:
    conf_out = conf_src
if KEY_SIM:
    conf_out, n_key = re.subn(r'(\bkey_sim\s*=\s*)false', r'\1true', conf_out, count=1)
    if n_key:
        print('屏幕按键：conf 内 key_sim 已写为 true')
    else:
        print('WARN: --key-sim 未找到 key_sim=false，未改写', file=sys.stderr)
print('打包作品：%s（conf 内 STARTUP.work 已写为 %s）' % (work, work))

if ALL_WORKS:
    selected = sorted(f[:-4] for f in os.listdir(os.path.join(root, 'works'))
                      if f.endswith('.lua'))
    print('注意：--all-works 模式，%d 个作品全部进包' % len(selected))
else:
    selected = [work]

# ---------------------------------------------------------------- 素材闭包（只扫入选作品）
needed = set()
for name in selected:
    p = os.path.join(root, 'works', name + '.lua')
    src = open(p, encoding='utf-8', errors='ignore').read()
    for pat in (r'M\.assets = \{(.*?)\n\}', r'M\.audios = \{(.*?)\n\}'):
        mm = re.search(pat, src, re.S)
        if mm:
            for k in re.findall(r'\["([0-9a-fA-F-]{8,})"\] = \{', mm.group(1)):
                needed.add(k)
print('作品引用素材 %d 个' % len(needed))

MEDIA = ('.png', '.jpg', '.jpeg', '.gif', '.webp', '.mp3', '.ogg', '.wav', '.m4a', '.svg')


def add(z, full, rel):
    """已经是压缩格式的素材直接 store，别浪费 CPU 去 deflate。"""
    ct = zipfile.ZIP_STORED if rel.lower().endswith(MEDIA) else zipfile.ZIP_DEFLATED
    z.write(full, rel, compress_type=ct)


def add_bytes(z, rel, data):
    ct = zipfile.ZIP_STORED if rel.lower().endswith(MEDIA) else zipfile.ZIP_DEFLATED
    z.writestr(rel, data, compress_type=ct)


def walk_dir(z, dirname):
    base = os.path.join(root, dirname)
    if not os.path.isdir(base):
        return
    for dirpath, _, files in os.walk(base):
        for f in sorted(files):
            if f == '.DS_Store':
                continue
            full = os.path.join(dirpath, f)
            rel = os.path.relpath(full, root)
            add(z, full, rel)


assert os.path.isfile(os.path.join(root, 'At', 'At.lua')), \
    'At/At.lua 缺失：变量/列表 monitor、控制台、DBG 面板与屏幕按键都会失效'

with zipfile.ZipFile(tmp, 'w', zipfile.ZIP_DEFLATED) as z:
    add(z, os.path.join(root, 'main.lua'), 'main.lua')
    add_bytes(z, 'conf.lua', conf_out.encode('utf-8'))
    walk_dir(z, 'rt')
    walk_dir(z, 'At')
    # 只打入选作品的编译产物
    for name in selected:
        rel = 'works/%s.lua' % name
        add(z, os.path.join(root, rel), rel)
    # 素材：只收被引用 id 的所有扩展名（.svg 旁挂文件不进包）
    assets = os.path.join(root, 'works', 'assets')
    if os.path.isdir(assets):
        for f in sorted(os.listdir(assets)):
            full = os.path.join(assets, f)
            if not os.path.isfile(full):
                continue
            stem = os.path.splitext(f)[0]
            if stem not in needed:
                continue
            if f.lower().endswith('.svg'):
                continue
            add(z, full, os.path.relpath(full, root))
    if DIAG:
        z.writestr('diag.on', '')
    if DRAW_DUMP:
        z.writestr('draw_dump.on', '')
    if B1_PROBE:
        z.writestr('b1_probe.on', '')

# ---------------------------------------------------------------- 校验
import hashlib
import shutil
zv = zipfile.ZipFile(tmp)
bad = zv.testzip()
names = set(zv.namelist())
assert bad is None, '压缩包损坏: %s' % bad
assert 'main.lua' in names, 'main.lua 不在包顶层'
assert 'conf.lua' in names, 'conf.lua 缺失'
assert 'At/At.lua' in names, 'At/At.lua 缺失（UI 会不可用）'
assert 'works/%s.lua' % work in names, '所选作品不在包里'
assert not any(n.startswith('works/assets/') and n.endswith('.svg') for n in names), \
    '素材包混入了 .svg 旁挂文件'
nv = len(names)
zv.close()
shutil.move(tmp, out)
h = hashlib.sha256()
with open(out, 'rb') as fh:
    for chunk in iter(lambda: fh.read(1 << 20), b''):
        h.update(chunk)
print('已生成 %s（%.1f MB，%d 个文件）' % (out, os.path.getsize(out) / 1048576, nv))
print('  sha256 = %s' % h.hexdigest())
print('  校验：CRC 全通过 ✓  main.lua 在顶层 ✓  At/At.lua ✓  单作品=%s ✓' % work)

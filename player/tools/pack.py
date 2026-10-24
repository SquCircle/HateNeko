#!/usr/bin/env python3
"""把 knplayer 打包成 .love（zip，改后缀）。

最简用法（**不用写路径**，作品名即可）：
    python3 tools/pack.py atkn                  # → builds/atkn.love
    python3 tools/pack.py atkn -o /tmp/a.love
    python3 tools/pack.py atkn --key-sim --diag

也可以给路径：
    python3 tools/pack.py bcmkn/atkn.bcmkn      # 名字自动取 atkn
    python3 tools/pack.py ../builds/x.love --work=atkn   # 旧写法：第一个参数是输出路径

发布包的默认规则：
  * **单作品**：默认只打所选作品（名字缺省时读 conf.lua 的 STARTUP.work）；
    同时只收该作品真正引用的素材（M.assets / M.audios 的 id 闭包）。
    --all-works 才恢复"所有 works/*.lua + 全部素材并集"的旧行为（体积巨大，仅调试用）。
  * **必须包含 At/**：AtLua 是变量/列表 monitor、控制台、DBG 面板、屏幕按键的依赖；
    旧脚本漏了它，按旧脚本打的包会静默退化成"无 UI"。
  * **conf.lua 现改现塞**：包内 STARTUP.work 会被改写为所选作品，不改仓库文件。
默认输出：<workspace>/builds/<作品>.love
"""
import argparse
import hashlib
import os
import re
import shutil
import sys
import zipfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))  # player/
WORKSPACE = os.path.dirname(ROOT)
DEFAULT_BUILDS = os.path.join(WORKSPACE, 'builds')

MEDIA = ('.png', '.jpg', '.jpeg', '.gif', '.webp', '.mp3', '.ogg', '.wav', '.m4a', '.svg')


# ---------------------------------------------------------------- 名字/路径解析
def work_name_of(arg):
    """'atkn' / 'atkn.bcmkn' / 'works/atkn.lua' / 'bcmkn/atkn.bcmkn' → 'atkn'。"""
    base = os.path.basename(str(arg).rstrip('/\\'))
    stem = os.path.splitext(base)[0]
    return re.sub(r'[^A-Za-z0-9_]', '_', stem).strip('_') or stem


def conf_work():
    p = os.path.join(ROOT, 'conf.lua')
    try:
        src = open(p, encoding='utf-8').read()
    except OSError:
        return None
    m = re.search(r'\bwork\s*=\s*"([^"]*)"', src)
    return m.group(1) if m else None


def compiled_works():
    d = os.path.join(ROOT, 'works')
    if not os.path.isdir(d):
        return []
    return sorted(f[:-4] for f in os.listdir(d) if f.endswith('.lua'))


def resolve_work(pos, explicit):
    """作品名优先级：--work > 位置参数 > conf.lua。"""
    if explicit:
        return explicit
    if pos:
        return work_name_of(pos)
    return conf_work()


def resolve_targets(pos, out_opt, work_opt):
    """位置参数既可以是作品名，也可以是旧写法的输出 .love 路径。"""
    out = out_opt
    pos_work = None
    if pos:
        if str(pos).lower().endswith('.love'):
            if out is None:
                out = pos
        else:
            pos_work = pos
    work = resolve_work(pos_work, work_opt)
    if not work:
        raise SystemExit('ERROR: 没能确定作品名。用法：python3 tools/pack.py <作品名>'
                         '（或 --work=名称）')
    if out is None:
        out = os.path.join(DEFAULT_BUILDS, work + '.love')
    else:
        out = os.path.abspath(out)
    return work, out


def build_parser():
    ap = argparse.ArgumentParser(
        prog='pack.py',
        description='把 knplayer + 一个作品打包成 .love（只传作品名即可）。',
        epilog=(
            '例子：\n'
            '  python3 tools/pack.py atkn                    # → builds/atkn.love\n'
            '  python3 tools/pack.py atkn --key-sim --diag\n'
            '  python3 tools/pack.py atkn -o /tmp/a.love\n'
            '  python3 tools/pack.py                         # 用 conf.lua 的 STARTUP.work\n'
            '  python3 tools/pack.py --list                  # 看哪些作品已编译\n'
        ),
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    ap.add_argument('work_or_out', nargs='?', help='作品名（atkn）或 .love 输出路径（旧写法）')
    ap.add_argument('--work', default=None, help='作品内部名（覆盖从名字推断）')
    ap.add_argument('-o', '--out', default=None, help='输出 .love（默认 builds/<作品>.love）')
    ap.add_argument('--key-sim', action='store_true', help='屏幕键盘面板默认显示（key_sim=true）')
    ap.add_argument('--diag', action='store_true', help='写入 diag.on：真机逐帧取证')
    ap.add_argument('--draw-dump', action='store_true', help='写入 draw_dump.on：逐帧绘制快照')
    ap.add_argument('--b1-probe', action='store_true', help='写入 b1_probe.on：B1 探针')
    ap.add_argument('--all-works', action='store_true', help='所有 works/*.lua 全进包（体积大）')
    ap.add_argument('--list', action='store_true', help='列出已编译作品与已有 .love')
    ap.add_argument('--dry-run', action='store_true', help='只打印将要打的包，不写文件')
    return ap


# ---------------------------------------------------------------- 打包主体
def build_package(work, out, flags):
    DIAG = '--diag' in flags
    DRAW_DUMP = '--draw-dump' in flags
    B1_PROBE = '--b1-probe' in flags
    ALL_WORKS = '--all-works' in flags
    KEY_SIM = '--key-sim' in flags

    conf_path = os.path.join(ROOT, 'conf.lua')
    with open(conf_path, encoding='utf-8') as f:
        conf_src = f.read()
    m = re.search(r'\bwork\s*=\s*"([^"]*)"', conf_src)
    work_file = os.path.join(ROOT, 'works', work + '.lua')
    if not os.path.isfile(work_file):
        print('ERROR: 作品还没编译：works/%s.lua' % work, file=sys.stderr)
        print('  先编译：python3 tools/kn.py build %s' % work, file=sys.stderr)
        return 2

    conf_out = conf_src[:m.start(1)] + work + conf_src[m.end(1):] if m else conf_src
    if KEY_SIM:
        conf_out, n_key = re.subn(r'(\bkey_sim\s*=\s*)false', r'\1true', conf_out, count=1)
        print('屏幕按键：conf 内 key_sim 已写为 true' if n_key
              else 'WARN: --key-sim 未找到 key_sim=false，未改写')

    out_dir = os.path.dirname(out)
    if out_dir and not os.path.isdir(out_dir):
        os.makedirs(out_dir, exist_ok=True)
    rel_out = os.path.relpath(out, ROOT).replace(os.sep, '/')
    shown_out = rel_out if not rel_out.startswith('..') else out
    print('打包作品：%s  →  %s' % (work, shown_out))

    if ALL_WORKS:
        selected = compiled_works()
        print('注意：--all-works 模式，%d 个作品全部进包' % len(selected))
    else:
        selected = [work]

    # 素材闭包（只扫入选作品）
    needed = set()
    for name in selected:
        p = os.path.join(ROOT, 'works', name + '.lua')
        src = open(p, encoding='utf-8', errors='ignore').read()
        for pat in (r'M\.assets = \{(.*?)\n\}', r'M\.audios = \{(.*?)\n\}'):
            mm = re.search(pat, src, re.S)
            if mm:
                for k in re.findall(r'\["([0-9a-fA-F-]{8,})"\] = \{', mm.group(1)):
                    needed.add(k)
    print('作品引用素材 %d 个' % len(needed))

    def comp_type(rel):
        return zipfile.ZIP_STORED if rel.lower().endswith(MEDIA) else zipfile.ZIP_DEFLATED

    def add(z, full, rel):
        z.write(full, rel, compress_type=comp_type(rel))

    def add_bytes(z, rel, data):
        z.writestr(rel, data, compress_type=comp_type(rel))

    def walk_dir(z, dirname):
        base = os.path.join(ROOT, dirname)
        if not os.path.isdir(base):
            return
        for dirpath, _, files in os.walk(base):
            for f in sorted(files):
                if f == '.DS_Store':
                    continue
                full = os.path.join(dirpath, f)
                rel = os.path.relpath(full, ROOT)
                add(z, full, rel)

    assert os.path.isfile(os.path.join(ROOT, 'At', 'At.lua')), \
        'At/At.lua 缺失：变量/列表 monitor、控制台、DBG 面板与屏幕按键都会失效'

    tmp = out + '.tmp'  # 先写临时文件，校验通过再原子改名（避免别人读到半截包 → CRC 错）
    with zipfile.ZipFile(tmp, 'w', zipfile.ZIP_DEFLATED) as z:
        add(z, os.path.join(ROOT, 'main.lua'), 'main.lua')
        add_bytes(z, 'conf.lua', conf_out.encode('utf-8'))
        walk_dir(z, 'rt')
        walk_dir(z, 'At')
        for name in selected:
            rel = 'works/%s.lua' % name
            add(z, os.path.join(ROOT, rel), rel)
        assets = os.path.join(ROOT, 'works', 'assets')
        if os.path.isdir(assets):
            for f in sorted(os.listdir(assets)):
                full = os.path.join(assets, f)
                if not os.path.isfile(full):
                    continue
                if os.path.splitext(f)[0] not in needed:
                    continue
                if f.lower().endswith('.svg'):
                    continue
                add(z, full, os.path.relpath(full, ROOT))
        if DIAG:
            z.writestr('diag.on', '')
        if DRAW_DUMP:
            z.writestr('draw_dump.on', '')
        if B1_PROBE:
            z.writestr('b1_probe.on', '')

    # 校验
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
    print('已生成 %s（%.1f MB，%d 个文件）' % (shown_out, os.path.getsize(out) / 1048576, nv))
    print('  sha256 = %s' % h.hexdigest())
    print('  校验：CRC 全通过 ✓  main.lua 在顶层 ✓  At/At.lua ✓  单作品=%s ✓' % work)
    return 0


def list_works():
    works = compiled_works()
    print('已编译作品（player/works/*.lua）：%d 个' % len(works))
    if works:
        print('  ' + '  '.join(works))
    if os.path.isdir(DEFAULT_BUILDS):
        loves = sorted(f for f in os.listdir(DEFAULT_BUILDS) if f.endswith('.love'))
        print('已有包（builds/）：%d 个' % len(loves))
        for f in loves:
            full = os.path.join(DEFAULT_BUILDS, f)
            print('  %-44s %5.1f MB' % (f, os.path.getsize(full) / 1048576))
    return 0


def main(argv=None):
    ap = build_parser()
    args = ap.parse_args(argv)
    if args.list:
        return list_works()
    work, out = resolve_targets(args.work_or_out, args.out, args.work)
    flags = set()
    for name in ('key_sim', 'diag', 'draw_dump', 'b1_probe', 'all_works'):
        if getattr(args, name):
            flags.add('--' + name.replace('_', '-'))
    if args.dry_run:
        print('作品：%s' % work)
        print('输出：%s' % os.path.relpath(out, ROOT).replace(os.sep, '/'))
        print('作品产物：%s' % ('works/%s.lua（存在）' % work
                              if os.path.isfile(os.path.join(ROOT, 'works', work + '.lua'))
                              else 'works/%s.lua（缺失，需要先编译）' % work))
        print('开关：%s' % (' '.join(sorted(flags)) or '（无）'))
        return 0
    return build_package(work, out, flags)


if __name__ == '__main__':
    sys.exit(main())

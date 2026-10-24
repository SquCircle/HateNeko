#!/usr/bin/env python3
"""knplayer 一站式工具：编译 + 打包（**只要作品名，不用写路径**）。

用法（在 player/ 或仓库根目录都能跑）：
    python3 tools/kn.py build atkn        # bcmkn/atkn.bcmkn → works/atkn.lua → builds/atkn.love
    python3 tools/kn.py build              # 用 conf.lua 里的 STARTUP.work
    python3 tools/kn.py compile atkn       # 只编译
    python3 tools/kn.py pack atkn          # 只打包（作品已编译）
    python3 tools/kn.py list               # 看有哪些作品/包
    python3 tools/kn.py                    # 帮助 + 列表

作品参数可以写：
    atkn                    作品名（在 bcmkn/、tests/fixtures/ 里找 .bcmkn）
    bcmkn/atkn.bcmkn        直接给路径
    works/atkn.lua          给编译产物（只会走打包）

常用开关：
    -o/--out 路径           打包输出（默认 <仓库>/builds/<作品>.love）
    --no-assets             编译时不联网/不校验素材（离线）
    --force                 强制重新编译（默认只在 .bcmkn 比 .lua 新时才编）
    --reuse                 完全不编译，直接打包现有 works/<作品>.lua
    --key-sim               屏幕键盘面板默认显示
    --diag / --draw-dump / --b1-probe   真机取证开关
    --trampoline            过程调用走显式 trampoline
    --dry-run               只打印将要做什么
"""
import argparse
import os
import re
import subprocess
import sys
import time

PLAYER = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))  # player/
WORKSPACE = os.path.dirname(PLAYER)
BCMKN = os.path.join(WORKSPACE, 'bcmkn')      # 日常使用：仓库根 bcmkn/
BCMKN_ALT = os.path.join(PLAYER, 'bcmkn')     # 历史位置：player/bcmkn/
FIXTURES = os.path.join(PLAYER, 'tests', 'fixtures')
WORKS = os.path.join(PLAYER, 'works')
BUILDS = os.path.join(WORKSPACE, 'builds')

C_OK = '\033[32m'
C_DIM = '\033[2m'
C_B = '\033[1m'
C_END = '\033[0m'


def _color(s, c):
    if not sys.stdout.isatty():
        return s
    return c + s + C_END


def say(msg):
    print(msg, flush=True)


def rel(p):
    for base in (PLAYER, WORKSPACE):
        r = os.path.relpath(p, base).replace(os.sep, '/')
        if not r.startswith('..'):
            return r
    return p


def conf_work():
    try:
        src = open(os.path.join(PLAYER, 'conf.lua'), encoding='utf-8').read()
    except OSError:
        return None
    m = re.search(r'\bwork\s*=\s*"([^"]*)"', src)
    return m.group(1) if m else None


def available_bcmkn():
    """只列 bcmkn/ 下的作品源；tests/fixtures 是回归用例，不打扰用户。"""
    out = []
    for d in (BCMKN, BCMKN_ALT):
        if os.path.isdir(d):
            for f in sorted(os.listdir(d)):
                if f.lower().endswith('.bcmkn'):
                    out.append(os.path.splitext(f)[0])
    return out


def available_works():
    if not os.path.isdir(WORKS):
        return []
    return sorted(f[:-4] for f in os.listdir(WORKS) if f.endswith('.lua'))


def resolve(arg):
    """→ (作品名, .bcmkn 路径或 None)。接受名字或路径。"""
    if not arg:
        name = conf_work()
        if not name:
            die('没有给作品名，conf.lua 里也没有 STARTUP.work。用法：kn build <作品名>')
        for d in (BCMKN, BCMKN_ALT):
            cand = os.path.join(d, name + '.bcmkn')
            if os.path.isfile(cand):
                return name, cand
        return name, None

    p = os.path.abspath(arg)
    if os.path.isfile(p):
        name = os.path.splitext(os.path.basename(p))[0]
        return name, (p if p.lower().endswith('.bcmkn') else None)

    name = os.path.splitext(os.path.basename(arg))[0]
    for d in (BCMKN, BCMKN_ALT, FIXTURES):
        cand = os.path.join(d, name + '.bcmkn')
        if os.path.isfile(cand):
            return name, cand
    if os.path.isfile(os.path.join(WORKS, name + '.lua')):
        return name, None
    names = available_bcmkn()
    die('找不到作品「%s」的 .bcmkn。\n  现有作品：%s\n  也可以直接给路径：kn build bcmkn/%s.bcmkn'
        % (arg, '、'.join(names[:16]) or '（bcmkn/ 为空）', name))


def die(msg, code=2):
    print('ERROR: ' + msg, file=sys.stderr)
    raise SystemExit(code)


def run(cmd, dry=False):
    say(_color('→ ' + ' '.join(_short(cmd)), C_DIM))
    if dry:
        return 0
    try:
        return subprocess.call(cmd, cwd=PLAYER)
    except KeyboardInterrupt:
        die('已中断', 130)


def _short(cmd):
    out = []
    for i, c in enumerate(cmd):
        if i == 0 and isinstance(c, str):
            out.append(os.path.basename(c))
        elif isinstance(c, str) and os.path.isabs(c) and (
                c.startswith(PLAYER + os.sep) or c.startswith(WORKSPACE + os.sep)):
            base = PLAYER if c.startswith(PLAYER + os.sep) else WORKSPACE
            out.append(os.path.relpath(c, base).replace(os.sep, '/'))
        else:
            out.append(c)
    return out


def compile_work(name, bcmkn, no_assets=False, trampoline=False, dry=False):
    lua = os.path.join(WORKS, name + '.lua')
    if not bcmkn:
        die('作品「%s」没有 .bcmkn 源文件，无法编译；如果只是打包请用：kn pack %s' % (name, name))
    cmd = [sys.executable, '-m', 'kntl.compile', bcmkn, lua]
    if no_assets:
        cmd.append('--no-assets')
    if trampoline:
        cmd.append('--proc-trampoline')
    rc = run(cmd, dry)
    if rc != 0:
        die('编译失败（exit %d）' % rc, rc)
    if not dry and not os.path.isfile(lua):
        die('编译后找不到 works/%s.lua' % name)
    return lua


def refresh_fingerprint(dry=False):
    return run([sys.executable, os.path.join(PLAYER, 'tools', 'gen_build.py')], dry)


def pack_work(name, out=None, flags=(), dry=False):
    lua = os.path.join(WORKS, name + '.lua')
    if not os.path.isfile(lua):
        die('作品「%s」还没编译（缺 works/%s.lua）。\n  先跑：kn build %s' % (name, name, name))
    out = os.path.abspath(out) if out else os.path.join(BUILDS, name + '.love')
    cmd = [sys.executable, os.path.join(PLAYER, 'tools', 'pack.py'), out, '--work=' + name]
    cmd += list(flags)
    rc = run(cmd, dry)
    if rc != 0:
        die('打包失败（exit %d）' % rc, rc)
    return out


def is_stale(bcmkn, lua):
    if not bcmkn or not os.path.isfile(lua):
        return True
    return os.path.getmtime(bcmkn) > os.path.getmtime(lua)


def cmd_build(args):
    name, bcmkn = resolve(args.work)
    lua = os.path.join(WORKS, name + '.lua')
    say(_color('== %s ==' % name, C_B))
    say('源文件：%s' % (rel(bcmkn) if bcmkn else '（无 .bcmkn，使用现有编译产物）'))
    say('输出：  %s' % rel(os.path.abspath(args.out) if args.out
                          else os.path.join(BUILDS, name + '.love')))
    if args.reuse and os.path.isfile(lua):
        say(_color('编译：复用 works/%s.lua' % name, C_DIM))
    elif not bcmkn:
        if os.path.isfile(lua):
            say(_color('编译：没有 .bcmkn 源文件，复用 works/%s.lua（不会重新编译）' % name, C_DIM))
            if args.dry_run:
                pass
        else:
            die('作品「%s」既没有 .bcmkn 源也没有 works/%s.lua' % (name, name))
    elif is_stale(bcmkn, lua) or args.force:
        compile_work(name, bcmkn, args.no_assets, args.trampoline, args.dry_run)
    else:
        say(_color('编译：works/%s.lua 已是最新（用 --force 可强制重编）' % name, C_DIM))
    if not args.dry_run:
        refresh_fingerprint()
        if os.path.isfile(lua):
            print(_color('  编译产物 %s（%d 行）' % (rel(lua), sum(1 for _ in open(lua, encoding='utf-8'))),
                         C_DIM))
    out = pack_work(name, args.out, args.pack_flags, args.dry_run)
    if not args.dry_run:
        say(_color('完成 ✓  %s（%.1f MB）' % (rel(out), os.path.getsize(out) / 1048576), C_OK))
    return 0


def cmd_compile(args):
    name, bcmkn = resolve(args.work)
    say(_color('== 编译 %s ==' % name, C_B))
    compile_work(name, bcmkn, args.no_assets, args.trampoline, args.dry_run)
    lua = os.path.join(WORKS, name + '.lua')
    if not args.dry_run:
        say(_color('完成 ✓  works/%s.lua（%d 行）' % (name, sum(1 for _ in open(lua, encoding='utf-8'))),
                   C_OK))
    return 0


def cmd_pack(args):
    name, _ = resolve(args.work)
    say(_color('== 打包 %s ==' % name, C_B))
    if not args.dry_run:
        refresh_fingerprint()
    out = pack_work(name, args.out, args.pack_flags, args.dry_run)
    if not args.dry_run:
        say(_color('完成 ✓  %s（%.1f MB）' % (rel(out), os.path.getsize(out) / 1048576), C_OK))
    return 0


def cmd_list(_args):
    bs, ws = available_bcmkn(), available_works()
    say('作品（bcmkn/ 源 + works/ 编译产物）：')
    names = sorted(set(bs) | set(ws))
    if not names:
        say('  （空）')
    for n in names:
        marks = ('✓源' if n in bs else '  ·') + (' ✓编译' if n in ws else '')
        say('  %-24s %s' % (n, marks))
    if os.path.isdir(BUILDS):
        loves = sorted(f for f in os.listdir(BUILDS) if f.endswith('.love'))
        say('\n已有包（builds/）：%d 个' % len(loves))
        for f in loves:
            p = os.path.join(BUILDS, f)
            say('  %-40s %5.1f MB  %s' % (f, os.path.getsize(p) / 1048576,
                                          time.strftime('%H:%M', time.localtime(os.path.getmtime(p)))))
    return 0


def build_parser():
    ap = argparse.ArgumentParser(
        prog='kn',
        description='knplayer 一站式工具：编译 + 打包（只要作品名，不用写路径）。',
        epilog=(
            '例子：\n'
            '  python3 tools/kn.py build atkn         # 编译 + 打包 → builds/atkn.love\n'
            '  python3 tools/kn.py build atkn --key-sim --diag\n'
            '  python3 tools/kn.py build              # 用 conf.lua 的 STARTUP.work\n'
            '  python3 tools/kn.py compile atkn       # 只编译\n'
            '  python3 tools/kn.py pack atkn          # 只打包\n'
            '  python3 tools/kn.py list               # 看作品与包\n'
        ),
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    sub = ap.add_subparsers(dest='cmd')

    def add_common(p, pack_flags=True):
        p.add_argument('work', nargs='?', default=None,
                       help='作品名（atkn）或路径（bcmkn/atkn.bcmkn）；缺省用 conf.lua')
        p.add_argument('-o', '--out', default=None, help='.love 输出路径（默认 builds/<作品>.love）')
        p.add_argument('--dry-run', action='store_true', help='只打印步骤，不执行')
        if pack_flags:
            p.add_argument('--key-sim', action='store_true')
            p.add_argument('--diag', action='store_true')
            p.add_argument('--draw-dump', action='store_true')
            p.add_argument('--b1-probe', action='store_true')

    p = sub.add_parser('build', help='编译（必要时）+ 打包')
    add_common(p)
    p.add_argument('--no-assets', action='store_true', help='编译时不联网/不校验素材')
    p.add_argument('--trampoline', action='store_true', help='过程调用走显式 trampoline')
    p.add_argument('--force', action='store_true', help='强制重新编译')
    p.add_argument('--reuse', action='store_true', help='不编译，直接用现有 works/<作品>.lua')
    p.set_defaults(func=cmd_build)

    p = sub.add_parser('compile', help='只编译')
    add_common(p, pack_flags=False)
    p.add_argument('--no-assets', action='store_true')
    p.add_argument('--trampoline', action='store_true')
    p.set_defaults(func=cmd_compile)

    p = sub.add_parser('pack', help='只打包（作品需已编译）')
    add_common(p)
    p.set_defaults(func=cmd_pack)

    p = sub.add_parser('list', help='列出作品与已有包')
    p.set_defaults(func=cmd_list)
    return ap


def main(argv=None):
    ap = build_parser()
    args = ap.parse_args(argv)
    if not getattr(args, 'func', None):
        ap.print_help()
        print()
        cmd_list(args)
        return 0
    args.pack_flags = []
    for name in ('key_sim', 'diag', 'draw_dump', 'b1_probe'):
        if getattr(args, name, False):
            args.pack_flags.append('--' + name.replace('_', '-'))
    return args.func(args)


if __name__ == '__main__':
    try:
        rc = main()
    except BrokenPipeError:      # `kn list | head` 这类管道提前关闭：安静退出
        os._exit(0)
    except KeyboardInterrupt:
        os._exit(130)
    sys.exit(rc)

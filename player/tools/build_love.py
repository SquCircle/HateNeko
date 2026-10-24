#!/usr/bin/env python3
"""一站式：.bcmkn -> 编译 -> 打包 .love（兼容旧入口，内部转给 tools/kn.py）。

推荐直接用：
    python3 tools/kn.py build atkn          # 只要作品名
    python3 tools/kn.py build               # 用 conf.lua 的 STARTUP.work

旧写法仍然可用（两个位置参数）：
    python3 tools/build_love.py bcmkn/atkn.bcmkn ../builds/atkn.love [--key-sim]
    python3 tools/build_love.py bcmkn/atkn.bcmkn                # 输出 build/<名字>.love
"""
import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def main(argv=None):
    args = list(sys.argv[1:] if argv is None else argv)
    pos, rest = [], []
    for a in args:
        if a.startswith('-'):
            rest.append(a)
        else:
            pos.append(a)
    if not pos:
        print(__doc__.strip())
        return 2
    src = pos[0]
    cmd = [sys.executable, os.path.join(ROOT, 'tools', 'kn.py'), 'build', src]
    if len(pos) >= 2:
        cmd += ['--out', pos[1]]
    cmd += rest
    return __import__('subprocess').call(cmd, cwd=ROOT)


if __name__ == '__main__':
    sys.exit(main())

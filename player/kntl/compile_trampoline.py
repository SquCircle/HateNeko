"""过程 trampoline 编译器分支入口。

用法与 `python3 -m kntl.compile` 相同，额外强制启用 --proc-trampoline。
"""
import sys
from kntl.compile import main

if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:] + ["--proc-trampoline"]))

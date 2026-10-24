#!/usr/bin/env python3
"""预编译所有测试作品：tests/fixtures/*.bcmkn -> tests/fixtures/compiled/<名>.lua + .report.json

Lua 侧只保留运行时；所有"作品 -> Lua"的工作都在 Python 编译期完成。
"""
import glob
import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from kntl import emit, spec  # noqa: E402


def main():
    root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    os.chdir(root)
    spec.load()
    outdir = "tests/fixtures/compiled"
    os.makedirs(outdir, exist_ok=True)
    n = 0
    paths = sorted(glob.glob("tests/fixtures/*.bcmkn")
                   + glob.glob("tests/fixtures/*.bcmkn.json"))
    for path in paths:
        base = os.path.basename(path)
        stem = base[:-len(".json")] if base.endswith(".bcmkn.json") else os.path.splitext(base)[0]
        if stem.endswith(".bcmkn"):
            stem = stem[:-len(".bcmkn")]
        with open(path, "rb") as f:
            work = json.loads(f.read().decode("utf-8"))
        src, rep = emit.compile_work(work)
        with open(os.path.join(outdir, stem + ".lua"), "wb") as f:
            f.write(src.encode("utf-8"))
        small = {k: rep.get(k, {}) for k in ("hats", "calls", "unknown", "literals")}
        small["procedures"] = rep.get("procedures") or 0
        small["loose"] = rep.get("loose") or 0
        with open(os.path.join(outdir, stem + ".report.json"), "w", encoding="utf-8") as f:
            json.dump(small, f, ensure_ascii=False)
        n += 1
    print("预编译 %d 个测试作品 → %s" % (n, outdir))


if __name__ == "__main__":
    main()

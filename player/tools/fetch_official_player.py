#!/usr/bin/env python3
"""抓取官方 KittenN 播放器（web release）到 tanyue_kn/player/，用于对照运行时语义。

来源：
  播放页 https://kn.codemao.cn/player
    → https://creation.bcmcdn.com/neko/web/release/static/js/main.<hash>.js
    → 其 webpack chunk 表里列出的全部 <id>.<hash>.chunk.js

产物（../reference/analysis/official_player/）：
  player.<hash>.js, chunk.*.js, pchunk.<id>.<hash>.js
"""
import json
import os
import re
import ssl
import sys
import time
import urllib.request

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DEST = os.environ.get("KN_OFFICIAL_PLAYER") or os.path.join(
    os.path.dirname(ROOT), "analysis", "official_player")
BASE = "https://creation.bcmcdn.com/neko/web/release/static/js/"
ENTRY = "https://kn.codemao.cn/player"
UA = {"User-Agent": "Mozilla/5.0"}


def get(url, timeout=120, tries=6):
    ctx = ssl.create_default_context()
    for i in range(tries):
        try:
            req = urllib.request.Request(url, headers=dict(UA, Connection="close"))
            return urllib.request.urlopen(req, timeout=timeout, context=ctx).read()
        except Exception as e:  # noqa: BLE001
            print("  retry", url.rsplit("/", 1)[-1], i, str(e)[:50], file=sys.stderr)
            time.sleep(2)
    return None


def main():
    os.makedirs(DEST, exist_ok=True)
    html = get(ENTRY).decode("utf-8", "ignore")
    scripts = re.findall(r'src="(https://creation\.bcmcdn\.com/neko/web/release/static/js/[^"]+\.js)"', html)
    print("入口脚本:", [s.rsplit("/", 1)[-1] for s in scripts])
    main_js = None
    for s in scripts:
        name = s.rsplit("/", 1)[-1]
        path = os.path.join(DEST, ("player." if name.startswith("main.") else "") + name)
        if not os.path.exists(path):
            data = get(s)
            if data:
                open(path, "wb").write(data)
        if name.startswith("main."):
            main_js = path
        print("  ", name, os.path.getsize(path) // 1024 if os.path.exists(path) else "-", "KB")

    if not main_js:
        print("没找到 main.js", file=sys.stderr)
        return 1
    src = open(main_js, encoding="utf-8", errors="ignore").read()
    i = src.find("__webpack_require__.u=")
    pairs = re.findall(r'(\d+):"([a-f0-9]{8})"', src[i:i + 6000])
    print("chunk 数:", len(pairs))
    ok = fail = 0
    for cid, h in pairs:
        fn = os.path.join(DEST, f"pchunk.{cid}.{h}.js")
        if os.path.exists(fn) and os.path.getsize(fn) > 1000:
            ok += 1
            continue
        data = get(BASE + f"{cid}.{h}.chunk.js")
        if data and len(data) > 1000:
            open(fn, "wb").write(data)
            ok += 1
        else:
            fail += 1
            print("  FAIL", cid, file=sys.stderr)
    print(f"完成：{ok} 个 chunk 就绪，{fail} 个失败（重跑本脚本可续传）")
    return 0


if __name__ == "__main__":
    sys.exit(main())

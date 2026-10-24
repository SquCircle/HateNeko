"""kntl.compile —— 作品编译入口（Python）

用法：
    python3 -m kntl.compile <作品.bcmkn> [输出.lua] [--assets-dir=works] [--no-assets] [--spec=路径]

编译期职责（Lua 只负责运行时）：
  1. 解析作品 JSON
  2. 生成 Lua 模块（数据 + 每个 hat 的 body 闭包）
  3. **下载并校验全部素材**（造型/音频），缺失即报错退出
"""
import argparse
import json
import os
import re
import subprocess
import sys
import threading
import urllib.request

from . import emit
from . import spec
from . import support


def _is_svg(data):
    head = data[:4096].lower()
    return b"<svg" in head


def _svg_intrinsic(text):
    """SVG 的内在尺寸：width/height 属性，缺则用 viewBox。官方按这个尺寸当纹理大小。"""
    m = re.search(rb"<svg[^>]*>", text, re.S)
    tag = m.group(0).decode("utf-8", "ignore") if m else ""
    w = re.search(r'width="([\d.]+)', tag)
    h = re.search(r'height="([\d.]+)', tag)
    if w and h:
        try:
            return float(w.group(1)), float(h.group(1))
        except ValueError:
            pass
    vb = re.search(r'viewBox="([-\d.]+)\s+([-\d.]+)\s+([\d.]+)\s+([\d.]+)"', tag)
    if vb:
        return float(vb.group(3)), float(vb.group(4))
    return None


def _rasterize_svg(svg_path, png_path, w, h):
    """按内在尺寸栅格化（不是固定 512！之前一律 512 导致 SVG 角色被放大 4 倍+）。"""
    w, h = max(1, int(round(w))), max(1, int(round(h)))
    cmds = [
        ["rsvg-convert", "-w", str(w), "-h", str(h), svg_path, "-o", png_path],
        ["rsvg-convert", "--width", str(w), "--height", str(h), "-o", png_path, svg_path],
    ]
    for c in cmds:
        try:
            r = subprocess.run(c, capture_output=True)
            if r.returncode == 0 and os.path.exists(png_path) and os.path.getsize(png_path) > 0:
                return True
        except FileNotFoundError:
            continue
    try:
        import cairosvg  # type: ignore
        cairosvg.svg2png(url=svg_path, write_to=png_path, output_width=w, output_height=h)
        return True
    except Exception:
        pass
    return False


def _maybe_convert_svg(path_noext, data, quiet=False):
    """下载到的是 SVG → 存 .svg 旁挂文件 + 按内在尺寸栅格化成 .png。返回新的目标文件路径。"""
    if not _is_svg(data):
        return None
    svg_path = path_noext + ".svg"
    with open(svg_path, "wb") as f:
        f.write(data)
    size = _svg_intrinsic(data)
    if not size:
        return svg_path
    png_path = path_noext + ".png"
    ok = _rasterize_svg(svg_path, png_path, size[0], size[1])
    if not quiet:
        print("  SVG %s → PNG %dx%d %s" % (os.path.basename(path_noext), int(round(size[0])),
                                           int(round(size[1])), "✓" if ok else "✗ 转换失败"))
    return png_path if ok else svg_path


def _ext_of(url, default):
    base = str(url or "").split("?")[0].split("#")[0]
    i = base.rfind(".")
    if i >= 0 and "/" not in base[i:]:
        return base[i + 1:]
    return default


def collect_assets(work):
    """返回 [(id, url, ext, 目标文件相对路径)]。"""
    out = []
    for sid, st in ((work.get("styles") or {}).get("stylesDict") or {}).items():
        url = st.get("url") or ""
        if not url:
            continue
        out.append((sid, url, _ext_of(url, "png"), "assets/%s.%s" % (sid, _ext_of(url, "png"))))
    for aid, au in ((work.get("audios") or {}).get("audiosDict") or {}).items():
        url = au.get("url") or ""
        if not url:
            continue
        out.append((aid, url, _ext_of(url, "mp3"), "assets/%s.%s" % (aid, _ext_of(url, "mp3"))))
    return out


def sync_assets(work, assets_dir, workers=12, timeout=40, quiet=False):
    """把缺失素材下载到 <assets_dir>/assets/ 下；返回 (已存在, 新下载, 失败列表)。"""
    items = collect_assets(work)
    root = os.path.join(assets_dir, "assets")
    os.makedirs(root, exist_ok=True)
    have, need = [], []
    for ident, url, ext, rel in items:
        path = os.path.join(assets_dir, rel)
        (have if os.path.exists(path) and os.path.getsize(path) > 0 else need).append((ident, url, path))
    if need:
        lock = threading.Lock()
        failed = []
        idx = {"n": 0}

        def fetch(pair):
            ident, url, path = pair
            last = None
            for _ in range(3):
                try:
                    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
                    data = urllib.request.urlopen(req, timeout=timeout).read()
                    if len(data) > 0:
                        if _is_svg(data):
                            _maybe_convert_svg(os.path.splitext(path)[0], data)
                        else:
                            with open(path, "wb") as f:
                                f.write(data)
                        with lock:
                            idx["n"] += 1
                            if not quiet:
                                print("  下载 %s … %d KB" % (ident[:8], len(data) // 1024))
                        return
                except Exception as e:  # noqa: BLE001
                    last = e
            with lock:
                failed.append((ident, url, str(last)))

        threads = []
        queue = list(need)
        qlock = threading.Lock()

        def worker():
            while True:
                with qlock:
                    if not queue:
                        return
                    pair = queue.pop()
                fetch(pair)

        for _ in range(min(workers, len(queue))):
            t = threading.Thread(target=worker, daemon=True)
            t.start()
            threads.append(t)
        for t in threads:
            t.join()

        # 校验
        for ident, url, path in need:
            if not os.path.exists(path) or os.path.getsize(path) == 0:
                if not any(f[0] == ident for f in failed):
                    failed.append((ident, url, "文件为空"))
        return len(have), idx["n"], failed
    return len(have), 0, []


def repair_svgs(work, assets_dir):
    """历史上按 512 宽栅格化的 SVG 素材，全部按内在尺寸重做。"""
    fixed = 0
    for sid, st in ((work.get("styles") or {}).get("stylesDict") or {}).items():
        url = (st.get("url") or "").split("?")[0]
        if not url.startswith("http"):
            continue
        base = os.path.join(assets_dir, "assets", sid)
        svg_path = base + ".svg"
        if not os.path.exists(svg_path):
            try:
                data = urllib.request.urlopen(urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"}), timeout=30).read()
            except Exception:
                continue
            if not _is_svg(data):
                continue
            with open(svg_path, "wb") as f:
                f.write(data)
        size = _svg_intrinsic(open(svg_path, "rb").read())
        if not size:
            continue
        if _rasterize_svg(svg_path, base + ".png", size[0], size[1]):
            fixed += 1
    print("SVG 素材按内在尺寸重做：%d 个" % fixed)
    return fixed


ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))  # player/
WORKSPACE = os.path.dirname(ROOT)
# 作品源有两个常见位置：仓库根的 bcmkn/（日常使用）和 player/bcmkn/（历史位置）
BCMKN_DIRS = [os.path.join(WORKSPACE, "bcmkn"), os.path.join(ROOT, "bcmkn")]


def disp_path(p):
    """显示用路径：优先仓库根/player 内的相对路径，避免一片 ../ 或绝对路径。"""
    for base in (WORKSPACE, ROOT):
        r = os.path.relpath(p, base).replace(os.sep, "/")
        if not r.startswith(".."):
            return r
    return p


def work_name_of(path):
    return os.path.splitext(os.path.basename(path))[0]


def resolve_input(arg):
    """把「作品名」或「路径」解析成 (绝对路径, 作品名)；找不到返回 (None, 名字)。

    依次尝试：
      * 原样（相对当前目录 / 绝对路径）
      * <player>/bcmkn/<名>.bcmkn
      * <player>/tests/fixtures/<名>.bcmkn
      * <player>/bcmkn/<名>（带扩展名的写法）
    """
    cands = [os.path.abspath(arg)]
    if not arg.lower().endswith(".bcmkn"):
        for d in BCMKN_DIRS:
            cands.append(os.path.join(d, arg + ".bcmkn"))
        cands.append(os.path.join(ROOT, "tests", "fixtures", arg + ".bcmkn"))
    for d in BCMKN_DIRS:
        cands.append(os.path.join(d, arg))
    for c in cands:
        if os.path.isfile(c):
            return c, work_name_of(c)
    return None, work_name_of(arg)


def available_works():
    out = []
    for d in BCMKN_DIRS + [os.path.join(ROOT, "tests", "fixtures")]:
        if not os.path.isdir(d):
            continue
        for f in sorted(os.listdir(d)):
            if f.lower().endswith(".bcmkn"):
                name = work_name_of(f)
                if name not in out:
                    out.append(name)
    return out


def main(argv=None):
    ap = argparse.ArgumentParser(
        prog="kntl.compile",
        description="把 .bcmkn 作品编译成 Lua 运行时模块（只传作品名即可）。",
        epilog=(
            "例子：\n"
            "  python3 -m kntl.compile atkn                  # bcmkn/atkn.bcmkn → works/atkn.lua\n"
            "  python3 -m kntl.compile bcmkn/atkn.bcmkn      # 也可以给路径\n"
            "  python3 -m kntl.compile atkn -o /tmp/a.lua --no-assets\n"
            "  python3 -m kntl.compile atkn -o -             # 输出到 stdout\n"
            "\n默认素材目录：<player>/works（素材已存在时不会联网）。"
        ),
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    ap.add_argument("input", help="作品名（atkn）或 .bcmkn 路径")
    ap.add_argument("output", nargs="?", default=None, help="输出 .lua；默认 works/<作品>.lua，'-' 表示 stdout")
    ap.add_argument("-o", "--out", dest="out_opt", default=None, help="输出 .lua（等价于第二个位置参数）")
    ap.add_argument("--assets-dir", default=None, help="素材目录（默认 <player>/works）")
    ap.add_argument("--no-assets", action="store_true", help="不下载/校验素材（离线编译）")
    ap.add_argument("--spec", default=None)
    ap.add_argument("--report-json", default=None, help="把编译报告写成 JSON（供工具链读取）")
    ap.add_argument("--repair-svg", action="store_true", help="按 SVG 内在尺寸重做已有素材")
    ap.add_argument("--proc-trampoline", action="store_true", help="过程调用走显式 trampoline（不占 Lua 递归栈）")
    ap.add_argument("--leaf-procs", action="store_true", help="叶子过程直调（默认关闭：会削弱过程原子性）")
    args = ap.parse_args(argv)

    src_path, name = resolve_input(args.input)
    if src_path is None:
        hint = "、".join(available_works()[:12]) or "（bcmkn/ 为空）"
        print("找不到作品：%s" % args.input, file=sys.stderr)
        print("  可按作品名直接传：python3 -m kntl.compile <名字>", file=sys.stderr)
        print("  现有作品：%s" % hint, file=sys.stderr)
        return 2

    out_opt = args.out_opt or args.output
    if out_opt is None:
        out_path = os.path.join(ROOT, "works", name + ".lua")
    elif out_opt == "-":
        out_path = None
    else:
        out_path = os.path.abspath(out_opt)
    if out_path:
        out_path_disp = disp_path(out_path)
        print("编译：%s → %s" % (disp_path(src_path), out_path_disp))

    assets_dir = args.assets_dir or os.path.join(ROOT, "works")
    if not os.path.isabs(assets_dir):
        assets_dir = os.path.join(ROOT, assets_dir)

    spec.load(args.spec)
    with open(src_path, "rb") as f:
        work = json.loads(f.read().decode("utf-8"))

    try:
        src, report = emit.compile_work(work, {"trampoline": args.proc_trampoline,
                                                "leaf_procs": args.leaf_procs})
    except emit.CompileError as e:
        print("编译错误：%s" % e, file=sys.stderr)
        return 1

    unsupported = support.unsupported_types_in_work(work)
    report["unsupported"] = unsupported
    if args.report_json:
        with open(args.report_json, "w", encoding="utf-8") as f:
            json.dump({k: report.get(k, {}) for k in ("hats", "calls", "unknown", "literals", "unsupported")},
                      f, ensure_ascii=False)

    if out_path:
        os.makedirs(os.path.dirname(out_path) or ".", exist_ok=True)
        with open(out_path, "wb") as f:
            f.write(src.encode("utf-8"))
        print("输出：%s（%d 行 / %.1f KB）" % (out_path_disp, src.count("\n"), len(src.encode("utf-8")) / 1024.0))
    else:
        sys.stdout.write(src)

    # 覆盖报告
    print("过程：%d 个" % (report.get("procedures") or 0), file=sys.stderr)
    if report["unknown"]:
        print("未知块：%s" % ", ".join(sorted(report["unknown"])), file=sys.stderr)
    if report["warn"]:
        for w in report["warn"][:10]:
            print("警告：%s" % w, file=sys.stderr)
    if report.get("loose"):
        print("游离块：%d（未挂在事件下，官方也不执行）" % report["loose"], file=sys.stderr)
    if unsupported:
        print("离线不支持：%d 类块（LÖVE 无对应服务/硬件，运行期为空操作）：" % len(unsupported), file=sys.stderr)
        for t in sorted(unsupported):
            print("  ! %s —— %s" % (t, unsupported[t]), file=sys.stderr)

    if args.repair_svg:
        repair_svgs(work, assets_dir)

    if not args.no_assets:
        have, got, failed = sync_assets(work, assets_dir)
        print("素材：已存在 %d，新下载 %d，失败 %d" % (have, got, len(failed)))
        if failed:
            for ident, url, why in failed[:10]:
                print("  ✗ %s %s（%s）" % (ident, url[:70], why), file=sys.stderr)
            print("素材不完整，编译失败", file=sys.stderr)
            return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())

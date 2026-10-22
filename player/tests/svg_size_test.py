#!/usr/bin/env python3
"""SVG 栅格化尺寸测试（无网络、秒级）。

规则：SVG 造型的 PNG 必须按**内在尺寸**（width/height 或 viewBox）栅格化。
历史 bug：一律按 rsvg-convert -w 512 输出 → 120×120 的 circle 变成 512×513（放大 4.27 倍）。
"""
import glob
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from kntl.compile import _svg_intrinsic  # noqa: E402

fails = checks = 0


def check(desc, got, want):
    global fails, checks
    checks += 1
    if got != want:
        fails += 1
        print("  FAIL %-46s got=%s want=%s" % (desc, got, want))
    else:
        print("  ok   %-46s %s" % (desc, got))


# ① 解析：width/height 属性
svg1 = b'<svg xmlns="http://www.w3.org/2000/svg" width="120" height="120.17610062893083" viewBox="0 0 120 121">'
check("解析 width/height", _svg_intrinsic(svg1), (120.0, 120.17610062893083))

# ② 只有 viewBox
svg2 = b'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 265 265">'
check("解析 viewBox", _svg_intrinsic(svg2), (265.0, 265.0))

# ③ 带换行/属性的多行标签
svg3 = b'<?xml version="1.0"?>\n<svg\n  width="48"\n  height="32"\n  viewBox="0 0 48 32">'
check("多行标签", _svg_intrinsic(svg3), (48.0, 32.0))

# ④ 无尺寸信息
check("无尺寸返回 None", _svg_intrinsic(b'<svg xmlns="x"></svg>'), None)


def png_size(path):
    with open(path, "rb") as f:
        d = f.read(33)
    if d[:8] != b"\x89PNG\r\n\x1a\n":
        return None
    return int.from_bytes(d[16:20], "big"), int.from_bytes(d[20:24], "big")


# ⑤ 素材一致性：有 .svg 旁挂的，PNG 必须等于内在尺寸（±1px）
svgs = sorted(glob.glob("works/assets/*.svg"))
bad = []
for sp in svgs:
    with open(sp, "rb") as f:
        size = _svg_intrinsic(f.read(8192))
    if not size:
        continue
    pp = sp[:-4] + ".png"
    if not os.path.exists(pp):
        continue
    dim = png_size(pp)
    if not dim:
        continue
    if abs(dim[0] - round(size[0])) > 1 or abs(dim[1] - round(size[1])) > 1:
        bad.append("%s svg=%dx%d png=%dx%d" % (os.path.basename(sp),
                                               round(size[0]), round(size[1]), dim[0], dim[1]))
print("  -- 已转换 SVG 素材 %d 个，尺寸不符 %d 个" % (len(svgs), len(bad)))
for b in bad[:6]:
    print("     ", b)
check("HTML 里所有 SVG 素材尺寸一致", len(bad), 0)

print("结果：%d 项检查，%d 项失败" % (checks, fails))
sys.exit(1 if fails else 0)

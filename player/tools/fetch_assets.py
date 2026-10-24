#!/usr/bin/env python3
"""把作品用到的媒体（造型 / 声音）下载到 <游戏目录>/<assets_dir>/assets/ 下。

命名与编译器一致：assets/<styleId>.<ext>，运行时按 id 找文件。
用法：
    python3 tools/fetch_assets.py <作品.bcmkn|.json> [--dir works] [--force]
"""
import json, os, sys, urllib.request

def svg_to_png(path):
    """下载到的 SVG 栅格化成同名 PNG（LÖVE 不支持矢量贴图）。"""
    if not path.lower().endswith('.svg'):
        return
    png = path[:-4] + '.png'
    if os.path.exists(png) and os.path.getsize(png) > 100:
        return
    import subprocess
    for tool in (['rsvg-convert', '-w', '512', path, '-o', png],
                 ['convert', path, png]):
        try:
            subprocess.run(tool, check=True, timeout=60)
            print(f'  栅格化 {os.path.basename(path)} -> {os.path.basename(png)}')
            return
        except Exception:
            continue

def main():
    args = sys.argv[1:]
    if not args:
        print(__doc__); return 2
    src = args[0]
    out_dir = 'works'
    force = '--force' in args
    for i, a in enumerate(args):
        if a == '--dir' and i + 1 < len(args):
            out_dir = args[i + 1]
    root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    asset_dir = os.path.join(root, out_dir, 'assets')
    os.makedirs(asset_dir, exist_ok=True)

    data = json.load(open(src, encoding='utf-8'))
    jobs = []
    for sid, st in (data.get('styles', {}).get('stylesDict') or {}).items():
        jobs.append((sid, st.get('url'), st.get('name')))
    for aid, au in (data.get('audios', {}).get('audiosDict') or {}).items():
        jobs.append((aid, au.get('url'), au.get('name')))

    # 并发下载：CDN 单连接很慢（~10s/文件），12 线程能把 300 个文件压到几分钟内
    import concurrent.futures as cf

    def one(job):
        ident, url, name = job
        if not url:
            return ('skip', ident, 0)
        ext = os.path.splitext(url)[1].lstrip('.') or 'bin'
        dest = os.path.join(asset_dir, f'{ident}.{ext}')
        if os.path.exists(dest) and not force:
            return ('skip', ident, 0)
        last = None
        for _ in range(3):  # 断点式重试
            try:
                req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
                blob = urllib.request.urlopen(req, timeout=90).read()
                tmp = dest + '.part'
                with open(tmp, 'wb') as fh:
                    fh.write(blob)
                os.replace(tmp, dest)
                try:
                    svg_to_png(dest)
                except Exception:
                    pass
                return ('ok', ident, len(blob))
            except Exception as e:
                last = e
        return ('fail', ident, str(last))

    ok = skip = fail = 0
    total_bytes = 0
    with cf.ThreadPoolExecutor(max_workers=12) as pool:
        for status, ident, extra in pool.map(one, jobs):
            if status == 'ok':
                ok += 1
                total_bytes += extra
                if ok % 25 == 0:
                    print(f'  已下载 {ok} 个（{total_bytes // 1024} KB）…', flush=True)
            elif status == 'skip':
                skip += 1
            else:
                fail += 1
                print(f'  !! 失败 {ident}: {extra}', flush=True)
    print(f'== 完成：下载 {ok}，已存在 {skip}，失败 {fail} → {asset_dir}', flush=True)
    return 0 if fail == 0 else 1

if __name__ == '__main__':
    sys.exit(main())

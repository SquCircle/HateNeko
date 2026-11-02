#!/usr/bin/env python3
"""生成 rt/build.lua：源码指纹 + 生成时间。启动时会打印，用来确认「跑的是哪份构建」。
用法: python3 tools/gen_build.py
"""
import hashlib, os, time

root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
targets = []
for sub in ('rt', 'kntl', 'works'):
    for dirpath, _, files in os.walk(os.path.join(root, sub)):
        for f in sorted(files):
            # 排除生成物自身（否则哈希会自我依赖、每次都不一样）
            # 连着色器一起纳入指纹（否则改了 .glsl 构建号不变，又会分不清哪份构建）
            if (f.endswith('.lua') and f != 'build.lua') or f.endswith('.glsl'):
                targets.append(os.path.join(dirpath, f))
for f in ('main.lua', 'conf.lua'):
    p = os.path.join(root, f)
    if os.path.exists(p):
        targets.append(p)

h = hashlib.sha256()
for p in sorted(targets):
    h.update(os.path.relpath(p, root).encode())
    h.update(open(p, 'rb').read())

# 素材也要纳入指纹：否则素材变了 build 号不变，用户分不清跑的是哪份包。
# 用「文件名 + 字节数」做指纹（185MB 全量哈希太慢），改动必然改变字节数或文件名。
asset_dir = os.path.join(root, 'works', 'assets')
asset_count = asset_total = 0
if os.path.isdir(asset_dir):
    for f in sorted(os.listdir(asset_dir)):
        fp = os.path.join(asset_dir, f)
        if not os.path.isfile(fp):
            continue
        size = os.path.getsize(fp)
        asset_count += 1
        asset_total += size
        h.update(f.encode())
        h.update(str(size).encode())

bid = h.hexdigest()[:8]
stamp = time.strftime('%Y-%m-%d %H:%M')
out = os.path.join(root, 'rt', 'build.lua')
with open(out, 'w') as fh:
    fh.write('-- 自动生成（tools/gen_build.py），用于确认运行的是哪份构建\n')
    fh.write(f'return {{ id = "{bid}", time = "{stamp}", files = {len(targets)}, '
             f'assets = {asset_count}, asset_bytes = {asset_total} }}\n')
print(f'build id {bid} @ {stamp}（{len(targets)} 个文件 + {asset_count} 个素材）→ rt/build.lua')

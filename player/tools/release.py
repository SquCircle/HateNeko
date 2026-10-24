#!/usr/bin/env python3
"""打发布包：源码 zip + 演示 .love + RELEASE.md + SHA256SUMS（一条命令）。

用法：
    python3 tools/release.py                       # 版本读 VERSION，演示作品 nodevm
    python3 tools/release.py --version 0.2.0
    python3 tools/release.py --demo atkn --key-sim
    python3 tools/release.py --skip-demo            # 只打源码包

产物（默认写到 <仓库>/release/HateNeko-<版本>/）：
    HateNeko-<版本>-source.zip     必要项目代码（不含 reference/、archive/、now 的 190MB 素材）
    HateNeko-<版本>-demo.love      演示作品（默认 nodevm，含屏幕按键）
    RELEASE.md / SHA256SUMS

源码包里的 `kn` 包装与 `bcmkn/` 一起发，解压后可直接 `./kn build <作品>`。
"""
import argparse
import hashlib
import os
import re
import shutil
import subprocess
import sys
import zipfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))  # player/
WORKSPACE = os.path.dirname(ROOT)
RELEASE_ROOT = os.path.join(WORKSPACE, 'release')

MEDIA = ('.png', '.jpg', '.jpeg', '.gif', '.webp', '.mp3', '.ogg', '.wav', '.m4a')
SKIP_DIRS = {'__pycache__', '.git', 'probe_out', 'archive', 'builds'}
SKIP_FILES = {'.DS_Store', 'Thumbs.db'}

# 按作品名排除大素材（now 系列每个 187MB）
HUGE_WORK_PREFIXES = ('now',)


def die(msg, code=2):
    print('ERROR: %s' % msg, file=sys.stderr)
    raise SystemExit(code)


def say(msg):
    print(msg, flush=True)


def sha256_of(path):
    h = hashlib.sha256()
    with open(path, 'rb') as f:
        for chunk in iter(lambda: f.read(1 << 20), b''):
            h.update(chunk)
    return h.hexdigest()


def read_version(explicit=None):
    if explicit:
        return explicit.strip()
    p = os.path.join(WORKSPACE, 'VERSION')
    if not os.path.isfile(p):
        die('缺少 VERSION 文件')
    v = open(p, encoding='utf-8').read().strip()
    if not re.match(r'^\d+\.\d+\.\d+', v):
        die('VERSION 内容不像版本号：%r' % v)
    return v


def work_asset_ids(work_lua):
    src = open(work_lua, encoding='utf-8', errors='ignore').read()
    ids = set()
    for pat in (r'M\.assets = \{(.*?)\n\}', r'M\.audios = \{(.*?)\n\}'):
        m = re.search(pat, src, re.S)
        if m:
            ids |= set(re.findall(r'\["([0-9a-fA-F-]{8,})"\] = \{', m.group(1)))
    return ids


def needed_assets(demo):
    """所有随包作品的素材 id 并集；now 系列排除（单作品 187MB）。"""
    works_dir = os.path.join(ROOT, 'works')
    ids = set()
    for f in sorted(os.listdir(works_dir)):
        if not f.endswith('.lua'):
            continue
        name = f[:-4]
        if any(name.startswith(p) for p in HUGE_WORK_PREFIXES):
            continue
        ids |= work_asset_ids(os.path.join(works_dir, f))
    ids |= work_asset_ids(os.path.join(works_dir, demo + '.lua'))
    return ids


def walk_files(base, rel_prefix):
    """(绝对路径, 包内相对路径) —— 过滤缓存/隐藏/大目录。"""
    out = []
    if not os.path.isdir(base):
        return out
    for dirpath, dirnames, files in os.walk(base):
        dirnames[:] = sorted(d for d in dirnames if d not in SKIP_DIRS)
        for f in sorted(files):
            if f in SKIP_FILES or f.endswith('.pyc') or f.endswith('.love'):
                continue
            full = os.path.join(dirpath, f)
            rel = os.path.join(rel_prefix, os.path.relpath(full, base)).replace(os.sep, '/')
            out.append((full, rel))
    return out


def build_demo(demo, version, release_dir, key_sim=True, dry=False):
    out = os.path.join(release_dir, 'HateNeko-%s-demo.love' % version)
    cmd = [sys.executable, os.path.join(ROOT, 'tools', 'kn.py'), 'build', demo,
           '--force', '--no-assets', '-o', out]
    if key_sim:
        cmd.append('--key-sim')
    say('→ 构建演示包：%s' % demo)
    if dry:
        return out
    rc = subprocess.call(cmd, cwd=ROOT)
    if rc != 0:
        die('演示包构建失败（exit %d）' % rc, rc)
    if not os.path.isfile(out):
        die('演示包没有生成：%s' % out)
    return out


def collect(version, demo):
    """返回 ([(绝对路径, 包内路径)], conf 内容 bytes)。"""
    entries = []
    top = 'HateNeko-%s' % version

    for name in ('VERSION', 'README.md', 'CHANGELOG.md', 'kn'):
        p = os.path.join(WORKSPACE, name)
        if os.path.isfile(p):
            entries.append((p, top + '/' + name))

    # 作品源（bcmkn/）：解压后 ./kn build <作品> 可直接用
    bcmkn = os.path.join(WORKSPACE, 'bcmkn')
    entries += [(p, top + '/' + rel) for p, rel in walk_files(bcmkn, 'bcmkn')]

    # player/ 代码
    for name in ('main.lua', 'README.md', 'SHARE_GUIDE.md',
                 'ATLUA_LICENSE', 'ATLUA_THIRD_PARTY_NOTICES.md'):
        p = os.path.join(ROOT, name)
        if os.path.isfile(p):
            entries.append((p, top + '/player/' + name))

    for d in ('rt', 'At', 'kntl', 'kn_spec', 'tests', 'tools', 'docs', 'LICENSES'):
        entries += [(p, top + '/' + rel) for p, rel in walk_files(os.path.join(ROOT, d), 'player/' + d)]

    # works/*.lua（全部编译产物，文本很小）
    works_dir = os.path.join(ROOT, 'works')
    for f in sorted(os.listdir(works_dir)):
        if f.endswith('.lua'):
            entries.append((os.path.join(works_dir, f), top + '/player/works/' + f))

    # 素材：只收随包作品引用到的（不含 now 的 187MB）
    ids = needed_assets(demo)
    assets_dir = os.path.join(works_dir, 'assets')
    asset_count = 0
    if os.path.isdir(assets_dir):
        for f in sorted(os.listdir(assets_dir)):
            full = os.path.join(assets_dir, f)
            if not os.path.isfile(full):
                continue
            stem, ext = os.path.splitext(f)
            if stem not in ids:
                continue
            if ext.lower() == '.svg':      # 运行期用 png 成品，svg 只是旁挂
                continue
            entries.append((full, top + '/player/works/assets/' + f))
            asset_count += 1

    # conf.lua：包内 STARTUP.work 指向演示作品
    conf = open(os.path.join(ROOT, 'conf.lua'), encoding='utf-8').read()
    conf = re.sub(r'(\bwork\s*=\s*")[^"]*(")', r'\g<1>%s\g<2>' % demo, conf, count=1)
    return entries, conf.encode('utf-8'), asset_count


def build_source_zip(version, demo, release_dir):
    entries, conf_bytes, asset_count = collect(version, demo)
    out = os.path.join(release_dir, 'HateNeko-%s-source.zip' % version)
    tmp = out + '.tmp'
    with zipfile.ZipFile(tmp, 'w', zipfile.ZIP_DEFLATED) as z:
        for full, rel in entries:
            ct = zipfile.ZIP_STORED if rel.lower().endswith(MEDIA) else zipfile.ZIP_DEFLATED
            z.write(full, rel, compress_type=ct)
            if rel.endswith('/kn') or rel.endswith('.sh') or rel.endswith('/tools/kn.py'):
                # 解压后可直接 ./kn build xxx（zip 默认不保留可执行位）
                z.getinfo(rel).external_attr = (0o100755 << 16)
        z.writestr('HateNeko-%s/player/conf.lua' % version, conf_bytes,
                   compress_type=zipfile.ZIP_DEFLATED)
    # 校验
    zv = zipfile.ZipFile(tmp)
    bad = zv.testzip()
    names = set(zv.namelist())
    zv.close()
    if bad:
        die('源码包损坏：%s' % bad)
    must = ['HateNeko-%s/player/main.lua' % version,
            'HateNeko-%s/player/rt/init.lua' % version,
            'HateNeko-%s/player/kntl/emit.py' % version,
            'HateNeko-%s/player/works/%s.lua' % (version, demo)]
    missing = [m for m in must if m not in names]
    if missing:
        die('源码包缺少关键文件：%s' % ', '.join(missing))
    shutil.move(tmp, out)
    raw = sum(i.file_size for i in zipfile.ZipFile(out).infolist())
    return out, len(names), raw, asset_count


def write_release_md(release_dir, version, demo, files):
    path = os.path.join(release_dir, 'RELEASE.md')
    lines = [
        '# HateNeko %s' % version,
        '',
        '## 内容',
        '',
        '- `HateNeko-%s-source.zip`：必要项目代码（`player/` 运行时代码、Python 编译器、测试、工具、' % version,
        '  文档、全部作品的编译产物、`bcmkn/` 作品源与随包作品素材）。**不含** `reference/` 官方原始',
        '  bundle、`archive/` 开发归档，以及 `now` 系列的 190MB 素材。',
        '- `HateNeko-%s-demo.love`：可直接运行的演示包（作品 `%s`，含屏幕按键；' % (version, demo),
        '  右上角 **KEY** 可切换键盘键面板显示/隐藏）。',
        '- `SHA256SUMS`：校验和。',
        '',
        '## 解压后直接构建',
        '',
        '```sh',
        'unzip HateNeko-%s-source.zip && cd HateNeko-%s' % (version, version),
        './kn build %-8s   # bcmkn/%s.bcmkn → works/%s.lua → builds/%s.love'
        % (demo, demo, demo, demo),
        './kn list            # 看作品/编译产物/已有包',
        '```',
        '',
        '## 运行演示',
        '',
        '```sh',
        'love HateNeko-%s-demo.love  # 或 cd HateNeko-%s/player && love .' % (version, version),
        '```',
        '',
        '## 回归测试',
        '',
        '需要 lua5.1 + luajit（LÖVE 真机运行时是 LuaJIT）：',
        '',
        '```sh',
        'cd HateNeko-%s/player && sh tests/all.sh' % version,
        '```',
        '',
        '## 版本',
        '',
        '`%s`（见 `VERSION`、`CHANGELOG.md`）。' % version,
        '',
        '## 文件',
        '',
    ]
    for f, size, sha in files:
        lines.append('- `%s` — %.1f MB — sha256 `%s`' % (f, size / 1048576, sha))
    lines.append('')
    open(path, 'w', encoding='utf-8').write('\n'.join(lines))
    return path


def write_sums(release_dir, files):
    path = os.path.join(release_dir, 'SHA256SUMS')
    with open(path, 'w', encoding='utf-8') as f:
        for name, _size, sha in files:
            f.write('%s  %s\n' % (sha, name))
    return path


def main(argv=None):
    ap = argparse.ArgumentParser(
        prog='release.py',
        description='打发布包：源码 zip + 演示 .love + RELEASE.md + SHA256SUMS。',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=(
            '例子：\n'
            '  python3 tools/release.py                        # 版本读 VERSION，演示 nodevm\n'
            '  python3 tools/release.py --version 0.2.0 --demo nodevm\n'
            '  python3 tools/release.py --skip-demo            # 只打源码\n'
        ),
    )
    ap.add_argument('--version', default=None, help='版本号（默认读 VERSION）')
    ap.add_argument('--demo', default='nodevm', help='演示作品名（默认 nodevm）')
    ap.add_argument('--key-sim', action='store_true', default=True, help='演示包默认显示屏幕按键（默认开）')
    ap.add_argument('--no-key-sim', dest='key_sim', action='store_false')
    ap.add_argument('--skip-demo', action='store_true', help='不构建演示包')
    ap.add_argument('--out-dir', default=RELEASE_ROOT, help='发布目录（默认 <仓库>/release）')
    args = ap.parse_args(argv)

    version = read_version(args.version)
    release_dir = os.path.join(os.path.abspath(args.out_dir), 'HateNeko-%s' % version)
    os.makedirs(release_dir, exist_ok=True)
    say('== HateNeko %s 发布 ==' % version)
    say('输出目录：%s' % os.path.relpath(release_dir, WORKSPACE))

    files = []
    if not args.skip_demo:
        demo_path = build_demo(args.demo, version, release_dir, args.key_sim)
        files.append((os.path.basename(demo_path), os.path.getsize(demo_path), sha256_of(demo_path)))

    say('→ 组装源码包（排除 reference/、archive/、now 大素材）')
    zpath, n_files, raw, n_assets = build_source_zip(version, args.demo, release_dir)
    files.append((os.path.basename(zpath), os.path.getsize(zpath), sha256_of(zpath)))
    say('  源码包：%d 个文件（含 %d 个素材），原始 %.1f MB，压缩 %.1f MB'
        % (n_files, n_assets, raw / 1048576, os.path.getsize(zpath) / 1048576))

    write_release_md(release_dir, version, args.demo, files)
    write_sums(release_dir, files)
    say('')
    say('完成 ✓  %s' % os.path.relpath(release_dir, WORKSPACE))
    for name, size, sha in files:
        say('  %-38s %6.1f MB  %s' % (name, size / 1048576, sha[:16] + '…'))
    say('  %-38s （校验和清单）' % 'SHA256SUMS')
    return 0


if __name__ == '__main__':
    sys.exit(main())

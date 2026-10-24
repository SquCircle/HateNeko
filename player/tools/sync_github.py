#!/usr/bin/env python3
"""把当前工作区同步到 GitHub（Git Data API；本机直连 github.com:443 不通时使用）。

用法：
    export GH_TOKEN=ghp_xxx                      # 需要 repo 权限
    python3 player/tools/sync_github.py          # 同步到 SquCircle/HateNeko 的 main
    GH_USER=you GH_REPO=repo python3 player/tools/sync_github.py

同步内容：player/ 代码（rt/At/kntl/kn_spec/tools/docs/LICENSES/main.lua/conf.lua/README…）、
works/*.lua 与随代码的小素材、bcmkn/ 作品源、根目录 README/CHANGELOG/VERSION/kn。
**不同步**：player/tests（测试代码）、reference/、archive/、builds/、release/、now 系列 187MB 素材。
只上传变化的 blob（按 git blob sha 比对远端树），并在最后更新 v<版本> 标签。
"""
import base64, hashlib, json, os, re, sys, time, urllib.request, urllib.error

TOKEN = os.environ.get('GH_TOKEN') or sys.exit('请先设置环境变量 GH_TOKEN（GitHub 令牌）')
USER, REPO = (os.environ.get('GH_USER') or 'SquCircle'), (os.environ.get('GH_REPO') or 'HateNeko')
API = 'https://api.github.com'
# 脚本在 player/tools/ 下：仓库根 = 上三级；从任意目录运行都行
WS = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
os.chdir(WS)
BRANCH = os.environ.get('GH_BRANCH') or 'main'


def api(method, path, body=None, tries=4):
    url = API + path
    data = json.dumps(body).encode() if body is not None else None
    for i in range(tries):
        req = urllib.request.Request(url, data=data, method=method, headers={
            'Authorization': 'Bearer ' + TOKEN,
            'Accept': 'application/vnd.github+json',
            'User-Agent': 'HateNeko-release-sync',
            'Content-Type': 'application/json',
        })
        try:
            with urllib.request.urlopen(req, timeout=60) as r:
                raw = r.read()
                return json.loads(raw) if raw.strip() else {}
        except urllib.error.HTTPError as e:
            body_txt = e.read().decode('utf-8', 'replace')[:300]
            if e.code in (429, 500, 502, 503, 504) and i + 1 < tries:
                time.sleep(2 * (i + 1)); continue
            raise SystemExit('API %s %s -> %s %s' % (method, path, e.code, body_txt))
        except Exception as e:
            if i + 1 < tries:
                time.sleep(2 * (i + 1)); continue
            raise


def blob_sha(data):
    h = hashlib.sha1(); h.update(b'blob %d\0' % len(data)); h.update(data)
    return h.hexdigest()


# ---------- 远端现状 ----------
ref = api('GET', '/repos/%s/%s/git/ref/heads/%s' % (USER, REPO, BRANCH))
head = ref['object']['sha']
commit = api('GET', '/repos/%s/%s/git/commits/%s' % (USER, REPO, head))
base_tree = commit['tree']['sha']
tree = api('GET', '/repos/%s/%s/git/trees/%s?recursive=1' % (USER, REPO, base_tree))
rtree = {e['path']: e for e in tree['tree'] if e['type'] == 'blob'}
print('远端 main=%s，base_tree=%s，已有文件 %d' % (head[:10], base_tree[:10], len(rtree)))

# ---------- 本地文件集 ----------
now_ids = set()
for w in sorted(os.listdir('player/works')):
    if w.startswith('now') and w.endswith('.lua'):
        src = open('player/works/' + w, encoding='utf-8', errors='ignore').read()
        for pat in (r'M\.assets = \{(.*?)\n\}', r'M\.audios = \{(.*?)\n\}'):
            m = re.search(pat, src, re.S)
            if m:
                now_ids |= set(re.findall(r'\["([0-9a-fA-F-]{8,})"\] = \{', m.group(1)))

SKIP_TOP = ('player/tests/', 'reference/', 'archive/', 'builds/', 'release/', 'player/archive/')
SKIP_DIRS = {'__pycache__', '.git', 'probe_out', 'archive', 'builds', 'release', 'reference'}


def allowed(rel):
    if any(rel.startswith(p) for p in SKIP_TOP):
        return False
    if '/__pycache__/' in rel or rel.endswith('.pyc') or rel.endswith('.love'):
        return False
    if rel.startswith('player/works/assets/'):
        if os.path.splitext(os.path.basename(rel))[0] in now_ids:
            return False
    return True


files = {}
for base in ('VERSION', 'README.md', 'CHANGELOG.md', 'kn'):
    if os.path.isfile(base):
        files[base] = open(base, 'rb').read()
for top in ('bcmkn', 'player'):
    for dp, dn, fs in os.walk(top):
        dn[:] = [d for d in dn if d not in SKIP_DIRS]
        for f in fs:
            p = os.path.join(dp, f).replace(os.sep, '/')
            if allowed(p):
                files[p] = open(p, 'rb').read()

EXEC = {'kn'} | {p for p in files if p.startswith('player/tools/') and (p.endswith('.py') or p.endswith('.sh'))}

# ---------- 上传变化的 blob ----------
entries = []
uploads = 0
for i, (path, data) in enumerate(sorted(files.items()), 1):
    sha = blob_sha(data)
    old = rtree.get(path)
    mode = '100755' if path in EXEC else '100644'
    if old is None or old['sha'] != sha or old.get('mode') != mode:
        if old is None or old['sha'] != sha:
            r = api('POST', '/repos/%s/%s/git/blobs' % (USER, REPO),
                    {'content': base64.b64encode(data).decode(), 'encoding': 'base64'})
            sha = r['sha']
            uploads += 1
        entries.append({'path': path, 'mode': mode, 'type': 'blob', 'sha': sha})
    if i % 25 == 0:
        print('  比对 %d/%d，已上传 %d' % (i, len(files), uploads), flush=True)

deletions = [p for p in rtree if p not in files]
for p in deletions:
    entries.append({'path': p, 'mode': '100644', 'type': 'blob', 'sha': None})

print('变更：新增/修改 %d，删除 %d（其中 tests %d）'
      % (len(entries) - len(deletions), len(deletions),
         sum(1 for p in deletions if p.startswith('player/tests/'))))

# ---------- 建 tree / commit / 更新分支 ----------
new_tree = api('POST', '/repos/%s/%s/git/trees' % (USER, REPO),
               {'base_tree': base_tree, 'tree': entries})
msg = ('HateNeko 0.2.0\n\n'
       '- 运行时语义修复：切屏冻结模型、广播 one_frame、属性单位、透明特效、列表相等、text_contain、造型号、ask 数值识别\n'
       '- 计时器两套时钟（TheatreStore 舞台计时器 / 旧版 timer_block）\n'
       '- 输入坐标域（stage_fit 一致、舞台 hitArea）、条件槽 JS 真值、函数_布尔 返回布尔、运动 NaN 保护\n'
       '- 右上角 KEY 开关（键盘键显示/隐藏）\n'
       '- 工具链：./kn build <作品名> 一站式；kntl.compile / tools/pack.py 只收作品名\n'
       '- 本仓库不含测试代码（player/tests/）与 reference/archive/builds/release 大件')
new_commit = api('POST', '/repos/%s/%s/git/commits' % (USER, REPO),
                 {'message': msg, 'tree': new_tree['sha'], 'parents': [head]})
api('PATCH', '/repos/%s/%s/git/refs/heads/%s' % (USER, REPO, BRANCH),
    {'sha': new_commit['sha'], 'force': False})
print('已推送 main → %s' % new_commit['sha'][:10])

# ---------- 轻量标签 v0.2.0 ----------
ver = open('VERSION', encoding='utf-8').read().strip()
tag = os.environ.get('GH_TAG') or ('v' + ver)
try:
    api('POST', '/repos/%s/%s/git/refs' % (USER, REPO),
        {'ref': 'refs/tags/' + tag, 'sha': new_commit['sha']})
    print('已建标签 ' + tag)
except SystemExit as e:
    if '422' in str(e):
        api('PATCH', '/repos/%s/%s/git/refs/tags/%s' % (USER, REPO, tag),
            {'sha': new_commit['sha'], 'force': True})
        print('已更新标签 ' + tag)
    else:
        raise

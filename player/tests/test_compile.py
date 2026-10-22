#!/usr/bin/env python3
"""编译器测试（无网络、秒级）。

验证 kntl.emit 的产出结构、确定性与素材命名规则。
"""
import glob
import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from kntl import emit, spec  # noqa: E402

fails = checks = 0


def check(desc, got, want):
    global fails, checks
    checks += 1
    if got != want:
        fails += 1
        print("  FAIL %-50s got=%s want=%s" % (desc, got, want))
    else:
        print("  ok   %-50s %s" % (desc, got))


spec.load()
works = sorted(glob.glob("tests/fixtures/*.bcmkn"))
check("有测试作品", len(works) > 0, True)

for path in works:
    stem = os.path.splitext(os.path.basename(path))[0]
    with open(path, "rb") as f:
        work = json.loads(f.read().decode("utf-8"))
    src, rep = emit.compile_work(work)

    # ① 基本结构
    check("%s 以声明开头" % stem, src.startswith("-- 由 knplayer/kntl 从作品自动生成"), True)
    check("%s 有 register" % stem, "function M.register(rt, game, ents)" in src, True)
    check("%s 有 requires" % stem, src.rstrip().endswith("}\nreturn M") or "return M" in src[-40:], True)

    # ② 确定性：编译两次必须完全一致
    src2, _ = emit.compile_work(json.loads(json.dumps(work)))
    check("%s 编译确定" % stem, src == src2, True)

    # ③ 素材命名：落地文件不得是 .svg（url 字段以 .svg 结尾是正常的）
    import re as _re
    svg_files = _re.findall(r'file = "assets/[^"]*\.svg"', src)
    check("%s 落地文件无 .svg" % stem, len(svg_files), 0)

    # ④ 元数据规模与作品一致
    actors = ((work.get("actors") or {}).get("actorsDict") or {})
    if actors:
        n = src.count('rotation =')
        check("%s 角色数一致(%d)" % (stem, len(actors)), n, len(actors))

    # ⑤ 初始屏幕 = 场景排序第一屏
    scenes = work.get("scenes") or {}
    order = scenes.get("sortList") or []
    if order:
        check("%s 初始屏幕=sortList[0]" % stem, ('M.cur_scene = "%s"' % order[0]) in src, True)

    # ⑥ 未知块不增长（只允许已知白名单）
    allowed = {"get_play_audio"}
    unknown = set(rep.get("unknown") or {}) - allowed
    check("%s 无新增未知块" % stem, unknown, set())

# ⑦ 孤立 break 必须编译期失败
bad = {
    "projectName": "bad_break",
    "version": "1",
    "stageSize": {"width": 100, "height": 100},
    "actors": {"actorsDict": {"a": {
        "id": "a", "name": "A", "styles": [],
        "nekoBlockJsonList": [
            {"type": "on_running_group_activated",
             "statements": {"DO": {"type": "break", "id": "bad1"}}},
        ],
    }}},
    "scenes": {"scenesDict": {}, "sortList": []},
}
try:
    emit.compile_work(bad)
    check("孤立 break 编译失败", "no error", "CompileError")
except emit.CompileError:
    check("孤立 break 编译失败", "CompileError", "CompileError")

# ⑧ 叶子过程直调（trampoline 模式下只对无过程调用的 proc 生效）
leaf_src = """proc_aaaaaaaa = function(th, self)
  return 1
end
proc_bbbbbbbb = function(th, self)
  return th:call_proc(proc_aaaaaaaa, self)
end
function M.register(rt, game, ents)
  th:call_proc(proc_aaaaaaaa, self)
  th:call_proc(proc_bbbbbbbb, self)
end
"""
patched, leaf_n = emit._leaf_direct_calls(leaf_src)
check("叶子过程识别数", leaf_n, 1)
check("叶子调用改直调（2 处）", patched.count("proc_aaaaaaaa(th,"), 2)
check("递归过程仍走 trampoline", "th:call_proc(proc_bbbbbbbb" in patched, True)
check("叶子过程不再 yield", "th:call_proc(proc_aaaaaaaa" in patched, False)

# ⑨ 全常量参数表复用（模块级 __C 表）
cctx = {"const_args": {}}
c1 = emit.arg_code({"TEXT": '"a"'}, cctx)
c2 = emit.arg_code({"TEXT": '"a"'}, cctx)
c3 = emit.arg_code({"TEXT": '"b"'}, cctx)
check("常量参数表复用同一表", c1, c2)
check("常量表是 __CONST[i]", c1.startswith("__CONST["), True)
check("不同常量参数表分开", c1 != c3, True)
check("常量表池大小", len(cctx["const_args"]), 2)
dynamic = emit.arg_code({"A": 'p_x', "B": "1"}, {"const_args": {}})
check("含局部变量的参数表不 hoist", dynamic, "{ A = p_x, B = 1 }")

print("结果：%d 项检查，%d 项失败" % (checks, fails))
sys.exit(1 if fails else 0)

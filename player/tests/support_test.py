#!/usr/bin/env python3
"""阶段 4：离线不支持分类 + 编译期报告回归。"""
import json
import os
import subprocess
import sys
import tempfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT)
from kntl import support  # noqa: E402

fails = checks = 0


def check(desc, got, want):
    global fails, checks
    checks += 1
    if got != want:
        fails += 1
        print("  FAIL %-52s got=%r want=%r" % (desc, got, want))
    else:
        print("  ok   %-52s %s" % (desc, got))


cat = json.load(open(os.path.join(ROOT, "kn_spec", "block_catalog.json"), encoding="utf-8"))
check("目录仍含 get_play_audio", "get_play_audio" in cat, True)
for t in ("script_variables_set", "change_script_variables", "get_sprite_property",
          "math_trig_rad", "sound_color", "get_play_audio"):
    check("%s 不误判离线" % t, support.unsupported_reason(t), None)

check("AI 需在线", support.unsupported_reason("ai_chat_ask"), "需要在线 AI 服务")
check("microbit 需硬件", support.unsupported_reason("microbit_led_plot"), "需要 micro:bit 硬件")
check("人脸需摄像头", support.unsupported_reason("check_emotion"), "需要摄像头与人脸识别")
check("机器人需硬件", support.unsupported_reason("set_robot_master_light_color"), "需要机器人硬件")
check("普通块不误判", support.unsupported_reason("math_arithmetic"), None)
check("编译期构造不误判", support.unsupported_reason("repeat_n_times"), None)

work = {"type": "ai_chat_ask", "inputs": {}, "fields": {}, "statements": {}, "next": None}
check("作品扫描命中 AI", support.unsupported_types_in_work(work),
      {"ai_chat_ask": "需要在线 AI 服务"})

# 真编译一个用了离线块的最小作品：必须打印清单，且产物带 M.unsupported_blocks
w = {
    "projectName": "offline_probe", "version": "0.27.4",
    "stageSize": {"width": 900, "height": 562},
    "scenes": {"scenesDict": {"s1": {"name": "S", "styles": [], "actorIds": ["a1"]}},
               "sortList": ["s1"], "currentSceneId": "s1"},
    "actors": {"actorsDict": {"a1": {
        "name": "A", "styles": [], "position": {"x": 0, "y": 0}, "visible": True,
        "nekoBlockJsonList": [{"type": "ai_chat_ask", "inputs": {}, "fields": {}, "next": None}],
    }}},
    "variables": {"variablesDict": {}}, "styles": {"stylesDict": {}},
    "audios": {"audiosDict": {}}, "procedures": {"proceduresDict": {}},
}
with tempfile.TemporaryDirectory() as td:
    src = os.path.join(td, "probe.bcmkn")
    out = os.path.join(td, "probe.lua")
    open(src, "w", encoding="utf-8").write(json.dumps(w))
    r = subprocess.run([sys.executable, "-m", "kntl.compile", src, out, "--no-assets"],
                       capture_output=True, text=True, cwd=ROOT)
    check("最小作品编译成功", r.returncode, 0)
    check("stderr 打印离线清单", "离线不支持：1 类块" in r.stderr, True)
    lua = open(out, encoding="utf-8").read() if os.path.exists(out) else ""
    check("产物带 M.unsupported_blocks", "M.unsupported_blocks = {" in lua, True)
    check("产物记录 AI 原因", "需要在线 AI 服务" in lua, True)

print(("结果：%d 项检查，%d 项失败" % (checks, fails)))
sys.exit(1 if fails else 0)

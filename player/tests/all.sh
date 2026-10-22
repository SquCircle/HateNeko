#!/bin/sh
# 一次跑完所有 headless 测试（Lua5.1 + LuaJIT 各一遍）
#
# 产物由 Python 编译器生成（Lua 只保留运行时）。
# ★ 解释器门禁：LÖVE 在 Android/桌面实际用的是 **LuaJIT**；缺 luajit 时默认**硬失败**，
#   不允许像以前那样 `continue` 静默跳过（那会让人误以为两端都验过）。
#   确实只能跑一端时，显式设置 KN_ALLOW_MISSING_LUAJIT=1（脚本会大字报 SKIP）。
cd "$(dirname "$0")/.." || exit 1

status=0

if ! command -v lua5.1 >/dev/null 2>&1; then
  echo "ERROR: 缺 lua5.1（回归基线必须跑 Lua5.1）" >&2
  exit 2
fi

LUAS="lua5.1"
if command -v luajit >/dev/null 2>&1; then
  LUAS="$LUAS luajit"
elif [ "${KN_ALLOW_MISSING_LUAJIT:-0}" = "1" ]; then
  echo "################################################################"
  echo "# SKIP: 未安装 luajit —— 只跑了 lua5.1。                      #"
  echo "#       LÖVE Android 实际运行 LuaJIT，本轮结果**不覆盖真机**。#"
  echo "################################################################"
else
  echo "ERROR: 未安装 luajit（LÖVE Android 实际运行 LuaJIT）。" >&2
  echo "       请安装 luajit；若只能跑 lua5.1，显式设置 KN_ALLOW_MISSING_LUAJIT=1。" >&2
  exit 2
fi

python3 tools/precompile.py || exit 1
python3 tools/gen_schema.py --check || exit 1
python3 tests/svg_size_test.py || exit 1
python3 tests/support_test.py || exit 1
python3 tests/test_compile.py || exit 1

TESTS="tests/run.lua tests/json_test.lua tests/compile_test.lua tests/vm_test.lua tests/works_test.lua tests/audio_test.lua tests/hit_test.lua tests/event_test.lua tests/event2_test.lua tests/motion_test.lua tests/sense_test.lua tests/screen_test.lua tests/meta_test.lua tests/loading_test.lua tests/coords_test.lua tests/units_test.lua tests/effects_test.lua tests/wait_until_test.lua tests/layer_test.lua tests/ask_test.lua tests/hat_order_test.lua tests/draw_dump_test.lua tests/nan_guard_test.lua tests/layer_real_test.lua tests/paint_test.lua tests/atui_test.lua tests/pen_test.lua tests/pen_order_test.lua tests/pen_screen_test.lua tests/action_test.lua tests/control_test.lua tests/stop_scope_test.lua tests/looks_test.lua tests/decimal_test.lua tests/operators_ui_test.lua tests/variables_types_test.lua tests/monitor_layout_test.lua tests/monitors_at_test.lua tests/effects_animation_test.lua tests/ui_new_test.lua tests/vars_new_test.lua tests/script_vars_test.lua tests/list_alias_test.lua tests/note_fall_test.lua tests/settlement_test.lua tests/device_semantics_test.lua tests/key_sim_test.lua tests/events_semantics_test.lua tests/semantics_p0_test.lua tests/semantics_p1_test.lua tests/perf_opt_test.lua tests/registry_test.lua tests/gap_blocks_test.lua tests/sync_tell_test.lua tests/perf_layers_test.lua tests/perf_extreme_test.lua tests/vm_conformance.lua"

for lua in $LUAS; do
  command -v "$lua" >/dev/null 2>&1 || continue
  echo "=== $lua ==="
  for t in $TESTS; do
    echo "--- $t"
    # 不能用 "$lua" "$t" | tail -3：管道退出码是 tail 的，测试崩了也会显示成功。
    # 先取真实退出码，再决定打印尾部几行。
    out=$("$lua" "$t" 2>&1)
    rc=$?
    if [ "$rc" -ne 0 ]; then
      printf '%s\n' "$out" | tail -20
      echo "  ^^ $t 退出码 $rc"
      status=1
    else
      printf '%s\n' "$out" | tail -3
    fi
  done
done
exit $status

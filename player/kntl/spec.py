"""块规格表（Python 版，等价于旧 kntl/spec.lua）。

规格表由编辑器产物抽出（kn_spec/block_catalog.json），
编译器的"块 -> 调用"知识全部来自这里。
"""
import json
import os

# 仓库内自带规格表（由 tools/gen_block_catalog.py 从编辑器 bundle 生成）。
# 历史路径 /workspace/kn_spec/block_catalog.json 仍可用 KN_SPEC / load(path) 覆盖。
DEFAULT_SPEC = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                            "kn_spec", "block_catalog.json")

KEYWORDS = {w: True for w in (
    "and break do else elseif end false for function goto if in local nil not or "
    "repeat return then true until while").split()}

EVENT_FALLBACK = {k: True for k in (
    "on_running_group_activated", "received_broadcast", "is_broadcast_received",
    "broadcast_received", "self_listen", "self_listen_with_param", "sprite_on_tap",
    "on_keydown", "on_swipe", "on_bump_actor", "when", "start_as_a_mirror",
    "on_clone_start", "start_on_click", "start_on_click_2", "on_tap",
    "sprite_on_click", "on_click", "on_message", "on_timer")}

LITERAL_NUMERIC = {"math_number": True, "math_number_with_dial": True}
LITERAL_STRING = {"text": True, "multiline_text": True, "shadow_text": True,
                  "broadcast_input": True, "pure_list_get": True}

# 注意：`get_play_audio` **不在这里**。它在编辑器里是「选声音」的 shadow
# （bundle: {blockName:"get_play_audio", fieldName:"audio_id"}），必须编译成音频 id 字面量；
# 曾把它当 reader → 编译出 f["get_play_audio"](...) 套进 play_audio，等于"先播一次再播一次"。
READER_SHADOWS = {k: True for k in (
    "coordinate_of_sprite", "get_orientation", "check_key", "mouse_down", "get_time",
    "timer", "list_length", "self_ask", "ask_and_choose",
    "random_num", "distance_to", "self_listen_value", "self_listen_param",
    "script_variables_value", "script_variables_param", "procedures_2_parameter",
    "procedures_2_stable_parameter", "traverse_number_value", "traverse_number_param")}

_catalog = None


def load(path=None):
    global _catalog
    path = path or os.environ.get("KN_SPEC") or DEFAULT_SPEC
    with open(path, "rb") as f:
        _catalog = json.loads(f.read().decode("utf-8"))
    return _catalog


def all_blocks():
    return _catalog or load()


def get(block_type):
    if _catalog is None:
        load()
    return _catalog.get(block_type)


def has(block_type):
    return get(block_type) is not None


def is_event(block_type):
    if EVENT_FALLBACK.get(block_type):
        return True
    e = get(block_type)
    return bool(e and e.get("isEvent"))


def arg_names(block_type):
    e = get(block_type)
    out = []
    for a in (e or {}).get("args") or []:
        if a.get("name") and a.get("type") != "input_statement":
            out.append(a["name"])
    return out


def is_literal(node):
    t = node.get("type")
    if t in LITERAL_NUMERIC or t in LITERAL_STRING or t in ("logic_empty", "logic_boolean"):
        return True
    if node.get("is_shadow") and not READER_SHADOWS.get(t) and not node.get("inputs"):
        has_input = bool(node.get("inputs"))
        has_stmt = bool(node.get("statements"))
        return (not has_input) and (not has_stmt)
    return False

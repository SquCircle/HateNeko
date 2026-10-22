"""编译期块支持分类（阶段 4）。

三类“不是运行期原语”的块：
  * EVENT：事件帽，由调度器/编译期注册处理；
  * COMPILER：编译期构造（循环/过程参数/break），不会生成 f[...] 调用；
  * OFFLINE：依赖在线服务或硬件的块，LÖVE 离线运行时明确不实现。

`unsupported_reason(t)` 是唯一判据：编译期用它打印“离线不支持”清单，
`tools/gen_schema.py` 用它生成 rt/schema.lua 的 unsupported 表，
`tests/registry_test.lua` 用它确认每个块都被分类（实现/事件/编译期/离线）。
"""

# 编译期构造：不会作为原语调用
COMPILER_TYPES = {
    "__break__",
    "repeat_forever",
    "repeat_forever_until",
    "repeat_n_times",
    "traverse_number",
    "procedures_2_actor_param",
}

# 离线不支持的离线/硬件能力（按前缀或精确类型给原因）
_PREFIX_REASONS = [
    ("ai_", "需要在线 AI 服务"),
    ("microbit_", "需要 micro:bit 硬件"),
    ("catbit_", "需要 CatBit 硬件"),
    ("wand_", "需要魔棒硬件"),
    ("robot", "需要机器人硬件"),
    ("get_robot", "需要机器人硬件"),
    ("change_robot", "需要机器人硬件"),
    ("set_robot", "需要机器人硬件"),
    ("stop_robot", "需要机器人硬件"),
    ("face_", "需要摄像头与人脸识别"),
    ("body_", "需要摄像头与人体识别"),
    ("recognize_", "需要摄像头/语音识别"),
    ("check_emotion", "需要摄像头与人脸识别"),
    ("check_face_shape", "需要人脸识别"),
    ("check_gender", "需要人脸识别"),
    ("check_tilt_direction", "需要人脸识别"),
    ("enable_", "需要摄像头识别"),
    ("evaluate_", "需要摄像头与在线模型"),
    ("get_face_", "需要人脸识别"),
    ("get_object_", "需要物体识别"),
    ("get_tilt_", "需要人脸识别"),
    ("get_evaluate_", "需要在线模型"),
    ("get_position_of_body", "需要人体识别"),
    ("get_appearance_of_part", "需要人体识别"),
    ("face_to_body", "需要人体识别"),
    ("move_to_body", "需要人体识别"),
    ("open_close_webcam", "需要摄像头"),
    ("open_hide_camera", "需要摄像头"),
    ("set_camera", "需要摄像头"),
    ("set_webcam", "需要摄像头"),
]

_EXACT_REASONS = {
    "user_ranking_info": "需要登录服务端排行榜",
    "new_conversation": "需要在线 AI 对话服务",
    "set_system_preset": "需要系统/硬件环境",
}


def unsupported_reason(block_type):
    """返回离线不支持原因；None 表示由运行期原语或事件/编译期处理。"""
    t = str(block_type or "")
    if t in COMPILER_TYPES:
        return None
    if t in _EXACT_REASONS:
        return _EXACT_REASONS[t]
    for prefix, reason in _PREFIX_REASONS:
        if t.startswith(prefix):
            return reason
    return None


def iter_block_types(work, _seen=None):
    """遍历作品 JSON 里所有块类型（含事件帽/游离块），去重返回集合。"""
    if _seen is None:
        _seen = set()
    if isinstance(work, dict):
        t = work.get("type")
        if isinstance(t, str) and (work.get("inputs") is not None or work.get("fields") is not None
                                   or work.get("statements") is not None
                                   or work.get("next") is not None or work.get("mutation") is not None):
            _seen.add(t)
        for v in work.values():
            iter_block_types(v, _seen)
    elif isinstance(work, list):
        for v in work:
            iter_block_types(v, _seen)
    return _seen


def unsupported_types_in_work(work):
    out = {}
    for t in iter_block_types(work):
        r = unsupported_reason(t)
        if r:
            out[t] = r
    return out


def unsupported_map(types):
    """{type: reason}，只保留确实用了的块。"""
    out = {}
    for t in types:
        r = unsupported_reason(t)
        if r:
            out[t] = r
    return out


# 运行期存在、但当前编辑器目录里没有的“历史块/内部别名”。
# registry 覆盖测试用：f 表里除目录条目外的函数必须在这里登记，
# 防止新加原语时忘记同步 schema。
KNOWN_EXTRA = set("""
MAX_SCALE_PCT MAX_STAMP_PX ROUNDING apply_scale broadcast broadcast_and_wait
broadcast_with_content change_variable clamp_scale clone confirm_translation
current_dialog data_length default_value delete_this_clone destruct draw_rotation
face_point get_clone_count get_clone_property get_cur_frames get_play_audio
get_rotation get_screens get_styles get_target_sprite_property get_variable
is_broadcast_received list_is_exist_slow list_value lists_append lists_copy
lists_delete lists_get lists_get_value lists_index_of lists_insert_value
lists_is_exist lists_length lists_replace logic_empty math_arc_trig
math_arithmetic_power math_number math_number_with_dial math_single multiline_text
once pure_list_get random reset_timer round_to script_variables_get
script_variables_param self_change_coordinate self_clear_all_effects self_fade
self_glide_coordinate self_listen_param self_move_to_sprite
self_point_towards_target self_reset self_set_camp self_set_effect_value
self_set_position self_set_position_value self_set_scale self_set_style
self_set_visibility self_show_bubble self_show_bubble_wait self_switch_style
set_layer set_variable shadow_text submit_answer submit_choice tell_and_wait
terminate text text_append text_implicit text_indexOf text_join_value
traverse_number_param traverse_number_value unknown update
""".split())

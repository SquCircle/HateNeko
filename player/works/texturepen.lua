-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：我的作品   version=0.27.0
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（条件槽用 V.js_boolean，字段解析用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用
local __CONST = {
  { PARAMS0 = nil, PARAMS1 = nil, name = "dx", names = { "dx", "dy" } },
  { TEXT = "dx" },
  { TEXT = "dy" },
  { color = "#ffffff" },
  { size = 10 },
  { type = "height", value = 10 },
  { sprite = "--mouse" },
  { variable = "ae9e06c5-3e00-4b88-8e66-1d0a48547a2d" },
  { variable = "46364626-f99a-4c48-a1e1-9cb9719fd0ce" },
  { sprite = "--screen", type = "down" },
  { type = "x" },
  { type = "y" },
  { variable = "8629ae92-0ddd-4bbb-8744-92898ff9b3e9" },
  { variable = "128b2933-0205-46be-a662-57f952338380" },
  { variable = "29b48658-ad85-4e1e-b16f-61136cd50ae4" },
}

-- ===== 自定义积木（过程）=====
local proc_78991bfc_187d_47a9_9662_370345de3ce8

proc_78991bfc_187d_47a9_9662_370345de3ce8 = function(th, self, p_xA, p_yA, p_xB, p_yB)
  -- 过程「b3c48ccd-f9d4-4211-8160-e630555d1829」 id=78991bfc-187d-47a9-9662-370345de3ce8
  f["script_variables"](self, __CONST[1], th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_xB, B = p_xA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"dx\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_yB, B = p_yA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"dy\"}" }, th)
  if V.js_boolean(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[2], th), B = 0, OP = "LT" }, th)) then
    return f["math_arithmetic"](self, { A = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[3], th), B = f["script_variables_value"](self, __CONST[2], th), type = "divide" }, th), type = "atan" }, th), B = 180, type = "add" }, th)
  elseif V.js_boolean(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[2], th), B = 0, OP = "EQ" }, th)) then
    if V.js_boolean(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[3], th), B = 0, OP = "GT" }, th)) then
      return 90
    elseif V.js_boolean(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[3], th), B = 0, OP = "LT" }, th)) then
      return 270
    else
      return 0
    end
  else
    if V.js_boolean(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[3], th), B = 0, OP = "GTE" }, th)) then
      return f["math_trig"](self, { num = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[3], th), B = f["script_variables_value"](self, __CONST[2], th), type = "divide" }, th), type = "atan" }, th)
    else
      return f["math_arithmetic"](self, { A = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[3], th), B = f["script_variables_value"](self, __CONST[2], th), type = "divide" }, th), type = "atan" }, th), B = 360, type = "add" }, th)
    end
  end
end

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 900, 562
M.timer_pos = { x = 720, y = 12 }
M.proc_trampoline = false
M.uses_timer = false
M.timer_hidden_default = false
M.vars = { { current_entity_id = "", cv_id = "", entity_name = "", id = "128b2933-0205-46be-a662-57f952338380", is_global = true, name = "上点y", order = 1, position = { x = 20, y = 100 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "29b48658-ad85-4e1e-b16f-61136cd50ae4", is_global = true, name = "l", order = 4, position = { x = 20, y = 340 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "46364626-f99a-4c48-a1e1-9cb9719fd0ce", is_global = true, name = "点y", order = 3, position = { x = 20, y = 260 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "8629ae92-0ddd-4bbb-8744-92898ff9b3e9", is_global = true, name = "上点x", order = 0, position = { x = 20, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "ae9e06c5-3e00-4b88-8e66-1d0a48547a2d", is_global = true, name = "点x", order = 2, position = { x = 20, y = 180 }, scale = 1, style = "default", type = "any", value = 0, visible = false } }
M.screens = { { id = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a", name = "背景", screenName = "屏幕", style_index = 1, styles = { "6d0d6c61-a1df-4076-8c19-83ddfdbbca1c" }, visible = true } }
M.cur_scene = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a"
M.actors = { { id = "c6f72e8a-68cc-4b6a-8e8d-919c2d0c963b", is_global = true, name = "新角色", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 2, styles = { "9b0ca242-1f42-4b18-8b0e-e440aa87766c", "beb17a98-29bf-4dc4-ad7f-1cdba17abc5e" }, visible = false, x = 0, y = 0 } }
M.assets_dir = "works"
M.assets = { ["6d0d6c61-a1df-4076-8c19-83ddfdbbca1c"] = { adaption = nil, center = nil, file = "assets/6d0d6c61-a1df-4076-8c19-83ddfdbbca1c.jpg", id = "6d0d6c61-a1df-4076-8c19-83ddfdbbca1c", name = "沼泽", styleType = 1, url = "https://creation.codemao.cn/396/8bc3a5b92e934d7287e63f1684b61de6.jpg" }, ["9b0ca242-1f42-4b18-8b0e-e440aa87766c"] = { adaption = nil, center = nil, file = "assets/9b0ca242-1f42-4b18-8b0e-e440aa87766c.png", id = "9b0ca242-1f42-4b18-8b0e-e440aa87766c", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/Ft3cn5j9TcDDjJ-gg4QSN91iFV4r?imageView2/0/format/png" }, ["beb17a98-29bf-4dc4-ad7f-1cdba17abc5e"] = { adaption = nil, center = nil, file = "assets/beb17a98-29bf-4dc4-ad7f-1cdba17abc5e.png", id = "beb17a98-29bf-4dc4-ad7f-1cdba17abc5e", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/Fh9WkFMpJa4EyIpIYhw2X-ZN72tY?imageView2/0/format/png" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_700824a5_44a8_4d03_a7e8_aa95d87e9b2a = ents["700824a5-44a8-4d03-a7e8-aa95d87e9b2a"]
  local e_c6f72e8a_68cc_4b6a_8e8d_919c2d0c963b = ents["c6f72e8a-68cc-4b6a-8e8d-919c2d0c963b"]
  -- -------- 角色 新角色 --------
  rt.on(e_c6f72e8a_68cc_4b6a_8e8d_919c2d0c963b, "on_running_group_activated", {}, function(th, self)
      f["self_set_pen_color"](self, __CONST[4], th)
      f["self_set_pen_size"](self, __CONST[5], th)
      f["set_width_height_scale"](self, __CONST[6], th)
      while true do
        f["self_move_specify"](self, __CONST[7], th)
        f["variables_set"](self, { value = f["variables_get"](self, __CONST[8], th), variable = "8629ae92-0ddd-4bbb-8744-92898ff9b3e9" }, th)
        f["variables_set"](self, { value = f["variables_get"](self, __CONST[9], th), variable = "128b2933-0205-46be-a662-57f952338380" }, th)
        if V.js_boolean(f["mouse_down"](self, __CONST[10], th)) then
          f["variables_set"](self, { value = f["get_mouse_info"](self, __CONST[11], th), variable = "ae9e06c5-3e00-4b88-8e66-1d0a48547a2d" }, th)
          f["variables_set"](self, { value = f["get_mouse_info"](self, __CONST[12], th), variable = "46364626-f99a-4c48-a1e1-9cb9719fd0ce" }, th)
          f["variables_set"](self, { value = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[8], th), B = f["variables_get"](self, __CONST[13], th), type = "minus" }, th), B = 2, type = "power" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[9], th), B = f["variables_get"](self, __CONST[14], th), type = "minus" }, th), B = 2, type = "power" }, th), type = "add" }, th), type = "0" }, th), variable = "29b48658-ad85-4e1e-b16f-61136cd50ae4" }, th)
          f["self_move_to"](self, { x = f["variables_get"](self, __CONST[8], th), y = f["variables_get"](self, __CONST[9], th) }, th)
          f["self_pen_down"](self, {}, th)
          f["self_pen_up"](self, {}, th)
          f["self_move_to"](self, { x = f["variables_get"](self, __CONST[13], th), y = f["variables_get"](self, __CONST[14], th) }, th)
          f["self_pen_down"](self, {}, th)
          f["self_pen_up"](self, {}, th)
          f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[8], th), B = f["variables_get"](self, __CONST[13], th), type = "add" }, th), B = 0.5, type = "multiply" }, th), y = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[9], th), B = f["variables_get"](self, __CONST[14], th), type = "add" }, th), B = 0.5, type = "multiply" }, th) }, th)
          f["self_point_towards"](self, { degrees = (proc_78991bfc_187d_47a9_9662_370345de3ce8(th, self, f["variables_get"](self, __CONST[13], th), f["variables_get"](self, __CONST[14], th), f["variables_get"](self, __CONST[8], th), f["variables_get"](self, __CONST[9], th), nil, nil)) }, th)
          f["set_width_height_scale"](self, { type = "width", value = f["variables_get"](self, __CONST[15], th) }, th)
          f["image_stamp"](self, {}, th)
        end
        if th:iter_n() then break end
      end
  end)
end

M.requires = {
  "get_mouse_info",
  "image_stamp",
  "logic_compare",
  "math_arithmetic",
  "math_function",
  "math_trig",
  "mouse_down",
  "script_variables",
  "script_variables_value",
  "self_move_specify",
  "self_move_to",
  "self_pen_down",
  "self_pen_up",
  "self_point_towards",
  "self_set_pen_color",
  "self_set_pen_size",
  "set_width_height_scale",
  "variables_get",
  "variables_set",
}
return M

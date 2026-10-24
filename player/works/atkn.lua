-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：At   version=0.27.3
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（条件槽用 V.js_boolean，字段解析用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用
local __CONST = {
  { PARAMS0 = nil, name = "a" },
  { ITEM0 = 0, ITEM1 = 0, ITEM2 = 0 },
  { TEXT = "a" },
  { PARAMS0 = nil, PARAMS1 = nil, name = "dx", names = { "dx", "dy" } },
  { TEXT = "dx" },
  { TEXT = "dy" },
  { PARAMS0 = nil, PARAMS1 = nil, name = "hex列表", names = { "hex列表", "hex2列表" } },
  { TEXT = "hex列表" },
  { TEXT = "hex2列表" },
  { PARAMS0 = nil, name = "hex列表" },
  { increase = "decrease", scope = "saturation", steps = 10 },
  { increase = "increase", steps = 20 },
  { increase = "increase", scope = "saturation", steps = 20 },
  { increase = "decrease", steps = 10 },
  { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, name = "hex列表", names = { "hex列表", "旋转备份", "hex2列表" } },
  { appearance = "direction", sprite = "--self" },
  { increase = "increase", scope = "saturation", steps = 10 },
  { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, PARAMS3 = nil, PARAMS4 = nil, name = "qx", names = { "qx", "qy", "dx", "dy", "d" } },
  { type = "x" },
  { type = "y" },
  { TEXT = "qx" },
  { TEXT = "qy" },
  { TEXT = "d" },
  { sprite = "--screen", type = "down" },
  { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, PARAMS3 = nil, PARAMS4 = nil, PARAMS5 = nil, PARAMS6 = nil, PARAMS7 = nil, PARAMS8 = nil, PARAMS9 = nil, name = "tir1", names = { "tir1", "tir2", "tir3", "tir4", "tir5", "tir6", "tir7", "tir8", "tir9", "l" } },
  { TEXT = "tir1" },
  { TEXT = "tir2" },
  { TEXT = "tir3" },
  { TEXT = "tir4" },
  { TEXT = "tir5" },
  { TEXT = "tir6" },
  { TEXT = "tir7" },
  { value = 0.5, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"l\"}" },
  { TEXT = "l" },
  { TEXT = "tir8" },
  { TEXT = "tir9" },
  { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, PARAMS3 = nil, PARAMS4 = nil, name = "换行", names = { "换行", "分割", "参数组", "ID组", "参数分割" } },
  { TEXT = "换行" },
  { ADD0 = "" },
  { TEXT = "分割" },
  { TEXT = "ID组" },
  { TEXT = "参数组" },
  { TEXT = "参数分割" },
  { value = "", variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" },
  { PARAMS0 = nil, PARAMS1 = nil, name = "hex列表", names = { "hex列表", "文字hex" } },
  { increase = "increase", value = 20 },
  { TEXT = "文字hex" },
  { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, PARAMS3 = nil, PARAMS4 = nil, PARAMS5 = nil, PARAMS6 = nil, PARAMS7 = nil, PARAMS8 = nil, PARAMS9 = nil, name = "RGB", names = { "RGB", "R", "G", "B", "min", "max", "delta", "h", "s", "v" } },
  { TEXT = "RGB" },
  { TEXT = "R" },
  { TEXT = "G" },
  { TEXT = "B" },
  { TEXT = "max" },
  { TEXT = "min" },
  { TEXT = "delta" },
  { value = 0, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"h\"}" },
  { TEXT = "h" },
  { method = "increase", value = 360, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"h\"}" },
  { value = 0, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"s\"}" },
  { TEXT = "s" },
  { TEXT = "v" },
  { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, PARAMS3 = nil, PARAMS4 = nil, PARAMS5 = nil, name = "dx", names = { "dx", "dy", "ix", "iy", "nearest_x", "nearest_y" } },
  { TEXT = "ix" },
  { TEXT = "iy" },
  { TEXT = "nearest_x" },
  { TEXT = "nearest_y" },
  { sprite = "--self" },
  { ADD0 = "000000" },
  { PARAMS0 = nil, PARAMS1 = nil, name = "btn", names = { "btn", "b" } },
  { text = "6", type = "number" },
  { TEXT = "btn" },
  { text = "碰到！", type = "talk" },
  { text = "点击！", type = "talk" },
  { A = 0, B = 100 },
  { ITEM0 = 50, ITEM1 = -100, ITEM2 = 100, ITEM3 = 100, ITEM4 = 50 },
}

-- ===== 自定义积木（过程）=====
local proc_1304ad1c_c306_4bf4_aa73_65d80b88312e, proc_13e4ca8c_303a_4d4f_a0cb_be771ef56322, proc_2c9b21d2_2eb6_4cf2_a846_1a7a7cc13576, proc_3f7b206b_81f6_4791_8ed4_51071d2ac194, proc_4e5fa736_0363_4a5c_9f5e_d3d00a0a33b5, proc_56fedea0_cbd2_457f_85f3_70006da0bd1f, proc_6054fd4e_0b79_4b87_b646_ade358c94405, proc_84ce8f31_c970_4a48_b1c5_3b7d57c8efb8, proc_863e6469_4a75_42b8_ac56_3d211a496e0c, proc_b4c9c4d4_540e_4653_ad1c_cf0e4230216b, proc_bafb837a_fcbf_4046_82d3_9ed9b39d656b, proc_bd70fea2_0318_4866_9940_0ebaf6fa4db8, proc_c2cedf9c_ba6a_4bbb_9f80_dbd01acb17f7, proc_d4ce4407_8c3b_4eb0_ac29_17496bbfbaa5, proc_dd777c17_75ed_40e6_a99a_85b70c064f6f, proc_e7b92cdb_611a_4629_9224_faacd3641488, proc_e7ce6425_2057_4902_960e_1bd6ed09a102

proc_1304ad1c_c306_4bf4_aa73_65d80b88312e = function(th, self, p_x, p_y, p____, p_____2, p_____________, p_HEX, p_i, p_HEX______)
  -- 过程「函数_3」 id=1304ad1c-c306-4bf4-aa73-65d80b88312e
  th:warp_enter()
  if V.js_boolean(f["logic_compare"](self, { A = p_____________, B = f["math_arithmetic"](self, { A = p_____2, B = 2, type = "divide" }, th), OP = "GT" }, th)) then
    proc_1304ad1c_c306_4bf4_aa73_65d80b88312e(th, self, p_x, p_y, p____, p_____2, f["math_arithmetic"](self, { A = p_____2, B = 2, type = "divide" }, th), p_HEX, 0, 0, nil)
    th:warp_exit()
    return nil
  end
  f["script_variables"](self, __CONST[1], th)
  if V.js_boolean(f["logic_compare"](self, { A = p_HEX______, B = 0, OP = "EQ" }, th)) then
    f["self_set_pen_size"](self, { size = f["math_arithmetic"](self, { A = p_____________, B = 2, type = "multiply" }, th) }, th)
    if V.js_boolean(f["logic_compare"](self, { A = p_HEX, B = 0, OP = "EQ" }, th)) then
      f["variables_set"](self, { value = f["temporary_list"](self, __CONST[2], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
    else
      f["variables_set"](self, { value = (proc_c2cedf9c_ba6a_4bbb_9f80_dbd01acb17f7(th, self, p_HEX, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
      f["self_set_pen_color_property"](self, { scope = "hue", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[3], th), list_index = 1 }, th) }, th)
      f["self_set_pen_color_property"](self, { scope = "saturation", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[3], th), list_index = 2 }, th) }, th)
      f["self_set_pen_color_property"](self, { scope = "brightness", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[3], th), list_index = 3 }, th) }, th)
    end
  else
    f["variables_set"](self, { value = p_HEX______, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
  end
  f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = p_x, B = p_____________, type = "add" }, th), y = f["math_arithmetic"](self, { A = p_y, B = f["math_arithmetic"](self, { A = p_i, B = p_____________, type = "add" }, th), type = "minus" }, th) }, th)
  f["self_pen_down"](self, {}, th)
  f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = p____, B = f["math_arithmetic"](self, { A = p_____________, B = 2, type = "multiply" }, th), type = "minus" }, th) }, th)
  if V.js_boolean(f["logic_compare"](self, { A = p_i, B = f["math_arithmetic"](self, { A = p_____2, B = f["math_arithmetic"](self, { A = p_____________, B = 2, type = "multiply" }, th), type = "minus" }, th), OP = "LT" }, th)) then
    proc_1304ad1c_c306_4bf4_aa73_65d80b88312e(th, self, p_x, p_y, p____, p_____2, p_____________, p_HEX, f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th), f["script_variables_value"](self, __CONST[3], th), nil)
  end
  f["self_pen_up"](self, {}, th)
  th:warp_exit()
end

proc_13e4ca8c_303a_4d4f_a0cb_be771ef56322 = function(th, self, p_xA, p_yA, p_xB, p_yB)
  -- 过程「函数_数_字符_1」 id=13e4ca8c-303a-4d4f-a0cb-be771ef56322
  f["script_variables"](self, __CONST[4], th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_xB, B = p_xA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"dx\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_yB, B = p_yA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"dy\"}" }, th)
  if V.js_boolean(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[5], th), B = 0, OP = "LT" }, th)) then
    return f["math_arithmetic"](self, { A = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[6], th), B = f["script_variables_value"](self, __CONST[5], th), type = "divide" }, th), type = "atan" }, th), B = 180, type = "add" }, th)
  elseif V.js_boolean(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[5], th), B = 0, OP = "EQ" }, th)) then
    if V.js_boolean(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[6], th), B = 0, OP = "GT" }, th)) then
      return 90
    elseif V.js_boolean(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[6], th), B = 0, OP = "LT" }, th)) then
      return 270
    else
      return 0
    end
  else
    if V.js_boolean(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[6], th), B = 0, OP = "GTE" }, th)) then
      return f["math_trig"](self, { num = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[6], th), B = f["script_variables_value"](self, __CONST[5], th), type = "divide" }, th), type = "atan" }, th)
    else
      return f["math_arithmetic"](self, { A = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[6], th), B = f["script_variables_value"](self, __CONST[5], th), type = "divide" }, th), type = "atan" }, th), B = 360, type = "add" }, th)
    end
  end
end

proc_2c9b21d2_2eb6_4cf2_a846_1a7a7cc13576 = function(th, self, p_x1, p_y1, p_x2, p_y2, p_x3, p_y3, p_x4, p_y4, p_x5, p_y5, p_x6, p_y6, p_res, p_hex, p_hex2, p_px)
  -- 过程「函数_8」 id=2c9b21d2-2eb6-4cf2-a846-1a7a7cc13576
  f["script_variables"](self, __CONST[7], th)
  th:warp_enter()
  f["variables_set"](self, { value = (proc_c2cedf9c_ba6a_4bbb_9f80_dbd01acb17f7(th, self, p_hex, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"hex列表\"}" }, th)
  f["variables_set"](self, { value = (proc_c2cedf9c_ba6a_4bbb_9f80_dbd01acb17f7(th, self, p_hex2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"hex2列表\"}" }, th)
  f["self_set_pen_color_property"](self, { scope = "hue", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[8], th), list_index = 1 }, th) }, th)
  f["self_set_pen_color_property"](self, { scope = "saturation", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[8], th), list_index = 2 }, th) }, th)
  f["self_set_pen_color_property"](self, { scope = "brightness", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[8], th), list_index = 3 }, th) }, th)
  proc_84ce8f31_c970_4a48_b1c5_3b7d57c8efb8(th, self, p_x1, p_y1, p_x2, p_y2, p_x3, p_y3, p_res, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)
  proc_84ce8f31_c970_4a48_b1c5_3b7d57c8efb8(th, self, p_x4, p_y4, p_x5, p_y5, p_x6, p_y6, p_res, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)
  f["self_set_pen_color_property"](self, { scope = "hue", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 1 }, th) }, th)
  f["self_set_pen_color_property"](self, { scope = "saturation", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 2 }, th) }, th)
  f["self_set_pen_color_property"](self, { scope = "brightness", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 3 }, th) }, th)
  proc_84ce8f31_c970_4a48_b1c5_3b7d57c8efb8(th, self, p_x1, f["math_arithmetic"](self, { A = p_y1, B = p_px, type = "add" }, th), p_x2, f["math_arithmetic"](self, { A = p_y2, B = p_px, type = "add" }, th), p_x3, f["math_arithmetic"](self, { A = p_y3, B = p_px, type = "add" }, th), p_res, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)
  proc_84ce8f31_c970_4a48_b1c5_3b7d57c8efb8(th, self, p_x4, f["math_arithmetic"](self, { A = p_y4, B = p_px, type = "add" }, th), p_x5, f["math_arithmetic"](self, { A = p_y5, B = p_px, type = "add" }, th), p_x6, f["math_arithmetic"](self, { A = p_y6, B = p_px, type = "add" }, th), p_res, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)
  th:warp_exit()
end

proc_3f7b206b_81f6_4791_8ed4_51071d2ac194 = function(th, self, p_x, p_y, p_______, p________2, p_HEX, p_n)
  -- 过程「6d8aa17b-76dc-4753-8660-211ef93ec1e2」 id=3f7b206b-81f6-4791-8ed4-51071d2ac194
  f["script_variables"](self, __CONST[10], th)
  th:warp_enter()
  f["variables_set"](self, { value = (proc_c2cedf9c_ba6a_4bbb_9f80_dbd01acb17f7(th, self, p_HEX, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"hex列表\"}" }, th)
  f["self_set_pen_color_property"](self, { scope = "hue", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[8], th), list_index = 1 }, th) }, th)
  f["self_set_pen_color_property"](self, { scope = "saturation", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[8], th), list_index = 2 }, th) }, th)
  f["self_set_pen_color_property"](self, { scope = "brightness", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[8], th), list_index = 3 }, th) }, th)
  f["self_move_to"](self, { x = p_x, y = p_y }, th)
  f["self_set_pen_size"](self, { size = p________2 }, th)
  f["self_pen_down"](self, {}, th)
  f["self_change_coordinate_x"](self, { increase = "increase", value = p_______ }, th)
  f["self_pen_up"](self, {}, th)
  f["self_change_pen_color_property"](self, __CONST[11], th)
  f["self_change_pen_size"](self, __CONST[12], th)
  f["self_move_to"](self, { x = p_x, y = p_y }, th)
  f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_______, B = p_n, type = "multiply" }, th), B = 100, type = "divide" }, th) }, th)
  f["self_pen_down"](self, {}, th)
  f["self_pen_up"](self, {}, th)
  f["self_change_pen_color_property"](self, __CONST[13], th)
  f["self_change_pen_size"](self, __CONST[14], th)
  f["self_pen_down"](self, {}, th)
  f["self_pen_up"](self, {}, th)
  th:warp_exit()
end

proc_4e5fa736_0363_4a5c_9f5e_d3d00a0a33b5 = function(th, self, p_x, p_y, p_______, p_HEX, p_HEX2, p_n)
  -- 过程「6d8aa17b-76dc-4753-8660-211ef93ec1e2」 id=4e5fa736-0363-4a5c-9f5e-d3d00a0a33b5
  f["script_variables"](self, __CONST[15], th)
  th:warp_enter()
  f["variables_set"](self, { value = (proc_c2cedf9c_ba6a_4bbb_9f80_dbd01acb17f7(th, self, p_HEX, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"hex列表\"}" }, th)
  f["variables_set"](self, { value = (proc_c2cedf9c_ba6a_4bbb_9f80_dbd01acb17f7(th, self, p_HEX2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"hex2列表\"}" }, th)
  f["variables_set"](self, { value = f["appearance_of_sprite"](self, __CONST[16], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"旋转备份\"}" }, th)
  f["self_set_pen_color_property"](self, { scope = "hue", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[8], th), list_index = 1 }, th) }, th)
  f["self_set_pen_color_property"](self, { scope = "saturation", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[8], th), list_index = 2 }, th) }, th)
  f["self_set_pen_color_property"](self, { scope = "brightness", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[8], th), list_index = 3 }, th) }, th)
  f["self_move_to"](self, { x = p_x, y = p_y }, th)
  f["self_change_pen_color_property"](self, __CONST[11], th)
  f["self_set_pen_size"](self, { size = f["math_arithmetic"](self, { A = p_______, B = 1.2, type = "multiply" }, th) }, th)
  f["self_pen_down"](self, {}, th)
  f["self_pen_up"](self, {}, th)
  f["self_change_pen_color_property"](self, __CONST[17], th)
  f["self_set_pen_size"](self, { size = p_______ }, th)
  f["self_pen_down"](self, {}, th)
  f["self_pen_up"](self, {}, th)
  f["self_set_pen_size"](self, { size = f["math_arithmetic"](self, { A = p_______, B = 5, type = "divide" }, th) }, th)
  f["self_set_pen_color_property"](self, { scope = "hue", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 1 }, th) }, th)
  f["self_set_pen_color_property"](self, { scope = "saturation", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 2 }, th) }, th)
  f["self_set_pen_color_property"](self, { scope = "brightness", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 3 }, th) }, th)
  f["self_point_towards"](self, { degrees = f["math_arithmetic"](self, { A = p_n, B = 90, type = "minus" }, th) }, th)
  f["self_go_forward"](self, { steps = f["math_arithmetic"](self, { A = p_______, B = 5, type = "divide" }, th) }, th)
  f["self_pen_down"](self, {}, th)
  f["self_pen_up"](self, {}, th)
  th:warp_exit()
end

proc_56fedea0_cbd2_457f_85f3_70006da0bd1f = function(th, self, p_______, p________2)
  -- 过程「函数_布尔_13」 id=56fedea0-cbd2-457f-85f3-70006da0bd1f
  f["script_variables"](self, __CONST[18], th)
  f["variables_set"](self, { value = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["get_mouse_info"](self, __CONST[19], th), B = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_______, list_index = 1 }, th), B = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_______, list_index = 3 }, th), B = 2, type = "divide" }, th), type = "add" }, th), type = "minus" }, th), type = "1" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"qx\"}" }, th)
  f["variables_set"](self, { value = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["get_mouse_info"](self, __CONST[20], th), B = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_______, list_index = 2 }, th), B = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_______, list_index = 4 }, th), B = 2, type = "divide" }, th), type = "minus" }, th), type = "minus" }, th), type = "1" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"qy\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[21], th), B = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_______, list_index = 3 }, th), B = 2, type = "divide" }, th), type = "minus" }, th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 5 }, th), type = "add" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"dx\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[22], th), B = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_______, list_index = 4 }, th), B = 2, type = "divide" }, th), type = "minus" }, th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 5 }, th), type = "add" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"dy\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = (proc_b4c9c4d4_540e_4653_ad1c_cf0e4230216b(th, self, f["temporary_list"](self, { ITEM0 = f["script_variables_value"](self, __CONST[5], th), ITEM1 = 0 }, th), "最大", nil)), B = 2, type = "power" }, th), B = f["math_arithmetic"](self, { A = (proc_b4c9c4d4_540e_4653_ad1c_cf0e4230216b(th, self, f["temporary_list"](self, { ITEM0 = f["script_variables_value"](self, __CONST[6], th), ITEM1 = 0 }, th), "最大", nil)), B = 2, type = "power" }, th), type = "add" }, th), type = "0" }, th), B = (proc_b4c9c4d4_540e_4653_ad1c_cf0e4230216b(th, self, f["temporary_list"](self, { ITEM0 = (proc_b4c9c4d4_540e_4653_ad1c_cf0e4230216b(th, self, f["temporary_list"](self, { ITEM0 = f["script_variables_value"](self, __CONST[5], th), ITEM1 = f["script_variables_value"](self, __CONST[6], th) }, th), "最大", nil)), ITEM1 = 0 }, th), "最小", nil)), type = "add" }, th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 5 }, th), type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"d\"}" }, th)
  if V.js_boolean(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[23], th), B = 0, OP = "LT" }, th)) then
    if V.js_boolean(f["logic_compare"](self, { A = p________2, B = "点击", OP = "EQ" }, th)) then
      if V.js_boolean(f["mouse_down"](self, __CONST[24], th)) then
        return true
      else
        return false
      end
    else
      return true
    end
  else
    return false
  end
end

proc_6054fd4e_0b79_4b87_b646_ade358c94405 = function(th, self, p_x1, p_y1, p_x2, p_y2, p_x3, p_y3, p_______, p_HEX)
  -- 过程「函数_40」 id=6054fd4e-0b79-4b87-b646-ade358c94405
  f["script_variables"](self, __CONST[10], th)
  th:warp_enter()
  f["variables_set"](self, { value = (proc_c2cedf9c_ba6a_4bbb_9f80_dbd01acb17f7(th, self, p_HEX, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"hex列表\"}" }, th)
  f["self_set_pen_size"](self, { size = p_______ }, th)
  f["self_set_pen_color_property"](self, { scope = "hue", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[8], th), list_index = 1 }, th) }, th)
  f["self_set_pen_color_property"](self, { scope = "saturation", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[8], th), list_index = 2 }, th) }, th)
  f["self_set_pen_color_property"](self, { scope = "brightness", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[8], th), list_index = 3 }, th) }, th)
  f["self_move_to"](self, { x = p_x1, y = p_y1 }, th)
  f["self_pen_down"](self, {}, th)
  f["self_move_to"](self, { x = p_x2, y = p_y2 }, th)
  f["self_move_to"](self, { x = p_x3, y = p_y3 }, th)
  f["self_move_to"](self, { x = p_x1, y = p_y1 }, th)
  f["self_pen_up"](self, {}, th)
  th:warp_exit()
end

proc_84ce8f31_c970_4a48_b1c5_3b7d57c8efb8 = function(th, self, p_x1, p_y1, p_x2, p_y2, p_x3, p_y3, p_res)
  -- 过程「函数_7」 id=84ce8f31-c970-4a48-b1c5-3b7d57c8efb8
  f["script_variables"](self, __CONST[25], th)
  th:warp_enter()
  f["variables_set"](self, { value = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_x3, B = p_x2, type = "minus" }, th), B = 2, type = "power" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_y3, B = p_y2, type = "minus" }, th), B = 2, type = "power" }, th), type = "add" }, th), type = "0" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"tir1\"}" }, th)
  f["variables_set"](self, { value = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_x3, B = p_x1, type = "minus" }, th), B = 2, type = "power" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_y3, B = p_y1, type = "minus" }, th), B = 2, type = "power" }, th), type = "add" }, th), type = "0" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"tir2\"}" }, th)
  f["variables_set"](self, { value = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_x1, B = p_x2, type = "minus" }, th), B = 2, type = "power" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_y1, B = p_y2, type = "minus" }, th), B = 2, type = "power" }, th), type = "add" }, th), type = "0" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"tir3\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[26], th), B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[27], th), B = f["script_variables_value"](self, __CONST[28], th), type = "add" }, th), type = "add" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"tir4\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[29], th), B = 2, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"tir5\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 2, B = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[30], th), B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[30], th), B = f["script_variables_value"](self, __CONST[26], th), type = "minus" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[30], th), B = f["script_variables_value"](self, __CONST[27], th), type = "minus" }, th), B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[30], th), B = f["script_variables_value"](self, __CONST[28], th), type = "minus" }, th), type = "multiply" }, th), type = "multiply" }, th), type = "0" }, th), type = "multiply" }, th), B = f["script_variables_value"](self, __CONST[30], th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"tir5\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[26], th), B = p_x1, type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[27], th), B = p_x2, type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[28], th), B = p_x3, type = "multiply" }, th), type = "add" }, th), type = "add" }, th), B = f["script_variables_value"](self, __CONST[29], th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"tir6\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[26], th), B = p_y1, type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[27], th), B = p_y2, type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[28], th), B = p_y3, type = "multiply" }, th), type = "add" }, th), type = "add" }, th), B = f["script_variables_value"](self, __CONST[29], th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"tir7\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_x1, B = f["script_variables_value"](self, __CONST[31], th), type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"tir1\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_y1, B = f["script_variables_value"](self, __CONST[32], th), type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"tir2\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_x2, B = f["script_variables_value"](self, __CONST[31], th), type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"tir3\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_y2, B = f["script_variables_value"](self, __CONST[32], th), type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"tir4\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_x3, B = f["script_variables_value"](self, __CONST[31], th), type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"tir8\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_y3, B = f["script_variables_value"](self, __CONST[32], th), type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"tir9\"}" }, th)
  f["variables_set"](self, __CONST[33], th)
  while true do
    f["self_set_pen_size"](self, { size = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[34], th), B = f["script_variables_value"](self, __CONST[30], th), type = "multiply" }, th), B = 1, type = "add" }, th) }, th)
    f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = p_x1, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[34], th), B = f["script_variables_value"](self, __CONST[26], th), type = "multiply" }, th), type = "minus" }, th), y = f["math_arithmetic"](self, { A = p_y1, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[34], th), B = f["script_variables_value"](self, __CONST[27], th), type = "multiply" }, th), type = "minus" }, th) }, th)
    f["self_pen_down"](self, {}, th)
    f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = p_x2, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[34], th), B = f["script_variables_value"](self, __CONST[28], th), type = "multiply" }, th), type = "minus" }, th), y = f["math_arithmetic"](self, { A = p_y2, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[34], th), B = f["script_variables_value"](self, __CONST[29], th), type = "multiply" }, th), type = "minus" }, th) }, th)
    f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = p_x3, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[34], th), B = f["script_variables_value"](self, __CONST[35], th), type = "multiply" }, th), type = "minus" }, th), y = f["math_arithmetic"](self, { A = p_y3, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[34], th), B = f["script_variables_value"](self, __CONST[36], th), type = "multiply" }, th), type = "minus" }, th) }, th)
    f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = p_x1, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[34], th), B = f["script_variables_value"](self, __CONST[26], th), type = "multiply" }, th), type = "minus" }, th), y = f["math_arithmetic"](self, { A = p_y1, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[34], th), B = f["script_variables_value"](self, __CONST[27], th), type = "multiply" }, th), type = "minus" }, th) }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[34], th), B = f["math_arithmetic"](self, { A = 2.718281828459, B = f["script_variables_value"](self, __CONST[34], th), type = "minus" }, th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"l\"}" }, th)
    if V.js_boolean(f["logic_compare"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[34], th), B = f["script_variables_value"](self, __CONST[30], th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_res, B = 2, type = "divide" }, th), B = 0.5, type = "add" }, th), OP = "LT" }, th)) then break end
    if th:iter_w() then break end
  end
  f["self_pen_up"](self, {}, th)
  f["self_move_to"](self, { x = p_x1, y = p_y1 }, th)
  f["self_pen_down"](self, {}, th)
  f["self_move_to"](self, { x = p_x2, y = p_y2 }, th)
  f["self_move_to"](self, { x = p_x3, y = p_y3 }, th)
  f["self_move_to"](self, { x = p_x1, y = p_y1 }, th)
  f["self_pen_up"](self, {}, th)
  th:warp_exit()
end

proc_863e6469_4a75_42b8_ac56_3d211a496e0c = function(th, self, p_AGML, p_____________)
  -- 过程「10a18fe6-93f4-43ff-aadf-e263a35f80f5」 id=863e6469-4a75-42b8-ac56-3d211a496e0c
  f["script_variables"](self, __CONST[37], th)
  th:warp_enter()
  f["variables_set"](self, { value = f["temporary_list"](self, {}, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ID组\"}" }, th)
  f["variables_set"](self, { value = f["temporary_list"](self, {}, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"参数组\"}" }, th)
  f["variables_set"](self, { value = f["text_split"](self, { SPLIT_TEXT = ";", TEXT_TO_SPLIT = (proc_e7ce6425_2057_4902_960e_1bd6ed09a102(th, self, p_AGML, " ", nil)) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"换行\"}" }, th)
  if V.js_boolean(f["logic_compare"](self, { A = f["list_item"](self, { item = "last", list = f["script_variables_value"](self, __CONST[38], th) }, th), B = f["text_join"](self, __CONST[39], th), OP = "EQ" }, th)) then
    f["delete_list_item"](self, { item = "last", list = f["script_variables_value"](self, __CONST[38], th) }, th)
  end
  do
    local _from_n1, _to_n1 = tonumber(1), tonumber(f["list_length"](self, { list = f["script_variables_value"](self, __CONST[38], th) }, th))
    if _from_n1 ~= _from_n1 or _to_n1 ~= _to_n1 then
      -- NaN from/to: official warning; no iterations
    else
      if _from_n1 <= _to_n1 then _from_n1 = math.ceil(_from_n1); if _from_n1 > _to_n1 then _from_n1 = _to_n1 + 1 end
      else _from_n1 = math.floor(_from_n1); if _from_n1 < _to_n1 then _from_n1 = _to_n1 - 1 end end
      local _by_n1 = 1
      if _by_n1 == nil then _by_n1 = 1 end
      _by_n1 = tonumber(_by_n1)
      if _by_n1 == nil or _by_n1 ~= _by_n1 or _by_n1 <= 0 then _by_n1 = 0 else _by_n1 = math.abs(math.floor(_by_n1 + 0.5)) end
      if _by_n1 > 0 then
        local _p_n1 = _from_n1
        while (_from_n1 <= _to_n1 and _p_n1 <= _to_n1) or (_from_n1 > _to_n1 and _p_n1 >= _to_n1) do
          local _i_n1 = _p_n1
          th:push_param(_p_n1)
        f["variables_set"](self, { value = f["text_split"](self, { SPLIT_TEXT = ":", TEXT_TO_SPLIT = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[38], th), list_index = _p_n1 }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"分割\"}" }, th)
        f["list_append"](self, { list = f["script_variables_value"](self, __CONST[41], th), list_item_value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[40], th), list_index = 1 }, th) }, th)
        f["list_append"](self, { list = f["script_variables_value"](self, __CONST[42], th), list_item_value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[40], th), list_index = 2 }, th) }, th)
          th:pop_param()
          _p_n1 = _p_n1 + _by_n1
          if th:iter_w() then break end
        end
      end
    end
  end
  do
    local _from_n2, _to_n2 = tonumber(1), tonumber(f["list_length"](self, { list = f["script_variables_value"](self, __CONST[41], th) }, th))
    if _from_n2 ~= _from_n2 or _to_n2 ~= _to_n2 then
      -- NaN from/to: official warning; no iterations
    else
      if _from_n2 <= _to_n2 then _from_n2 = math.ceil(_from_n2); if _from_n2 > _to_n2 then _from_n2 = _to_n2 + 1 end
      else _from_n2 = math.floor(_from_n2); if _from_n2 < _to_n2 then _from_n2 = _to_n2 - 1 end end
      local _by_n2 = 1
      if _by_n2 == nil then _by_n2 = 1 end
      _by_n2 = tonumber(_by_n2)
      if _by_n2 == nil or _by_n2 ~= _by_n2 or _by_n2 <= 0 then _by_n2 = 0 else _by_n2 = math.abs(math.floor(_by_n2 + 0.5)) end
      if _by_n2 > 0 then
        local _p_n2 = _from_n2
        while (_from_n2 <= _to_n2 and _p_n2 <= _to_n2) or (_from_n2 > _to_n2 and _p_n2 >= _to_n2) do
          local _i_n2 = _p_n2
          th:push_param(_p_n2)
        f["variables_set"](self, { value = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[42], th), list_index = _p_n2 }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"参数分割\"}" }, th)
        if V.js_boolean(p_____________) then
          while true do
            f["list_append"](self, { list = f["script_variables_value"](self, __CONST[43], th), list_item_value = 0 }, th)
            if V.js_boolean(f["logic_compare"](self, { A = f["list_length"](self, { list = f["script_variables_value"](self, __CONST[43], th) }, th), B = 9, OP = "EQ" }, th)) then break end
            if th:iter_w() then break end
          end
        end
        if V.js_boolean(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[41], th), list_index = _p_n2 }, th), B = "btn", OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[41], th), list_index = _p_n2 }, th), B = "in", OP = "EQ" }, th), type = "or" }, th)) then
          proc_dd777c17_75ed_40e6_a99a_85b70c064f6f(th, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 1 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 2 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 3 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 4 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 5 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 6 }, th), f["convert_type"](self, { text = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 7 }, th), type = "boolean" }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 8 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 9 }, th), nil, nil)
        elseif V.js_boolean(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[41], th), list_index = _p_n2 }, th), B = "tri", OP = "EQ" }, th)) then
          proc_84ce8f31_c970_4a48_b1c5_3b7d57c8efb8(th, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 1 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 2 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 3 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 4 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 5 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 6 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 7 }, th), nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)
        elseif V.js_boolean(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[41], th), list_index = _p_n2 }, th), B = "tri_edge", OP = "EQ" }, th)) then
          proc_6054fd4e_0b79_4b87_b646_ade358c94405(th, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 1 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 2 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 3 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 4 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 5 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 6 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 7 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 8 }, th), nil)
        elseif V.js_boolean(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[41], th), list_index = _p_n2 }, th), B = "rdb", OP = "EQ" }, th)) then
          if V.js_boolean(f["convert_type"](self, { text = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 5 }, th), type = "boolean" }, th)) then
            proc_bd70fea2_0318_4866_9940_0ebaf6fa4db8(th, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 1 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 2 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 3 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 4 }, th), "单选", "选中", f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 6 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 7 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 8 }, th), nil, nil)
          else
            proc_bd70fea2_0318_4866_9940_0ebaf6fa4db8(th, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 1 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 2 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 3 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 4 }, th), "单选", "没选中", f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 6 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 7 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 8 }, th), nil, nil)
          end
        elseif V.js_boolean(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[41], th), list_index = _p_n2 }, th), B = "chk", OP = "EQ" }, th)) then
          if V.js_boolean(f["convert_type"](self, { text = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 5 }, th), type = "boolean" }, th)) then
            proc_bd70fea2_0318_4866_9940_0ebaf6fa4db8(th, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 1 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 2 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 3 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 4 }, th), "多选", "选中", f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 6 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 7 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 8 }, th), nil, nil)
          else
            proc_bd70fea2_0318_4866_9940_0ebaf6fa4db8(th, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 1 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 2 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 3 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 4 }, th), "多选", "没选中", f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 6 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 7 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 8 }, th), nil, nil)
          end
        elseif V.js_boolean(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[41], th), list_index = _p_n2 }, th), B = "sld", OP = "EQ" }, th)) then
          proc_3f7b206b_81f6_4791_8ed4_51071d2ac194(th, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 1 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 2 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 3 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 4 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 5 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 6 }, th), nil)
        elseif V.js_boolean(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[41], th), list_index = _p_n2 }, th), B = "say", OP = "EQ" }, th)) then
          if V.js_boolean(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 3 }, th), B = 1, OP = "EQ" }, th)) then
            f["stamp"](self, { align = "center", size = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 2 }, th), text = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 1 }, th) }, th)
          elseif V.js_boolean(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 3 }, th), B = 2, OP = "EQ" }, th)) then
            f["stamp"](self, { align = "left", size = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 2 }, th), text = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 1 }, th) }, th)
          else
            f["stamp"](self, { align = "right", size = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 2 }, th), text = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 1 }, th) }, th)
          end
        elseif V.js_boolean(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[41], th), list_index = _p_n2 }, th), B = "to", OP = "EQ" }, th)) then
          f["self_move_to"](self, { x = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 1 }, th), y = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 2 }, th) }, th)
        elseif V.js_boolean(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[41], th), list_index = _p_n2 }, th), B = "clr", OP = "EQ" }, th)) then
          f["script_variables"](self, __CONST[10], th)
          f["variables_set"](self, { value = (proc_c2cedf9c_ba6a_4bbb_9f80_dbd01acb17f7(th, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 1 }, th), nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"hex列表\"}" }, th)
          f["self_set_pen_color_property"](self, { scope = "hue", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[8], th), list_index = 1 }, th) }, th)
          f["self_set_pen_color_property"](self, { scope = "saturation", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[8], th), list_index = 2 }, th) }, th)
          f["self_set_pen_color_property"](self, { scope = "brightness", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[8], th), list_index = 3 }, th) }, th)
        elseif V.js_boolean(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[41], th), list_index = _p_n2 }, th), B = "spn", OP = "EQ" }, th)) then
          proc_4e5fa736_0363_4a5c_9f5e_d3d00a0a33b5(th, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 1 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 2 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 3 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 4 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 5 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[43], th), list_index = 6 }, th), nil, nil, nil)
        end
          th:pop_param()
          _p_n2 = _p_n2 + _by_n2
          if th:iter_w() then break end
        end
      end
    end
  end
  th:warp_exit()
end

proc_b4c9c4d4_540e_4653_ad1c_cf0e4230216b = function(th, self, p_______, p________2)
  -- 过程「函数_数_字符_24」 id=b4c9c4d4-540e-4653-ad1c-cf0e4230216b
  th:warp_enter()
  f["script_variables"](self, __CONST[1], th)
  f["variables_set"](self, __CONST[44], th)
  do
    local _from_n1, _to_n1 = tonumber(1), tonumber(f["list_length"](self, { list = p_______ }, th))
    if _from_n1 ~= _from_n1 or _to_n1 ~= _to_n1 then
      -- NaN from/to: official warning; no iterations
    else
      if _from_n1 <= _to_n1 then _from_n1 = math.ceil(_from_n1); if _from_n1 > _to_n1 then _from_n1 = _to_n1 + 1 end
      else _from_n1 = math.floor(_from_n1); if _from_n1 < _to_n1 then _from_n1 = _to_n1 - 1 end end
      local _by_n1 = 1
      if _by_n1 == nil then _by_n1 = 1 end
      _by_n1 = tonumber(_by_n1)
      if _by_n1 == nil or _by_n1 ~= _by_n1 or _by_n1 <= 0 then _by_n1 = 0 else _by_n1 = math.abs(math.floor(_by_n1 + 0.5)) end
      if _by_n1 > 0 then
        local _p_n1 = _from_n1
        while (_from_n1 <= _to_n1 and _p_n1 <= _to_n1) or (_from_n1 > _to_n1 and _p_n1 >= _to_n1) do
          local _i_n1 = _p_n1
          th:push_param(_p_n1)
        if V.js_boolean(f["logic_operation"](self, { A = f["logic_compare"](self, { A = p________2, B = "最大", OP = "EQ" }, th), B = f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[3], th), B = "", OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[3], th), B = f["list_item"](self, { item = "any", list = p_______, list_index = _p_n1 }, th), OP = "LT" }, th), type = "or" }, th), type = "and" }, th)) then
          f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = p_______, list_index = _p_n1 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        elseif V.js_boolean(f["logic_operation"](self, { A = f["logic_compare"](self, { A = p________2, B = "最小", OP = "EQ" }, th), B = f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[3], th), B = "", OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[3], th), B = f["list_item"](self, { item = "any", list = p_______, list_index = _p_n1 }, th), OP = "GT" }, th), type = "or" }, th), type = "and" }, th)) then
          f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = p_______, list_index = _p_n1 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        end
          th:pop_param()
          _p_n1 = _p_n1 + _by_n1
          if th:iter_w() then break end
        end
      end
    end
  end
  th:warp_exit()
  return f["script_variables_value"](self, __CONST[3], th)
end

proc_bafb837a_fcbf_4046_82d3_9ed9b39d656b = function(th, self, p_______1, p_______2, p_______3)
  -- 过程「函数_布尔_14」 id=bafb837a-fcbf-4046-82d3-9ed9b39d656b
  if V.js_boolean(f["logic_operation"](self, { A = f["logic_compare"](self, { A = p_______2, B = p_______1, OP = "LTE" }, th), B = f["logic_compare"](self, { A = p_______1, B = p_______3, OP = "LTE" }, th), type = "and" }, th)) then
    return true
  else
    return false
  end
end

proc_bd70fea2_0318_4866_9940_0ebaf6fa4db8 = function(th, self, p_x, p_y, p_______, p________2, p________3, p________4, p_HEX, p________5, p_______HEX)
  -- 过程「6d8aa17b-76dc-4753-8660-211ef93ec1e2」 id=bd70fea2-0318-4866-9940-0ebaf6fa4db8
  f["script_variables"](self, __CONST[45], th)
  th:warp_enter()
  f["variables_set"](self, { value = (proc_c2cedf9c_ba6a_4bbb_9f80_dbd01acb17f7(th, self, p_HEX, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"hex列表\"}" }, th)
  f["variables_set"](self, { value = (proc_c2cedf9c_ba6a_4bbb_9f80_dbd01acb17f7(th, self, p_______HEX, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"文字hex\"}" }, th)
  f["self_set_pen_color_property"](self, { scope = "hue", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[8], th), list_index = 1 }, th) }, th)
  f["self_set_pen_color_property"](self, { scope = "saturation", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[8], th), list_index = 2 }, th) }, th)
  f["self_set_pen_color_property"](self, { scope = "brightness", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[8], th), list_index = 3 }, th) }, th)
  f["self_set_pen_size"](self, { size = p________2 }, th)
  if V.js_boolean(f["logic_compare"](self, { A = p________3, B = "单选", OP = "EQ" }, th)) then
    f["self_change_pen_color_property"](self, __CONST[11], th)
    f["self_change_pen_size"](self, __CONST[12], th)
    f["self_move_to"](self, { x = p_x, y = p_y }, th)
    f["self_pen_down"](self, {}, th)
    f["self_pen_up"](self, {}, th)
    if V.js_boolean(f["logic_compare"](self, { A = p________4, B = "选中", OP = "EQ" }, th)) then
      f["self_change_pen_color_property"](self, __CONST[13], th)
      f["self_change_pen_size"](self, __CONST[14], th)
      f["self_pen_down"](self, {}, th)
      f["self_pen_up"](self, {}, th)
    end
    f["self_change_coordinate_x"](self, __CONST[46], th)
    f["self_set_pen_color_property"](self, { scope = "hue", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[47], th), list_index = 1 }, th) }, th)
    f["self_set_pen_color_property"](self, { scope = "saturation", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[47], th), list_index = 2 }, th) }, th)
    f["self_set_pen_color_property"](self, { scope = "brightness", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[47], th), list_index = 3 }, th) }, th)
    f["stamp"](self, { align = "left", size = p_______, text = p________5 }, th)
  else
    f["self_change_pen_color_property"](self, __CONST[11], th)
    f["self_change_pen_size"](self, __CONST[12], th)
    f["self_move_to"](self, { x = p_x, y = p_y }, th)
    f["self_pen_down"](self, {}, th)
    f["self_pen_up"](self, {}, th)
    f["self_set_pen_color_property"](self, { scope = "hue", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[47], th), list_index = 1 }, th) }, th)
    f["self_set_pen_color_property"](self, { scope = "saturation", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[47], th), list_index = 2 }, th) }, th)
    f["self_set_pen_color_property"](self, { scope = "brightness", val = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[47], th), list_index = 3 }, th) }, th)
    if V.js_boolean(f["logic_compare"](self, { A = p________4, B = "选中", OP = "EQ" }, th)) then
      f["stamp"](self, { align = "center", size = p_______, text = "✓" }, th)
    end
    f["self_change_coordinate_x"](self, __CONST[46], th)
    f["stamp"](self, { align = "left", size = p_______, text = p________5 }, th)
  end
  th:warp_exit()
end

proc_c2cedf9c_ba6a_4bbb_9f80_dbd01acb17f7 = function(th, self, p_HEX)
  -- 过程「函数_数_字符_9」 id=c2cedf9c-ba6a-4bbb-9f80-dbd01acb17f7
  th:warp_enter()
  f["script_variables"](self, __CONST[48], th)
  if V.js_boolean(f["logic_compare"](self, { A = f["text_select"](self, { start_index = 1, text = p_HEX }, th), B = "#", OP = "EQ" }, th)) then
    f["variables_set"](self, { value = f["temporary_list"](self, { ITEM0 = f["convert_type"](self, { text = f["text_join"](self, { ADD0 = "0x", ADD1 = f["text_select"](self, { end_index = 3, start_index = 2, text = p_HEX }, th) }, th), type = "number" }, th), ITEM1 = f["convert_type"](self, { text = f["text_join"](self, { ADD0 = "0x", ADD1 = f["text_select"](self, { end_index = 5, start_index = 4, text = p_HEX }, th) }, th), type = "number" }, th), ITEM2 = f["convert_type"](self, { text = f["text_join"](self, { ADD0 = "0x", ADD1 = f["text_select"](self, { end_index = 7, start_index = 6, text = p_HEX }, th) }, th), type = "number" }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"RGB\"}" }, th)
  else
    f["variables_set"](self, { value = f["temporary_list"](self, { ITEM0 = f["convert_type"](self, { text = f["text_join"](self, { ADD0 = "0x", ADD1 = f["text_select"](self, { end_index = 2, start_index = 1, text = p_HEX }, th) }, th), type = "number" }, th), ITEM1 = f["convert_type"](self, { text = f["text_join"](self, { ADD0 = "0x", ADD1 = f["text_select"](self, { end_index = 4, start_index = 3, text = p_HEX }, th) }, th), type = "number" }, th), ITEM2 = f["convert_type"](self, { text = f["text_join"](self, { ADD0 = "0x", ADD1 = f["text_select"](self, { end_index = 6, start_index = 5, text = p_HEX }, th) }, th), type = "number" }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"RGB\"}" }, th)
  end
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[49], th), list_index = 1 }, th), B = 255, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"R\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[49], th), list_index = 2 }, th), B = 255, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"G\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[49], th), list_index = 3 }, th), B = 255, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"B\"}" }, th)
  f["variables_set"](self, { value = (proc_b4c9c4d4_540e_4653_ad1c_cf0e4230216b(th, self, f["temporary_list"](self, { ITEM0 = f["script_variables_value"](self, __CONST[50], th), ITEM1 = f["script_variables_value"](self, __CONST[51], th), ITEM2 = f["script_variables_value"](self, __CONST[52], th) }, th), "最大", nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"max\"}" }, th)
  f["variables_set"](self, { value = (proc_b4c9c4d4_540e_4653_ad1c_cf0e4230216b(th, self, f["temporary_list"](self, { ITEM0 = f["script_variables_value"](self, __CONST[50], th), ITEM1 = f["script_variables_value"](self, __CONST[51], th), ITEM2 = f["script_variables_value"](self, __CONST[52], th) }, th), "最小", nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"min\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[53], th), B = f["script_variables_value"](self, __CONST[54], th), type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"delta\"}" }, th)
  if V.js_boolean(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[55], th), B = 0, OP = "EQ" }, th)) then
    f["variables_set"](self, __CONST[56], th)
  else
    if V.js_boolean(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[53], th), B = f["script_variables_value"](self, __CONST[50], th), OP = "EQ" }, th)) then
      f["variables_set"](self, { value = f["math_arithmetic"](self, { A = 60, B = f["math_modulo"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[51], th), B = f["script_variables_value"](self, __CONST[52], th), type = "minus" }, th), B = f["script_variables_value"](self, __CONST[55], th), type = "divide" }, th), B = 6 }, th), type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"h\"}" }, th)
    elseif V.js_boolean(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[53], th), B = f["script_variables_value"](self, __CONST[51], th), OP = "EQ" }, th)) then
      f["variables_set"](self, { value = f["math_arithmetic"](self, { A = 60, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[52], th), B = f["script_variables_value"](self, __CONST[50], th), type = "minus" }, th), B = f["script_variables_value"](self, __CONST[55], th), type = "divide" }, th), B = 2, type = "add" }, th), type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"h\"}" }, th)
    elseif V.js_boolean(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[53], th), B = f["script_variables_value"](self, __CONST[52], th), OP = "EQ" }, th)) then
      f["variables_set"](self, { value = f["math_arithmetic"](self, { A = 60, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[50], th), B = f["script_variables_value"](self, __CONST[51], th), type = "minus" }, th), B = f["script_variables_value"](self, __CONST[55], th), type = "divide" }, th), B = 4, type = "add" }, th), type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"h\"}" }, th)
    end
  end
  if V.js_boolean(f["math_number_property"](self, { num = f["script_variables_value"](self, __CONST[57], th), type = "NEGATIVE" }, th)) then
    f["change_variables"](self, __CONST[58], th)
  end
  if V.js_boolean(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[53], th), B = 0, OP = "EQ" }, th)) then
    f["variables_set"](self, __CONST[59], th)
  else
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[55], th), B = f["script_variables_value"](self, __CONST[53], th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"s\"}" }, th)
  end
  f["variables_set"](self, { value = f["script_variables_value"](self, __CONST[53], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"v\"}" }, th)
  th:warp_exit()
  return f["temporary_list"](self, { ITEM0 = f["script_variables_value"](self, __CONST[57], th), ITEM1 = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[60], th), B = 100, type = "multiply" }, th), ITEM2 = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[61], th), B = 100, type = "multiply" }, th) }, th)
end

proc_d4ce4407_8c3b_4eb0_ac29_17496bbfbaa5 = function(th, self, p_x, p_y, p_____________, p______________2)
  -- 过程「c609cfc8-4724-41e8-8a0c-14a860fe4f43」 id=d4ce4407-8c3b-4eb0-ac29-17496bbfbaa5
  f["script_variables"](self, __CONST[62], th)
  th:warp_enter()
  if V.js_boolean(f["logic_compare"](self, { A = p______________2, B = "段数", OP = "EQ" }, th)) then
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = 900, B = p_____________, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"dx\"}" }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = 562, B = p_____________, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"dy\"}" }, th)
    f["variables_set"](self, { value = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_x, B = -450, type = "minus" }, th), B = f["script_variables_value"](self, __CONST[5], th), type = "divide" }, th), type = "round" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ix\"}" }, th)
    f["variables_set"](self, { value = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_y, B = -281, type = "minus" }, th), B = f["script_variables_value"](self, __CONST[6], th), type = "divide" }, th), type = "round" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"iy\"}" }, th)
    f["variables_set"](self, { value = (proc_b4c9c4d4_540e_4653_ad1c_cf0e4230216b(th, self, f["temporary_list"](self, { ITEM0 = 0, ITEM1 = (proc_b4c9c4d4_540e_4653_ad1c_cf0e4230216b(th, self, f["temporary_list"](self, { ITEM0 = p_____________, ITEM1 = f["script_variables_value"](self, __CONST[63], th) }, th), "最小", nil)) }, th), "最大", nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ix\"}" }, th)
    f["variables_set"](self, { value = (proc_b4c9c4d4_540e_4653_ad1c_cf0e4230216b(th, self, f["temporary_list"](self, { ITEM0 = 0, ITEM1 = (proc_b4c9c4d4_540e_4653_ad1c_cf0e4230216b(th, self, f["temporary_list"](self, { ITEM0 = p_____________, ITEM1 = f["script_variables_value"](self, __CONST[64], th) }, th), "最小", nil)) }, th), "最大", nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"iy\"}" }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = -450, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[63], th), B = f["script_variables_value"](self, __CONST[5], th), type = "multiply" }, th), type = "add" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"nearest_x\"}" }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = -281, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[64], th), B = f["script_variables_value"](self, __CONST[6], th), type = "multiply" }, th), type = "add" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"nearest_y\"}" }, th)
    th:warp_exit()
    return f["temporary_list"](self, { ITEM0 = f["script_variables_value"](self, __CONST[65], th), ITEM1 = f["script_variables_value"](self, __CONST[66], th) }, th)
  else
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = 900, B = f["math_arithmetic"](self, { A = p_____________, B = 1, type = "minus" }, th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"dx\"}" }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = 562, B = f["math_arithmetic"](self, { A = p_____________, B = 1, type = "minus" }, th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"dy\"}" }, th)
    f["variables_set"](self, { value = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_x, B = -450, type = "minus" }, th), B = f["script_variables_value"](self, __CONST[5], th), type = "divide" }, th), type = "round" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ix\"}" }, th)
    f["variables_set"](self, { value = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_y, B = -281, type = "minus" }, th), B = f["script_variables_value"](self, __CONST[6], th), type = "divide" }, th), type = "round" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"iy\"}" }, th)
    f["variables_set"](self, { value = (proc_b4c9c4d4_540e_4653_ad1c_cf0e4230216b(th, self, f["temporary_list"](self, { ITEM0 = 0, ITEM1 = (proc_b4c9c4d4_540e_4653_ad1c_cf0e4230216b(th, self, f["temporary_list"](self, { ITEM0 = f["math_arithmetic"](self, { A = p_____________, B = 1, type = "minus" }, th), ITEM1 = f["script_variables_value"](self, __CONST[63], th) }, th), "最小", nil)) }, th), "最大", nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ix\"}" }, th)
    f["variables_set"](self, { value = (proc_b4c9c4d4_540e_4653_ad1c_cf0e4230216b(th, self, f["temporary_list"](self, { ITEM0 = 0, ITEM1 = (proc_b4c9c4d4_540e_4653_ad1c_cf0e4230216b(th, self, f["temporary_list"](self, { ITEM0 = f["math_arithmetic"](self, { A = p_____________, B = 1, type = "minus" }, th), ITEM1 = f["script_variables_value"](self, __CONST[64], th) }, th), "最小", nil)) }, th), "最大", nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"iy\"}" }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = -450, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[63], th), B = f["script_variables_value"](self, __CONST[5], th), type = "multiply" }, th), type = "add" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"nearest_x\"}" }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = -281, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[64], th), B = f["script_variables_value"](self, __CONST[6], th), type = "multiply" }, th), type = "add" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"nearest_y\"}" }, th)
    th:warp_exit()
    return f["temporary_list"](self, { ITEM0 = f["script_variables_value"](self, __CONST[65], th), ITEM1 = f["script_variables_value"](self, __CONST[66], th) }, th)
  end
  th:warp_exit()
end

proc_dd777c17_75ed_40e6_a99a_85b70c064f6f = function(th, self, p_x, p_y, p____, p_____2, p_res, p_hex, p_____3, p_hex2, p_px)
  -- 过程「函数_12」 id=dd777c17-75ed-40e6-a99a-85b70c064f6f
  f["script_variables"](self, __CONST[7], th)
  th:warp_enter()
  proc_1304ad1c_c306_4bf4_aa73_65d80b88312e(th, self, p_x, p_y, p____, p_____2, p_res, p_hex, 0, 0, nil)
  if V.js_boolean(p_____3) then
    proc_1304ad1c_c306_4bf4_aa73_65d80b88312e(th, self, p_x, f["math_arithmetic"](self, { A = p_y, B = p_px, type = "add" }, th), p____, p_____2, p_res, p_hex2, 0, 0, nil)
  end
  th:warp_exit()
  return f["temporary_list"](self, { ITEM0 = p_x, ITEM1 = p_y, ITEM2 = p____, ITEM3 = f["math_arithmetic"](self, { A = p_____2, B = p_px, type = "add" }, th), ITEM4 = p_res }, th)
end

proc_e7b92cdb_611a_4629_9224_faacd3641488 = function(th, self, p_x, p_y, p____, p_____2, p_______, p________________, p________2)
  -- 过程「f5795247-ebf2-455c-92b5-f86b11168d8c」 id=e7b92cdb-611a-4629-9224-faacd3641488
  th:warp_enter()
  if V.js_boolean(p________________) then
    f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = p_x, B = f["math_arithmetic"](self, { A = p____, B = 2, type = "divide" }, th), type = "add" }, th), y = f["math_arithmetic"](self, { A = p_y, B = f["math_arithmetic"](self, { A = p_____2, B = 2, type = "divide" }, th), type = "minus" }, th) }, th)
  else
    f["self_move_to"](self, { x = p_x, y = p_y }, th)
  end
  f["set_width_height_scale"](self, { type = "width", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p____, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_______, B = 2, type = "multiply" }, th), B = 3.125, type = "divide" }, th), B = 2, type = "multiply" }, th), type = "add" }, th), B = p________2, type = "divide" }, th) }, th)
  f["set_width_height_scale"](self, { type = "height", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_____2, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_______, B = 2, type = "multiply" }, th), B = 3.125, type = "divide" }, th), B = 2, type = "multiply" }, th), type = "add" }, th), B = p________2, type = "divide" }, th) }, th)
  f["image_stamp"](self, {}, th)
  th:warp_exit()
end

proc_e7ce6425_2057_4902_960e_1bd6ed09a102 = function(th, self, p__________, p_______)
  -- 过程「函数_数_字符_5」 id=e7ce6425-2057-4902-960e-1bd6ed09a102
  th:warp_enter()
  f["script_variables"](self, __CONST[1], th)
  f["variables_set"](self, __CONST[44], th)
  do
    local _from_n1, _to_n1 = tonumber(1), tonumber(f["text_length"](self, { text = p__________ }, th))
    if _from_n1 ~= _from_n1 or _to_n1 ~= _to_n1 then
      -- NaN from/to: official warning; no iterations
    else
      if _from_n1 <= _to_n1 then _from_n1 = math.ceil(_from_n1); if _from_n1 > _to_n1 then _from_n1 = _to_n1 + 1 end
      else _from_n1 = math.floor(_from_n1); if _from_n1 < _to_n1 then _from_n1 = _to_n1 - 1 end end
      local _by_n1 = 1
      if _by_n1 == nil then _by_n1 = 1 end
      _by_n1 = tonumber(_by_n1)
      if _by_n1 == nil or _by_n1 ~= _by_n1 or _by_n1 <= 0 then _by_n1 = 0 else _by_n1 = math.abs(math.floor(_by_n1 + 0.5)) end
      if _by_n1 > 0 then
        local _p_n1 = _from_n1
        while (_from_n1 <= _to_n1 and _p_n1 <= _to_n1) or (_from_n1 > _to_n1 and _p_n1 >= _to_n1) do
          local _i_n1 = _p_n1
          th:push_param(_p_n1)
        if V.js_boolean(f["logic_negate"](self, { logic = f["text_contain"](self, { A = p_______, B = f["text_select"](self, { start_index = _p_n1, text = p__________ }, th) }, th) }, th)) then
          f["variables_set"](self, { value = f["text_join"](self, { ADD0 = f["script_variables_value"](self, __CONST[3], th), ADD1 = f["text_select"](self, { start_index = _p_n1, text = p__________ }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        end
          th:pop_param()
          _p_n1 = _p_n1 + _by_n1
          if th:iter_w() then break end
        end
      end
    end
  end
  th:warp_exit()
  return f["script_variables_value"](self, __CONST[3], th)
end

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 900, 562
M.timer_pos = { x = 720, y = 12 }
M.proc_trampoline = false
M.uses_timer = false
M.timer_hidden_default = false
M.vars = {  }
M.screens = { { id = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a", name = "背景", screenName = "屏幕", style_index = 1, styles = { "7214235c-73b5-4218-99ac-43e21097e686" }, visible = true } }
M.cur_scene = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a"
M.actors = { { id = "944ed5e5-3f15-4e80-ad24-9cee4d0c8ed4", is_global = true, name = "At", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "ad5aedbc-e73b-4d60-9150-367c442e8b41" }, visible = true, x = 0, y = 0 }, { id = "1ac1b7dc-a0d6-4e21-8437-0560dbc5cb31", is_global = true, name = "介绍", order = 2, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "c9de8089-21b8-4e2f-96f4-fa774598550e" }, visible = true, x = 0, y = 0 }, { id = "b99c613d-a302-477a-9e5f-93f4e1922220", is_global = true, name = "介绍2", order = 3, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "65bcd5b6-0c2c-40ea-87b2-002672ed9fd1" }, visible = true, x = 0, y = 0 }, { id = "ce7201cd-1ee8-438e-bafd-92613a6f132a", is_global = true, name = "介绍3", order = 4, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "05580112-eeca-44c6-9fb2-81d031919549" }, visible = true, x = 0, y = 0 }, { id = "56ee5773-b9f6-4826-8319-1b9898a43bbe", is_global = true, name = "shadow", order = 5, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "3e73274e-27a4-4671-86dc-f0a3fdda61bc", "bf415a80-acf1-469f-8789-68a4640d2c16", "ed4945bd-b1b7-4f2c-8535-c6775f5b03a6", "788dcf13-4b71-4d1a-8897-e03dc3ca79eb", "142bcb9a-5035-44e7-8b3f-d8a776cf5ba5", "19d8cee4-575a-4f3e-b7df-c48b0abfe40e" }, visible = false, x = 0, y = 0 } }
M.assets_dir = "works"
M.assets = { ["05580112-eeca-44c6-9fb2-81d031919549"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/05580112-eeca-44c6-9fb2-81d031919549.png", id = "05580112-eeca-44c6-9fb2-81d031919549", name = "介绍3", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["142bcb9a-5035-44e7-8b3f-d8a776cf5ba5"] = { adaption = nil, center = nil, file = "assets/142bcb9a-5035-44e7-8b3f-d8a776cf5ba5.png", id = "142bcb9a-5035-44e7-8b3f-d8a776cf5ba5", name = "默认-浮雕-白色", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzMxMjc3NTI5OF8xNzc3NjIyNDAwMDAwX0ZwWTJrVFBGUHdUa1FYVUg2bVlaZ3ktZEZxUXg=.png" }, ["19d8cee4-575a-4f3e-b7df-c48b0abfe40e"] = { adaption = nil, center = nil, file = "assets/19d8cee4-575a-4f3e-b7df-c48b0abfe40e.png", id = "19d8cee4-575a-4f3e-b7df-c48b0abfe40e", name = "浮雕-白色", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzMxMjc3NTI5OF8xNzc3NjIyNDAwMDAwX0ZqY2Ezbk1vbGFtcVRlbU1STzBzV3ZBLVpEalk=.png" }, ["3e73274e-27a4-4671-86dc-f0a3fdda61bc"] = { adaption = nil, center = nil, file = "assets/3e73274e-27a4-4671-86dc-f0a3fdda61bc.png", id = "3e73274e-27a4-4671-86dc-f0a3fdda61bc", name = "矩形 1 (3)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzMxMjc3NTI5OF8xNzc3NjE4ODAwMDAwX0ZsYUotbEVUaENHOW9oM1c1TldENmpIdlhBdDg=.png" }, ["65bcd5b6-0c2c-40ea-87b2-002672ed9fd1"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/65bcd5b6-0c2c-40ea-87b2-002672ed9fd1.png", id = "65bcd5b6-0c2c-40ea-87b2-002672ed9fd1", name = "介绍1", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["7214235c-73b5-4218-99ac-43e21097e686"] = { adaption = nil, center = nil, file = "assets/7214235c-73b5-4218-99ac-43e21097e686.png", id = "7214235c-73b5-4218-99ac-43e21097e686", name = "背景", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/img_stage_defult_landscape.png" }, ["788dcf13-4b71-4d1a-8897-e03dc3ca79eb"] = { adaption = nil, center = nil, file = "assets/788dcf13-4b71-4d1a-8897-e03dc3ca79eb.png", id = "788dcf13-4b71-4d1a-8897-e03dc3ca79eb", name = "默认-白色", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzMxMjc3NTI5OF8xNzc3NjIyNDAwMDAwX0ZtMzNLMGlGNmdXUl90ZmdnY2l4elo1SzVqOFc=.png" }, ["ad5aedbc-e73b-4d60-9150-367c442e8b41"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/ad5aedbc-e73b-4d60-9150-367c442e8b41.png", id = "ad5aedbc-e73b-4d60-9150-367c442e8b41", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["bf415a80-acf1-469f-8789-68a4640d2c16"] = { adaption = nil, center = nil, file = "assets/bf415a80-acf1-469f-8789-68a4640d2c16.png", id = "bf415a80-acf1-469f-8789-68a4640d2c16", name = "默认-浮雕", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzMxMjc3NTI5OF8xNzc3NjIyNDAwMDAwX0ZtdzdOaElmWHNyNTJrZFpFM2ozTU5RUW1EZ24=.png" }, ["c9de8089-21b8-4e2f-96f4-fa774598550e"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/c9de8089-21b8-4e2f-96f4-fa774598550e.png", id = "c9de8089-21b8-4e2f-96f4-fa774598550e", name = "At1", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["ed4945bd-b1b7-4f2c-8535-c6775f5b03a6"] = { adaption = nil, center = nil, file = "assets/ed4945bd-b1b7-4f2c-8535-c6775f5b03a6.png", id = "ed4945bd-b1b7-4f2c-8535-c6775f5b03a6", name = "浮雕", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzMxMjc3NTI5OF8xNzc3NjIyNDAwMDAwX0ZtemtXcEREUFlCVUhGcUxiTGdKbTlNdzVqbC0=.png" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_700824a5_44a8_4d03_a7e8_aa95d87e9b2a = ents["700824a5-44a8-4d03-a7e8-aa95d87e9b2a"]
  local e_944ed5e5_3f15_4e80_ad24_9cee4d0c8ed4 = ents["944ed5e5-3f15-4e80-ad24-9cee4d0c8ed4"]
  local e_1ac1b7dc_a0d6_4e21_8437_0560dbc5cb31 = ents["1ac1b7dc-a0d6-4e21-8437-0560dbc5cb31"]
  local e_b99c613d_a302_477a_9e5f_93f4e1922220 = ents["b99c613d-a302-477a-9e5f-93f4e1922220"]
  local e_ce7201cd_1ee8_438e_bafd_92613a6f132a = ents["ce7201cd-1ee8-438e-bafd-92613a6f132a"]
  local e_56ee5773_b9f6_4826_8319_1b9898a43bbe = ents["56ee5773-b9f6-4826-8319-1b9898a43bbe"]
  -- -------- 角色 介绍 --------
  rt.on(e_1ac1b7dc_a0d6_4e21_8437_0560dbc5cb31, "on_running_group_activated", {}, function(th, self)
      do
        local _times_n1 = 2
        while true do
          if _times_n1 <= 0 then break end
          _times_n1 = _times_n1 - 1
          f["mirror"](self, __CONST[67], th)
          if th:iter_n() then break end
        end
      end
  end)
  rt.on(e_1ac1b7dc_a0d6_4e21_8437_0560dbc5cb31, "start_as_a_mirror", {}, function(th, self)
      if V.js_boolean(f["logic_compare"](self, { A = f["get_current_clone_index"](self, {}, th), B = 1, OP = "EQ" }, th)) then
        proc_6054fd4e_0b79_4b87_b646_ade358c94405(th, self, -300, 100, 0, 100, 0, 200, 0, f["text_join"](self, __CONST[68], th), nil)
      elseif V.js_boolean(f["logic_compare"](self, { A = f["get_current_clone_index"](self, {}, th), B = 2, OP = "EQ" }, th)) then
        proc_84ce8f31_c970_4a48_b1c5_3b7d57c8efb8(th, self, -300, 0, 0, 100, 0, 0, 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)
      end
  end)
  -- -------- 角色 介绍2 --------
  rt.on(e_b99c613d_a302_477a_9e5f_93f4e1922220, "on_running_group_activated", {}, function(th, self)
      f["script_variables"](self, __CONST[69], th)
      f["variables_set"](self, { value = f["temporary_list"](self, { ITEM0 = (proc_dd777c17_75ed_40e6_a99a_85b70c064f6f(th, self, 100, 100, 200, 50, 0, "A7DCFF", true, 333333, 5, nil, nil)), ITEM1 = (proc_dd777c17_75ed_40e6_a99a_85b70c064f6f(th, self, -300, -100, 200, 50, 20, "A7DCFF", true, 333333, 5, nil, nil)), ITEM2 = (proc_dd777c17_75ed_40e6_a99a_85b70c064f6f(th, self, -300, -200, 200, 50, 20, "A7DCFF", true, 333333, 5, nil, nil)) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"btn\"}" }, th)
      f["tell"](self, { sprite = "56ee5773-b9f6-4826-8319-1b9898a43bbe", DO = function(t2, s2)
          f["set_sprite_style"](s2, { style_id = f["convert_type"](s2, __CONST[70], t2) }, t2)
          proc_e7b92cdb_611a_4629_9224_faacd3641488(t2, s2, 100, 105, 200, 55, 0, true, 1)
      end }, th)
      while true do
        if V.js_boolean((proc_56fedea0_cbd2_457f_85f3_70006da0bd1f(th, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[71], th), list_index = 2 }, th), "触摸", nil, nil, nil, nil, nil))) then
          f["self_dialog_wait"](self, __CONST[72], th)
        elseif V.js_boolean((proc_56fedea0_cbd2_457f_85f3_70006da0bd1f(th, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[71], th), list_index = 3 }, th), "点击", nil, nil, nil, nil, nil))) then
          f["self_dialog_wait"](self, __CONST[73], th)
        else
          f["close_self_dialog"](self, {}, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 介绍3 --------
  rt.on(e_ce7201cd_1ee8_438e_bafd_92613a6f132a, "on_running_group_activated", {}, function(th, self)
      proc_bd70fea2_0318_4866_9940_0ebaf6fa4db8(th, self, 100, 0, 24, 0, "单选", "选中", "A7DCFF", "你好", 111111, nil, nil)
      proc_bd70fea2_0318_4866_9940_0ebaf6fa4db8(th, self, 100, -25, 24, 0, "单选", "没选中", "A7DCFF", "你好", 111111, nil, nil)
      proc_bd70fea2_0318_4866_9940_0ebaf6fa4db8(th, self, 100, -50, 24, 0, "多选", "选中", "A7DCFF", "你好", 111111, nil, nil)
      proc_bd70fea2_0318_4866_9940_0ebaf6fa4db8(th, self, 100, -75, 24, 0, "多选", "没选中", "A7DCFF", "你好", 111111, nil, nil)
      proc_3f7b206b_81f6_4791_8ed4_51071d2ac194(th, self, 100, -100, 200, 1, "A7DCFF", f["random_num"](self, __CONST[74], th), nil)
      while true do
        proc_4e5fa736_0363_4a5c_9f5e_d3d00a0a33b5(th, self, 100, -150, 50, "A7DCFF", "FFFFFF", f["math_arithmetic"](self, { A = (proc_13e4ca8c_303a_4d4f_a0cb_be771ef56322(th, self, 100, -150, f["get_mouse_info"](self, __CONST[19], th), f["get_mouse_info"](self, __CONST[20], th), nil, nil)), B = 90, type = "add" }, th), nil, nil, nil)
        while not V.js_boolean((proc_56fedea0_cbd2_457f_85f3_70006da0bd1f(th, self, f["temporary_list"](self, __CONST[75], th), "点击", nil, nil, nil, nil, nil))) do
          if th:iter_n() then break end
        end
        if th:iter_n() then break end
      end
  end)
end

M.requires = {
  "appearance_of_sprite",
  "change_variables",
  "close_self_dialog",
  "convert_type",
  "delete_list_item",
  "get_current_clone_index",
  "get_mouse_info",
  "image_stamp",
  "list_append",
  "list_item",
  "list_length",
  "logic_compare",
  "logic_negate",
  "logic_operation",
  "math_arithmetic",
  "math_function",
  "math_modulo",
  "math_number_property",
  "math_round",
  "math_trig",
  "mirror",
  "mouse_down",
  "random_num",
  "script_variables",
  "script_variables_value",
  "self_change_coordinate_x",
  "self_change_pen_color_property",
  "self_change_pen_size",
  "self_dialog_wait",
  "self_go_forward",
  "self_move_to",
  "self_pen_down",
  "self_pen_up",
  "self_point_towards",
  "self_set_pen_color_property",
  "self_set_pen_size",
  "set_sprite_style",
  "set_width_height_scale",
  "stamp",
  "temporary_list",
  "text_contain",
  "text_join",
  "text_length",
  "text_select",
  "text_split",
  "variables_set",
}
return M

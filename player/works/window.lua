-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：现代化窗口   version=0.27.3
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（条件槽用 V.js_boolean，字段解析用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用
local __CONST = {
  { type = "width" },
  { type = "height" },
  { PARAMS0 = nil, PARAMS1 = nil, name = "a", names = { "a", "b" } },
  { sprite = "--self", type = "down" },
  { variable = "bc5c381d-0e29-47ab-85e3-e6a4d4c23a0a" },
  { TEXT = "a" },
  { variable = "97812897-dd76-4fc8-94fa-8fe0a8243deb" },
  { TEXT = "b" },
  { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, PARAMS3 = nil, PARAMS4 = nil, name = "x", names = { "x", "y", "w", "h", "deg" } },
  { TEXT = "x" },
  { TEXT = "y" },
  { TEXT = "w" },
  { TEXT = "h" },
  { TEXT = "deg" },
  { coordinate = "x", sprite = "--self" },
  { coordinate = "y", sprite = "--self" },
  { appearance = "width", sprite = "--self" },
  { appearance = "height", sprite = "--self" },
  { sprite = "e8df6c52-aa79-4aab-8b7e-e8a6e98b7769", type = "down" },
  { appearance = "direction", sprite = "--self" },
  { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, PARAMS3 = nil, name = "w", names = { "w", "h", "deg", "rgb" } },
  { TEXT = "rgb" },
  { variable = "755982d6-e5f1-4f4a-966e-eb427b32d1d7" },
  { effect = "0", sprite = "--self" },
  { A = 1, B = 900 },
  { A = 1, B = 562 },
  { coordinate = "x", sprite = "2c6a7055-683c-4463-b0da-7863cb522653" },
  { coordinate = "y", sprite = "2c6a7055-683c-4463-b0da-7863cb522653" },
  { text = "拖动我改变窗口大小！", time = 2, type = "talk" },
  { coordinate = "x", sprite = "e8df6c52-aa79-4aab-8b7e-e8a6e98b7769" },
  { coordinate = "y", sprite = "e8df6c52-aa79-4aab-8b7e-e8a6e98b7769" },
  { item = "any", list = "e250fc39-8f2e-41e3-998b-f2aed40c9c43", list_index = 1 },
  { item = "any", list = "e250fc39-8f2e-41e3-998b-f2aed40c9c43", list_index = 2 },
  { text = "宽,高" },
  { key = "68", type = "down" },
  { key = "83", type = "down" },
  { key = "87", type = "down" },
  { increase = "increase", value = 5 },
  { increase = "decrease", value = 5 },
  { key = "65", type = "down" },
  { variable = "0da54715-1db8-4309-b57c-05182da3dd1e" },
  { variable = "dcd8aee8-bec4-423f-b984-2c255d957b5f" },
  { sprite = "--mouse" },
}

-- ===== 自定义积木（过程）=====
local proc_15d2a5a2_1d80_4f74_a493_12c87527410b, proc_4f983c44_2db5_40bb_9dda_7f3e9f8044b3, proc_8b717067_8750_43db_92d5_aaf03abb2b0c, proc_9a0ed070_0472_4184_816d_8e01aaf9e3b0, proc_b26f9346_15fc_4c28_a991_8ea8624e5eb1, proc_c92bbc0c_358e_4782_9ba8_a26a75bc1ee1, proc_cf9e399e_169f_46ea_97d8_43b6dfca1ef7, proc_e15ecf63_939a_4ae8_9821_624616b7a854, proc_e8f90ea5_0f9b_4410_9138_6a94574a930e

proc_15d2a5a2_1d80_4f74_a493_12c87527410b = function(th, self, p_a, p_b)
  -- 过程「db801375-43ca-4c3e-81c3-398a3e6afca0」 id=15d2a5a2-1d80-4f74-a493-12c87527410b
  return (proc_e8f90ea5_0f9b_4410_9138_6a94574a930e(th, self, f["logic_compare"](self, { A = p_a, B = p_b, OP = "GT" }, th), p_a, p_b))
end

proc_4f983c44_2db5_40bb_9dda_7f3e9f8044b3 = function(th, self, p_a, p_b)
  -- 过程「db801375-43ca-4c3e-81c3-398a3e6afca0」 id=4f983c44-2db5-40bb-9dda-7f3e9f8044b3
  return (proc_e8f90ea5_0f9b_4410_9138_6a94574a930e(th, self, f["logic_compare"](self, { A = p_a, B = p_b, OP = "LT" }, th), p_a, p_b))
end

proc_8b717067_8750_43db_92d5_aaf03abb2b0c = function(th, self, p_______, p________2)
  -- 过程「6dd4354f-ab67-4472-aa2b-0d38678763c1」 id=8b717067-8750-43db-92d5-aaf03abb2b0c
  if V.js_boolean(f["logic_compare"](self, { A = p_______, B = "宽", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p________2, B = f["get_stage_info"](self, __CONST[1], th), type = "divide" }, th)
  else
    return f["math_arithmetic"](self, { A = p________2, B = f["get_stage_info"](self, __CONST[2], th), type = "divide" }, th)
  end
end

proc_9a0ed070_0472_4184_816d_8e01aaf9e3b0 = function(th, self, p____, p_____2)
  -- 过程「函数_1」 id=9a0ed070-0472-4184-816d-8e01aaf9e3b0
  f["replace_list_item"](self, { item = "any", list = "e250fc39-8f2e-41e3-998b-f2aed40c9c43", list_index = 1, list_item_value = p____ }, th)
  f["replace_list_item"](self, { item = "any", list = "e250fc39-8f2e-41e3-998b-f2aed40c9c43", list_index = 2, list_item_value = p_____2 }, th)
end

proc_b26f9346_15fc_4c28_a991_8ea8624e5eb1 = function(th, self, p_xy, p_xy_2, p_______)
  -- 过程「e696c17b-2415-4f49-912f-d8459a2b155c」 id=b26f9346-15fc-4c28-a991-8ea8624e5eb1
  if V.js_boolean(f["logic_compare"](self, { A = p_xy, B = "x", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_xy_2, B = f["math_arithmetic"](self, { A = p_______, B = f["get_stage_info"](self, __CONST[1], th), type = "divide" }, th), type = "multiply" }, th)
  else
    return f["math_arithmetic"](self, { A = p_xy_2, B = f["math_arithmetic"](self, { A = p_______, B = f["get_stage_info"](self, __CONST[2], th), type = "divide" }, th), type = "multiply" }, th)
  end
end

proc_c92bbc0c_358e_4782_9ba8_a26a75bc1ee1 = function(th, self, p_x______, p_y______, p______________________, p__________x______, p__________y______, p__________x_______2, p__________y_______2)
  -- 过程「函数_9」 id=c92bbc0c-358e-4782-9ba8-a26a75bc1ee1
  f["script_variables"](self, __CONST[3], th)
  while true do
    f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[5], th), B = f["script_variables_value"](self, __CONST[6], th), type = "minus" }, th), B = p_x______, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
    f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[7], th), B = f["script_variables_value"](self, __CONST[8], th), type = "minus" }, th), B = p_y______, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"b\"}" }, th)
    f["self_change_coordinate_x"](self, { increase = "increase", value = f["script_variables_value"](self, __CONST[6], th) }, th)
    f["self_change_coordinate_y"](self, { increase = "increase", value = f["script_variables_value"](self, __CONST[8], th) }, th)
    if V.js_boolean(f["logic_negate"](self, { logic = f["mouse_down"](self, __CONST[4], th) }, th)) then break end
    if th:iter_d() then break end
  end
  f["variables_set"](self, { value = f["variables_get"](self, __CONST[5], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
  f["variables_set"](self, { value = f["variables_get"](self, __CONST[7], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"b\"}" }, th)
  do
    local _times_n1 = p______________________
    while true do
      if _times_n1 <= 0 then break end
      _times_n1 = _times_n1 - 1
      f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[6], th), B = p__________x______, type = "divide" }, th), B = f["script_variables_value"](self, __CONST[6], th), type = "minus" }, th), B = p__________x_______2, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
      f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[8], th), B = p__________y______, type = "divide" }, th), B = f["script_variables_value"](self, __CONST[8], th), type = "minus" }, th), B = p__________y_______2, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"b\"}" }, th)
      f["self_change_coordinate_x"](self, { increase = "increase", value = f["script_variables_value"](self, __CONST[6], th) }, th)
      f["self_change_coordinate_y"](self, { increase = "increase", value = f["script_variables_value"](self, __CONST[8], th) }, th)
      if V.js_boolean(f["mouse_down"](self, __CONST[4], th)) then
        break
      end
      if th:iter_d() then break end
    end
  end
end

proc_cf9e399e_169f_46ea_97d8_43b6dfca1ef7 = function(th, self, p_______)
  -- 过程「函数_7」 id=cf9e399e-169f-46ea-97d8-43b6dfca1ef7
  while not V.js_boolean(f["logic_compare"](self, { A = f["list_length"](self, { list = p_______ }, th), B = 18, OP = "EQ" }, th)) do
    if th:iter_n() then break end
  end
  f["script_variables"](self, __CONST[9], th)
  while true do
    th:warp_enter()
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[10], th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 14 }, th), type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"x\"}" }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[11], th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 15 }, th), type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"y\"}" }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[12], th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 16 }, th), type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"w\"}" }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[13], th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 17 }, th), type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"h\"}" }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[14], th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 18 }, th), type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"deg\"}" }, th)
    f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_______, list_index = 5 }, th), B = (proc_b26f9346_15fc_4c28_a991_8ea8624e5eb1(th, self, "x", f["list_item"](self, { item = "any", list = p_______, list_index = 1 }, th), f["list_item"](self, { item = "any", list = p_______, list_index = 7 }, th))), type = "add" }, th), B = f["coordinate_of_sprite"](self, __CONST[15], th), type = "minus" }, th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 9 }, th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"x\"}" }, th)
    f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_______, list_index = 6 }, th), B = (proc_b26f9346_15fc_4c28_a991_8ea8624e5eb1(th, self, "y", f["list_item"](self, { item = "any", list = p_______, list_index = 2 }, th), f["list_item"](self, { item = "any", list = p_______, list_index = 8 }, th))), type = "add" }, th), B = f["coordinate_of_sprite"](self, __CONST[16], th), type = "minus" }, th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 10 }, th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"y\"}" }, th)
    f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_______, list_index = 3 }, th), B = (proc_8b717067_8750_43db_92d5_aaf03abb2b0c(th, self, "宽", f["list_item"](self, { item = "any", list = p_______, list_index = 7 }, th))), type = "multiply" }, th), B = f["appearance_of_sprite"](self, __CONST[17], th), type = "minus" }, th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 11 }, th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"w\"}" }, th)
    f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_______, list_index = 4 }, th), B = (proc_8b717067_8750_43db_92d5_aaf03abb2b0c(th, self, "高", f["list_item"](self, { item = "any", list = p_______, list_index = 8 }, th))), type = "multiply" }, th), B = f["appearance_of_sprite"](self, __CONST[18], th), type = "minus" }, th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 12 }, th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"h\"}" }, th)
    f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = (proc_e8f90ea5_0f9b_4410_9138_6a94574a930e(th, self, f["mouse_down"](self, __CONST[19], th), f["math_function"](self, { num = f["variables_get"](self, __CONST[5], th), type = "2" }, th), 0)), B = f["appearance_of_sprite"](self, __CONST[20], th), type = "minus" }, th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 13 }, th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"deg\"}" }, th)
    f["add_width_height_scale"](self, { increase = "increase", type = "width", value = f["script_variables_value"](self, __CONST[12], th) }, th)
    f["add_width_height_scale"](self, { increase = "increase", type = "height", value = f["script_variables_value"](self, __CONST[13], th) }, th)
    f["self_change_coordinate_x"](self, { increase = "increase", value = f["script_variables_value"](self, __CONST[10], th) }, th)
    f["self_change_coordinate_y"](self, { increase = "increase", value = f["script_variables_value"](self, __CONST[11], th) }, th)
    f["self_rotate"](self, { degrees = f["script_variables_value"](self, __CONST[14], th) }, th)
    th:warp_exit()
    if th:iter_d() then break end
  end
end

proc_e15ecf63_939a_4ae8_9821_624616b7a854 = function(th, self, p_______)
  -- 过程「函数_8」 id=e15ecf63-939a-4ae8-9821-624616b7a854
  while not V.js_boolean(f["logic_compare"](self, { A = f["list_length"](self, { list = p_______ }, th), B = 14, OP = "EQ" }, th)) do
    if th:iter_n() then break end
  end
  f["script_variables"](self, __CONST[21], th)
  while true do
    th:warp_enter()
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[12], th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 11 }, th), type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"w\"}" }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[13], th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 12 }, th), type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"h\"}" }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[14], th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 13 }, th), type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"deg\"}" }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[22], th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 14 }, th), type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"rgb\"}" }, th)
    f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_______, list_index = 1 }, th), B = (proc_e8f90ea5_0f9b_4410_9138_6a94574a930e(th, self, f["mouse_down"](self, __CONST[4], th), f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[23], th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 3 }, th), type = "add" }, th), 0)), type = "add" }, th), B = f["appearance_of_sprite"](self, __CONST[17], th), type = "minus" }, th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 7 }, th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"w\"}" }, th)
    f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_______, list_index = 2 }, th), B = (proc_e8f90ea5_0f9b_4410_9138_6a94574a930e(th, self, f["mouse_down"](self, __CONST[4], th), f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[7], th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 4 }, th), type = "add" }, th), 0)), type = "add" }, th), B = f["appearance_of_sprite"](self, __CONST[18], th), type = "minus" }, th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 8 }, th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"h\"}" }, th)
    f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = (proc_e8f90ea5_0f9b_4410_9138_6a94574a930e(th, self, f["mouse_down"](self, __CONST[4], th), (proc_4f983c44_2db5_40bb_9dda_7f3e9f8044b3(th, self, f["math_function"](self, { num = f["variables_get"](self, __CONST[5], th), type = "2" }, th), f["list_item"](self, { item = "any", list = p_______, list_index = 5 }, th))), 0)), B = f["appearance_of_sprite"](self, __CONST[20], th), type = "minus" }, th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 9 }, th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"deg\"}" }, th)
    f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = (proc_e8f90ea5_0f9b_4410_9138_6a94574a930e(th, self, f["mouse_down"](self, __CONST[4], th), (proc_4f983c44_2db5_40bb_9dda_7f3e9f8044b3(th, self, f["math_function"](self, { num = f["variables_get"](self, __CONST[5], th), type = "1" }, th), f["list_item"](self, { item = "any", list = p_______, list_index = 6 }, th))), 0)), B = f["effect_of_sprite"](self, __CONST[24], th), type = "minus" }, th), B = f["list_item"](self, { item = "any", list = p_______, list_index = 10 }, th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"rgb\"}" }, th)
    f["add_width_height_scale"](self, { increase = "increase", type = "width", value = f["script_variables_value"](self, __CONST[12], th) }, th)
    f["add_width_height_scale"](self, { increase = "increase", type = "height", value = f["script_variables_value"](self, __CONST[13], th) }, th)
    f["self_rotate"](self, { degrees = f["script_variables_value"](self, __CONST[14], th) }, th)
    f["self_change_effect"](self, { increase = "increase", scope = "0", value = f["script_variables_value"](self, __CONST[22], th) }, th)
    th:warp_exit()
    if th:iter_d() then break end
  end
end

proc_e8f90ea5_0f9b_4410_9138_6a94574a930e = function(th, self, p_______, p________2, p________3)
  -- 过程「85aa8db2-67cb-440a-b8e8-fec01de5947e」 id=e8f90ea5-0f9b-4410-9138-6a94574a930e
  if V.js_boolean(p_______) then
    return p________2
  else
    return p________3
  end
end

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 900, 562
M.timer_pos = { x = 720, y = 12 }
M.proc_trampoline = false
M.uses_timer = false
M.timer_hidden_default = false
M.vars = { { current_entity_id = "025dd83c-de62-46a3-86bb-2ab6333e16c2", cv_id = "", entity_name = "编程猫", id = "0611e88a-fb0d-4bb5-a72d-208a1e5818c7", is_global = false, name = "角色", order = 7, position = { x = 20, y = 490 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "0da54715-1db8-4309-b57c-05182da3dd1e", is_global = true, name = "鼠标上一帧x坐标", order = 1, position = { x = 20, y = 87 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "755982d6-e5f1-4f4a-966e-eb427b32d1d7", is_global = true, name = "鼠标速度", order = 5, position = { x = 20, y = 356 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "a9a78278-345a-44a4-86ea-34d4f4476e49", cv_id = "", entity_name = "字", id = "8d8c0869-6ecb-4c3b-a207-87fa0cd9a62c", is_global = false, name = "角色", order = 8, position = { x = 220, y = 20 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "97812897-dd76-4fc8-94fa-8fe0a8243deb", is_global = true, name = "鼠标y速度", order = 4, position = { x = 20, y = 288 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "bc5c381d-0e29-47ab-85e3-e6a4d4c23a0a", is_global = true, name = "鼠标x速度", order = 3, position = { x = 20, y = 221 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "dcd8aee8-bec4-423f-b984-2c255d957b5f", is_global = true, name = "鼠标上一帧y坐标", order = 2, position = { x = 20, y = 154 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "e250fc39-8f2e-41e3-998b-f2aed40c9c43", is_global = true, name = "窗口大小", order = 0, position = { x = 20, y = 20 }, scale = 1, style = "default", type = "list", value = { 100, 100 }, visible = false }, { current_entity_id = "e8df6c52-aa79-4aab-8b7e-e8a6e98b7769", cv_id = "", entity_name = "窗口", id = "fee28211-ae6f-4934-82d1-8d975fa054fa", is_global = false, name = "窗口", order = 6, position = { x = 20, y = 423 }, scale = 1, style = "default", type = "list", value = {  }, visible = false } }
M.screens = { { id = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a", name = "背景", screenName = "屏幕", style_index = 1, styles = { "9182f281-1aae-4375-8583-ed0345d1ff63" }, visible = true } }
M.cur_scene = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a"
M.actors = { { id = "025dd83c-de62-46a3-86bb-2ab6333e16c2", is_global = true, name = "编程猫", order = 2, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "e9792a0f-ae14-4489-90c8-dd0fd6edd6d9" }, visible = true, x = 0, y = 0 }, { id = "e8df6c52-aa79-4aab-8b7e-e8a6e98b7769", is_global = true, name = "窗口", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "5f60ca9f-f544-4d52-bab9-6b03292f4d48" }, visible = true, x = 0, y = 0 }, { id = "2c6a7055-683c-4463-b0da-7863cb522653", is_global = true, name = "鼠标", order = 4, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "e3e817e5-86d6-41c4-8e2e-c3f33c82903a" }, visible = true, x = 0, y = 0 }, { id = "a9a78278-345a-44a4-86ea-34d4f4476e49", is_global = true, name = "字", order = 3, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "46e56f96-81c5-4d8d-8cb1-6f09fbc84539" }, visible = true, x = 0, y = 0 } }
M.assets_dir = "works"
M.assets = { ["46e56f96-81c5-4d8d-8cb1-6f09fbc84539"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/46e56f96-81c5-4d8d-8cb1-6f09fbc84539.png", id = "46e56f96-81c5-4d8d-8cb1-6f09fbc84539", name = "编程猫1", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzMyNDMyMzUyMF8xNzg1NTQyNDAwMDAwX0Z2VlhvMjhnUE4wc2kzcjlYVE00ZDdubW9lZFA=.svg" }, ["5f60ca9f-f544-4d52-bab9-6b03292f4d48"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/5f60ca9f-f544-4d52-bab9-6b03292f4d48.png", id = "5f60ca9f-f544-4d52-bab9-6b03292f4d48", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzMyNDMyMzUyMF8xNzg2MzI3MjAwMDAwX0ZuM0VpamVzUEFDa0NOY09tbm12YTRKMFA0VFo=.svg" }, ["9182f281-1aae-4375-8583-ed0345d1ff63"] = { adaption = nil, center = nil, file = "assets/9182f281-1aae-4375-8583-ed0345d1ff63.png", id = "9182f281-1aae-4375-8583-ed0345d1ff63", name = "背景", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/img_stage_defult_landscape.png" }, ["e3e817e5-86d6-41c4-8e2e-c3f33c82903a"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/e3e817e5-86d6-41c4-8e2e-c3f33c82903a.png", id = "e3e817e5-86d6-41c4-8e2e-c3f33c82903a", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["e9792a0f-ae14-4489-90c8-dd0fd6edd6d9"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/e9792a0f-ae14-4489-90c8-dd0fd6edd6d9.png", id = "e9792a0f-ae14-4489-90c8-dd0fd6edd6d9", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/c364f36a8dcf42d1a6acbe26c7eb6aaa.png" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_700824a5_44a8_4d03_a7e8_aa95d87e9b2a = ents["700824a5-44a8-4d03-a7e8-aa95d87e9b2a"]
  local e_025dd83c_de62_46a3_86bb_2ab6333e16c2 = ents["025dd83c-de62-46a3-86bb-2ab6333e16c2"]
  local e_e8df6c52_aa79_4aab_8b7e_e8a6e98b7769 = ents["e8df6c52-aa79-4aab-8b7e-e8a6e98b7769"]
  local e_2c6a7055_683c_4463_b0da_7863cb522653 = ents["2c6a7055-683c-4463-b0da-7863cb522653"]
  local e_a9a78278_345a_44a4_86ea_34d4f4476e49 = ents["a9a78278-345a-44a4-86ea-34d4f4476e49"]
  -- -------- 角色 编程猫 --------
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "on_running_group_activated", {}, function(th, self)
      proc_9a0ed070_0472_4184_816d_8e01aaf9e3b0(th, self, f["random_num"](self, __CONST[25], th), f["random_num"](self, __CONST[26], th))
      proc_cf9e399e_169f_46ea_97d8_43b6dfca1ef7(th, self, "0611e88a-fb0d-4bb5-a72d-208a1e5818c7", nil, nil, nil, nil, nil)
  end)
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "sprite_on_tap", { sprite = "--self", type = "mouse_down" }, function(th, self)
      proc_9a0ed070_0472_4184_816d_8e01aaf9e3b0(th, self, f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, __CONST[27], th), B = f["coordinate_of_sprite"](self, __CONST[15], th), type = "minus" }, th), type = "1" }, th), f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, __CONST[28], th), B = f["coordinate_of_sprite"](self, __CONST[16], th), type = "minus" }, th), type = "1" }, th))
  end)
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "on_running_group_activated", {}, function(th, self)
      f["self_dialog"](self, __CONST[29], th)
  end)
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "on_running_group_activated", {}, function(th, self)
      f["list_copy"](self, { list = f["temporary_list"](self, { ITEM0 = 0, ITEM1 = 0, ITEM10 = 5, ITEM11 = 5, ITEM12 = 5, ITEM13 = 0.275, ITEM14 = 0.275, ITEM15 = 0.6, ITEM16 = 0.6, ITEM17 = 0.3, ITEM2 = 100, ITEM3 = 100, ITEM4 = f["coordinate_of_sprite"](self, __CONST[30], th), ITEM5 = f["coordinate_of_sprite"](self, __CONST[31], th), ITEM6 = f["list_item"](self, __CONST[32], th), ITEM7 = f["list_item"](self, __CONST[33], th), ITEM8 = 2, ITEM9 = 2 }, th), target_list = "0611e88a-fb0d-4bb5-a72d-208a1e5818c7" }, th)
      while true do
        f["replace_list_item"](self, { item = "any", list = "0611e88a-fb0d-4bb5-a72d-208a1e5818c7", list_index = 5, list_item_value = f["coordinate_of_sprite"](self, __CONST[30], th) }, th)
        f["replace_list_item"](self, { item = "any", list = "0611e88a-fb0d-4bb5-a72d-208a1e5818c7", list_index = 6, list_item_value = f["coordinate_of_sprite"](self, __CONST[31], th) }, th)
        f["replace_list_item"](self, { item = "any", list = "0611e88a-fb0d-4bb5-a72d-208a1e5818c7", list_index = 7, list_item_value = f["list_item"](self, __CONST[32], th) }, th)
        f["replace_list_item"](self, { item = "any", list = "0611e88a-fb0d-4bb5-a72d-208a1e5818c7", list_index = 8, list_item_value = f["list_item"](self, __CONST[33], th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 窗口 --------
  rt.on(e_e8df6c52_aa79_4aab_8b7e_e8a6e98b7769, "on_running_group_activated", {}, function(th, self)
      proc_e15ecf63_939a_4ae8_9821_624616b7a854(th, self, "fee28211-ae6f-4934-82d1-8d975fa054fa", nil, nil, nil, nil)
  end)
  rt.on(e_e8df6c52_aa79_4aab_8b7e_e8a6e98b7769, "sprite_on_tap", { sprite = "--self", type = "mouse_down" }, function(th, self)
      proc_c92bbc0c_358e_4782_9ba8_a26a75bc1ee1(th, self, 5, 5, 100, 5, 5, 5, 5, nil, nil)
  end)
  rt.on(e_e8df6c52_aa79_4aab_8b7e_e8a6e98b7769, "on_keydown", { key = "68", type = "down" }, function(th, self)
      f["self_ask"](self, __CONST[34], th)
      proc_9a0ed070_0472_4184_816d_8e01aaf9e3b0(th, self, f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = f["get_answer"](self, {}, th) }, th), list_index = 1 }, th), f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = f["get_answer"](self, {}, th) }, th), list_index = 2 }, th))
      while not V.js_boolean(f["logic_negate"](self, { logic = f["check_key"](self, __CONST[35], th) }, th)) do
        if th:iter_n() then break end
      end
  end)
  rt.on(e_e8df6c52_aa79_4aab_8b7e_e8a6e98b7769, "on_keydown", { key = "83", type = "down" }, function(th, self)
      proc_9a0ed070_0472_4184_816d_8e01aaf9e3b0(th, self, f["random_num"](self, __CONST[25], th), f["random_num"](self, __CONST[26], th))
      while not V.js_boolean(f["logic_negate"](self, { logic = f["check_key"](self, __CONST[36], th) }, th)) do
        if th:iter_n() then break end
      end
  end)
  rt.on(e_e8df6c52_aa79_4aab_8b7e_e8a6e98b7769, "on_keydown", { key = "87", type = "down" }, function(th, self)
      f["script_variables"](self, __CONST[3], th)
      while true do
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[6], th), B = 0.6, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[8], th), B = 0.6, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"b\"}" }, th)
        f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 0, B = f["coordinate_of_sprite"](self, __CONST[15], th), type = "minus" }, th), B = 5, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 0, B = f["coordinate_of_sprite"](self, __CONST[16], th), type = "minus" }, th), B = 5, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"b\"}" }, th)
        f["self_change_coordinate_x"](self, { increase = "increase", value = f["script_variables_value"](self, __CONST[6], th) }, th)
        f["self_change_coordinate_y"](self, { increase = "increase", value = f["script_variables_value"](self, __CONST[8], th) }, th)
        if V.js_boolean(f["mouse_down"](self, __CONST[4], th)) then
          break
        end
        if V.js_boolean(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["math_round"](self, { num = f["coordinate_of_sprite"](self, __CONST[15], th), type = "round" }, th), B = 0, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["math_round"](self, { num = f["coordinate_of_sprite"](self, __CONST[16], th), type = "round" }, th), B = 0, OP = "EQ" }, th), type = "and" }, th)) then break end
        if th:iter_n() then break end
      end
      while not V.js_boolean(f["logic_negate"](self, { logic = f["check_key"](self, __CONST[37], th) }, th)) do
        if th:iter_n() then break end
      end
  end)
  rt.on(e_e8df6c52_aa79_4aab_8b7e_e8a6e98b7769, "on_keydown", { key = "38", type = "down" }, function(th, self)
      f["self_change_coordinate_y"](self, __CONST[38], th)
  end)
  rt.on(e_e8df6c52_aa79_4aab_8b7e_e8a6e98b7769, "on_keydown", { key = "40", type = "down" }, function(th, self)
      f["self_change_coordinate_y"](self, __CONST[39], th)
  end)
  rt.on(e_e8df6c52_aa79_4aab_8b7e_e8a6e98b7769, "on_keydown", { key = "39", type = "down" }, function(th, self)
      f["self_change_coordinate_x"](self, __CONST[38], th)
  end)
  rt.on(e_e8df6c52_aa79_4aab_8b7e_e8a6e98b7769, "on_keydown", { key = "37", type = "down" }, function(th, self)
      f["self_change_coordinate_x"](self, __CONST[39], th)
  end)
  rt.on(e_e8df6c52_aa79_4aab_8b7e_e8a6e98b7769, "on_keydown", { key = "65", type = "down" }, function(th, self)
      proc_9a0ed070_0472_4184_816d_8e01aaf9e3b0(th, self, f["get_stage_info"](self, __CONST[1], th), f["get_stage_info"](self, __CONST[2], th))
      while not V.js_boolean(f["logic_negate"](self, { logic = f["check_key"](self, __CONST[40], th) }, th)) do
        if th:iter_n() then break end
      end
  end)
  rt.on(e_e8df6c52_aa79_4aab_8b7e_e8a6e98b7769, "on_running_group_activated", {}, function(th, self)
      f["list_copy"](self, { list = f["temporary_list"](self, { ITEM0 = f["list_item"](self, __CONST[32], th), ITEM1 = f["list_item"](self, __CONST[33], th), ITEM10 = 0.6, ITEM11 = 0.6, ITEM12 = 0.3, ITEM13 = 0.3, ITEM2 = 5, ITEM3 = 5, ITEM4 = 90, ITEM5 = 120, ITEM6 = 5, ITEM7 = 5, ITEM8 = 5, ITEM9 = 5 }, th), target_list = "fee28211-ae6f-4934-82d1-8d975fa054fa" }, th)
      while true do
        f["replace_list_item"](self, { item = "any", list = "fee28211-ae6f-4934-82d1-8d975fa054fa", list_index = 1, list_item_value = f["list_item"](self, __CONST[32], th) }, th)
        f["replace_list_item"](self, { item = "any", list = "fee28211-ae6f-4934-82d1-8d975fa054fa", list_index = 2, list_item_value = f["list_item"](self, __CONST[33], th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 鼠标 --------
  rt.on(e_2c6a7055_683c_4463_b0da_7863cb522653, "on_running_group_activated", {}, function(th, self)
      while true do
        th:warp_enter()
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, __CONST[15], th), B = f["variables_get"](self, __CONST[41], th), type = "minus" }, th), variable = "bc5c381d-0e29-47ab-85e3-e6a4d4c23a0a" }, th)
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, __CONST[16], th), B = f["variables_get"](self, __CONST[42], th), type = "minus" }, th), variable = "97812897-dd76-4fc8-94fa-8fe0a8243deb" }, th)
        f["variables_set"](self, { value = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[5], th), B = f["variables_get"](self, __CONST[5], th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[7], th), B = f["variables_get"](self, __CONST[7], th), type = "multiply" }, th), type = "add" }, th), type = "0" }, th), variable = "755982d6-e5f1-4f4a-966e-eb427b32d1d7" }, th)
        f["variables_set"](self, { value = f["coordinate_of_sprite"](self, __CONST[15], th), variable = "0da54715-1db8-4309-b57c-05182da3dd1e" }, th)
        f["variables_set"](self, { value = f["coordinate_of_sprite"](self, __CONST[16], th), variable = "dcd8aee8-bec4-423f-b984-2c255d957b5f" }, th)
        th:warp_exit()
        if th:iter_n() then break end
      end
  end)
  rt.on(e_2c6a7055_683c_4463_b0da_7863cb522653, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_move_specify"](self, __CONST[43], th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 字 --------
  rt.on(e_a9a78278_345a_44a4_86ea_34d4f4476e49, "on_running_group_activated", {}, function(th, self)
      f["list_copy"](self, { list = f["temporary_list"](self, { ITEM0 = 0, ITEM1 = 0, ITEM10 = 5, ITEM11 = 5, ITEM12 = 5, ITEM13 = 0.275, ITEM14 = 0.275, ITEM15 = 0.6, ITEM16 = 0.6, ITEM17 = 0.3, ITEM2 = 100, ITEM3 = 100, ITEM4 = f["coordinate_of_sprite"](self, __CONST[30], th), ITEM5 = f["coordinate_of_sprite"](self, __CONST[31], th), ITEM6 = f["list_item"](self, __CONST[32], th), ITEM7 = f["list_item"](self, __CONST[33], th), ITEM8 = 2, ITEM9 = 2 }, th), target_list = "8d8c0869-6ecb-4c3b-a207-87fa0cd9a62c" }, th)
      while true do
        f["replace_list_item"](self, { item = "any", list = "8d8c0869-6ecb-4c3b-a207-87fa0cd9a62c", list_index = 5, list_item_value = f["coordinate_of_sprite"](self, __CONST[30], th) }, th)
        f["replace_list_item"](self, { item = "any", list = "8d8c0869-6ecb-4c3b-a207-87fa0cd9a62c", list_index = 6, list_item_value = f["coordinate_of_sprite"](self, __CONST[31], th) }, th)
        f["replace_list_item"](self, { item = "any", list = "8d8c0869-6ecb-4c3b-a207-87fa0cd9a62c", list_index = 7, list_item_value = f["list_item"](self, __CONST[32], th) }, th)
        f["replace_list_item"](self, { item = "any", list = "8d8c0869-6ecb-4c3b-a207-87fa0cd9a62c", list_index = 8, list_item_value = f["list_item"](self, __CONST[33], th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_a9a78278_345a_44a4_86ea_34d4f4476e49, "on_running_group_activated", {}, function(th, self)
      proc_cf9e399e_169f_46ea_97d8_43b6dfca1ef7(th, self, "8d8c0869-6ecb-4c3b-a207-87fa0cd9a62c", nil, nil, nil, nil, nil)
  end)
end

M.requires = {
  "add_width_height_scale",
  "appearance_of_sprite",
  "change_variables",
  "check_key",
  "coordinate_of_sprite",
  "effect_of_sprite",
  "get_answer",
  "get_stage_info",
  "list_copy",
  "list_item",
  "list_length",
  "logic_compare",
  "logic_negate",
  "logic_operation",
  "math_arithmetic",
  "math_function",
  "math_round",
  "mouse_down",
  "random_num",
  "replace_list_item",
  "script_variables",
  "script_variables_value",
  "self_ask",
  "self_change_coordinate_x",
  "self_change_coordinate_y",
  "self_change_effect",
  "self_dialog",
  "self_move_specify",
  "self_rotate",
  "temporary_list",
  "text_split",
  "variables_get",
  "variables_set",
}
return M

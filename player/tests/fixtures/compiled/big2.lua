-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：模板 | KittenN  3D Tirangle   version=0.24.3
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用
local __CONST = {
  { variable = "98a2e534-befe-4ef8-b22f-b57daf53c5b0" },
  { PARAMS0 = nil, PARAMS1 = nil, PARAMS10 = nil, PARAMS11 = nil, PARAMS12 = nil, PARAMS2 = nil, PARAMS3 = nil, PARAMS4 = nil, PARAMS5 = nil, PARAMS6 = nil, PARAMS7 = nil, PARAMS8 = nil, PARAMS9 = nil, name = "hx", names = { "hx", "hy", "hpoint", "ang1", "ang2", "deff", "temp", "tanA", "tanB", "tanC", "ha", "hb", "hc" } },
  { TEXT = "hpoint" },
  { TEXT = "hx" },
  { TEXT = "hy" },
  { TEXT = "tanA" },
  { TEXT = "ang2" },
  { TEXT = "ang1" },
  { TEXT = "deff" },
  { TEXT = "ha" },
  { TEXT = "tanB" },
  { TEXT = "hb" },
  { TEXT = "tanC" },
  { TEXT = "hc" },
  { variable = "b6730dd0-393e-4481-9ba7-ed35d6644d49" },
  { variable = "15647f70-09f4-47da-82fa-a09f334a3457" },
  { variable = "c29f1d38-54e3-42b3-8576-0a26918e1ba5" },
  { variable = "9055c2fd-e6ef-4991-b71a-1c8d1dc72e6d" },
  { variable = "47ba0e4f-4441-4689-9ac9-08e0a13079ef" },
  { variable = "849f244c-b61f-47d2-a04e-700702223585" },
  { variable = "ccd4ae8d-e3d8-4917-a47b-c8208844c946" },
  { variable = "1bc419b7-235d-491d-b684-62406c7d6e8f" },
  { variable = "41e6dc01-4b65-408f-b73c-1db5177c90a2" },
  { variable = "3063fd4f-2a35-49f1-a594-b046385c2f2d" },
  { variable = "1368c116-b3ed-4437-b7de-5b0566a99d0b" },
  { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, PARAMS3 = nil, PARAMS4 = nil, name = "ux", names = { "ux", "uy", "vx", "vy", "t" } },
  { TEXT = "ux" },
  { TEXT = "vx" },
  { TEXT = "uy" },
  { TEXT = "vy" },
  { TEXT = "t" },
  { PARAMS0 = nil, PARAMS1 = nil, name = "dx", names = { "dx", "dy" } },
  { TEXT = "dx" },
  { TEXT = "dy" },
  { variable = "3b885530-ccce-414f-9610-11f4db23c0ec" },
  { variable = "37451d75-097d-40c2-ad87-b3c6c2cc5ad7" },
  { variable = "74b2661f-17f8-4118-96ca-a59dc794a0ba" },
  { variable = "691ec139-2fe8-4f38-a4e0-cc34ca62f213" },
  { variable = "117fff25-11c1-44c4-aad1-324df7071889" },
  { variable = "c51270ae-cf74-496a-9359-09a7a2797311" },
  { variable = "fbcd173d-58eb-4e20-a0ca-53ad103ecb32" },
  { variable = "10583836-3fed-47d0-a60c-fd899ba36aac" },
  { variable = "9d2de14b-7f88-4db8-873d-5d92e657e347" },
  { variable = "560bdc6b-879f-4c01-b379-7979016f2b58" },
  { variable = "b4edaba7-e45a-4156-a31b-bb49471b96e9" },
  { variable = "6f5557c9-de68-4253-a77e-5a9a12230854" },
  { variable = "8276295d-4e63-432f-9a3e-e4d77a107cea" },
  { variable = "821c1310-6217-493d-99e8-71f9e0189974" },
  { variable = "eb40bd8b-38d9-4ece-b0d3-c3a7af0e0ee0" },
  { variable = "21cfa597-9229-46d8-a661-22588c3ac7d0" },
  { variable = "96d4a909-41d2-4e75-b5c4-1a898c04a66e" },
  { variable = "4b34cac7-8ec1-4ebc-bf24-2cbf677bfa5e" },
  { variable = "12527a06-5427-4285-b7e5-29cf04fea1e7" },
  { variable = "5156a784-88eb-4bda-910f-b3a109e1190c" },
  { variable = "9360e3a4-8b39-4755-9d15-936b8d005f6d" },
  { variable = "23bbceee-39e2-42b0-a783-eb0dfb9b22e3" },
  { value = 0, variable = "1c344e6b-7fe2-4023-86c1-3a09c6ba59fc" },
  { value = 100, variable = "5516c603-b6a4-40e1-8546-ef5ad0db8821" },
  { variable = "1c344e6b-7fe2-4023-86c1-3a09c6ba59fc" },
  { variable = "5516c603-b6a4-40e1-8546-ef5ad0db8821" },
  { variable = "4b5cdacf-67fe-4fc0-b6d0-fc1644d00e47" },
  { key = "39", type = "down" },
  { method = "increase", value = 3, variable = "691ec139-2fe8-4f38-a4e0-cc34ca62f213" },
  { key = "37", type = "down" },
  { method = "decrease", value = 3, variable = "691ec139-2fe8-4f38-a4e0-cc34ca62f213" },
  { key = "38", type = "down" },
  { method = "increase", value = 3, variable = "117fff25-11c1-44c4-aad1-324df7071889" },
  { key = "40", type = "down" },
  { method = "decrease", value = 3, variable = "117fff25-11c1-44c4-aad1-324df7071889" },
  { key = "87", type = "down" },
  { key = "83", type = "down" },
  { key = "68", type = "down" },
  { key = "65", type = "down" },
  { key = "32", type = "down" },
  { method = "increase", value = 5, variable = "37451d75-097d-40c2-ad87-b3c6c2cc5ad7" },
  { key = "67", type = "down" },
  { method = "decrease", value = 5, variable = "37451d75-097d-40c2-ad87-b3c6c2cc5ad7" },
  { time = "second" },
  { variable = "46362f3a-7c20-476d-a261-a4145b692581" },
  { method = "increase", value = 1, variable = "1f7ac39a-cc9e-44dc-95b2-f6264c58a9a0" },
  { variable = "1f7ac39a-cc9e-44dc-95b2-f6264c58a9a0" },
  { value = 0, variable = "1f7ac39a-cc9e-44dc-95b2-f6264c58a9a0" },
}

-- ===== 自定义积木（过程）=====
local proc_1015b961_7412_49b2_8094_02110c2743e0, proc_1a36b1c8_d025_4e6e_b1bc_4c8079832414, proc_1dfeb9ef_6a5b_45c2_bfd0_131e5f63640c, proc_4909b0fe_fe84_4828_9d72_f50d081a71ae, proc_4b4ad405_e399_49ab_a9f8_d7f69c854644, proc_4df10709_4490_4d61_8bfb_83cdfba713bb, proc_6abdc655_7f12_44d5_8f51_81c7d640cec8, proc_6aede338_0e58_4475_a5cc_c1de062d6978, proc_83f881bd_0ebe_4575_9d71_73e8549b8436, proc_993736bd_e871_4529_a5f4_a0a7979612bf, proc_b1171717_bd08_4965_b1ab_7409be300178, proc_c1c13eac_b483_4854_8b91_7119e8870ae3, proc_d8cc006c_b4fa_43c9_a00d_3b3e0feabc18, proc_e16de984_b530_4a61_9106_f3ee31a33f51, proc_f539dc6f_c44d_49c3_b609_c04fe84776ee, proc_fb0ce82b_38d0_4cd4_9b33_7ef0024e17b8, proc_fd402d9b_0e69_490d_9785_2839d1341847

proc_1015b961_7412_49b2_8094_02110c2743e0 = function(th, self, p_x, p_y, p_z, p_x1, p_y1, p_z1, p_distanec)
  -- 过程「197e5d6b-cf81-4a09-82f6-99f6aacd9752」 id=1015b961-7412-49b2-8094-02110c2743e0
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_distanec, B = p_z, type = "minus" }, th), B = f["math_arithmetic"](self, { A = p_z1, B = p_z, type = "minus" }, th), type = "divide" }, th), variable = "98a2e534-befe-4ef8-b22f-b57daf53c5b0" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_x, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_x1, B = p_x, type = "minus" }, th), B = f["variables_get"](self, __CONST[1], th), type = "multiply" }, th), type = "add" }, th), variable = "1bc419b7-235d-491d-b684-62406c7d6e8f" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_y, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_y1, B = p_y, type = "minus" }, th), B = f["variables_get"](self, __CONST[1], th), type = "multiply" }, th), type = "add" }, th), variable = "41e6dc01-4b65-408f-b73c-1db5177c90a2" }, th)
end

proc_1a36b1c8_d025_4e6e_b1bc_4c8079832414 = function(th, self, p_______, p_xA, p_yA, p_xB, p_yB, p_xC, p_yC)
  -- 过程「39bc2f18-8bc8-45e0-97b5-32510986d2b5」 id=1a36b1c8-d025-4e6e-b1bc-4c8079832414
  f["script_variables"](self, __CONST[2], th)
  f["variables_set"](self, { value = (proc_4b4ad405_e399_49ab_a9f8_d7f69c854644(th, self, p_xA, p_yA, p_xB, p_yB, p_xC, p_yC, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"hpoint\"}" }, th)
  f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[3], th), list_index = 1 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"hx\"}" }, th)
  f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[3], th), list_index = 2 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"hy\"}" }, th)
  f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[3], th), list_index = 3 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"hpoint\"}" }, th)
  if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[3], th), B = 1, OP = "EQ" }, th)) then
    f["variables_set"](self, { value = (proc_6aede338_0e58_4475_a5cc_c1de062d6978(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xA, p_yA)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ha\"}" }, th)
    f["variables_set"](self, { value = (proc_6abdc655_7f12_44d5_8f51_81c7d640cec8(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xA, p_yA, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"tanA\"}" }, th)
    f["variables_set"](self, { value = f["script_variables_value"](self, __CONST[6], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang1\"}" }, th)
    f["variables_set"](self, { value = (proc_6abdc655_7f12_44d5_8f51_81c7d640cec8(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xB, p_yB, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang2\"}" }, th)
    f["variables_set"](self, { value = f["math_modulo"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[7], th), B = f["script_variables_value"](self, __CONST[8], th), type = "minus" }, th), B = 360, type = "add" }, th), B = 360 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"deff\"}" }, th)
    if V.bool(f["logic_compare"](self, { A = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[9], th), B = 90, type = "minus" }, th), type = "1" }, th), B = 1, OP = "LT" }, th)) then
      proc_4df10709_4490_4d61_8bfb_83cdfba713bb(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xA, p_yA, p_xB, p_yB, f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_xB, B = p_xA, type = "add" }, th), B = 2, type = "divide" }, th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_yB, B = p_yA, type = "add" }, th), B = 2, type = "divide" }, th), (proc_6aede338_0e58_4475_a5cc_c1de062d6978(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xB, p_yB)), p_______)
    else
      proc_4df10709_4490_4d61_8bfb_83cdfba713bb(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xB, p_yB, p_xA, p_yA, f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_xB, B = p_xA, type = "add" }, th), B = 2, type = "divide" }, th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_yB, B = p_yA, type = "add" }, th), B = 2, type = "divide" }, th), f["script_variables_value"](self, __CONST[10], th), p_______)
    end
    f["variables_set"](self, { value = (proc_6abdc655_7f12_44d5_8f51_81c7d640cec8(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xC, p_yC, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang1\"}" }, th)
    f["variables_set"](self, { value = f["script_variables_value"](self, __CONST[6], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang2\"}" }, th)
    f["variables_set"](self, { value = f["math_modulo"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[7], th), B = f["script_variables_value"](self, __CONST[8], th), type = "minus" }, th), B = 360, type = "add" }, th), B = 360 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"deff\"}" }, th)
    if V.bool(f["logic_compare"](self, { A = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[9], th), B = 90, type = "minus" }, th), type = "1" }, th), B = 1, OP = "LT" }, th)) then
      proc_4df10709_4490_4d61_8bfb_83cdfba713bb(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xC, p_yC, p_xA, p_yA, f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_xA, B = p_xC, type = "add" }, th), B = 2, type = "divide" }, th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_yA, B = p_yC, type = "add" }, th), B = 2, type = "divide" }, th), f["script_variables_value"](self, __CONST[10], th), p_______)
    else
      proc_4df10709_4490_4d61_8bfb_83cdfba713bb(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xA, p_yA, p_xC, p_yC, f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_xC, B = p_xA, type = "add" }, th), B = 2, type = "divide" }, th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_yC, B = p_yA, type = "add" }, th), B = 2, type = "divide" }, th), (proc_6aede338_0e58_4475_a5cc_c1de062d6978(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xC, p_yC)), p_______)
    end
  elseif V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[3], th), B = 2, OP = "EQ" }, th)) then
    f["variables_set"](self, { value = (proc_6aede338_0e58_4475_a5cc_c1de062d6978(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xB, p_yB)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"hb\"}" }, th)
    f["variables_set"](self, { value = (proc_6abdc655_7f12_44d5_8f51_81c7d640cec8(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xB, p_yB, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"tanB\"}" }, th)
    f["variables_set"](self, { value = f["script_variables_value"](self, __CONST[11], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang1\"}" }, th)
    f["variables_set"](self, { value = (proc_6abdc655_7f12_44d5_8f51_81c7d640cec8(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xA, p_yA, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang2\"}" }, th)
    f["variables_set"](self, { value = f["math_modulo"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[7], th), B = f["script_variables_value"](self, __CONST[8], th), type = "minus" }, th), B = 360, type = "add" }, th), B = 360 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"deff\"}" }, th)
    if V.bool(f["logic_compare"](self, { A = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[9], th), B = 90, type = "minus" }, th), type = "1" }, th), B = 1, OP = "LT" }, th)) then
      proc_4df10709_4490_4d61_8bfb_83cdfba713bb(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xB, p_yB, p_xA, p_yA, f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_xB, B = p_xA, type = "add" }, th), B = 2, type = "divide" }, th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_yB, B = p_yA, type = "add" }, th), B = 2, type = "divide" }, th), (proc_6aede338_0e58_4475_a5cc_c1de062d6978(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xA, p_yA)), p_______)
    else
      proc_4df10709_4490_4d61_8bfb_83cdfba713bb(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xA, p_yA, p_xB, p_yB, f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_xB, B = p_xA, type = "add" }, th), B = 2, type = "divide" }, th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_yB, B = p_yA, type = "add" }, th), B = 2, type = "divide" }, th), f["script_variables_value"](self, __CONST[12], th), p_______)
    end
    f["variables_set"](self, { value = f["script_variables_value"](self, __CONST[11], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang1\"}" }, th)
    f["variables_set"](self, { value = (proc_6abdc655_7f12_44d5_8f51_81c7d640cec8(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xC, p_yC, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang2\"}" }, th)
    f["variables_set"](self, { value = f["math_modulo"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[7], th), B = f["script_variables_value"](self, __CONST[8], th), type = "minus" }, th), B = 360, type = "add" }, th), B = 360 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"deff\"}" }, th)
    if V.bool(f["logic_compare"](self, { A = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[9], th), B = 90, type = "minus" }, th), type = "1" }, th), B = 1, OP = "LT" }, th)) then
      proc_4df10709_4490_4d61_8bfb_83cdfba713bb(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xB, p_yB, p_xC, p_yC, f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_xB, B = p_xC, type = "add" }, th), B = 2, type = "divide" }, th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_yB, B = p_yC, type = "add" }, th), B = 2, type = "divide" }, th), (proc_6aede338_0e58_4475_a5cc_c1de062d6978(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xC, p_yC)), p_______)
    else
      proc_4df10709_4490_4d61_8bfb_83cdfba713bb(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xC, p_yC, p_xB, p_yB, f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_xB, B = p_xC, type = "add" }, th), B = 2, type = "divide" }, th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_yB, B = p_yC, type = "add" }, th), B = 2, type = "divide" }, th), f["script_variables_value"](self, __CONST[12], th), p_______)
    end
  else
    f["variables_set"](self, { value = (proc_6aede338_0e58_4475_a5cc_c1de062d6978(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xC, p_yC)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"hc\"}" }, th)
    f["variables_set"](self, { value = (proc_6abdc655_7f12_44d5_8f51_81c7d640cec8(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xC, p_yC, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"tanC\"}" }, th)
    f["variables_set"](self, { value = f["script_variables_value"](self, __CONST[13], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang1\"}" }, th)
    f["variables_set"](self, { value = (proc_6abdc655_7f12_44d5_8f51_81c7d640cec8(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xA, p_yA, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang2\"}" }, th)
    f["variables_set"](self, { value = f["math_modulo"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[7], th), B = f["script_variables_value"](self, __CONST[8], th), type = "minus" }, th), B = 360, type = "add" }, th), B = 360 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"deff\"}" }, th)
    if V.bool(f["logic_compare"](self, { A = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[9], th), B = 90, type = "minus" }, th), type = "1" }, th), B = 1, OP = "LT" }, th)) then
      proc_4df10709_4490_4d61_8bfb_83cdfba713bb(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xC, p_yC, p_xA, p_yA, f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_xC, B = p_xA, type = "add" }, th), B = 2, type = "divide" }, th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_yC, B = p_yA, type = "add" }, th), B = 2, type = "divide" }, th), (proc_6aede338_0e58_4475_a5cc_c1de062d6978(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xA, p_yA)), p_______)
    else
      proc_4df10709_4490_4d61_8bfb_83cdfba713bb(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xA, p_yA, p_xC, p_yC, f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_xC, B = p_xA, type = "add" }, th), B = 2, type = "divide" }, th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_yC, B = p_yA, type = "add" }, th), B = 2, type = "divide" }, th), f["script_variables_value"](self, __CONST[14], th), p_______)
    end
    f["variables_set"](self, { value = f["script_variables_value"](self, __CONST[13], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang1\"}" }, th)
    f["variables_set"](self, { value = (proc_6abdc655_7f12_44d5_8f51_81c7d640cec8(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xB, p_yB, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang2\"}" }, th)
    f["variables_set"](self, { value = f["math_modulo"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[7], th), B = f["script_variables_value"](self, __CONST[8], th), type = "minus" }, th), B = 360, type = "add" }, th), B = 360 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"deff\"}" }, th)
    if V.bool(f["logic_compare"](self, { A = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[9], th), B = 90, type = "minus" }, th), type = "1" }, th), B = 1, OP = "LT" }, th)) then
      proc_4df10709_4490_4d61_8bfb_83cdfba713bb(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xC, p_yC, p_xB, p_yB, f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_xB, B = p_xC, type = "add" }, th), B = 2, type = "divide" }, th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_yB, B = p_yC, type = "add" }, th), B = 2, type = "divide" }, th), (proc_6aede338_0e58_4475_a5cc_c1de062d6978(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xB, p_yB)), p_______)
    else
      proc_4df10709_4490_4d61_8bfb_83cdfba713bb(th, self, f["script_variables_value"](self, __CONST[4], th), f["script_variables_value"](self, __CONST[5], th), p_xB, p_yB, p_xC, p_yC, f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_xB, B = p_xC, type = "add" }, th), B = 2, type = "divide" }, th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_yB, B = p_yC, type = "add" }, th), B = 2, type = "divide" }, th), f["script_variables_value"](self, __CONST[14], th), p_______)
    end
  end
end

proc_1dfeb9ef_6a5b_45c2_bfd0_131e5f63640c = function(th, self, p_DISTANCE)
  -- 过程「4867c4dd-c372-49a9-97ab-abfbb7f442b6」 id=1dfeb9ef-6a5b-45c2-bfd0-131e5f63640c
  proc_e16de984_b530_4a61_9106_f3ee31a33f51(th, self)
  proc_f539dc6f_c44d_49c3_b609_c04fe84776ee(th, self, "NaN", "NaN", "NaN")
  if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, __CONST[15], th), B = p_DISTANCE, OP = "LT" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, __CONST[16], th), B = p_DISTANCE, OP = "LT" }, th), type = "and" }, th)) then
    proc_1015b961_7412_49b2_8094_02110c2743e0(th, self, f["variables_get"](self, __CONST[17], th), f["variables_get"](self, __CONST[18], th), f["variables_get"](self, __CONST[16], th), f["variables_get"](self, __CONST[19], th), f["variables_get"](self, __CONST[20], th), f["variables_get"](self, __CONST[21], th), p_DISTANCE)
    proc_c1c13eac_b483_4854_8b91_7119e8870ae3(th, self, f["variables_get"](self, __CONST[22], th), f["variables_get"](self, __CONST[23], th), p_DISTANCE)
    proc_1015b961_7412_49b2_8094_02110c2743e0(th, self, f["variables_get"](self, __CONST[24], th), f["variables_get"](self, __CONST[25], th), f["variables_get"](self, __CONST[15], th), f["variables_get"](self, __CONST[19], th), f["variables_get"](self, __CONST[20], th), f["variables_get"](self, __CONST[21], th), p_DISTANCE)
    proc_4909b0fe_fe84_4828_9d72_f50d081a71ae(th, self, f["variables_get"](self, __CONST[22], th), f["variables_get"](self, __CONST[23], th), p_DISTANCE)
  else
    if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, __CONST[15], th), B = p_DISTANCE, OP = "LT" }, th)) then
      proc_1015b961_7412_49b2_8094_02110c2743e0(th, self, f["variables_get"](self, __CONST[24], th), f["variables_get"](self, __CONST[25], th), f["variables_get"](self, __CONST[15], th), f["variables_get"](self, __CONST[19], th), f["variables_get"](self, __CONST[20], th), f["variables_get"](self, __CONST[21], th), p_DISTANCE)
      proc_f539dc6f_c44d_49c3_b609_c04fe84776ee(th, self, f["variables_get"](self, __CONST[22], th), f["variables_get"](self, __CONST[23], th), p_DISTANCE)
      proc_1015b961_7412_49b2_8094_02110c2743e0(th, self, f["variables_get"](self, __CONST[24], th), f["variables_get"](self, __CONST[25], th), f["variables_get"](self, __CONST[15], th), f["variables_get"](self, __CONST[17], th), f["variables_get"](self, __CONST[18], th), f["variables_get"](self, __CONST[16], th), p_DISTANCE)
      proc_4909b0fe_fe84_4828_9d72_f50d081a71ae(th, self, f["variables_get"](self, __CONST[22], th), f["variables_get"](self, __CONST[23], th), p_DISTANCE)
    end
  end
end

proc_4909b0fe_fe84_4828_9d72_f50d081a71ae = function(th, self, p_x, p_y, p_z)
  -- 过程「24604939-b231-4e58-874a-ee48ac8edc43」 id=4909b0fe-fe84-4828-9d72-f50d081a71ae
  f["variables_set"](self, { value = p_x, variable = "3063fd4f-2a35-49f1-a594-b046385c2f2d" }, th)
  f["variables_set"](self, { value = p_y, variable = "1368c116-b3ed-4437-b7de-5b0566a99d0b" }, th)
  f["variables_set"](self, { value = p_z, variable = "b6730dd0-393e-4481-9ba7-ed35d6644d49" }, th)
end

proc_4b4ad405_e399_49ab_a9f8_d7f69c854644 = function(th, self, p_xA, p_yA, p_xB, p_yB, p_xC, p_yC)
  -- 过程「9992272c-4a0e-46bd-8efd-66f887fa7dab」 id=4b4ad405-e399-49ab-a9f8-d7f69c854644
  f["script_variables"](self, __CONST[26], th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_xC, B = p_xB, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ux\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_yC, B = p_yB, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"uy\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_xA, B = p_xB, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"vx\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_yA, B = p_yB, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"vy\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[27], th), B = f["script_variables_value"](self, __CONST[28], th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[29], th), B = f["script_variables_value"](self, __CONST[30], th), type = "multiply" }, th), type = "add" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[27], th), B = 2, type = "power" }, th), B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[29], th), B = 2, type = "power" }, th), type = "add" }, th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"t\"}" }, th)
  if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = 0, B = f["script_variables_value"](self, __CONST[31], th), OP = "LTE" }, th), B = f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[31], th), B = 1, OP = "LTE" }, th), type = "and" }, th)) then
    return f["temporary_list"](self, { ITEM0 = f["math_arithmetic"](self, { A = p_xB, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[31], th), B = f["script_variables_value"](self, __CONST[27], th), type = "multiply" }, th), type = "add" }, th), ITEM1 = f["math_arithmetic"](self, { A = p_yB, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[31], th), B = f["script_variables_value"](self, __CONST[29], th), type = "multiply" }, th), type = "add" }, th), ITEM2 = 1 }, th)
  else
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_xC, B = p_xA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ux\"}" }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_yC, B = p_yA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"uy\"}" }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_xB, B = p_xA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"vx\"}" }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_yB, B = p_yA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"vy\"}" }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[27], th), B = f["script_variables_value"](self, __CONST[28], th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[29], th), B = f["script_variables_value"](self, __CONST[30], th), type = "multiply" }, th), type = "add" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[27], th), B = 2, type = "power" }, th), B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[29], th), B = 2, type = "power" }, th), type = "add" }, th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"t\"}" }, th)
    if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = 0, B = f["script_variables_value"](self, __CONST[31], th), OP = "LTE" }, th), B = f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[31], th), B = 1, OP = "LTE" }, th), type = "and" }, th)) then
      return f["temporary_list"](self, { ITEM0 = f["math_arithmetic"](self, { A = p_xA, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[31], th), B = f["script_variables_value"](self, __CONST[27], th), type = "multiply" }, th), type = "add" }, th), ITEM1 = f["math_arithmetic"](self, { A = p_yA, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[31], th), B = f["script_variables_value"](self, __CONST[29], th), type = "multiply" }, th), type = "add" }, th), ITEM2 = 2 }, th)
    else
      f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_xB, B = p_xA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ux\"}" }, th)
      f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_yB, B = p_yA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"uy\"}" }, th)
      f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_xC, B = p_xA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"vx\"}" }, th)
      f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_yC, B = p_yA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"vy\"}" }, th)
      f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[27], th), B = f["script_variables_value"](self, __CONST[28], th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[29], th), B = f["script_variables_value"](self, __CONST[30], th), type = "multiply" }, th), type = "add" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[27], th), B = 2, type = "power" }, th), B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[29], th), B = 2, type = "power" }, th), type = "add" }, th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"t\"}" }, th)
      return f["temporary_list"](self, { ITEM0 = f["math_arithmetic"](self, { A = p_xA, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[31], th), B = f["script_variables_value"](self, __CONST[27], th), type = "multiply" }, th), type = "add" }, th), ITEM1 = f["math_arithmetic"](self, { A = p_yA, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[31], th), B = f["script_variables_value"](self, __CONST[29], th), type = "multiply" }, th), type = "add" }, th), ITEM2 = 3 }, th)
    end
  end
end

proc_4df10709_4490_4d61_8bfb_83cdfba713bb = function(th, self, p_xd, p_yd, p_x1, p_y1, p_x2, p_y2, p_x, p_y, p____, p_______)
  -- 过程「5e8534f2-04f2-4339-a0d1-e2f8b8a1c4bf」 id=4df10709-4490-4d61-8bfb-83cdfba713bb
  f["self_point_towards"](self, { degrees = (proc_6abdc655_7f12_44d5_8f51_81c7d640cec8(th, self, p_xd, p_yd, p_x1, p_y1, nil, nil)) }, th)
  f["set_width_height_scale"](self, { type = "width", value = f["math_arithmetic"](self, { A = 2, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = p_______, type = "divide" }, th), B = (proc_6aede338_0e58_4475_a5cc_c1de062d6978(th, self, p_x1, p_y1, p_xd, p_yd)), type = "multiply" }, th), type = "add" }, th) }, th)
  f["set_width_height_scale"](self, { type = "height", value = f["math_arithmetic"](self, { A = 2, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = p_______, type = "divide" }, th), B = p____, type = "multiply" }, th), type = "add" }, th) }, th)
  f["self_move_to"](self, { x = p_x, y = p_y }, th)
  f["image_stamp"](self, {}, th)
end

proc_6abdc655_7f12_44d5_8f51_81c7d640cec8 = function(th, self, p_xA, p_yA, p_xB, p_yB)
  -- 过程「b3c48ccd-f9d4-4211-8160-e630555d1829」 id=6abdc655-7f12-44d5-8f51-81c7d640cec8
  f["script_variables"](self, __CONST[32], th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_xB, B = p_xA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"dx\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_yB, B = p_yA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"dy\"}" }, th)
  if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[33], th), B = 0, OP = "LT" }, th)) then
    return f["math_arithmetic"](self, { A = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[34], th), B = f["script_variables_value"](self, __CONST[33], th), type = "divide" }, th), type = "atan" }, th), B = 180, type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[33], th), B = 0, OP = "EQ" }, th)) then
    if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[34], th), B = 0, OP = "GT" }, th)) then
      return 90
    elseif V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[34], th), B = 0, OP = "LT" }, th)) then
      return 270
    else
      return 0
    end
  else
    if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[34], th), B = 0, OP = "GTE" }, th)) then
      return f["math_trig"](self, { num = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[34], th), B = f["script_variables_value"](self, __CONST[33], th), type = "divide" }, th), type = "atan" }, th)
    else
      return f["math_arithmetic"](self, { A = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[34], th), B = f["script_variables_value"](self, __CONST[33], th), type = "divide" }, th), type = "atan" }, th), B = 360, type = "add" }, th)
    end
  end
end

proc_6aede338_0e58_4475_a5cc_c1de062d6978 = function(th, self, p_x1, p_y1, p_x2, p_y2)
  -- 过程「5447c10a-34a6-468c-97ec-a155197129af」 id=6aede338-0e58-4475-a5cc-c1de062d6978
  return f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_x1, B = p_x2, type = "minus" }, th), B = 2, type = "power" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_y1, B = p_y2, type = "minus" }, th), B = 2, type = "power" }, th), type = "add" }, th), type = "0" }, th)
end

proc_83f881bd_0ebe_4575_9d71_73e8549b8436 = function(th, self, p_x1, p_y1, p_x2, p_y2, p_x3, p_y3, p_res)
  -- 过程「1bff4cb1-ef60-4797-8d98-3ef0f06829a0」 id=83f881bd-0ebe-4575-9d71-73e8549b8436
  proc_1a36b1c8_d025_4e6e_b1bc_4c8079832414(th, self, 100, p_x1, p_y1, p_x2, p_y2, p_x3, p_y3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)
end

proc_993736bd_e871_4529_a5f4_a0a7979612bf = function(th, self, p_x, p_y, p_z)
  -- 过程「497a50fb-b300-4c35-ad37-b06a97781d48」 id=993736bd-e871-4529-a5f4-a0a7979612bf
  proc_d8cc006c_b4fa_43c9_a00d_3b3e0feabc18(th, self, f["math_arithmetic"](self, { A = p_x, B = f["variables_get"](self, __CONST[35], th), type = "minus" }, th), f["math_arithmetic"](self, { A = p_y, B = f["variables_get"](self, __CONST[36], th), type = "minus" }, th), f["math_arithmetic"](self, { A = p_z, B = f["variables_get"](self, __CONST[37], th), type = "minus" }, th))
  proc_d8cc006c_b4fa_43c9_a00d_3b3e0feabc18(th, self, f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[21], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = f["variables_get"](self, __CONST[38], th), type = "minus" }, th), type = "sin" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[19], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = f["variables_get"](self, __CONST[38], th), type = "minus" }, th), type = "cos" }, th), type = "multiply" }, th), type = "add" }, th), f["variables_get"](self, __CONST[20], th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[21], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = f["variables_get"](self, __CONST[38], th), type = "minus" }, th), type = "cos" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[19], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = f["variables_get"](self, __CONST[38], th), type = "minus" }, th), type = "sin" }, th), type = "multiply" }, th), type = "minus" }, th))
  proc_d8cc006c_b4fa_43c9_a00d_3b3e0feabc18(th, self, f["variables_get"](self, __CONST[19], th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[21], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = f["variables_get"](self, __CONST[39], th), type = "minus" }, th), type = "sin" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[20], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = f["variables_get"](self, __CONST[39], th), type = "minus" }, th), type = "cos" }, th), type = "multiply" }, th), type = "add" }, th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[21], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = f["variables_get"](self, __CONST[39], th), type = "minus" }, th), type = "cos" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[20], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = f["variables_get"](self, __CONST[39], th), type = "minus" }, th), type = "sin" }, th), type = "multiply" }, th), type = "minus" }, th))
  if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, __CONST[21], th), B = 0.1, OP = "GT" }, th)) then
    f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[19], th), B = f["math_arithmetic"](self, { A = 250, B = f["variables_get"](self, __CONST[21], th), type = "divide" }, th), type = "multiply" }, th), y = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[20], th), B = f["math_arithmetic"](self, { A = 250, B = f["variables_get"](self, __CONST[21], th), type = "divide" }, th), type = "multiply" }, th) }, th)
  end
end

proc_b1171717_bd08_4965_b1ab_7409be300178 = function(th, self, p_x, p_y, p_z, p_x1, p_y1, p_z1, p_x2, p_y2, p_z2, p_res, p_CameraX, p_CameraY, p_CameraZ, p_FOV, p_Ax, p_Ay, p_distance, p_R, p_G, p_B, p_A)
  -- 过程「3ac83952-f894-4b94-8d19-cd7810d7b0bd」 id=b1171717-bd08-4965-b1ab-7409be300178
  proc_fd402d9b_0e69_490d_9785_2839d1341847(th, self, p_R, p_G, p_B)
  f["self_set_pen_color_property"](self, { scope = "alpha", val = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_A, B = 255, type = "divide" }, th), B = 100, type = "multiply" }, th) }, th)
  proc_d8cc006c_b4fa_43c9_a00d_3b3e0feabc18(th, self, f["math_arithmetic"](self, { A = p_x, B = p_CameraX, type = "minus" }, th), f["math_arithmetic"](self, { A = p_y, B = p_CameraY, type = "minus" }, th), f["math_arithmetic"](self, { A = p_z, B = p_CameraZ, type = "minus" }, th))
  proc_c1c13eac_b483_4854_8b91_7119e8870ae3(th, self, f["math_arithmetic"](self, { A = p_x1, B = p_CameraX, type = "minus" }, th), f["math_arithmetic"](self, { A = p_y1, B = p_CameraY, type = "minus" }, th), f["math_arithmetic"](self, { A = p_z1, B = p_CameraZ, type = "minus" }, th))
  proc_4909b0fe_fe84_4828_9d72_f50d081a71ae(th, self, f["math_arithmetic"](self, { A = p_x2, B = p_CameraX, type = "minus" }, th), f["math_arithmetic"](self, { A = p_y2, B = p_CameraY, type = "minus" }, th), f["math_arithmetic"](self, { A = p_z2, B = p_CameraZ, type = "minus" }, th))
  proc_d8cc006c_b4fa_43c9_a00d_3b3e0feabc18(th, self, f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[21], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ay, type = "minus" }, th), type = "sin" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[19], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ay, type = "minus" }, th), type = "cos" }, th), type = "multiply" }, th), type = "add" }, th), f["variables_get"](self, __CONST[20], th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[21], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ay, type = "minus" }, th), type = "cos" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[19], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ay, type = "minus" }, th), type = "sin" }, th), type = "multiply" }, th), type = "minus" }, th))
  proc_c1c13eac_b483_4854_8b91_7119e8870ae3(th, self, f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[16], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ay, type = "minus" }, th), type = "sin" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[17], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ay, type = "minus" }, th), type = "cos" }, th), type = "multiply" }, th), type = "add" }, th), f["variables_get"](self, __CONST[18], th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[16], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ay, type = "minus" }, th), type = "cos" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[17], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ay, type = "minus" }, th), type = "sin" }, th), type = "multiply" }, th), type = "minus" }, th))
  proc_4909b0fe_fe84_4828_9d72_f50d081a71ae(th, self, f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[15], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ay, type = "minus" }, th), type = "sin" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[24], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ay, type = "minus" }, th), type = "cos" }, th), type = "multiply" }, th), type = "add" }, th), f["variables_get"](self, __CONST[25], th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[15], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ay, type = "minus" }, th), type = "cos" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[24], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ay, type = "minus" }, th), type = "sin" }, th), type = "multiply" }, th), type = "minus" }, th))
  proc_d8cc006c_b4fa_43c9_a00d_3b3e0feabc18(th, self, f["variables_get"](self, __CONST[19], th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[21], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ax, type = "minus" }, th), type = "sin" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[20], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ax, type = "minus" }, th), type = "cos" }, th), type = "multiply" }, th), type = "add" }, th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[21], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ax, type = "minus" }, th), type = "cos" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[20], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ax, type = "minus" }, th), type = "sin" }, th), type = "multiply" }, th), type = "minus" }, th))
  proc_c1c13eac_b483_4854_8b91_7119e8870ae3(th, self, f["variables_get"](self, __CONST[17], th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[16], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ax, type = "minus" }, th), type = "sin" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[18], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ax, type = "minus" }, th), type = "cos" }, th), type = "multiply" }, th), type = "add" }, th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[16], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ax, type = "minus" }, th), type = "cos" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[18], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ax, type = "minus" }, th), type = "sin" }, th), type = "multiply" }, th), type = "minus" }, th))
  proc_4909b0fe_fe84_4828_9d72_f50d081a71ae(th, self, f["variables_get"](self, __CONST[24], th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[15], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ax, type = "minus" }, th), type = "sin" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[25], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ax, type = "minus" }, th), type = "cos" }, th), type = "multiply" }, th), type = "add" }, th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[15], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ax, type = "minus" }, th), type = "cos" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[25], th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 0, B = p_Ax, type = "minus" }, th), type = "sin" }, th), type = "multiply" }, th), type = "minus" }, th))
  if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, __CONST[15], th), B = p_distance, OP = "GT" }, th), B = f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, __CONST[16], th), B = p_distance, OP = "GT" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, __CONST[21], th), B = p_distance, OP = "GT" }, th), type = "or" }, th), type = "or" }, th)) then
    proc_1dfeb9ef_6a5b_45c2_bfd0_131e5f63640c(th, self, p_distance)
    proc_83f881bd_0ebe_4575_9d71_73e8549b8436(th, self, f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[19], th), B = f["math_arithmetic"](self, { A = p_FOV, B = f["variables_get"](self, __CONST[21], th), type = "divide" }, th), type = "multiply" }, th), f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[20], th), B = f["math_arithmetic"](self, { A = p_FOV, B = f["variables_get"](self, __CONST[21], th), type = "divide" }, th), type = "multiply" }, th), f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[17], th), B = f["math_arithmetic"](self, { A = p_FOV, B = f["variables_get"](self, __CONST[16], th), type = "divide" }, th), type = "multiply" }, th), f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[18], th), B = f["math_arithmetic"](self, { A = p_FOV, B = f["variables_get"](self, __CONST[16], th), type = "divide" }, th), type = "multiply" }, th), f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[24], th), B = f["math_arithmetic"](self, { A = p_FOV, B = f["variables_get"](self, __CONST[15], th), type = "divide" }, th), type = "multiply" }, th), f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[25], th), B = f["math_arithmetic"](self, { A = p_FOV, B = f["variables_get"](self, __CONST[15], th), type = "divide" }, th), type = "multiply" }, th), p_res)
    if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, __CONST[40], th), B = "NaN", OP = "NEQ" }, th)) then
      proc_83f881bd_0ebe_4575_9d71_73e8549b8436(th, self, f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[19], th), B = f["math_arithmetic"](self, { A = p_FOV, B = f["variables_get"](self, __CONST[21], th), type = "divide" }, th), type = "multiply" }, th), f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[20], th), B = f["math_arithmetic"](self, { A = p_FOV, B = f["variables_get"](self, __CONST[21], th), type = "divide" }, th), type = "multiply" }, th), f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[41], th), B = f["math_arithmetic"](self, { A = p_FOV, B = f["variables_get"](self, __CONST[40], th), type = "divide" }, th), type = "multiply" }, th), f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[42], th), B = f["math_arithmetic"](self, { A = p_FOV, B = f["variables_get"](self, __CONST[40], th), type = "divide" }, th), type = "multiply" }, th), f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[24], th), B = f["math_arithmetic"](self, { A = p_FOV, B = f["variables_get"](self, __CONST[15], th), type = "divide" }, th), type = "multiply" }, th), f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[25], th), B = f["math_arithmetic"](self, { A = p_FOV, B = f["variables_get"](self, __CONST[15], th), type = "divide" }, th), type = "multiply" }, th), p_res)
    end
  end
end

proc_c1c13eac_b483_4854_8b91_7119e8870ae3 = function(th, self, p_x, p_y, p_z)
  -- 过程「732cc682-2c3d-4b1a-a5d6-7153e5dfcc58」 id=c1c13eac-b483-4854-8b91-7119e8870ae3
  f["variables_set"](self, { value = p_x, variable = "c29f1d38-54e3-42b3-8576-0a26918e1ba5" }, th)
  f["variables_set"](self, { value = p_y, variable = "9055c2fd-e6ef-4991-b71a-1c8d1dc72e6d" }, th)
  f["variables_set"](self, { value = p_z, variable = "15647f70-09f4-47da-82fa-a09f334a3457" }, th)
end

proc_d8cc006c_b4fa_43c9_a00d_3b3e0feabc18 = function(th, self, p_x, p_y, p_z)
  -- 过程「98e777c4-95d1-4523-8065-5d579d6d2180」 id=d8cc006c-b4fa-43c9-a00d-3b3e0feabc18
  f["variables_set"](self, { value = p_x, variable = "47ba0e4f-4441-4689-9ac9-08e0a13079ef" }, th)
  f["variables_set"](self, { value = p_y, variable = "849f244c-b61f-47d2-a04e-700702223585" }, th)
  f["variables_set"](self, { value = p_z, variable = "ccd4ae8d-e3d8-4917-a47b-c8208844c946" }, th)
end

proc_e16de984_b530_4a61_9106_f3ee31a33f51 = function(th, self)
  -- 过程「82b618b8-9043-4186-bdfd-c60f37080f57」 id=e16de984-b530-4a61-9106-f3ee31a33f51
  if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, __CONST[21], th), B = f["variables_get"](self, __CONST[16], th), OP = "LT" }, th)) then
    proc_f539dc6f_c44d_49c3_b609_c04fe84776ee(th, self, f["variables_get"](self, __CONST[19], th), f["variables_get"](self, __CONST[20], th), f["variables_get"](self, __CONST[21], th))
    proc_d8cc006c_b4fa_43c9_a00d_3b3e0feabc18(th, self, f["variables_get"](self, __CONST[17], th), f["variables_get"](self, __CONST[18], th), f["variables_get"](self, __CONST[16], th))
    proc_c1c13eac_b483_4854_8b91_7119e8870ae3(th, self, f["variables_get"](self, __CONST[41], th), f["variables_get"](self, __CONST[42], th), f["variables_get"](self, __CONST[40], th))
  end
  if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, __CONST[21], th), B = f["variables_get"](self, __CONST[15], th), OP = "LT" }, th)) then
    proc_f539dc6f_c44d_49c3_b609_c04fe84776ee(th, self, f["variables_get"](self, __CONST[19], th), f["variables_get"](self, __CONST[20], th), f["variables_get"](self, __CONST[21], th))
    proc_d8cc006c_b4fa_43c9_a00d_3b3e0feabc18(th, self, f["variables_get"](self, __CONST[24], th), f["variables_get"](self, __CONST[25], th), f["variables_get"](self, __CONST[15], th))
    proc_4909b0fe_fe84_4828_9d72_f50d081a71ae(th, self, f["variables_get"](self, __CONST[41], th), f["variables_get"](self, __CONST[42], th), f["variables_get"](self, __CONST[40], th))
  end
  if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, __CONST[16], th), B = f["variables_get"](self, __CONST[15], th), OP = "LT" }, th)) then
    proc_f539dc6f_c44d_49c3_b609_c04fe84776ee(th, self, f["variables_get"](self, __CONST[17], th), f["variables_get"](self, __CONST[18], th), f["variables_get"](self, __CONST[16], th))
    proc_c1c13eac_b483_4854_8b91_7119e8870ae3(th, self, f["variables_get"](self, __CONST[24], th), f["variables_get"](self, __CONST[25], th), f["variables_get"](self, __CONST[15], th))
    proc_4909b0fe_fe84_4828_9d72_f50d081a71ae(th, self, f["variables_get"](self, __CONST[41], th), f["variables_get"](self, __CONST[42], th), f["variables_get"](self, __CONST[40], th))
  end
end

proc_f539dc6f_c44d_49c3_b609_c04fe84776ee = function(th, self, p_x, p_y, p_z)
  -- 过程「ed6b5a12-4d69-4d68-8e29-444db8ae743c」 id=f539dc6f-c44d-49c3-b609-c04fe84776ee
  f["variables_set"](self, { value = p_x, variable = "fbcd173d-58eb-4e20-a0ca-53ad103ecb32" }, th)
  f["variables_set"](self, { value = p_y, variable = "10583836-3fed-47d0-a60c-fd899ba36aac" }, th)
  f["variables_set"](self, { value = p_z, variable = "c51270ae-cf74-496a-9359-09a7a2797311" }, th)
end

proc_fb0ce82b_38d0_4cd4_9b33_7ef0024e17b8 = function(th, self, p_x, p_y, p_x1, p_y1, p_x2, p_y2, p_R)
  -- 过程「3e290cd7-542a-4400-8511-a9b3ae11774d」 id=fb0ce82b-38d0-4cd4-9b33-7ef0024e17b8
  if V.bool(f["logic_compare"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[43], th), B = f["variables_get"](self, __CONST[44], th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_R, B = 2, type = "divide" }, th), B = 0.5, type = "add" }, th), OP = "LT" }, th)) then
    return nil
  end
  f["self_set_pen_size"](self, { size = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[43], th), B = f["variables_get"](self, __CONST[44], th), type = "multiply" }, th), B = 1, type = "add" }, th) }, th)
  f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = p_x, B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[43], th), B = f["variables_get"](self, __CONST[45], th), type = "multiply" }, th), type = "minus" }, th), y = f["math_arithmetic"](self, { A = p_y, B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[43], th), B = f["variables_get"](self, __CONST[46], th), type = "multiply" }, th), type = "minus" }, th) }, th)
  f["self_pen_down"](self, {}, th)
  f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = p_x1, B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[43], th), B = f["variables_get"](self, __CONST[47], th), type = "multiply" }, th), type = "minus" }, th), y = f["math_arithmetic"](self, { A = p_y1, B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[43], th), B = f["variables_get"](self, __CONST[48], th), type = "multiply" }, th), type = "minus" }, th) }, th)
  f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = p_x2, B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[43], th), B = f["variables_get"](self, __CONST[49], th), type = "multiply" }, th), type = "minus" }, th), y = f["math_arithmetic"](self, { A = p_y2, B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[43], th), B = f["variables_get"](self, __CONST[50], th), type = "multiply" }, th), type = "minus" }, th) }, th)
  f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = p_x, B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[43], th), B = f["variables_get"](self, __CONST[45], th), type = "multiply" }, th), type = "minus" }, th), y = f["math_arithmetic"](self, { A = p_y, B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[43], th), B = f["variables_get"](self, __CONST[46], th), type = "multiply" }, th), type = "minus" }, th) }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[43], th), B = f["math_arithmetic"](self, { A = 2.7, B = f["variables_get"](self, __CONST[43], th), type = "minus" }, th), type = "divide" }, th), variable = "9d2de14b-7f88-4db8-873d-5d92e657e347" }, th)
  proc_fb0ce82b_38d0_4cd4_9b33_7ef0024e17b8(th, self, p_x, p_y, p_x1, p_y1, p_x2, p_y2, p_R)
end

proc_fd402d9b_0e69_490d_9785_2839d1341847 = function(th, self, p_R, p_G, p_B)
  -- 过程「b0cba4d7-3735-4127-be83-5431812a5ecb」 id=fd402d9b-0e69-490d-9785-2839d1341847
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_R, B = 255, type = "divide" }, th), variable = "96d4a909-41d2-4e75-b5c4-1a898c04a66e" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_G, B = 255, type = "divide" }, th), variable = "4b34cac7-8ec1-4ebc-bf24-2cbf677bfa5e" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_B, B = 255, type = "divide" }, th), variable = "12527a06-5427-4285-b7e5-29cf04fea1e7" }, th)
  if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, __CONST[51], th), B = f["variables_get"](self, __CONST[52], th), OP = "GTE" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, __CONST[51], th), B = f["variables_get"](self, __CONST[53], th), OP = "GTE" }, th), type = "and" }, th)) then
    f["variables_set"](self, { value = f["variables_get"](self, __CONST[51], th), variable = "5156a784-88eb-4bda-910f-b3a109e1190c" }, th)
  elseif V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, __CONST[52], th), B = f["variables_get"](self, __CONST[51], th), OP = "GTE" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, __CONST[52], th), B = f["variables_get"](self, __CONST[53], th), OP = "GTE" }, th), type = "and" }, th)) then
    f["variables_set"](self, { value = f["variables_get"](self, __CONST[52], th), variable = "5156a784-88eb-4bda-910f-b3a109e1190c" }, th)
  else
    f["variables_set"](self, { value = f["variables_get"](self, __CONST[53], th), variable = "5156a784-88eb-4bda-910f-b3a109e1190c" }, th)
  end
  if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, __CONST[51], th), B = f["variables_get"](self, __CONST[52], th), OP = "LTE" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, __CONST[51], th), B = f["variables_get"](self, __CONST[53], th), OP = "LTE" }, th), type = "and" }, th)) then
    f["variables_set"](self, { value = f["variables_get"](self, __CONST[51], th), variable = "9360e3a4-8b39-4755-9d15-936b8d005f6d" }, th)
  elseif V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, __CONST[52], th), B = f["variables_get"](self, __CONST[51], th), OP = "LTE" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, __CONST[52], th), B = f["variables_get"](self, __CONST[53], th), OP = "LTE" }, th), type = "and" }, th)) then
    f["variables_set"](self, { value = f["variables_get"](self, __CONST[52], th), variable = "9360e3a4-8b39-4755-9d15-936b8d005f6d" }, th)
  else
    f["variables_set"](self, { value = f["variables_get"](self, __CONST[53], th), variable = "9360e3a4-8b39-4755-9d15-936b8d005f6d" }, th)
  end
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[54], th), B = f["variables_get"](self, __CONST[55], th), type = "minus" }, th), variable = "23bbceee-39e2-42b0-a783-eb0dfb9b22e3" }, th)
  if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, __CONST[56], th), B = 0, OP = "EQ" }, th)) then
    f["variables_set"](self, __CONST[57], th)
  elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, __CONST[54], th), B = f["variables_get"](self, __CONST[51], th), OP = "EQ" }, th)) then
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_modulo"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[52], th), B = f["variables_get"](self, __CONST[53], th), type = "minus" }, th), B = f["variables_get"](self, __CONST[56], th), type = "divide" }, th), B = 6 }, th), B = 60, type = "multiply" }, th), variable = "1c344e6b-7fe2-4023-86c1-3a09c6ba59fc" }, th)
  elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, __CONST[54], th), B = f["variables_get"](self, __CONST[52], th), OP = "EQ" }, th)) then
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[53], th), B = f["variables_get"](self, __CONST[51], th), type = "minus" }, th), B = f["variables_get"](self, __CONST[56], th), type = "divide" }, th), B = 2, type = "add" }, th), B = 60, type = "multiply" }, th), variable = "1c344e6b-7fe2-4023-86c1-3a09c6ba59fc" }, th)
  else
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[51], th), B = f["variables_get"](self, __CONST[52], th), type = "minus" }, th), B = f["variables_get"](self, __CONST[56], th), type = "divide" }, th), B = 4, type = "add" }, th), B = 60, type = "multiply" }, th), variable = "1c344e6b-7fe2-4023-86c1-3a09c6ba59fc" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, __CONST[54], th), B = 0, OP = "NEQ" }, th)) then
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[56], th), B = f["variables_get"](self, __CONST[54], th), type = "divide" }, th), B = 100, type = "multiply" }, th), variable = "5516c603-b6a4-40e1-8546-ef5ad0db8821" }, th)
  else
    f["variables_set"](self, __CONST[58], th)
  end
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[54], th), B = 100, type = "multiply" }, th), variable = "4b5cdacf-67fe-4fc0-b6d0-fc1644d00e47" }, th)
  f["self_set_pen_color_property"](self, { scope = "hue", val = f["variables_get"](self, __CONST[59], th) }, th)
  f["self_set_pen_color_property"](self, { scope = "saturation", val = f["variables_get"](self, __CONST[60], th) }, th)
  f["self_set_pen_color_property"](self, { scope = "brightness", val = f["math_arithmetic"](self, { A = 10, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[61], th), B = 2, type = "divide" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = f["variables_get"](self, __CONST[60], th), type = "minus" }, th), B = 2, type = "divide" }, th), type = "add" }, th), type = "add" }, th) }, th)
end

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 900, 562
M.timer_pos = { x = 720, y = 12 }
M.proc_trampoline = false
M.uses_timer = false
M.timer_hidden_default = false
M.vars = { { current_entity_id = "", cv_id = "", entity_name = "", id = "10583836-3fed-47d0-a60c-fd899ba36aac", is_global = true, name = "VERTEX Y3", order = 20, position = { x = 420, y = 288 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "117fff25-11c1-44c4-aad1-324df7071889", is_global = true, name = "镜头x方向", order = 28, position = { x = 620, y = 420 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "12527a06-5427-4285-b7e5-29cf04fea1e7", is_global = true, name = "Bdot", order = 32, position = { x = 657, y = 221 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "1368c116-b3ed-4437-b7de-5b0566a99d0b", is_global = true, name = "VERTEX Y2", order = 17, position = { x = 420, y = 87 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "14575e0d-0cb6-45a7-809a-bde2650e099b", is_global = true, name = "y1", order = 40, position = { x = 764, y = 221 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "15647f70-09f4-47da-82fa-a09f334a3457", is_global = true, name = "VERTEX Z1", order = 15, position = { x = 220, y = 490 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "1bc419b7-235d-491d-b684-62406c7d6e8f", is_global = true, name = "TX", order = 23, position = { x = 620, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "1c344e6b-7fe2-4023-86c1-3a09c6ba59fc", is_global = true, name = "H", order = 36, position = { x = 657, y = 490 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "1e78a122-c953-4e94-93d0-afdc6b6f2d6f", is_global = true, name = "tir6", order = 5, position = { x = 20, y = 356 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "1f7ac39a-cc9e-44dc-95b2-f6264c58a9a0", is_global = true, name = "count", order = 47, position = { x = 764, y = 154 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "21cfa597-9229-46d8-a661-22588c3ac7d0", is_global = true, name = "tir9", order = 8, position = { x = 220, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "23bbceee-39e2-42b0-a783-eb0dfb9b22e3", is_global = true, name = "Delta", order = 35, position = { x = 657, y = 423 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "2413e681-ff8c-4a3b-98fc-ebeee8d84ca3", is_global = true, name = "fps", order = 45, position = { x = 764, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "3063fd4f-2a35-49f1-a594-b046385c2f2d", is_global = true, name = "VERTEX X2", order = 16, position = { x = 420, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "3378f111-466c-41cf-82db-23dde4e02326", is_global = true, name = "y2", order = 42, position = { x = 764, y = 356 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "357d677d-ef24-44f8-94c4-790e81762874", is_global = true, name = "x3", order = 43, position = { x = 764, y = 423 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "37451d75-097d-40c2-ad87-b3c6c2cc5ad7", is_global = true, name = "镜头y", order = 26, position = { x = 620, y = 260 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "3b885530-ccce-414f-9610-11f4db23c0ec", is_global = true, name = "镜头x", order = 25, position = { x = 620, y = 180 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "41e6dc01-4b65-408f-b73c-1db5177c90a2", is_global = true, name = "TY", order = 24, position = { x = 620, y = 100 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "46362f3a-7c20-476d-a261-a4145b692581", is_global = true, name = "t", order = 46, position = { x = 764, y = 87 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "47ba0e4f-4441-4689-9ac9-08e0a13079ef", is_global = true, name = "VERTEX X", order = 10, position = { x = 220, y = 154 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "4b34cac7-8ec1-4ebc-bf24-2cbf677bfa5e", is_global = true, name = "Gdot", order = 31, position = { x = 657, y = 154 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "4b5cdacf-67fe-4fc0-b6d0-fc1644d00e47", is_global = true, name = "V", order = 38, position = { x = 764, y = 87 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "5156a784-88eb-4bda-910f-b3a109e1190c", is_global = true, name = "Cmax", order = 33, position = { x = 657, y = 288 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "5516c603-b6a4-40e1-8546-ef5ad0db8821", is_global = true, name = "S", order = 37, position = { x = 764, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "560bdc6b-879f-4c01-b379-7979016f2b58", is_global = true, name = "tir5", order = 4, position = { x = 20, y = 288 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "61369190-900c-44e8-9531-ace3909ab712", is_global = true, name = "x1", order = 39, position = { x = 764, y = 154 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "691ec139-2fe8-4f38-a4e0-cc34ca62f213", is_global = true, name = "镜头y方向", order = 29, position = { x = 657, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "6f5557c9-de68-4253-a77e-5a9a12230854", is_global = true, name = "tir2", order = 1, position = { x = 20, y = 87 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "74b2661f-17f8-4118-96ca-a59dc794a0ba", is_global = true, name = "镜头z", order = 27, position = { x = 620, y = 340 }, scale = 1, style = "default", type = "any", value = -200, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "821c1310-6217-493d-99e8-71f9e0189974", is_global = true, name = "tir4", order = 3, position = { x = 20, y = 221 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "8276295d-4e63-432f-9a3e-e4d77a107cea", is_global = true, name = "tir3", order = 2, position = { x = 20, y = 154 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "835594a0-950d-4fc7-8aaf-7553259ea6df", is_global = true, name = "y3", order = 44, position = { x = 764, y = 490 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "849f244c-b61f-47d2-a04e-700702223585", is_global = true, name = "VERTEX Y", order = 11, position = { x = 220, y = 221 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "9055c2fd-e6ef-4991-b71a-1c8d1dc72e6d", is_global = true, name = "VERTEX Y1", order = 14, position = { x = 220, y = 423 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "9360e3a4-8b39-4755-9d15-936b8d005f6d", is_global = true, name = "Cmin", order = 34, position = { x = 657, y = 356 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "96d4a909-41d2-4e75-b5c4-1a898c04a66e", is_global = true, name = "Rdot", order = 30, position = { x = 657, y = 87 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "98a2e534-befe-4ef8-b22f-b57daf53c5b0", is_global = true, name = "clip", order = 22, position = { x = 420, y = 436 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "9d2de14b-7f88-4db8-873d-5d92e657e347", is_global = true, name = "l", order = 9, position = { x = 220, y = 87 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "aeb8dc80-c509-46de-b5dd-64d74ef8fa70", is_global = true, name = "x2", order = 41, position = { x = 764, y = 288 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "b4edaba7-e45a-4156-a31b-bb49471b96e9", is_global = true, name = "tir1", order = 0, position = { x = 20, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "b6730dd0-393e-4481-9ba7-ed35d6644d49", is_global = true, name = "VERTEX Z2", order = 18, position = { x = 420, y = 154 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "c29f1d38-54e3-42b3-8576-0a26918e1ba5", is_global = true, name = "VERTEX X1", order = 13, position = { x = 220, y = 356 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "c51270ae-cf74-496a-9359-09a7a2797311", is_global = true, name = "VERTEX Z3", order = 21, position = { x = 420, y = 356 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "ccd4ae8d-e3d8-4917-a47b-c8208844c946", is_global = true, name = "VERTEX Z", order = 12, position = { x = 220, y = 288 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "eb40bd8b-38d9-4ece-b0d3-c3a7af0e0ee0", is_global = true, name = "tir8", order = 7, position = { x = 20, y = 490 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "f7ad614d-b070-41ac-924f-da04fe855bc4", is_global = true, name = "tir7", order = 6, position = { x = 20, y = 423 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "fbcd173d-58eb-4e20-a0ca-53ad103ecb32", is_global = true, name = "VERTEX X3", order = 19, position = { x = 420, y = 221 }, scale = 1, style = "default", type = "any", value = 0, visible = false } }
M.screens = { { id = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a", name = "背景", screenName = "屏幕", style_index = 2, styles = { "c038331a-e7b3-4fb2-abbc-ca240a547846", "530f94a0-87f6-4275-aa0e-38c766102ff4" }, visible = true } }
M.cur_scene = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a"
M.actors = { { id = "efb8e9a8-dae5-445a-ac22-7efdf92735a0", is_global = true, name = "新角色", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "cbc5cc76-4d0f-4435-b027-733e8647e92d", "075ea099-1b45-46e9-a17a-8c1d83911d66" }, visible = true, x = 0, y = 0 }, { id = "18f19b66-03a2-459a-ba2c-de3102dafb29", is_global = true, name = "新角色1", order = 2, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "30720b21-d735-48b7-abb9-a24e455f6b2e" }, visible = true, x = 0, y = 0 }, { id = "14cd84e7-e041-48be-87b5-092e0bb71a45", is_global = true, name = "Texture Triangle", order = 3, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 2, styles = { "69f4a0a9-661a-4cfc-a5ca-638841ddf0c9", "21228633-e785-4fb1-ac91-ce8ce80e886c", "a985fdad-3b58-4863-8b4e-c95279bbf331", "5057b542-d47c-4b00-b0e6-fa090d6f45f0", "e85f8c20-6687-4260-8893-ccd94f8748f0" }, visible = false, x = 0, y = 0 } }
M.assets_dir = "works"
M.assets = { ["075ea099-1b45-46e9-a17a-8c1d83911d66"] = { adaption = 0, center = { x = 0, y = 0 }, file = "assets/075ea099-1b45-46e9-a17a-8c1d83911d66.png", id = "075ea099-1b45-46e9-a17a-8c1d83911d66", name = "", styleType = nil, url = "https://creation.codemao.cn/922/user-files/Fhkz1PNfBsdsaclAruTTOLum1f6c.svg" }, ["21228633-e785-4fb1-ac91-ce8ce80e886c"] = { adaption = nil, center = nil, file = "assets/21228633-e785-4fb1-ac91-ce8ce80e886c.png", id = "21228633-e785-4fb1-ac91-ce8ce80e886c", name = "Texture Triangle", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/FgZ8ZTWqaqI2W-a9zNKcoB39Kqgl?imageView2/0/format/png" }, ["30720b21-d735-48b7-abb9-a24e455f6b2e"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/30720b21-d735-48b7-abb9-a24e455f6b2e.png", id = "30720b21-d735-48b7-abb9-a24e455f6b2e", name = "新角色1", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["5057b542-d47c-4b00-b0e6-fa090d6f45f0"] = { adaption = nil, center = nil, file = "assets/5057b542-d47c-4b00-b0e6-fa090d6f45f0.png", id = "5057b542-d47c-4b00-b0e6-fa090d6f45f0", name = "Texture Triangle", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/Fu52WkwFqMDQi_ZtZnLg7w3GlKFf?imageView2/0/format/png" }, ["530f94a0-87f6-4275-aa0e-38c766102ff4"] = { adaption = 0, center = { x = -23.329724009625, y = -91.339799576376 }, file = "assets/530f94a0-87f6-4275-aa0e-38c766102ff4.png", id = "530f94a0-87f6-4275-aa0e-38c766102ff4", name = "", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FqNXdsYynu4NaDhnmEWMUO7cb8ix.svg" }, ["69f4a0a9-661a-4cfc-a5ca-638841ddf0c9"] = { adaption = nil, center = nil, file = "assets/69f4a0a9-661a-4cfc-a5ca-638841ddf0c9.png", id = "69f4a0a9-661a-4cfc-a5ca-638841ddf0c9", name = "Texture Triangle", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/FpOksz2-wBJ_GYaf65baQ4PQQ_pg?imageView2/0/format/png" }, ["a985fdad-3b58-4863-8b4e-c95279bbf331"] = { adaption = nil, center = nil, file = "assets/a985fdad-3b58-4863-8b4e-c95279bbf331.png", id = "a985fdad-3b58-4863-8b4e-c95279bbf331", name = "Texture Triangle", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/Fs2Jznz_V2His7DcrT6rmGs18dct?imageView2/0/format/png" }, ["c038331a-e7b3-4fb2-abbc-ca240a547846"] = { adaption = nil, center = nil, file = "assets/c038331a-e7b3-4fb2-abbc-ca240a547846.png", id = "c038331a-e7b3-4fb2-abbc-ca240a547846", name = "背景", styleType = nil, url = "https://static.codemao.cn/neko/img_stage_defult_landscape.png" }, ["cbc5cc76-4d0f-4435-b027-733e8647e92d"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/cbc5cc76-4d0f-4435-b027-733e8647e92d.png", id = "cbc5cc76-4d0f-4435-b027-733e8647e92d", name = "新角色", styleType = nil, url = "https://static.codemao.cn/neko/painter/img/emptyFrame.png" }, ["e85f8c20-6687-4260-8893-ccd94f8748f0"] = { adaption = nil, center = nil, file = "assets/e85f8c20-6687-4260-8893-ccd94f8748f0.png", id = "e85f8c20-6687-4260-8893-ccd94f8748f0", name = "Texture Triangle", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/Fu79B9yLWGJF7PAeOp8Pq7Pk-YQQ?imageView2/0/format/png" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_700824a5_44a8_4d03_a7e8_aa95d87e9b2a = ents["700824a5-44a8-4d03-a7e8-aa95d87e9b2a"]
  local e_efb8e9a8_dae5_445a_ac22_7efdf92735a0 = ents["efb8e9a8-dae5-445a-ac22-7efdf92735a0"]
  local e_18f19b66_03a2_459a_ba2c_de3102dafb29 = ents["18f19b66-03a2-459a-ba2c-de3102dafb29"]
  local e_14cd84e7_e041_48be_87b5_092e0bb71a45 = ents["14cd84e7-e041-48be-87b5-092e0bb71a45"]
  -- -------- 角色 新角色 --------
  rt.on(e_efb8e9a8_dae5_445a_ac22_7efdf92735a0, "on_running_group_activated", {}, function(th, self)
  end)
  -- -------- 角色 Texture Triangle --------
  rt.on(e_14cd84e7_e041_48be_87b5_092e0bb71a45, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["check_key"](self, __CONST[62], th)) then
          f["change_variables"](self, __CONST[63], th)
        end
        if V.bool(f["check_key"](self, __CONST[64], th)) then
          f["change_variables"](self, __CONST[65], th)
        end
        if V.bool(f["check_key"](self, __CONST[66], th)) then
          f["change_variables"](self, __CONST[67], th)
        end
        if V.bool(f["check_key"](self, __CONST[68], th)) then
          f["change_variables"](self, __CONST[69], th)
        end
        if V.bool(f["check_key"](self, __CONST[70], th)) then
          f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = 5, B = f["math_trig"](self, { num = f["variables_get"](self, __CONST[38], th), type = "cos" }, th), type = "multiply" }, th), variable = "74b2661f-17f8-4118-96ca-a59dc794a0ba" }, th)
          f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = 5, B = f["math_trig"](self, { num = f["variables_get"](self, __CONST[38], th), type = "sin" }, th), type = "multiply" }, th), variable = "3b885530-ccce-414f-9610-11f4db23c0ec" }, th)
        end
        if V.bool(f["check_key"](self, __CONST[71], th)) then
          f["change_variables"](self, { method = "decrease", value = f["math_arithmetic"](self, { A = 5, B = f["math_trig"](self, { num = f["variables_get"](self, __CONST[38], th), type = "cos" }, th), type = "multiply" }, th), variable = "74b2661f-17f8-4118-96ca-a59dc794a0ba" }, th)
          f["change_variables"](self, { method = "decrease", value = f["math_arithmetic"](self, { A = 5, B = f["math_trig"](self, { num = f["variables_get"](self, __CONST[38], th), type = "sin" }, th), type = "multiply" }, th), variable = "3b885530-ccce-414f-9610-11f4db23c0ec" }, th)
        end
        if V.bool(f["check_key"](self, __CONST[72], th)) then
          f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = -5, B = f["math_trig"](self, { num = f["variables_get"](self, __CONST[38], th), type = "sin" }, th), type = "multiply" }, th), variable = "74b2661f-17f8-4118-96ca-a59dc794a0ba" }, th)
          f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = 5, B = f["math_trig"](self, { num = f["variables_get"](self, __CONST[38], th), type = "cos" }, th), type = "multiply" }, th), variable = "3b885530-ccce-414f-9610-11f4db23c0ec" }, th)
        end
        if V.bool(f["check_key"](self, __CONST[73], th)) then
          f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = 5, B = f["math_trig"](self, { num = f["variables_get"](self, __CONST[38], th), type = "sin" }, th), type = "multiply" }, th), variable = "74b2661f-17f8-4118-96ca-a59dc794a0ba" }, th)
          f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = -5, B = f["math_trig"](self, { num = f["variables_get"](self, __CONST[38], th), type = "cos" }, th), type = "multiply" }, th), variable = "3b885530-ccce-414f-9610-11f4db23c0ec" }, th)
        end
        if V.bool(f["check_key"](self, __CONST[74], th)) then
          f["change_variables"](self, __CONST[75], th)
        end
        if V.bool(f["check_key"](self, __CONST[76], th)) then
          f["change_variables"](self, __CONST[77], th)
        end
        f["clear_drawing"](self, {}, th)
        proc_b1171717_bd08_4965_b1ab_7409be300178(th, self, -100, -100, -100, 100, -100, -100, -100, -100, 100, 0, f["variables_get"](self, __CONST[35], th), f["variables_get"](self, __CONST[36], th), f["variables_get"](self, __CONST[37], th), 250, f["variables_get"](self, __CONST[39], th), f["variables_get"](self, __CONST[38], th), 1, 255, 0, 0, 0)
        proc_b1171717_bd08_4965_b1ab_7409be300178(th, self, 100, -100, 100, 100, -100, -100, -100, -100, 100, 0, f["variables_get"](self, __CONST[35], th), f["variables_get"](self, __CONST[36], th), f["variables_get"](self, __CONST[37], th), 250, f["variables_get"](self, __CONST[39], th), f["variables_get"](self, __CONST[38], th), 1, 255, 0, 0, 0)
        proc_b1171717_bd08_4965_b1ab_7409be300178(th, self, 200, -100, -100, 400, -100, -100, 200, -100, 100, 0, f["variables_get"](self, __CONST[35], th), f["variables_get"](self, __CONST[36], th), f["variables_get"](self, __CONST[37], th), 250, f["variables_get"](self, __CONST[39], th), f["variables_get"](self, __CONST[38], th), 1, 0, 255, 0, 0)
        proc_b1171717_bd08_4965_b1ab_7409be300178(th, self, 400, -100, 100, 400, -100, -100, 200, -100, 100, 0, f["variables_get"](self, __CONST[35], th), f["variables_get"](self, __CONST[36], th), f["variables_get"](self, __CONST[37], th), 250, f["variables_get"](self, __CONST[39], th), f["variables_get"](self, __CONST[38], th), 1, 0, 255, 0, 0)
        proc_b1171717_bd08_4965_b1ab_7409be300178(th, self, 500, -100, -100, 700, -100, -100, 500, -100, 100, 0, f["variables_get"](self, __CONST[35], th), f["variables_get"](self, __CONST[36], th), f["variables_get"](self, __CONST[37], th), 250, f["variables_get"](self, __CONST[39], th), f["variables_get"](self, __CONST[38], th), 1, 0, 0, 255, 0)
        proc_b1171717_bd08_4965_b1ab_7409be300178(th, self, 700, -100, 100, 700, -100, -100, 500, -100, 100, 0, f["variables_get"](self, __CONST[35], th), f["variables_get"](self, __CONST[36], th), f["variables_get"](self, __CONST[37], th), 250, f["variables_get"](self, __CONST[39], th), f["variables_get"](self, __CONST[38], th), 1, 0, 0, 255, 0)
        proc_b1171717_bd08_4965_b1ab_7409be300178(th, self, -100, -100, 200, 100, -100, 200, -100, -100, 400, 0, f["variables_get"](self, __CONST[35], th), f["variables_get"](self, __CONST[36], th), f["variables_get"](self, __CONST[37], th), 250, f["variables_get"](self, __CONST[39], th), f["variables_get"](self, __CONST[38], th), 1, 255, 0, 0, 127.5)
        proc_b1171717_bd08_4965_b1ab_7409be300178(th, self, 100, -100, 400, 100, -100, 200, -100, -100, 400, 0, f["variables_get"](self, __CONST[35], th), f["variables_get"](self, __CONST[36], th), f["variables_get"](self, __CONST[37], th), 250, f["variables_get"](self, __CONST[39], th), f["variables_get"](self, __CONST[38], th), 1, 255, 0, 0, 127.5)
        proc_b1171717_bd08_4965_b1ab_7409be300178(th, self, 200, -100, 200, 400, -100, 200, 200, -100, 400, 0, f["variables_get"](self, __CONST[35], th), f["variables_get"](self, __CONST[36], th), f["variables_get"](self, __CONST[37], th), 250, f["variables_get"](self, __CONST[39], th), f["variables_get"](self, __CONST[38], th), 1, 0, 255, 0, 127.5)
        proc_b1171717_bd08_4965_b1ab_7409be300178(th, self, 400, -100, 400, 400, -100, 200, 200, -100, 400, 0, f["variables_get"](self, __CONST[35], th), f["variables_get"](self, __CONST[36], th), f["variables_get"](self, __CONST[37], th), 250, f["variables_get"](self, __CONST[39], th), f["variables_get"](self, __CONST[38], th), 1, 0, 255, 0, 127.5)
        proc_b1171717_bd08_4965_b1ab_7409be300178(th, self, 500, -100, 200, 700, -100, 200, 500, -100, 400, 0, f["variables_get"](self, __CONST[35], th), f["variables_get"](self, __CONST[36], th), f["variables_get"](self, __CONST[37], th), 250, f["variables_get"](self, __CONST[39], th), f["variables_get"](self, __CONST[38], th), 1, 0, 0, 255, 127.5)
        proc_b1171717_bd08_4965_b1ab_7409be300178(th, self, 700, -100, 400, 700, -100, 200, 500, -100, 400, 0, f["variables_get"](self, __CONST[35], th), f["variables_get"](self, __CONST[36], th), f["variables_get"](self, __CONST[37], th), 250, f["variables_get"](self, __CONST[39], th), f["variables_get"](self, __CONST[38], th), 1, 0, 0, 255, 127.5)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_14cd84e7_e041_48be_87b5_092e0bb71a45, "on_running_group_activated", {}, function(th, self)
      while true do
        f["variables_set"](self, { value = f["get_time"](self, __CONST[78], th), variable = "46362f3a-7c20-476d-a261-a4145b692581" }, th)
        while true do
          if f["logic_compare"](self, { A = f["variables_get"](self, __CONST[79], th), B = f["get_time"](self, __CONST[78], th), OP = "NEQ" }, th) then break end
          f["change_variables"](self, __CONST[80], th)
          if th:iter_n() then break end
        end
        f["variables_set"](self, { value = f["variables_get"](self, __CONST[81], th), variable = "2413e681-ff8c-4a3b-98fc-ebeee8d84ca3" }, th)
        f["variables_set"](self, __CONST[82], th)
        if th:iter_n() then break end
      end
  end)
end

M.requires = {
  "change_variables",
  "check_key",
  "clear_drawing",
  "get_time",
  "image_stamp",
  "list_item",
  "logic_compare",
  "logic_operation",
  "math_arithmetic",
  "math_function",
  "math_modulo",
  "math_trig",
  "script_variables",
  "script_variables_value",
  "self_move_to",
  "self_pen_down",
  "self_point_towards",
  "self_set_pen_color_property",
  "self_set_pen_size",
  "set_width_height_scale",
  "temporary_list",
  "variables_get",
  "variables_set",
}
return M

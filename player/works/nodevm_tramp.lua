-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：Node VM v3 - 全猫最强解释器   version=0.27.4
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用

-- ===== 自定义积木（过程）=====
local proc_00052c87_d103_4c38_b378_685e8251a501, proc_08dc6ce9_a84d_40cb_a208_6f1873097115, proc_093d9411_7542_4203_b427_550056e1b13e, proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, proc_100d961a_9778_44ef_b6c3_dccf5b32df15, proc_20fea0b0_d162_4786_b754_dbaac584913c, proc_25ce3e3b_60fa_48f5_9d4c_b5c54fbd1b74, proc_280d939c_ebff_42fc_bc51_2fa4bd23ebef, proc_32f3c134_9a04_44e1_a8a5_2339303cc1b1, proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, proc_569f9907_450b_496d_af3e_e5a6f9b700eb, proc_5e4818da_3fdb_4718_9ba7_0a58a1d41b0d, proc_5f70c810_67eb_4c43_a508_053c464fa86d, proc_61d190fb_f81a_4dbe_83ec_f4b19e214a3b, proc_636b3378_66f6_4cef_9502_9dc7953af847, proc_6be6ac61_9b92_4bba_8470_e6a31431a34d, proc_6cbcb627_87ad_413d_a95d_943e43d0f90d, proc_71540544_dcc5_47b4_8f23_4d49c5e9fd45, proc_71cfe477_3ca4_4eb3_8c6e_1a798f19938c, proc_79bd69fe_5e2b_47d3_8d8a_06149e3029b7, proc_803f4f62_01e2_4370_b5e6_88cd6ad88290, proc_8836e0fd_6d26_4479_9180_8424267a294e, proc_8ad455ed_0ad7_4213_aa68_9d8ffe25d346, proc_9186745c_97b7_4607_9dae_9af46b3cd7d2, proc_923e1ade_6e8f_4d2b_8d72_0bee849299c8, proc_9972f10d_437e_4895_8ab5_b984b7c346ab, proc_a4c40a96_8fae_4226_9ec9_b9b9751ba6d9, proc_a621de99_c663_495a_bb73_539e94b3a042, proc_a75bfa6d_91ec_4b59_82e1_0a98ecdb705e, proc_ac536656_1aae_4712_89a4_5afac85d9f8e, proc_b3d1e130_56d4_40d9_95de_4c7396b11b16, proc_b70d629c_789d_4168_b10b_afeb318088e6, proc_b9858f0c_554f_45ef_a324_ba5411bc14ad, proc_b9ce9990_1b77_4af5_9d76_99be5ee42bfa, proc_ba4fe1c3_fa6d_4c6d_9ae3_9924083a8b0a, proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, proc_bfd7e9dd_7ad6_46e2_89c2_9d081462c62c, proc_c50c29e1_f1fd_4464_a845_7295a1078080, proc_c5bc63b5_725d_463e_856b_0ec83f60ae9f, proc_c60a7cae_450c_4d26_8c44_f1144792d722, proc_cb5a8bce_0c73_448c_ac32_fbb2f7e82149, proc_d4a50d54_6168_41f6_a527_491c49c608ef, proc_d920a649_112b_48f8_a825_4d0498684265, proc_da9cde44_c87a_45dd_8679_74c712c8300a, proc_db4375fd_d4a6_4c57_b430_333603f7ba36, proc_dfb1a1a9_094c_4010_a210_76cf972162e9, proc_e115ca8b_53f0_4844_97a3_a15141c0a242, proc_ea2840b0_96b7_4a3c_95e7_bff42dde31b0, proc_ee7e471d_cfb7_44a8_9328_40c0e6b606f3, proc_f07d943c_fa58_4638_9635_a44accb55f4f, proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, proc_f1a134be_67a9_45c8_823e_988d84c3097a, proc_fdff4a26_8852_4abb_9cb4_ab94e5d7a174

proc_00052c87_d103_4c38_b378_685e8251a501 = function(th, self, p_env, p_n, p_v)
  -- 过程「704f9ee0-391a-4723-81d1-842f1c6b0edb」 id=00052c87-d103-4c38-b378-685e8251a501
  f["script_variables"](self, { PARAMS0 = nil, name = "varinenvpos" }, th)
  f["variables_set"](self, { value = f["list_index_of"](self, { list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th), list_index = 1 }, th), list_item_value = p_n }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"varinenvpos\"}" }, th)
  if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "varinenvpos" }, th), B = 0, OP = "GT" }, th)) then
    f["replace_list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th), list_index = 2 }, th), list_index = f["script_variables_value"](self, { TEXT = "varinenvpos" }, th), list_item_value = p_v }, th)
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  f["list_append"](self, { list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th), list_index = 1 }, th), list_item_value = p_n }, th)
  f["list_append"](self, { list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th), list_index = 2 }, th), list_item_value = p_v }, th)
  return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
end

proc_08dc6ce9_a84d_40cb_a208_6f1873097115 = function(th, self, p_tokens, p_global, p_env)
  -- 过程「8a17f8ab-8516-406d-be1b-35dd82c033f9」 id=08dc6ce9-a84d-40cb-a208-6f1873097115
  f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_5f70c810_67eb_4c43_a508_053c464fa86d, self, (th:call_proc(proc_71540544_dcc5_47b4_8f23_4d49c5e9fd45, self, p_tokens, p_global, f["temporary_list"](self, {}, th))))) }, th)
  th:warp_enter()
  while true do
    if false then break end
    if V.bool(f["variables_get"](self, { variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)) then
      th:warp_exit()
      return 0
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "LeftParen", OP = "EQ" }, th)) then
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
      f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_25ce3e3b_60fa_48f5_9d4c_b5c54fbd1b74, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "RightParen", nil)))
      f["replace_list_item"](self, { item = "any", list = p_env, list_index = 1, list_item_value = f["temporary_list"](self, { ITEM0 = "call", ITEM1 = f["list_item"](self, { item = "last", list = p_env }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th) }, th) }, th)
    elseif V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "LeftSquare", OP = "EQ" }, th)) then
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
      f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "RightSquare", nil)))
      f["replace_list_item"](self, { item = "any", list = p_env, list_index = 1, list_item_value = f["temporary_list"](self, { ITEM0 = "index", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), ITEM2 = f["list_item"](self, { item = "last", list = p_env }, th) }, th) }, th)
    elseif V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Dot", OP = "EQ" }, th)) then
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
      f["list_append"](self, { list = p_env, list_item_value = f["temporary_list"](self, { ITEM0 = "string", ITEM1 = f["list_item"](self, { item = "any", list = (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Identifier", nil)), list_index = 2 }, th) }, th) }, th)
      f["replace_list_item"](self, { item = "any", list = p_env, list_index = 1, list_item_value = f["temporary_list"](self, { ITEM0 = "index", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), ITEM2 = f["list_item"](self, { item = "last", list = p_env }, th) }, th) }, th)
    else
      break
    end
    if th:iter_w() then break end
  end
  th:warp_exit()
  return f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th)
end

proc_093d9411_7542_4203_b427_550056e1b13e = function(th, self, p_tokens, p_global, p_env)
  -- 过程「6737f722-cff6-418e-9bea-dd22ad282983」 id=093d9411-7542-4203-b427-550056e1b13e
  f["list_append"](self, { list = p_env, list_item_value = f["temporary_list"](self, {}, th) }, th)
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "RightParen", OP = "EQ" }, th)) then
    return f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th)
  end
  th:warp_enter()
  while true do
    if false then break end
    if V.bool(f["variables_get"](self, { variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)) then
      th:warp_exit()
      return 0
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Spread", OP = "EQ" }, th)) then
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
      f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "identifier", ITEM1 = f["list_item"](self, { item = "any", list = (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Identifier", nil)), list_index = 2 }, th), ITEM2 = f["temporary_list"](self, {}, th), ITEM3 = true }, th) }, th)
      break
    end
    f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "identifier", ITEM1 = f["list_item"](self, { item = "any", list = (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Identifier", nil)), list_index = 2 }, th) }, th) }, th)
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Assign", OP = "EQ" }, th)) then
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
      f["list_append"](self, { list = f["list_item"](self, { item = "last", list = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th) }, th), list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    else
      f["list_append"](self, { list = f["list_item"](self, { item = "last", list = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th) }, th), list_item_value = f["temporary_list"](self, {}, th) }, th)
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Comma", OP = "EQ" }, th)) then
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    else
      break
    end
    if th:iter_w() then break end
  end
  th:warp_exit()
  return f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th)
end

proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37 = function(th, self, p_tokens, p_global, p_type)
  -- 过程「cf405328-98ed-482e-bea7-327a5c49c975」 id=09f58d51-06fa-49c8-9fa9-f41de0f76f37
  f["script_variables"](self, { PARAMS0 = nil, name = "advance" }, th)
  f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = p_tokens, list_index = f["list_item"](self, { item = "any", list = p_global, list_index = 1 }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"advance\"}" }, th)
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, { TEXT = "advance" }, th), list_index = 1 }, th), B = p_type, OP = "EQ" }, th)) then
    f["replace_list_item"](self, { item = "any", list = p_global, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_global, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
    return f["script_variables_value"](self, { TEXT = "advance" }, th)
  end
  th:call_proc(proc_20fea0b0_d162_4786_b754_dbaac584913c, self, f["text_join"](self, { ADD0 = "需要\"", ADD1 = p_type, ADD2 = "\"，实际得到\"", ADD3 = f["script_variables_value"](self, { TEXT = "advance" }, th), ADD4 = "\"" }, th), f["script_variables_value"](self, { TEXT = "advance" }, th))
  return 0
end

proc_100d961a_9778_44ef_b6c3_dccf5b32df15 = function(th, self, p_console, p_i)
  -- 过程「487e5ef9-40c6-4774-ade8-c8dc4e51e06e」 id=100d961a-9778-44ef-b6c3-dccf5b32df15
  if V.bool(f["logic_compare"](self, { A = p_i, B = f["list_length"](self, { list = p_console }, th), OP = "GT" }, th)) then
    return nil
  end
  f["stamp"](self, { align = "left", size = 18, text = f["list_item"](self, { item = "any", list = p_console, list_index = p_i }, th) }, th)
  f["self_change_coordinate_y"](self, { increase = "increase", value = -22 }, th)
  th:call_proc(proc_100d961a_9778_44ef_b6c3_dccf5b32df15, self, p_console, f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th))
end

proc_20fea0b0_d162_4786_b754_dbaac584913c = function(th, self, p_msg, p_token)
  -- 过程「b22a20be-72ca-4dc1-8b8f-ef61fc38b649」 id=20fea0b0-d162-4786-b754-dbaac584913c
  f["variables_set"](self, { value = f["temporary_list"](self, { ITEM0 = "dict", ITEM1 = f["temporary_list"](self, { ITEM0 = f["temporary_list"](self, { ITEM0 = "type", ITEM1 = "msg" }, th), ITEM1 = f["temporary_list"](self, { ITEM0 = "SystemError", ITEM1 = f["text_join"](self, { ADD0 = "", ADD1 = p_msg, ADD2 = "，位于行", ADD3 = f["list_item"](self, { item = "any", list = p_token, list_index = 3 }, th), ADD4 = "，列", ADD5 = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_token, list_index = 4 }, th), B = f["text_length"](self, { text = f["variables_get"](self, { variable = "4819da5c-3e70-45b5-935e-a049951d72b2" }, th) }, th), type = "minus" }, th) }, th) }, th) }, th) }, th), variable = "06f6cc9b-ad2e-44e3-bea6-e4b25cb4cd99" }, th)
  f["variables_set"](self, { value = true, variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)
end

proc_25ce3e3b_60fa_48f5_9d4c_b5c54fbd1b74 = function(th, self, p_tokens, p_global, p_env)
  -- 过程「84dcd644-a634-450f-86a0-51b24a1c4243」 id=25ce3e3b-60fa-48f5-9d4c-b5c54fbd1b74
  f["list_append"](self, { list = p_env, list_item_value = f["temporary_list"](self, {}, th) }, th)
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "RightParen", OP = "EQ" }, th)) then
    return f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th)
  end
  th:warp_enter()
  while true do
    if false then break end
    if V.bool(f["variables_get"](self, { variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)) then
      th:warp_exit()
      return 0
    end
    f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Comma", OP = "EQ" }, th)) then
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    else
      break
    end
    if th:iter_w() then break end
  end
  th:warp_exit()
  return f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th)
end

proc_280d939c_ebff_42fc_bc51_2fa4bd23ebef = function(th, self, p_tokens, p_global, p_env)
  -- 过程「d46ca2ae-6899-4bad-a712-6099cb189f19」 id=280d939c-ebff-42fc-bc51-2fa4bd23ebef
  if V.bool(f["variables_get"](self, { variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)) then
    return 0
  end
  th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Function", nil)))
  th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "LeftParen", nil)))
  f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_093d9411_7542_4203_b427_550056e1b13e, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
  th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "RightParen", nil)))
  f["list_append"](self, { list = p_env, list_item_value = f["temporary_list"](self, {}, th) }, th)
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Use", OP = "EQ" }, th)) then
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    f["replace_list_item"](self, { item = "any", list = p_env, list_index = 2, list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
  end
  f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_b3d1e130_56d4_40d9_95de_4c7396b11b16, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
  if V.bool(f["logic_compare"](self, { A = f["list_length"](self, { list = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th) }, th), B = 0, OP = "GT" }, th)) then
    return f["temporary_list"](self, { ITEM0 = "function", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_env, list_index = 3 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th) }, th)
  end
  return f["temporary_list"](self, { ITEM0 = "function", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_env, list_index = 3 }, th) }, th)
end

proc_32f3c134_9a04_44e1_a8a5_2339303cc1b1 = function(th, self, p_t)
  -- 过程「74f7280b-f9a4-4ac4-8ced-f4f8b8569118」 id=32f3c134-9a04-44e1-a8a5-2339303cc1b1
  f["script_variables"](self, { PARAMS0 = nil, name = "opi" }, th)
  f["variables_set"](self, { value = f["list_index_of"](self, { list = f["variables_get"](self, { variable = "c9d9feef-dd94-4174-b7da-d8e441b74b27" }, th), list_item_value = p_t }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"opi\"}" }, th)
  if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "opi" }, th), B = 0, OP = "EQ" }, th)) then
    return 0
  end
  return f["list_item"](self, { item = "any", list = f["variables_get"](self, { variable = "f5a79007-362b-4620-bee2-efd4f3427d7a" }, th), list_index = f["script_variables_value"](self, { TEXT = "opi" }, th) }, th)
end

proc_47888fa6_5576_45a3_a4db_bd570c2a93b6 = function(th, self, p_tokens, p_global)
  -- 过程「cf405328-98ed-482e-bea7-327a5c49c975」 id=47888fa6-5576-45a3-a4db-bd570c2a93b6
  f["script_variables"](self, { PARAMS0 = nil, name = "advance" }, th)
  f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = p_tokens, list_index = f["list_item"](self, { item = "any", list = p_global, list_index = 1 }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"advance\"}" }, th)
  f["replace_list_item"](self, { item = "any", list = p_global, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_global, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
  return f["script_variables_value"](self, { TEXT = "advance" }, th)
end

proc_569f9907_450b_496d_af3e_e5a6f9b700eb = function(th, self, p_node, p_env, p_r, p_i)
  -- 过程「2234e4dd-9de4-489e-8dcf-4ca9fcc305a5」 id=569f9907-450b-496d-af3e-e5a6f9b700eb
  if V.bool(f["logic_compare"](self, { A = p_i, B = f["list_length"](self, { list = p_node }, th), OP = "GT" }, th)) then
    return p_r
  end
  f["list_append"](self, { list = p_r, list_item_value = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = p_i }, th), p_env, f["temporary_list"](self, {}, th))) }, th)
  return (th:call_proc(proc_569f9907_450b_496d_af3e_e5a6f9b700eb, self, p_node, p_env, p_r, f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th)))
end

proc_5e4818da_3fdb_4718_9ba7_0a58a1d41b0d = function(th, self, p_ident)
  -- 过程「0ac5a1a6-d831-4507-b843-622b2b83b8f5」 id=5e4818da-3fdb-4718-9ba7-0a58a1d41b0d
  f["script_variables"](self, { PARAMS0 = nil, name = "keywordList" }, th)
  f["variables_set"](self, { value = f["temporary_list"](self, { ITEM0 = "var", ITEM1 = "false", ITEM10 = "for", ITEM11 = "break", ITEM12 = "continue", ITEM13 = "throw", ITEM14 = "environ", ITEM15 = "use", ITEM16 = "NaN", ITEM2 = "function", ITEM3 = "if", ITEM4 = "while", ITEM5 = "return", ITEM6 = "try", ITEM7 = "catch", ITEM8 = "else", ITEM9 = "true" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"keywordList\"}" }, th)
  if V.bool(f["list_is_exist"](self, { list = f["script_variables_value"](self, { TEXT = "keywordList" }, th), list_item_value = p_ident }, th)) then
    return f["list_item"](self, { item = "any", list = f["temporary_list"](self, { ITEM0 = "Var", ITEM1 = "False", ITEM10 = "For", ITEM11 = "Break", ITEM12 = "Continue", ITEM13 = "Throw", ITEM14 = "Environ", ITEM15 = "Use", ITEM16 = "NaN", ITEM2 = "Function", ITEM3 = "If", ITEM4 = "While", ITEM5 = "Return", ITEM6 = "Try", ITEM7 = "Catch", ITEM8 = "Else", ITEM9 = "True" }, th), list_index = f["list_index_of"](self, { list = f["script_variables_value"](self, { TEXT = "keywordList" }, th), list_item_value = p_ident }, th) }, th)
  end
  return "Identifier"
end

proc_5f70c810_67eb_4c43_a508_053c464fa86d = function(th, self, p_token)
  -- 过程「be23aa9b-7548-44a6-938c-5fb9577ea35e」 id=5f70c810-67eb-4c43-a508-053c464fa86d
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_token, list_index = 1 }, th), B = "identifier", OP = "EQ" }, th)) then
    return f["temporary_list"](self, { ITEM0 = "getVar", ITEM1 = p_token }, th)
  end
  return p_token
end

proc_61d190fb_f81a_4dbe_83ec_f4b19e214a3b = function(th, self, p_char)
  -- 过程「f08b3144-f5f8-4b38-acb2-6a8b81d2fdb5」 id=61d190fb-f81a-4dbe-83ec-f4b19e214a3b
  return f["logic_operation"](self, { A = f["logic_compare"](self, { A = 0, B = p_char, OP = "LTE" }, th), B = f["logic_compare"](self, { A = p_char, B = 9, OP = "LTE" }, th), type = "and" }, th)
end

proc_636b3378_66f6_4cef_9502_9dc7953af847 = function(th, self, p_code, p_v)
  -- 过程「c81cfb1e-1af6-4a33-9778-60636a0844c9」 id=636b3378-66f6-4cef-9502-9dc7953af847
  f["script_variables"](self, { PARAMS0 = nil, name = "haspoint" }, th)
  f["variables_set"](self, { value = false, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"haspoint\"}" }, th)
  th:warp_enter()
  while true do
    if f["logic_negate"](self, { logic = f["logic_operation"](self, { A = (th:call_proc(proc_61d190fb_f81a_4dbe_83ec_f4b19e214a3b, self, f["list_item"](self, { item = "any", list = p_code, list_index = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th) }, th))), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th) }, th), B = ".", OP = "EQ" }, th), type = "or" }, th) }, th) then break end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th) }, th), B = ".", OP = "EQ" }, th)) then
      if V.bool(f["script_variables_value"](self, { TEXT = "haspoint" }, th)) then
        th:call_proc(proc_e115ca8b_53f0_4844_97a3_a15141c0a242, self, f["text_join"](self, { ADD0 = "多个小数点位于数字中" }, th), p_v)
      else
        f["variables_set"](self, { value = true, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"haspoint\"}" }, th)
      end
    end
    f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 2 }, th), list_item_value = f["list_item"](self, { item = "any", list = p_code, list_index = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th) }, th) }, th)
    f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
    f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
    if th:iter_w() then break end
  end
  f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Number", ITEM1 = (th:call_proc(proc_cb5a8bce_0c73_448c_ac32_fbb2f7e82149, self, f["list_item"](self, { item = "any", list = p_v, list_index = 2 }, th), "", 1)), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
  th:warp_exit()
end

proc_6be6ac61_9b92_4bba_8470_e6a31431a34d = function(th, self, p_tokens, p_global, p_minprec, p_env)
  -- 过程「efcddcf6-09fe-4230-8d86-934d5f1e7a1a」 id=6be6ac61-9b92-4bba-8470-e6a31431a34d
  f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_71cfe477_3ca4_4eb3_8c6e_1a798f19938c, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
  th:warp_enter()
  while true do
    if false then break end
    if V.bool(f["variables_get"](self, { variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)) then
      th:warp_exit()
      return 0
    end
    f["script_variables"](self, { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, name = "t", names = { "t", "p", "rm" } }, th)
    f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"t\"}" }, th)
    if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "t" }, th), B = "Question", OP = "EQ" }, th)) then
      if V.bool(f["logic_compare"](self, { A = 1, B = p_minprec, OP = "LT" }, th)) then
        break
      end
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
      f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_6be6ac61_9b92_4bba_8470_e6a31431a34d, self, p_tokens, p_global, 1, f["temporary_list"](self, {}, th), nil, nil, nil, nil, nil)) }, th)
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Colon", nil)))
      f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_6be6ac61_9b92_4bba_8470_e6a31431a34d, self, p_tokens, p_global, 1, f["temporary_list"](self, {}, th), nil, nil, nil, nil, nil)) }, th)
      f["replace_list_item"](self, { item = "any", list = p_env, list_index = 1, list_item_value = f["temporary_list"](self, { ITEM0 = "ternary", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_env, list_index = 3 }, th) }, th) }, th)
    else
      f["variables_set"](self, { value = (th:call_proc(proc_32f3c134_9a04_44e1_a8a5_2339303cc1b1, self, f["script_variables_value"](self, { TEXT = "t" }, th), nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"p\"}" }, th)
      if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "p" }, th), B = 0, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "p" }, th), B = p_minprec, OP = "LT" }, th), type = "or" }, th)) then
        break
      end
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
      f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "p" }, th), B = 1, type = "add" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"rm\"}" }, th)
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "t" }, th), B = "Pow", OP = "EQ" }, th)) then
        f["variables_set"](self, { value = f["script_variables_value"](self, { TEXT = "p" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"rm\"}" }, th)
      end
      f["replace_list_item"](self, { item = "any", list = p_env, list_index = 1, list_item_value = f["temporary_list"](self, { ITEM0 = "binary", ITEM1 = f["script_variables_value"](self, { TEXT = "t" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), ITEM3 = (th:call_proc(proc_6be6ac61_9b92_4bba_8470_e6a31431a34d, self, p_tokens, p_global, f["script_variables_value"](self, { TEXT = "rm" }, th), f["temporary_list"](self, {}, th), nil, nil, nil, nil, nil)) }, th) }, th)
    end
    if th:iter_w() then break end
  end
  th:warp_exit()
  return f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th)
end

proc_6cbcb627_87ad_413d_a95d_943e43d0f90d = function(th, self, p_env, p_n)
  -- 过程「e8492928-aff0-4d00-b7e7-812654d315bf」 id=6cbcb627-87ad-413d-a95d-943e43d0f90d
  if V.bool(f["logic_negate"](self, { logic = (th:call_proc(proc_b9858f0c_554f_45ef_a324_ba5411bc14ad, self, p_env)) }, th)) then
    return (th:call_proc(proc_fdff4a26_8852_4abb_9cb4_ab94e5d7a174, self, f["text_join"](self, { ADD0 = "环境为空" }, th)))
  end
  if V.bool(f["logic_compare"](self, { A = f["list_length"](self, { list = p_env }, th), B = 0, OP = "EQ" }, th)) then
    return (th:call_proc(proc_fdff4a26_8852_4abb_9cb4_ab94e5d7a174, self, f["text_join"](self, { ADD0 = "未定义的符号：\"", ADD1 = p_n, ADD2 = "\"" }, th)))
  end
  f["script_variables"](self, { PARAMS0 = nil, name = "#1" }, th)
  f["variables_set"](self, { value = f["list_index_of"](self, { list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th), list_index = 1 }, th), list_item_value = p_n }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"#1\"}" }, th)
  if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "#1" }, th), B = 0, OP = "GT" }, th)) then
    return f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th), list_index = 2 }, th), list_index = f["script_variables_value"](self, { TEXT = "#1" }, th) }, th)
  end
  return (th:call_proc(proc_6cbcb627_87ad_413d_a95d_943e43d0f90d, self, f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), p_n, nil))
end

proc_71540544_dcc5_47b4_8f23_4d49c5e9fd45 = function(th, self, p_tokens, p_global, p_env)
  -- 过程「692c5e8e-c372-491c-ad01-22a3a65af41b」 id=71540544-dcc5-47b4-8f23-4d49c5e9fd45
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Identifier", OP = "EQ" }, th)) then
    return f["temporary_list"](self, { ITEM0 = "identifier", ITEM1 = f["list_item"](self, { item = "any", list = (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)), list_index = 2 }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Number", OP = "EQ" }, th)) then
    return f["temporary_list"](self, { ITEM0 = "number", ITEM1 = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)), list_index = 2 }, th), B = 1, type = "multiply" }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "String", OP = "EQ" }, th)) then
    return f["temporary_list"](self, { ITEM0 = "string", ITEM1 = f["list_item"](self, { item = "any", list = (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)), list_index = 2 }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "True", OP = "EQ" }, th)) then
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    return f["temporary_list"](self, { ITEM0 = "true" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "False", OP = "EQ" }, th)) then
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    return f["temporary_list"](self, { ITEM0 = "false" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "NaN", OP = "EQ" }, th)) then
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    return f["temporary_list"](self, { ITEM0 = "nan" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Function", OP = "EQ" }, th)) then
    return (th:call_proc(proc_280d939c_ebff_42fc_bc51_2fa4bd23ebef, self, p_tokens, p_global, f["temporary_list"](self, {}, th)))
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "LeftSquare", OP = "EQ" }, th)) then
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_ee7e471d_cfb7_44a8_9328_40c0e6b606f3, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "RightSquare", nil)))
    return f["temporary_list"](self, { ITEM0 = "list", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "LeftParen", OP = "EQ" }, th)) then
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "RightParen", nil)))
    return f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "LeftGrace", OP = "EQ" }, th)) then
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_9972f10d_437e_4895_8ab5_b984b7c346ab, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "RightGrace", nil)))
    return f["temporary_list"](self, { ITEM0 = "dictL", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Environ", OP = "EQ" }, th)) then
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    return f["temporary_list"](self, { ITEM0 = "environ" }, th)
  end
  th:call_proc(proc_20fea0b0_d162_4786_b754_dbaac584913c, self, f["text_join"](self, { ADD0 = "期望一个字面量，实际得到", ADD1 = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)) }, th), (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)))
  return 0
end

proc_71cfe477_3ca4_4eb3_8c6e_1a798f19938c = function(th, self, p_tokens, p_global, p_env)
  -- 过程「f7755c4d-8b3d-4f36-8756-cba949357e60」 id=71cfe477-3ca4-4eb3-8c6e-1a798f19938c
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Sub", OP = "EQ" }, th)) then
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    return f["temporary_list"](self, { ITEM0 = "unary", ITEM1 = "Sub", ITEM2 = (th:call_proc(proc_71cfe477_3ca4_4eb3_8c6e_1a798f19938c, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Not", OP = "EQ" }, th)) then
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    return f["temporary_list"](self, { ITEM0 = "unary", ITEM1 = "Not", ITEM2 = (th:call_proc(proc_71cfe477_3ca4_4eb3_8c6e_1a798f19938c, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
  end
  return (th:call_proc(proc_08dc6ce9_a84d_40cb_a208_6f1873097115, self, p_tokens, p_global, p_env))
end

proc_79bd69fe_5e2b_47d3_8d8a_06149e3029b7 = function(th, self, p_tokens, p_global, p_env)
  -- 过程「c240ee3f-98f6-4144-a6eb-f7a5f5c429b0」 id=79bd69fe-5e2b-47d3-8d8a-06149e3029b7
  f["list_append"](self, { list = p_env, list_item_value = f["temporary_list"](self, {}, th) }, th)
  f["list_append"](self, { list = p_env, list_item_value = f["temporary_list"](self, {}, th) }, th)
  f["list_append"](self, { list = p_env, list_item_value = f["temporary_list"](self, {}, th) }, th)
  f["list_append"](self, { list = p_env, list_item_value = f["temporary_list"](self, {}, th) }, th)
  f["list_append"](self, { list = p_env, list_item_value = "" }, th)
  f["list_append"](self, { list = p_env, list_item_value = "" }, th)
  f["list_append"](self, { list = p_env, list_item_value = "" }, th)
  f["list_append"](self, { list = p_env, list_item_value = "" }, th)
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Var", OP = "EQ" }, th)) then
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    f["replace_list_item"](self, { item = "any", list = p_env, list_index = 5, list_item_value = f["list_item"](self, { item = "any", list = (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Identifier", nil)), list_index = 2 }, th) }, th)
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Assign", nil)))
    f["replace_list_item"](self, { item = "any", list = p_env, list_index = 6, list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    f["replace_list_item"](self, { item = "any", list = p_env, list_index = 1, list_item_value = f["temporary_list"](self, { ITEM0 = "assignVar", ITEM1 = f["temporary_list"](self, { ITEM0 = "identifier", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 5 }, th) }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_env, list_index = 6 }, th) }, th) }, th)
  elseif V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Semicolon", OP = "NEQ" }, th)) then
    f["replace_list_item"](self, { item = "any", list = p_env, list_index = 1, list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Assign", OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Reunite", OP = "EQ" }, th), type = "or" }, th)) then
      f["replace_list_item"](self, { item = "any", list = p_env, list_index = 5, list_item_value = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th) }, th)
      if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_env, list_index = 5 }, th), list_index = 1 }, th), B = "getVar", OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_env, list_index = 5 }, th), list_index = 2 }, th), list_index = 1 }, th), B = "identifier", OP = "EQ" }, th), type = "and" }, th)) then
        f["replace_list_item"](self, { item = "any", list = p_env, list_index = 5, list_item_value = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_env, list_index = 5 }, th), list_index = 2 }, th) }, th)
      end
      if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Reunite", OP = "EQ" }, th)) then
        f["replace_list_item"](self, { item = "any", list = p_env, list_index = 7, list_item_value = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 5 }, th) }, th)
      end
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
      f["replace_list_item"](self, { item = "any", list = p_env, list_index = 6, list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
      if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_env, list_index = 7 }, th), B = "", OP = "EQ" }, th)) then
        f["replace_list_item"](self, { item = "any", list = p_env, list_index = 1, list_item_value = f["temporary_list"](self, { ITEM0 = "changeVar", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 5 }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_env, list_index = 6 }, th) }, th) }, th)
      else
        f["replace_list_item"](self, { item = "any", list = p_env, list_index = 1, list_item_value = f["temporary_list"](self, { ITEM0 = "changeVar", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 5 }, th), ITEM2 = f["temporary_list"](self, { ITEM0 = "binary", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 7 }, th), ITEM2 = (th:call_proc(proc_5f70c810_67eb_4c43_a508_053c464fa86d, self, f["list_item"](self, { item = "any", list = p_env, list_index = 5 }, th))), ITEM3 = (th:call_proc(proc_5f70c810_67eb_4c43_a508_053c464fa86d, self, f["list_item"](self, { item = "any", list = p_env, list_index = 6 }, th))) }, th) }, th) }, th)
      end
    end
  end
  th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Semicolon", nil)))
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Semicolon", OP = "NEQ" }, th)) then
    f["replace_list_item"](self, { item = "any", list = p_env, list_index = 2, list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
  end
  th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Semicolon", nil)))
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "RightParen", OP = "NEQ" }, th)) then
    f["replace_list_item"](self, { item = "any", list = p_env, list_index = 3, list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Assign", OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Reunite", OP = "EQ" }, th), type = "or" }, th)) then
      f["replace_list_item"](self, { item = "any", list = p_env, list_index = 5, list_item_value = f["list_item"](self, { item = "any", list = p_env, list_index = 3 }, th) }, th)
      if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_env, list_index = 5 }, th), list_index = 1 }, th), B = "getVar", OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_env, list_index = 5 }, th), list_index = 2 }, th), list_index = 1 }, th), B = "identifier", OP = "EQ" }, th), type = "and" }, th)) then
        f["replace_list_item"](self, { item = "any", list = p_env, list_index = 5, list_item_value = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_env, list_index = 5 }, th), list_index = 2 }, th) }, th)
      end
      if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Reunite", OP = "EQ" }, th)) then
        f["replace_list_item"](self, { item = "any", list = p_env, list_index = 8, list_item_value = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 5 }, th) }, th)
      end
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
      f["replace_list_item"](self, { item = "any", list = p_env, list_index = 6, list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
      if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_env, list_index = 8 }, th), B = "", OP = "EQ" }, th)) then
        f["replace_list_item"](self, { item = "any", list = p_env, list_index = 3, list_item_value = f["temporary_list"](self, { ITEM0 = "changeVar", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 5 }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_env, list_index = 6 }, th) }, th) }, th)
      else
        f["replace_list_item"](self, { item = "any", list = p_env, list_index = 3, list_item_value = f["temporary_list"](self, { ITEM0 = "changeVar", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 5 }, th), ITEM2 = f["temporary_list"](self, { ITEM0 = "binary", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 8 }, th), ITEM2 = (th:call_proc(proc_5f70c810_67eb_4c43_a508_053c464fa86d, self, f["list_item"](self, { item = "any", list = p_env, list_index = 5 }, th))), ITEM3 = (th:call_proc(proc_5f70c810_67eb_4c43_a508_053c464fa86d, self, f["list_item"](self, { item = "any", list = p_env, list_index = 6 }, th))) }, th) }, th) }, th)
      end
    end
  end
  th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "RightParen", nil)))
  f["replace_list_item"](self, { item = "any", list = p_env, list_index = 4, list_item_value = (th:call_proc(proc_b3d1e130_56d4_40d9_95de_4c7396b11b16, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
  return f["temporary_list"](self, { ITEM0 = "for", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_env, list_index = 3 }, th), ITEM4 = f["list_item"](self, { item = "any", list = p_env, list_index = 4 }, th) }, th)
end

proc_803f4f62_01e2_4370_b5e6_88cd6ad88290 = function(th, self, p_node, p_env, p_result, p_i)
  -- 过程「202bbf8b-a798-4822-9324-3806b6d43130」 id=803f4f62-01e2-4370-b5e6-88cd6ad88290
  if V.bool(f["variables_get"](self, { variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)) then
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th), B = "", OP = "NEQ" }, th)) then
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["variables_get"](self, { variable = "b6b5f7c3-2437-4272-9ccb-1e647362b076" }, th)) then
    if V.bool(f["logic_negate"](self, { logic = f["list_item"](self, { item = "any", list = p_env, list_index = 3 }, th) }, th)) then
      f["variables_set"](self, { value = false, variable = "b6b5f7c3-2437-4272-9ccb-1e647362b076" }, th)
    end
    return p_result
  end
  if V.bool(f["logic_compare"](self, { A = p_i, B = f["list_length"](self, { list = p_node }, th), OP = "GT" }, th)) then
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  return (th:call_proc(proc_803f4f62_01e2_4370_b5e6_88cd6ad88290, self, p_node, p_env, (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = p_i }, th), p_env, f["temporary_list"](self, {}, th))), f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th)))
end

proc_8836e0fd_6d26_4479_9180_8424267a294e = function(th, self, p_env, p_p, p_a, p_ids, p_i, p_v)
  -- 过程「9d26547d-1199-4319-bd25-0f0d78b43e16」 id=8836e0fd-6d26-4479-9180-8424267a294e
  if V.bool(f["logic_compare"](self, { A = p_i, B = f["list_length"](self, { list = p_p }, th), OP = "GT" }, th)) then
    return p_ids
  end
  f["list_append"](self, { list = p_v, list_item_value = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_p, list_index = p_i }, th), p_env, f["temporary_list"](self, {}, th))) }, th)
  if V.bool(f["list_is_exist"](self, { list = f["list_item"](self, { item = "any", list = p_ids, list_index = 1 }, th), list_item_value = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th) }, th)) then
    return (th:call_proc(proc_fdff4a26_8852_4abb_9cb4_ab94e5d7a174, self, f["text_join"](self, { ADD0 = "重复定义的符号：\"", ADD1 = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), ADD2 = "\"" }, th)))
  end
  f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_ids, list_index = 1 }, th), list_item_value = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th) }, th)
  if V.bool(f["logic_compare"](self, { A = f["list_length"](self, { list = f["list_item"](self, { item = "any", list = p_p, list_index = p_i }, th) }, th), B = 4, OP = "EQ" }, th)) then
    if V.bool(f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_p, list_index = p_i }, th), list_index = 4 }, th)) then
      f["list_append"](self, { list = p_v, list_item_value = f["temporary_list"](self, {}, th) }, th)
      th:warp_enter()
      do
        local _from_n1, _to_n1 = tonumber(p_i), tonumber(f["list_length"](self, { list = p_a }, th))
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
            f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 2 }, th), list_item_value = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_a, list_index = _p_n1 }, th), p_env, f["temporary_list"](self, {}, th))) }, th)
              th:pop_param()
              _p_n1 = _p_n1 + _by_n1
              if th:iter_w() then break end
            end
          end
        end
      end
      th:warp_exit()
      f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_ids, list_index = 2 }, th), list_item_value = f["list_item"](self, { item = "any", list = p_v, list_index = 2 }, th) }, th)
      return p_ids
    end
  end
  if V.bool(f["logic_compare"](self, { A = p_i, B = f["list_length"](self, { list = p_a }, th), OP = "GT" }, th)) then
    if V.bool(f["logic_compare"](self, { A = f["list_length"](self, { list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_p, list_index = p_i }, th), list_index = 3 }, th) }, th), B = 0, OP = "GT" }, th)) then
      f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_ids, list_index = 2 }, th), list_item_value = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_p, list_index = p_i }, th), list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))) }, th)
    else
      return (th:call_proc(proc_fdff4a26_8852_4abb_9cb4_ab94e5d7a174, self, f["text_join"](self, { ADD0 = "错误数量的参数：期望 ", ADD1 = p_i, ADD2 = " 个，实际得到 ", ADD3 = f["list_length"](self, { list = p_a }, th), ADD4 = " 个" }, th)))
    end
  else
    f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_ids, list_index = 2 }, th), list_item_value = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_a, list_index = p_i }, th), p_env, f["temporary_list"](self, {}, th))) }, th)
  end
  return (th:call_proc(proc_8836e0fd_6d26_4479_9180_8424267a294e, self, p_env, p_p, p_a, p_ids, f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th), f["temporary_list"](self, {}, th)))
end

proc_8ad455ed_0ad7_4213_aa68_9d8ffe25d346 = function(th, self, p_tokens, p_global, p_env)
  -- 过程「b0952b75-d911-4ebb-8c39-03593d5edb33」 id=8ad455ed-0ad7-4213-aa68-9d8ffe25d346
  if V.bool(f["variables_get"](self, { variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)) then
    return 0
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Var", OP = "EQ" }, th)) then
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    f["list_append"](self, { list = p_env, list_item_value = f["list_item"](self, { item = "any", list = (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Identifier", nil)), list_index = 2 }, th) }, th)
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Assign", nil)))
    f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Semicolon", nil)))
    return f["temporary_list"](self, { ITEM0 = "assignVar", ITEM1 = f["temporary_list"](self, { ITEM0 = "identifier", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th) }, th), ITEM2 = (th:call_proc(proc_5f70c810_67eb_4c43_a508_053c464fa86d, self, f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th))) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Return", OP = "EQ" }, th)) then
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Semicolon", OP = "NEQ" }, th)) then
      f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Semicolon", nil)))
      return f["temporary_list"](self, { ITEM0 = "return", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th) }, th)
    else
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Semicolon", nil)))
      return f["temporary_list"](self, { ITEM0 = "return" }, th)
    end
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Throw", OP = "EQ" }, th)) then
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Semicolon", nil)))
    return f["temporary_list"](self, { ITEM0 = "throw", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Break", OP = "EQ" }, th)) then
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Semicolon", nil)))
    return f["temporary_list"](self, { ITEM0 = "break" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Continue", OP = "EQ" }, th)) then
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Semicolon", nil)))
    return f["temporary_list"](self, { ITEM0 = "continue" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "While", OP = "EQ" }, th)) then
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "LeftParen", nil)))
    f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "RightParen", nil)))
    f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_b3d1e130_56d4_40d9_95de_4c7396b11b16, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    return f["temporary_list"](self, { ITEM0 = "while", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "For", OP = "EQ" }, th)) then
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "LeftParen", nil)))
    return (th:call_proc(proc_79bd69fe_5e2b_47d3_8d8a_06149e3029b7, self, p_tokens, p_global, p_env))
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "If", OP = "EQ" }, th)) then
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "LeftParen", nil)))
    f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "RightParen", nil)))
    f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_b3d1e130_56d4_40d9_95de_4c7396b11b16, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Else", OP = "EQ" }, th)) then
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
      if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "If", OP = "EQ" }, th)) then
        f["list_append"](self, { list = p_env, list_item_value = f["temporary_list"](self, { ITEM0 = (th:call_proc(proc_8ad455ed_0ad7_4213_aa68_9d8ffe25d346, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th) }, th)
      else
        f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_b3d1e130_56d4_40d9_95de_4c7396b11b16, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
      end
      return f["temporary_list"](self, { ITEM0 = "if", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_env, list_index = 3 }, th) }, th)
    end
    return f["temporary_list"](self, { ITEM0 = "if", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Try", OP = "EQ" }, th)) then
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_b3d1e130_56d4_40d9_95de_4c7396b11b16, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Catch", OP = "EQ" }, th)) then
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "LeftParen", nil)))
      f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_093d9411_7542_4203_b427_550056e1b13e, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "RightParen", nil)))
      f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_b3d1e130_56d4_40d9_95de_4c7396b11b16, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
      return f["temporary_list"](self, { ITEM0 = "try", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_env, list_index = 3 }, th) }, th)
    end
    return f["temporary_list"](self, { ITEM0 = "try", ITEM1 = f["temporary_list"](self, {}, th), ITEM2 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Function", OP = "EQ" }, th)) then
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    f["list_append"](self, { list = p_env, list_item_value = f["temporary_list"](self, { ITEM0 = "identifier", ITEM1 = f["list_item"](self, { item = "any", list = (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Identifier", nil)), list_index = 2 }, th) }, th) }, th)
    th:warp_enter()
    while true do
      if false then break end
      if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Dot", OP = "EQ" }, th)) then
        f["replace_list_item"](self, { item = "any", list = p_env, list_index = 1, list_item_value = (th:call_proc(proc_5f70c810_67eb_4c43_a508_053c464fa86d, self, f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th))) }, th)
        th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
        f["list_append"](self, { list = p_env, list_item_value = f["temporary_list"](self, { ITEM0 = "string", ITEM1 = f["list_item"](self, { item = "any", list = (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Identifier", nil)), list_index = 2 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_env, list_index = 1, list_item_value = f["temporary_list"](self, { ITEM0 = "index", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), ITEM2 = f["list_item"](self, { item = "last", list = p_env }, th) }, th) }, th)
      elseif V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "LeftSquare", OP = "EQ" }, th)) then
        f["replace_list_item"](self, { item = "any", list = p_env, list_index = 1, list_item_value = (th:call_proc(proc_5f70c810_67eb_4c43_a508_053c464fa86d, self, f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th))) }, th)
        th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
        f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
        th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "RightSquare", nil)))
        f["replace_list_item"](self, { item = "any", list = p_env, list_index = 1, list_item_value = f["temporary_list"](self, { ITEM0 = "index", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), ITEM2 = f["list_item"](self, { item = "last", list = p_env }, th) }, th) }, th)
      else
        break
      end
      if th:iter_w() then break end
    end
    th:warp_exit()
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "LeftParen", nil)))
    f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_093d9411_7542_4203_b427_550056e1b13e, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "RightParen", nil)))
    f["list_append"](self, { list = p_env, list_item_value = f["temporary_list"](self, {}, th) }, th)
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Use", OP = "EQ" }, th)) then
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
      f["replace_list_item"](self, { item = "last", list = p_env, list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    end
    f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_b3d1e130_56d4_40d9_95de_4c7396b11b16, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    if V.bool(f["logic_compare"](self, { A = f["list_length"](self, { list = f["list_item"](self, { item = "any", list = p_env, list_index = f["math_arithmetic"](self, { A = f["list_length"](self, { list = p_env }, th), B = 1, type = "minus" }, th) }, th) }, th), B = 0, OP = "GT" }, th)) then
      if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), list_index = 1 }, th), B = "identifier", OP = "EQ" }, th)) then
        return f["temporary_list"](self, { ITEM0 = "assignVar", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), ITEM2 = f["temporary_list"](self, { ITEM0 = "function", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = f["math_arithmetic"](self, { A = f["list_length"](self, { list = p_env }, th), B = 2, type = "minus" }, th) }, th), ITEM2 = f["list_item"](self, { item = "last", list = p_env }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_env, list_index = f["math_arithmetic"](self, { A = f["list_length"](self, { list = p_env }, th), B = 1, type = "minus" }, th) }, th) }, th) }, th)
      end
      return f["temporary_list"](self, { ITEM0 = "changeVar", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), ITEM2 = f["temporary_list"](self, { ITEM0 = "function", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = f["math_arithmetic"](self, { A = f["list_length"](self, { list = p_env }, th), B = 2, type = "minus" }, th) }, th), ITEM2 = f["list_item"](self, { item = "last", list = p_env }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_env, list_index = f["math_arithmetic"](self, { A = f["list_length"](self, { list = p_env }, th), B = 1, type = "minus" }, th) }, th) }, th) }, th)
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), list_index = 1 }, th), B = "identifier", OP = "EQ" }, th)) then
      return f["temporary_list"](self, { ITEM0 = "assignVar", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), ITEM2 = f["temporary_list"](self, { ITEM0 = "function", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = f["math_arithmetic"](self, { A = f["list_length"](self, { list = p_env }, th), B = 2, type = "minus" }, th) }, th), ITEM2 = f["list_item"](self, { item = "last", list = p_env }, th) }, th) }, th)
    end
    return f["temporary_list"](self, { ITEM0 = "changeVar", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), ITEM2 = f["temporary_list"](self, { ITEM0 = "function", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = f["math_arithmetic"](self, { A = f["list_length"](self, { list = p_env }, th), B = 2, type = "minus" }, th) }, th), ITEM2 = f["list_item"](self, { item = "last", list = p_env }, th) }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "LeftGrace", OP = "EQ" }, th)) then
    f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_b3d1e130_56d4_40d9_95de_4c7396b11b16, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    return f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th)
  end
  f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
  if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Assign", OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Reunite", OP = "EQ" }, th), type = "or" }, th)) then
    f["list_append"](self, { list = p_env, list_item_value = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th) }, th)
    if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th), list_index = 1 }, th), B = "getVar", OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th), list_index = 2 }, th), list_index = 1 }, th), B = "identifier", OP = "EQ" }, th), type = "and" }, th)) then
      f["replace_list_item"](self, { item = "any", list = p_env, list_index = 2, list_item_value = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th), list_index = 2 }, th) }, th)
    end
    f["list_append"](self, { list = p_env, list_item_value = "" }, th)
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Reunite", OP = "EQ" }, th)) then
      f["replace_list_item"](self, { item = "any", list = p_env, list_index = 3, list_item_value = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 5 }, th) }, th)
    end
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    f["list_append"](self, { list = p_env, list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Semicolon", nil)))
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_env, list_index = 3 }, th), B = "", OP = "EQ" }, th)) then
      return f["temporary_list"](self, { ITEM0 = "changeVar", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th), ITEM2 = (th:call_proc(proc_5f70c810_67eb_4c43_a508_053c464fa86d, self, f["list_item"](self, { item = "last", list = p_env }, th))) }, th)
    end
    return f["temporary_list"](self, { ITEM0 = "changeVar", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th), ITEM2 = f["temporary_list"](self, { ITEM0 = "binary", ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 3 }, th), ITEM2 = (th:call_proc(proc_5f70c810_67eb_4c43_a508_053c464fa86d, self, f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th))), ITEM3 = (th:call_proc(proc_5f70c810_67eb_4c43_a508_053c464fa86d, self, f["list_item"](self, { item = "last", list = p_env }, th))) }, th) }, th)
  end
  th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Semicolon", nil)))
  return f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th)
end

proc_9186745c_97b7_4607_9dae_9af46b3cd7d2 = function(th, self, p_char)
  -- 过程「595bb403-eb66-4822-9cbc-b8706e649946」 id=9186745c-97b7-4607-9dae-9af46b3cd7d2
  return f["logic_operation"](self, { A = f["logic_operation"](self, { A = f["logic_compare"](self, { A = "一", B = p_char, OP = "LTE" }, th), B = f["logic_compare"](self, { A = p_char, B = "鿿", OP = "LTE" }, th), type = "and" }, th), B = f["logic_operation"](self, { A = f["logic_operation"](self, { A = f["logic_operation"](self, { A = f["logic_compare"](self, { A = "a", B = p_char, OP = "LTE" }, th), B = f["logic_compare"](self, { A = p_char, B = "z", OP = "LTE" }, th), type = "and" }, th), B = f["logic_operation"](self, { A = f["logic_compare"](self, { A = "A", B = p_char, OP = "LTE" }, th), B = f["logic_compare"](self, { A = p_char, B = "Z", OP = "LTE" }, th), type = "and" }, th), type = "or" }, th), B = f["logic_compare"](self, { A = p_char, B = "_", OP = "EQ" }, th), type = "or" }, th), type = "or" }, th)
end

proc_923e1ade_6e8f_4d2b_8d72_0bee849299c8 = function(th, self, p_f, p_a)
  -- 过程「63507671-6e90-4a34-9bb2-e2fb7cf7d4d4」 id=923e1ade-6e8f-4d2b-8d72-0bee849299c8
  if V.bool(f["variables_get"](self, { variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)) then
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "dictSet", OP = "EQ" }, th)) then
    f["script_variables"](self, { PARAMS0 = nil, name = "dicti" }, th)
    f["variables_set"](self, { value = f["list_index_of"](self, { list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), list_index = 2 }, th), list_index = 1 }, th), list_item_value = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"dicti\"}" }, th)
    if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "dicti" }, th), B = 0, OP = "EQ" }, th)) then
      f["list_append"](self, { list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), list_index = 2 }, th), list_index = 1 }, th), list_item_value = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th) }, th)
      f["list_append"](self, { list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), list_index = 2 }, th), list_index = 2 }, th), list_item_value = f["list_item"](self, { item = "any", list = p_a, list_index = 3 }, th) }, th)
    else
      f["replace_list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), list_index = 2 }, th), list_index = 2 }, th), list_index = f["script_variables_value"](self, { TEXT = "dicti" }, th), list_item_value = f["list_item"](self, { item = "any", list = p_a, list_index = 3 }, th) }, th)
    end
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "dictGet", OP = "EQ" }, th)) then
    f["script_variables"](self, { PARAMS0 = nil, name = "dicti" }, th)
    f["variables_set"](self, { value = f["list_index_of"](self, { list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), list_index = 2 }, th), list_index = 1 }, th), list_item_value = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"dicti\"}" }, th)
    if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "dicti" }, th), B = 0, OP = "EQ" }, th)) then
      return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
    end
    return f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), list_index = 2 }, th), list_index = 2 }, th), list_index = f["script_variables_value"](self, { TEXT = "dicti" }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "console_log", OP = "EQ" }, th)) then
    f["list_append"](self, { list = f["variables_get"](self, { variable = "4eefb5ed-46e0-4ccc-8d35-5a43c9fbfbe2" }, th), list_item_value = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th)
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "input", OP = "EQ" }, th)) then
    f["list_append"](self, { list = f["variables_get"](self, { variable = "4eefb5ed-46e0-4ccc-8d35-5a43c9fbfbe2" }, th), list_item_value = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th)
    f["variables_set"](self, { value = true, variable = "f13953cd-e130-4564-a483-1abde875a10a" }, th)
    while not V.bool(f["logic_negate"](self, { logic = f["variables_get"](self, { variable = "f13953cd-e130-4564-a483-1abde875a10a" }, th) }, th)) do
      if th:iter_n() then break end
    end
    f["self_ask"](self, { text = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th)
    f["delete_list_item"](self, { item = "last", list = f["variables_get"](self, { variable = "4eefb5ed-46e0-4ccc-8d35-5a43c9fbfbe2" }, th) }, th)
    f["list_append"](self, { list = f["variables_get"](self, { variable = "4eefb5ed-46e0-4ccc-8d35-5a43c9fbfbe2" }, th), list_item_value = f["text_join"](self, { ADD0 = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), ADD1 = f["get_answer"](self, {}, th) }, th) }, th)
    return f["get_answer"](self, {}, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "toString", OP = "EQ" }, th)) then
    return f["text_join"](self, { ADD0 = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "toNumber", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), B = 1, type = "multiply" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "toBoolean", OP = "EQ" }, th)) then
    return f["convert_type"](self, { text = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), type = "boolean" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "getElement", OP = "EQ" }, th)) then
    return f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th), B = 1, type = "add" }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "length", OP = "EQ" }, th)) then
    return f["list_length"](self, { list = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "loadCode", OP = "EQ" }, th)) then
    f["script_variables"](self, { PARAMS0 = nil, name = "loader" }, th)
    f["variables_set"](self, { value = f["temporary_list"](self, { ITEM0 = "function", ITEM1 = f["temporary_list"](self, {}, th), ITEM2 = (th:call_proc(proc_f1a134be_67a9_45c8_823e_988d84c3097a, self, (th:call_proc(proc_ea2840b0_96b7_4a3c_95e7_bff42dde31b0, self, f["text_split"](self, { SPLIT_TEXT = "", TEXT_TO_SPLIT = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th), f["temporary_list"](self, { ITEM0 = 1, ITEM1 = f["temporary_list"](self, {}, th), ITEM2 = f["temporary_list"](self, {}, th), ITEM3 = 1, ITEM4 = 0 }, th), nil)), f["temporary_list"](self, { ITEM0 = 1 }, th), f["temporary_list"](self, {}, th))), ITEM3 = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"loader\"}" }, th)
    if V.bool(f["variables_get"](self, { variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)) then
      return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
    end
    return f["script_variables_value"](self, { TEXT = "loader" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "dictHas", OP = "EQ" }, th)) then
    return f["list_is_exist"](self, { list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), list_index = 2 }, th), list_index = 1 }, th), list_item_value = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "calculate", OP = "EQ" }, th)) then
    return f["calculate"](self, { input = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "sin", OP = "EQ" }, th)) then
    return f["calculate"](self, { input = f["text_join"](self, { ADD0 = "sin(", ADD1 = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), ADD2 = ")" }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "cos", OP = "EQ" }, th)) then
    return f["calculate"](self, { input = f["text_join"](self, { ADD0 = "cos(", ADD1 = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), ADD2 = ")" }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "tan", OP = "EQ" }, th)) then
    return f["calculate"](self, { input = f["text_join"](self, { ADD0 = "tan(", ADD1 = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), ADD2 = ")" }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "asin", OP = "EQ" }, th)) then
    return f["calculate"](self, { input = f["text_join"](self, { ADD0 = "asin(", ADD1 = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), ADD2 = ")" }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "acos", OP = "EQ" }, th)) then
    return f["calculate"](self, { input = f["text_join"](self, { ADD0 = "acos(", ADD1 = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), ADD2 = ")" }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "atan", OP = "EQ" }, th)) then
    return f["calculate"](self, { input = f["text_join"](self, { ADD0 = "atan(", ADD1 = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), ADD2 = ")" }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "random", OP = "EQ" }, th)) then
    return f["random_num"](self, { A = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), B = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "round", OP = "EQ" }, th)) then
    return f["math_round"](self, { num = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), type = "round" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "floor", OP = "EQ" }, th)) then
    return f["math_round"](self, { num = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), type = "round_down" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "ceil", OP = "EQ" }, th)) then
    return f["math_round"](self, { num = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), type = "round_up" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "sqrt", OP = "EQ" }, th)) then
    return f["math_function"](self, { num = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), type = "0" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "abs", OP = "EQ" }, th)) then
    return f["math_function"](self, { num = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), type = "1" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "log", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = f["math_function"](self, { num = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th), type = "3" }, th), B = f["math_function"](self, { num = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), type = "3" }, th), type = "divide" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "split", OP = "EQ" }, th)) then
    return f["text_split"](self, { SPLIT_TEXT = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th), TEXT_TO_SPLIT = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "slice", OP = "EQ" }, th)) then
    return f["text_select"](self, { end_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_a, list_index = 3 }, th), B = 1, type = "add" }, th), start_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th), B = 1, type = "add" }, th), text = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "strLength", OP = "EQ" }, th)) then
    return f["text_length"](self, { text = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "hasChar", OP = "EQ" }, th)) then
    return f["text_contain"](self, { A = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), B = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "push", OP = "EQ" }, th)) then
    f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), list_item_value = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th) }, th)
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "insert", OP = "EQ" }, th)) then
    f["list_insert_value"](self, { list = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_a, list_index = 3 }, th), B = 1, type = "add" }, th), list_item_value = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th) }, th)
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "remove", OP = "EQ" }, th)) then
    f["delete_list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th), B = 1, type = "add" }, th) }, th)
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "set", OP = "EQ" }, th)) then
    f["replace_list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th), B = 1, type = "add" }, th), list_item_value = f["list_item"](self, { item = "any", list = p_a, list_index = 3 }, th) }, th)
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "indexOf", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = f["list_index_of"](self, { list = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), list_item_value = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th) }, th), B = 1, type = "minus" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "includes", OP = "EQ" }, th)) then
    return f["list_is_exist"](self, { list = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), list_item_value = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "listFormat", OP = "EQ" }, th)) then
    return (th:call_proc(proc_c60a7cae_450c_4d26_8c44_f1144792d722, self, f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th)))
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "fromCharCode", OP = "EQ" }, th)) then
    return f["text_select"](self, { start_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), B = 1, type = "add" }, th), text = f["variables_get"](self, { variable = "59416620-c0d2-49a0-9006-a52b1e5bb833" }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "toCharCode", OP = "EQ" }, th)) then
    f["script_variables"](self, { PARAMS0 = nil, name = "ascii" }, th)
    f["variables_set"](self, { value = f["list_index_of"](self, { list = f["variables_get"](self, { variable = "fec1fa0f-f1a2-41ec-a1e5-02e95bd44ac1" }, th), list_item_value = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ascii\"}" }, th)
    if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "ascii" }, th), B = 0, OP = "GT" }, th)) then
      return f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "ascii" }, th), B = 1, type = "minus" }, th)
    end
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "copy", OP = "EQ" }, th)) then
    f["script_variables"](self, { PARAMS0 = nil, name = "copy" }, th)
    f["variables_set"](self, { value = f["temporary_list"](self, {}, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"copy\"}" }, th)
    f["list_copy"](self, { list = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), target_list = f["script_variables_value"](self, { TEXT = "copy" }, th) }, th)
    return f["script_variables_value"](self, { TEXT = "copy" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "typeOf", OP = "EQ" }, th)) then
    if V.bool(f["logic_compare"](self, { A = f["list_length"](self, { list = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th), B = 0, OP = "GTE" }, th)) then
      if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), list_index = 1 }, th), B = "dict", OP = "EQ" }, th)) then
        return "Dictionary"
      end
      if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), list_index = 1 }, th), B = "function", OP = "EQ" }, th)) then
        return "Function"
      end
      if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), list_index = 1 }, th), B = "native", OP = "EQ" }, th)) then
        return "Function"
      end
      return "List"
    end
    if V.bool(f["logic_compare"](self, { A = f["text_join"](self, { ADD0 = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th), B = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), OP = "EQ" }, th)) then
      return "String"
    end
    if V.bool(f["logic_compare"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), B = 0, type = "add" }, th), B = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), OP = "EQ" }, th)) then
      if V.bool(f["logic_compare"](self, { A = f["text_join"](self, { ADD0 = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th), B = "NaN", OP = "EQ" }, th)) then
        return "NaN"
      end
      return "Number"
    end
    if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), B = true, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), B = false, OP = "EQ" }, th), type = "or" }, th)) then
      return "Boolean"
    end
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "setPenSize", OP = "EQ" }, th)) then
    f["self_set_pen_size"](self, { size = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th)
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "penDown", OP = "EQ" }, th)) then
    f["self_pen_down"](self, {}, th)
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "penUp", OP = "EQ" }, th)) then
    f["self_pen_up"](self, {}, th)
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "penGoto", OP = "EQ" }, th)) then
    f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = -250, B = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), type = "add" }, th), y = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th) }, th)
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "setHsva", OP = "EQ" }, th)) then
    f["self_set_pen_color"](self, { color = "#ff0000" }, th)
    f["self_set_pen_color_property"](self, { scope = "hue", val = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th)
    f["self_set_pen_color_property"](self, { scope = "saturation", val = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th) }, th)
    f["self_set_pen_color_property"](self, { scope = "brightness", val = f["list_item"](self, { item = "any", list = p_a, list_index = 3 }, th) }, th)
    f["self_set_pen_color_property"](self, { scope = "alpha", val = f["math_arithmetic"](self, { A = 100, B = f["list_item"](self, { item = "any", list = p_a, list_index = 4 }, th), type = "minus" }, th) }, th)
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "fingerX", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = f["get_mouse_info"](self, { type = "x" }, th), B = 250, type = "add" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "fingerY", OP = "EQ" }, th)) then
    return f["get_mouse_info"](self, { type = "y" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "penX", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), B = 250, type = "add" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "penY", OP = "EQ" }, th)) then
    return f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "isPress", OP = "EQ" }, th)) then
    return f["mouse_down"](self, { sprite = "--screen", type = "down" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "getTime", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = f["get_timer"](self, {}, th), B = f["variables_get"](self, { variable = "cb1468b1-eb20-4cc6-bc3e-91b6bfdd2b27" }, th), type = "minus" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "clean", OP = "EQ" }, th)) then
    f["variables_set"](self, { value = true, variable = "1f503b9a-3c74-4a36-8634-bdda5526537d" }, th)
    while not V.bool(f["logic_negate"](self, { logic = f["variables_get"](self, { variable = "1f503b9a-3c74-4a36-8634-bdda5526537d" }, th) }, th)) do
      if th:iter_n() then break end
    end
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "printText", OP = "EQ" }, th)) then
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_a, list_index = 3 }, th), B = "left", OP = "EQ" }, th)) then
      f["stamp"](self, { align = "right", size = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th), text = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th)
    elseif V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_a, list_index = 3 }, th), B = "middle", OP = "EQ" }, th)) then
      f["stamp"](self, { align = "center", size = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th), text = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th)
    elseif V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_a, list_index = 3 }, th), B = "right", OP = "EQ" }, th)) then
      f["stamp"](self, { align = "left", size = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th), text = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th)
    end
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "isEqual", OP = "EQ" }, th)) then
    return f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), B = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th), OP = "EQ" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "writeLocal", OP = "EQ" }, th)) then
    f["script_variables"](self, { PARAMS0 = nil, name = "writelocal" }, th)
    f["variables_set"](self, { value = f["list_index_of"](self, { list = f["list_item"](self, { item = "any", list = f["variables_get"](self, { variable = "9dcb03e8-dfbb-4cf1-acbf-6a96becbca96" }, th), list_index = 1 }, th), list_item_value = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"writelocal\"}" }, th)
    if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "writelocal" }, th), B = 0, OP = "GT" }, th)) then
      f["replace_list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["variables_get"](self, { variable = "9dcb03e8-dfbb-4cf1-acbf-6a96becbca96" }, th), list_index = 2 }, th), list_index = f["script_variables_value"](self, { TEXT = "writelocal" }, th), list_item_value = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th) }, th)
    else
      f["list_append"](self, { list = f["list_item"](self, { item = "any", list = f["variables_get"](self, { variable = "9dcb03e8-dfbb-4cf1-acbf-6a96becbca96" }, th), list_index = 1 }, th), list_item_value = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th)
      f["list_append"](self, { list = f["list_item"](self, { item = "any", list = f["variables_get"](self, { variable = "9dcb03e8-dfbb-4cf1-acbf-6a96becbca96" }, th), list_index = 2 }, th), list_item_value = f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th) }, th)
    end
    th:call_proc(proc_a621de99_c663_495a_bb73_539e94b3a042, self)
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "readLocal", OP = "EQ" }, th)) then
    f["script_variables"](self, { PARAMS0 = nil, name = "readlocal" }, th)
    f["variables_set"](self, { value = f["list_index_of"](self, { list = f["list_item"](self, { item = "any", list = f["variables_get"](self, { variable = "9dcb03e8-dfbb-4cf1-acbf-6a96becbca96" }, th), list_index = 1 }, th), list_item_value = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"readlocal\"}" }, th)
    if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "readlocal" }, th), B = 0, OP = "GT" }, th)) then
      return f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["variables_get"](self, { variable = "9dcb03e8-dfbb-4cf1-acbf-6a96becbca96" }, th), list_index = 2 }, th), list_index = f["script_variables_value"](self, { TEXT = "readlocal" }, th) }, th)
    end
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "deleteLocal", OP = "EQ" }, th)) then
    f["script_variables"](self, { PARAMS0 = nil, name = "deletelocal" }, th)
    f["variables_set"](self, { value = f["list_index_of"](self, { list = f["list_item"](self, { item = "any", list = f["variables_get"](self, { variable = "9dcb03e8-dfbb-4cf1-acbf-6a96becbca96" }, th), list_index = 1 }, th), list_item_value = f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"deletelocal\"}" }, th)
    if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "deletelocal" }, th), B = 0, OP = "GT" }, th)) then
      f["delete_list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["variables_get"](self, { variable = "9dcb03e8-dfbb-4cf1-acbf-6a96becbca96" }, th), list_index = 1 }, th), list_index = f["script_variables_value"](self, { TEXT = "deletelocal" }, th) }, th)
      f["delete_list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["variables_get"](self, { variable = "9dcb03e8-dfbb-4cf1-acbf-6a96becbca96" }, th), list_index = 2 }, th), list_index = f["script_variables_value"](self, { TEXT = "deletelocal" }, th) }, th)
    end
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = p_f, B = "envGet", OP = "EQ" }, th)) then
    return (th:call_proc(proc_6cbcb627_87ad_413d_a95d_943e43d0f90d, self, f["list_item"](self, { item = "any", list = p_a, list_index = 1 }, th), f["list_item"](self, { item = "any", list = p_a, list_index = 2 }, th), nil))
  end
  return (th:call_proc(proc_fdff4a26_8852_4abb_9cb4_ab94e5d7a174, self, f["text_join"](self, { ADD0 = "\"", ADD1 = p_f, ADD2 = "\"不是一个可调用的原生函数" }, th)))
end

proc_9972f10d_437e_4895_8ab5_b984b7c346ab = function(th, self, p_tokens, p_global, p_env)
  -- 过程「64fe3cb4-d2c5-4849-a910-8099ae0f085e」 id=9972f10d-437e-4895-8ab5-b984b7c346ab
  f["list_append"](self, { list = p_env, list_item_value = f["temporary_list"](self, {}, th) }, th)
  f["list_append"](self, { list = p_env, list_item_value = "" }, th)
  f["list_append"](self, { list = p_env, list_item_value = "" }, th)
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "RightGrace", OP = "EQ" }, th)) then
    return f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th)
  end
  th:warp_enter()
  while true do
    if false then break end
    if V.bool(f["variables_get"](self, { variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)) then
      th:warp_exit()
      return 0
    end
    f["replace_list_item"](self, { item = "any", list = p_env, list_index = 2, list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "Colon", nil)))
    f["replace_list_item"](self, { item = "any", list = p_env, list_index = 3, list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th), ITEM1 = f["list_item"](self, { item = "any", list = p_env, list_index = 3 }, th) }, th) }, th)
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Comma", OP = "EQ" }, th)) then
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    else
      break
    end
    if th:iter_w() then break end
  end
  th:warp_exit()
  return f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th)
end

proc_a4c40a96_8fae_4226_9ec9_b9b9751ba6d9 = function(th, self, p_code, p_v)
  -- 过程「352a4ebb-b293-439f-939e-752d29411fa9」 id=a4c40a96-8fae-4226-9ec9-b9b9751ba6d9
  if V.bool(f["logic_negate"](self, { logic = f["logic_operation"](self, { A = (th:call_proc(proc_9186745c_97b7_4607_9dae_9af46b3cd7d2, self, f["list_item"](self, { item = "any", list = p_code, list_index = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th) }, th))), B = f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["text_join"](self, { ADD0 = "0" }, th), B = f["list_item"](self, { item = "any", list = p_code, list_index = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th) }, th), OP = "LTE" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th) }, th), B = f["text_join"](self, { ADD0 = "9" }, th), OP = "LTE" }, th), type = "and" }, th), type = "or" }, th) }, th)) then
    f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
    f["variables_set"](self, { value = (th:call_proc(proc_cb5a8bce_0c73_448c_ac32_fbb2f7e82149, self, f["list_item"](self, { item = "any", list = p_v, list_index = 2 }, th), "", 1)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
    f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = (th:call_proc(proc_5e4818da_3fdb_4718_9ba7_0a58a1d41b0d, self, f["script_variables_value"](self, { TEXT = "a" }, th), nil)), ITEM1 = f["script_variables_value"](self, { TEXT = "a" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
    return nil
  end
  f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 2 }, th), list_item_value = f["list_item"](self, { item = "any", list = p_code, list_index = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th) }, th) }, th)
  f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
  f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
  th:call_proc(proc_a4c40a96_8fae_4226_9ec9_b9b9751ba6d9, self, p_code, p_v, nil)
end

proc_a621de99_c663_495a_bb73_539e94b3a042 = function(th, self)
  -- 过程「bd03d81c-0bce-424c-a443-cad2bd4e7813」 id=a621de99-c663-495a-bb73-539e94b3a042
  f["variables_set"](self, { value = f["variables_get"](self, { variable = "9dcb03e8-dfbb-4cf1-acbf-6a96becbca96" }, th), variable = "f6464b41-87be-42b8-ae2a-55f7eac7a359" }, th)
  f["variables_set"](self, { value = f["variables_get"](self, { variable = "f6464b41-87be-42b8-ae2a-55f7eac7a359" }, th), variable = "9dcb03e8-dfbb-4cf1-acbf-6a96becbca96" }, th)
end

proc_a75bfa6d_91ec_4b59_82e1_0a98ecdb705e = function(th, self, p_l, p_s, p_i, p_t)
  -- 过程「6d205304-0d78-4858-8c34-269fbf4cf8a5」 id=a75bfa6d-91ec-4b59-82e1-0a98ecdb705e
  if V.bool(f["logic_compare"](self, { A = p_i, B = f["list_length"](self, { list = p_l }, th), OP = "GT" }, th)) then
    return p_s
  end
  f["list_append"](self, { list = p_s, list_item_value = (th:call_proc(proc_ac536656_1aae_4712_89a4_5afac85d9f8e, self, f["list_item"](self, { item = "any", list = p_l, list_index = p_i }, th), p_t, nil, nil)) }, th)
  return (th:call_proc(proc_a75bfa6d_91ec_4b59_82e1_0a98ecdb705e, self, p_l, p_s, f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th), p_t))
end

proc_ac536656_1aae_4712_89a4_5afac85d9f8e = function(th, self, p_l, p_t)
  -- 过程「5dbfc699-dac5-430a-814c-b3e95b514cab」 id=ac536656-1aae-4712-89a4-5afac85d9f8e
  if V.bool((th:call_proc(proc_b9858f0c_554f_45ef_a324_ba5411bc14ad, self, p_l))) then
    if V.bool(f["logic_compare"](self, { A = f["list_length"](self, { list = p_l }, th), B = 0, OP = "EQ" }, th)) then
      return "[]"
    end
    if V.bool(f["list_is_exist"](self, { list = p_t, list_item_value = p_l }, th)) then
      return "[Circular]"
    end
    f["list_append"](self, { list = p_t, list_item_value = p_l }, th)
    f["script_variables"](self, { PARAMS0 = nil, name = "formatformat" }, th)
    f["variables_set"](self, { value = f["text_join"](self, { ADD0 = "[", ADD1 = (th:call_proc(proc_a75bfa6d_91ec_4b59_82e1_0a98ecdb705e, self, p_l, f["temporary_list"](self, {}, th), 1, p_t)), ADD2 = "]" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"formatformat\"}" }, th)
    f["delete_list_item"](self, { item = "last", list = p_t }, th)
    return f["script_variables_value"](self, { TEXT = "formatformat" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["text_join"](self, { ADD0 = p_l, ADD1 = "" }, th), B = p_l, OP = "EQ" }, th)) then
    f["script_variables"](self, { PARAMS0 = nil, name = "removeremove" }, th)
    f["variables_set"](self, { value = f["text_split"](self, { SPLIT_TEXT = "", TEXT_TO_SPLIT = p_l }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"removeremove\"}" }, th)
    th:warp_enter()
    while true do
      if f["logic_negate"](self, { logic = f["list_is_exist"](self, { list = f["script_variables_value"](self, { TEXT = "removeremove" }, th), list_item_value = "\\" }, th) }, th) then break end
      f["replace_list_item"](self, { item = "any", list = f["script_variables_value"](self, { TEXT = "removeremove" }, th), list_index = f["list_index_of"](self, { list = f["script_variables_value"](self, { TEXT = "removeremove" }, th), list_item_value = "\\" }, th), list_item_value = "\\\\" }, th)
      if th:iter_w() then break end
    end
    while true do
      if f["logic_negate"](self, { logic = f["list_is_exist"](self, { list = f["script_variables_value"](self, { TEXT = "removeremove" }, th), list_item_value = "\"" }, th) }, th) then break end
      f["replace_list_item"](self, { item = "any", list = f["script_variables_value"](self, { TEXT = "removeremove" }, th), list_index = f["list_index_of"](self, { list = f["script_variables_value"](self, { TEXT = "removeremove" }, th), list_item_value = "\"" }, th), list_item_value = "\\\"" }, th)
      if th:iter_w() then break end
    end
    th:warp_exit()
    return f["text_join"](self, { ADD0 = "\"", ADD1 = (th:call_proc(proc_ba4fe1c3_fa6d_4c6d_9ae3_9924083a8b0a, self, f["script_variables_value"](self, { TEXT = "removeremove" }, th), "", 1)), ADD2 = "\"" }, th)
  end
  return p_l
end

proc_b3d1e130_56d4_40d9_95de_4c7396b11b16 = function(th, self, p_tokens, p_global, p_env)
  -- 过程「e4160f53-baa1-4b95-bee9-f56d7e3cd733」 id=b3d1e130-56d4-40d9-95de-4c7396b11b16
  th:warp_enter()
  th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
  f["list_append"](self, { list = p_env, list_item_value = f["temporary_list"](self, {}, th) }, th)
  while true do
    if f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "RightGrace", OP = "EQ" }, th) then break end
    if V.bool(f["variables_get"](self, { variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)) then
      th:warp_exit()
      return 0
    end
    f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), list_item_value = (th:call_proc(proc_8ad455ed_0ad7_4213_aa68_9d8ffe25d346, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    if th:iter_w() then break end
  end
  th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_09f58d51_06fa_49c8_9fa9_f41de0f76f37, self, p_tokens, p_global, "RightGrace", nil)))
  th:warp_exit()
  return f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th)
end

proc_b70d629c_789d_4168_b10b_afeb318088e6 = function(th, self, p_pairs, p_env, p_r, p_i)
  -- 过程「4dbc7ad4-ab78-43f0-9418-cb773ed8a2cd」 id=b70d629c-789d-4168-b10b-afeb318088e6
  if V.bool(f["logic_compare"](self, { A = p_i, B = f["list_length"](self, { list = p_pairs }, th), OP = "GT" }, th)) then
    return p_r
  end
  f["list_append"](self, { list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_r, list_index = 2 }, th), list_index = 1 }, th), list_item_value = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_pairs, list_index = p_i }, th), list_index = 1 }, th), p_env, f["temporary_list"](self, {}, th))) }, th)
  f["list_append"](self, { list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_r, list_index = 2 }, th), list_index = 2 }, th), list_item_value = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_pairs, list_index = p_i }, th), list_index = 2 }, th), p_env, f["temporary_list"](self, {}, th))) }, th)
  return (th:call_proc(proc_b70d629c_789d_4168_b10b_afeb318088e6, self, p_pairs, p_env, p_r, f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th)))
end

proc_b9858f0c_554f_45ef_a324_ba5411bc14ad = function(th, self, p_l)
  -- 过程「2e19ee01-2c43-4434-ac2c-04d06802ec72」 id=b9858f0c-554f-45ef-a324-ba5411bc14ad
  return f["logic_compare"](self, { A = f["list_length"](self, { list = p_l }, th), B = 0, OP = "GTE" }, th)
end

proc_b9ce9990_1b77_4af5_9d76_99be5ee42bfa = function(th, self, p_env, p_n, p_v)
  -- 过程「3b3bc379-9ac4-4caf-ae6d-37f48e9c580e」 id=b9ce9990-1b77-4af5-9d76-99be5ee42bfa
  if V.bool(f["logic_compare"](self, { A = f["list_length"](self, { list = p_env }, th), B = 0, OP = "EQ" }, th)) then
    return (th:call_proc(proc_fdff4a26_8852_4abb_9cb4_ab94e5d7a174, self, f["text_join"](self, { ADD0 = "未定义的符号：\"", ADD1 = p_n, ADD2 = "\"" }, th)))
  end
  f["script_variables"](self, { PARAMS0 = nil, name = "#2" }, th)
  f["variables_set"](self, { value = f["list_index_of"](self, { list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th), list_index = 1 }, th), list_item_value = p_n }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"#2\"}" }, th)
  if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "#2" }, th), B = 0, OP = "GT" }, th)) then
    f["replace_list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th), list_index = 2 }, th), list_index = f["script_variables_value"](self, { TEXT = "#2" }, th), list_item_value = p_v }, th)
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  return (th:call_proc(proc_b9ce9990_1b77_4af5_9d76_99be5ee42bfa, self, f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), p_n, p_v, nil))
end

proc_ba4fe1c3_fa6d_4c6d_9ae3_9924083a8b0a = function(th, self, p_l, p_r, p_i)
  -- 过程「ba5e927e-bc6f-4524-b985-1a76db398770」 id=ba4fe1c3-fa6d-4c6d-9ae3-9924083a8b0a
  if V.bool(f["logic_compare"](self, { A = p_i, B = f["list_length"](self, { list = p_l }, th), OP = "GT" }, th)) then
    return p_r
  end
  return (th:call_proc(proc_ba4fe1c3_fa6d_4c6d_9ae3_9924083a8b0a, self, p_l, f["text_join"](self, { ADD0 = p_r, ADD1 = f["list_item"](self, { item = "any", list = p_l, list_index = p_i }, th) }, th), f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th)))
end

proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528 = function(th, self, p_tokens, p_global, p_env)
  -- 过程「8a17f8ab-8516-406d-be1b-35dd82c033f9」 id=bfa2f83c-ca7e-405c-a52e-3db0ed532528
  return (th:call_proc(proc_6be6ac61_9b92_4bba_8470_e6a31431a34d, self, p_tokens, p_global, 1, f["temporary_list"](self, {}, th), nil, nil, nil, nil, nil))
end

proc_bfd7e9dd_7ad6_46e2_89c2_9d081462c62c = function(th, self, p_env, p_a, p_l, p_n, p_i)
  -- 过程「a4f2a4be-01a4-4ad3-87b8-fa38b22765c4」 id=bfd7e9dd-7ad6-46e2-89c2-9d081462c62c
  if V.bool(f["logic_compare"](self, { A = p_i, B = p_n, OP = "GT" }, th)) then
    return p_l
  end
  if V.bool(f["logic_compare"](self, { A = p_i, B = f["list_length"](self, { list = p_a }, th), OP = "GT" }, th)) then
    return (th:call_proc(proc_fdff4a26_8852_4abb_9cb4_ab94e5d7a174, self, f["text_join"](self, { ADD0 = "错误数量的参数：期望 ", ADD1 = p_i, ADD2 = " 个，实际得到 ", ADD3 = f["list_length"](self, { list = p_a }, th), ADD4 = " 个" }, th)))
  else
    f["list_append"](self, { list = p_l, list_item_value = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_a, list_index = p_i }, th), p_env, f["temporary_list"](self, {}, th))) }, th)
  end
  return (th:call_proc(proc_bfd7e9dd_7ad6_46e2_89c2_9d081462c62c, self, p_env, p_a, p_l, p_n, f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th)))
end

proc_c50c29e1_f1fd_4464_a845_7295a1078080 = function(th, self)
  -- 过程「202bbf8b-a798-4822-9324-3806b6d43130」 id=c50c29e1-f1fd-4464-a845-7295a1078080
  return f["math_arithmetic"](self, { A = 0, B = 0, type = "divide" }, th)
end

proc_c5bc63b5_725d_463e_856b_0ec83f60ae9f = function(th, self, p_code, p_v)
  -- 过程「def8142d-ed61-41de-9914-5a5142e01dfd」 id=c5bc63b5-725d-463e-856b-0ec83f60ae9f
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = f["list_length"](self, { list = p_code }, th), OP = "GT" }, th)) then
    return nil
  end
  if V.bool(f["logic_operation"](self, { A = f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th) }, th), B = " ", OP = "NEQ" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th) }, th), B = "\
", OP = "NEQ" }, th), type = "and" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th) }, th), B = "	", OP = "NEQ" }, th), type = "and" }, th)) then
    return nil
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th) }, th), B = "\
", OP = "EQ" }, th)) then
    f["replace_list_item"](self, { item = "any", list = p_v, list_index = 4, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), B = 1, type = "add" }, th) }, th)
    f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = 0 }, th)
  else
    f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
  end
  f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
  th:call_proc(proc_c5bc63b5_725d_463e_856b_0ec83f60ae9f, self, p_code, p_v)
end

proc_c60a7cae_450c_4d26_8c44_f1144792d722 = function(th, self, p_list)
  -- 过程「41d679f9-3615-4cb2-b647-5c983c5451e4」 id=c60a7cae-450c-4d26-8c44-f1144792d722
  return (th:call_proc(proc_ac536656_1aae_4712_89a4_5afac85d9f8e, self, p_list, f["temporary_list"](self, {}, th), nil, nil))
end

proc_cb5a8bce_0c73_448c_ac32_fbb2f7e82149 = function(th, self, p_split, p_s, p_i)
  -- 过程「0997e6cd-2efe-4b8a-ac4f-5cbf2aa08264」 id=cb5a8bce-0c73-448c-ac32-fbb2f7e82149
  if V.bool(f["logic_compare"](self, { A = p_i, B = f["list_length"](self, { list = p_split }, th), OP = "GT" }, th)) then
    f["delete_list_item"](self, { item = "all", list = p_split }, th)
    return p_s
  end
  return (th:call_proc(proc_cb5a8bce_0c73_448c_ac32_fbb2f7e82149, self, p_split, f["text_join"](self, { ADD0 = p_s, ADD1 = f["list_item"](self, { item = "any", list = p_split, list_index = p_i }, th) }, th), f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th)))
end

proc_d4a50d54_6168_41f6_a527_491c49c608ef = function(th, self, p_node, p_env, p_v)
  -- 过程「0e0eb936-02f3-4475-ac95-935023703d00」 id=d4a50d54-6168-41f6-a527-491c49c608ef
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "identifier", OP = "EQ" }, th)) then
    return f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "number", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), B = 1, type = "multiply" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "string", OP = "EQ" }, th)) then
    return f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "true", OP = "EQ" }, th)) then
    return true
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "false", OP = "EQ" }, th)) then
    return false
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "nan", OP = "EQ" }, th)) then
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "environ", OP = "EQ" }, th)) then
    return p_env
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "list", OP = "EQ" }, th)) then
    return (th:call_proc(proc_569f9907_450b_496d_af3e_e5a6f9b700eb, self, f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), p_env, f["temporary_list"](self, {}, th), 1))
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "dictL", OP = "EQ" }, th)) then
    return (th:call_proc(proc_b70d629c_789d_4168_b10b_afeb318088e6, self, f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), p_env, f["temporary_list"](self, { ITEM0 = "dict", ITEM1 = f["temporary_list"](self, { ITEM0 = f["temporary_list"](self, {}, th), ITEM1 = f["temporary_list"](self, {}, th) }, th) }, th), 1))
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "dict", OP = "EQ" }, th)) then
    return p_node
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "ternary", OP = "EQ" }, th)) then
    if V.bool((th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), p_env, f["temporary_list"](self, {}, th)))) then
      return (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th)))
    end
    return (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 4 }, th), p_env, f["temporary_list"](self, {}, th)))
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "binary", OP = "EQ" }, th)) then
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), B = "Add", OP = "EQ" }, th)) then
      return f["math_arithmetic"](self, { A = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))), B = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 4 }, th), p_env, f["temporary_list"](self, {}, th))), type = "add" }, th)
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), B = "Sub", OP = "EQ" }, th)) then
      return f["math_arithmetic"](self, { A = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))), B = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 4 }, th), p_env, f["temporary_list"](self, {}, th))), type = "minus" }, th)
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), B = "Mul", OP = "EQ" }, th)) then
      return f["math_arithmetic"](self, { A = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))), B = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 4 }, th), p_env, f["temporary_list"](self, {}, th))), type = "multiply" }, th)
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), B = "Div", OP = "EQ" }, th)) then
      return f["math_arithmetic"](self, { A = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))), B = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 4 }, th), p_env, f["temporary_list"](self, {}, th))), type = "divide" }, th)
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), B = "Pow", OP = "EQ" }, th)) then
      return f["math_arithmetic"](self, { A = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))), B = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 4 }, th), p_env, f["temporary_list"](self, {}, th))), type = "power" }, th)
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), B = "Mod", OP = "EQ" }, th)) then
      return f["math_modulo"](self, { A = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))), B = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 4 }, th), p_env, f["temporary_list"](self, {}, th))) }, th)
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), B = "Lt", OP = "EQ" }, th)) then
      return f["logic_compare"](self, { A = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))), B = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 4 }, th), p_env, f["temporary_list"](self, {}, th))), OP = "LT" }, th)
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), B = "Le", OP = "EQ" }, th)) then
      return f["logic_compare"](self, { A = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))), B = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 4 }, th), p_env, f["temporary_list"](self, {}, th))), OP = "LTE" }, th)
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), B = "Gt", OP = "EQ" }, th)) then
      return f["logic_compare"](self, { A = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))), B = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 4 }, th), p_env, f["temporary_list"](self, {}, th))), OP = "GT" }, th)
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), B = "Ge", OP = "EQ" }, th)) then
      return f["logic_compare"](self, { A = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))), B = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 4 }, th), p_env, f["temporary_list"](self, {}, th))), OP = "GTE" }, th)
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), B = "Eq", OP = "EQ" }, th)) then
      return f["list_is_exist"](self, { list = f["temporary_list"](self, { ITEM0 = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))) }, th), list_item_value = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 4 }, th), p_env, f["temporary_list"](self, {}, th))) }, th)
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), B = "Ne", OP = "EQ" }, th)) then
      return f["logic_negate"](self, { logic = f["list_is_exist"](self, { list = f["temporary_list"](self, { ITEM0 = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))) }, th), list_item_value = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 4 }, th), p_env, f["temporary_list"](self, {}, th))) }, th) }, th)
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), B = "And", OP = "EQ" }, th)) then
      if V.bool(f["logic_negate"](self, { logic = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))) }, th)) then
        return false
      end
      return f["convert_type"](self, { text = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 4 }, th), p_env, f["temporary_list"](self, {}, th))), type = "boolean" }, th)
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), B = "Or", OP = "EQ" }, th)) then
      if V.bool((th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th)))) then
        return true
      end
      return f["convert_type"](self, { text = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 4 }, th), p_env, f["temporary_list"](self, {}, th))), type = "boolean" }, th)
    end
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "unary", OP = "EQ" }, th)) then
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), B = "Sub", OP = "EQ" }, th)) then
      return f["math_function"](self, { num = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))), type = "2" }, th)
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), B = "Not", OP = "EQ" }, th)) then
      return f["logic_negate"](self, { logic = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))) }, th)
    end
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "function", OP = "EQ" }, th)) then
    if V.bool(f["logic_compare"](self, { A = f["list_length"](self, { list = p_node }, th), B = 4, OP = "EQ" }, th)) then
      return f["temporary_list"](self, { ITEM0 = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), ITEM1 = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), ITEM3 = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 4 }, th), p_env, f["temporary_list"](self, {}, th))) }, th)
    end
    return f["temporary_list"](self, { ITEM0 = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), ITEM1 = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), ITEM3 = p_env }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "assignVar", OP = "EQ" }, th)) then
    return (th:call_proc(proc_00052c87_d103_4c38_b378_685e8251a501, self, p_env, (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), p_env, f["temporary_list"](self, {}, th))), (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))), nil))
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "changeVar", OP = "EQ" }, th)) then
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), list_index = 1 }, th), B = "identifier", OP = "EQ" }, th)) then
      return (th:call_proc(proc_b9ce9990_1b77_4af5_9d76_99be5ee42bfa, self, p_env, (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), p_env, f["temporary_list"](self, {}, th))), (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))), nil))
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), list_index = 1 }, th), B = "index", OP = "EQ" }, th)) then
      f["list_append"](self, { list = p_v, list_item_value = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), list_index = 2 }, th), p_env, f["temporary_list"](self, {}, th))) }, th)
      f["list_append"](self, { list = p_v, list_item_value = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))) }, th)
      f["list_append"](self, { list = p_v, list_item_value = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))) }, th)
      if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["list_length"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th) }, th), B = 2, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), list_index = 1 }, th), B = "dict", OP = "EQ" }, th), type = "and" }, th)) then
        return (th:call_proc(proc_923e1ade_6e8f_4d2b_8d72_0bee849299c8, self, "dictSet", f["temporary_list"](self, { ITEM0 = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), ITEM1 = f["list_item"](self, { item = "any", list = p_v, list_index = 2 }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th) }, th), nil, nil, nil, nil, nil, nil, nil, nil))
      end
      f["replace_list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 2 }, th), B = 1, type = "add" }, th), list_item_value = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th) }, th)
      return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
    end
    return (th:call_proc(proc_fdff4a26_8852_4abb_9cb4_ab94e5d7a174, self, f["text_join"](self, { ADD0 = "非法的赋值左值：\"", ADD1 = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), ADD2 = "\"" }, th)))
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "getVar", OP = "EQ" }, th)) then
    return (th:call_proc(proc_6cbcb627_87ad_413d_a95d_943e43d0f90d, self, p_env, (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), p_env, f["temporary_list"](self, {}, th))), nil))
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "index", OP = "EQ" }, th)) then
    f["list_append"](self, { list = p_v, list_item_value = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), p_env, f["temporary_list"](self, {}, th))) }, th)
    f["list_append"](self, { list = p_v, list_item_value = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))) }, th)
    if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["list_length"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th) }, th), B = 2, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), list_index = 1 }, th), B = "dict", OP = "EQ" }, th), type = "and" }, th)) then
      return (th:call_proc(proc_923e1ade_6e8f_4d2b_8d72_0bee849299c8, self, "dictGet", f["temporary_list"](self, { ITEM0 = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), ITEM1 = f["list_item"](self, { item = "any", list = p_v, list_index = 2 }, th) }, th), nil, nil, nil, nil, nil, nil, nil, nil))
    end
    return f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 2 }, th), B = 1, type = "add" }, th) }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "while", OP = "EQ" }, th)) then
    f["list_append"](self, { list = p_v, list_item_value = (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self)) }, th)
    th:warp_enter()
    while true do
      if false then break end
      while true do
        if false then break end
        if V.bool(f["logic_negate"](self, { logic = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), p_env, f["temporary_list"](self, {}, th))) }, th)) then
          f["variables_set"](self, { value = "condition", variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th)
          break
        end
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = (th:call_proc(proc_803f4f62_01e2_4370_b5e6_88cd6ad88290, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), f["temporary_list"](self, { ITEM0 = p_env, ITEM1 = f["temporary_list"](self, { ITEM0 = f["temporary_list"](self, {}, th), ITEM1 = f["temporary_list"](self, {}, th) }, th), ITEM2 = true }, th), (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self)), 1)) }, th)
        if V.bool(f["variables_get"](self, { variable = "b6b5f7c3-2437-4272-9ccb-1e647362b076" }, th)) then
          th:warp_exit()
          return f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th)
        end
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th), B = "break", OP = "EQ" }, th)) then
          break
        end
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th), B = "continue", OP = "EQ" }, th)) then
          f["variables_set"](self, { value = "", variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th)
          break
        end
        if th:iter_w() then break end
      end
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th), B = "condition", OP = "EQ" }, th)) then
        f["variables_set"](self, { value = "", variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th), B = "break", OP = "EQ" }, th)) then
        f["variables_set"](self, { value = "", variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th)
        break
      end
      if th:iter_w() then break end
    end
    f["variables_set"](self, { value = "", variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th)
    th:warp_exit()
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "for", OP = "EQ" }, th)) then
    f["list_append"](self, { list = p_v, list_item_value = f["temporary_list"](self, { ITEM0 = p_env, ITEM1 = f["temporary_list"](self, { ITEM0 = f["temporary_list"](self, {}, th), ITEM1 = f["temporary_list"](self, {}, th) }, th), ITEM2 = true }, th) }, th)
    if V.bool(f["logic_compare"](self, { A = f["list_length"](self, { list = f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th) }, th), B = 0, OP = "GT" }, th)) then
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), f["temporary_list"](self, {}, th))))
    end
    f["list_append"](self, { list = p_v, list_item_value = (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self)) }, th)
    th:warp_enter()
    while true do
      if false then break end
      do
        local _times_n1 = 1
        while true do
          if _times_n1 <= 0 then break end
          _times_n1 = _times_n1 - 1
          if V.bool(f["logic_compare"](self, { A = f["list_length"](self, { list = f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th) }, th), B = 0, OP = "GT" }, th)) then
            if V.bool(f["logic_negate"](self, { logic = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), f["temporary_list"](self, {}, th))) }, th)) then
              f["variables_set"](self, { value = "condition", variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th)
              break
            end
          end
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 2, list_item_value = (th:call_proc(proc_803f4f62_01e2_4370_b5e6_88cd6ad88290, self, f["list_item"](self, { item = "any", list = p_node, list_index = 5 }, th), f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self)), 1)) }, th)
          if V.bool(f["variables_get"](self, { variable = "b6b5f7c3-2437-4272-9ccb-1e647362b076" }, th)) then
            th:warp_exit()
            return f["list_item"](self, { item = "any", list = p_v, list_index = 2 }, th)
          end
          if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th), B = "break", OP = "EQ" }, th)) then
            break
          end
          if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th), B = "continue", OP = "EQ" }, th)) then
            f["variables_set"](self, { value = "", variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th)
            break
          end
          if th:iter_w() then break end
        end
      end
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th), B = "break", OP = "EQ" }, th)) then
        f["variables_set"](self, { value = "", variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th), B = "condition", OP = "EQ" }, th)) then
        f["variables_set"](self, { value = "", variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["list_length"](self, { list = f["list_item"](self, { item = "any", list = p_node, list_index = 4 }, th) }, th), B = 0, OP = "GT" }, th)) then
        th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 4 }, th), f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), f["temporary_list"](self, {}, th))))
      end
      if th:iter_w() then break end
    end
    f["variables_set"](self, { value = "", variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th)
    th:warp_exit()
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "if", OP = "EQ" }, th)) then
    if V.bool((th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), p_env, f["temporary_list"](self, {}, th)))) then
      return (th:call_proc(proc_803f4f62_01e2_4370_b5e6_88cd6ad88290, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), f["temporary_list"](self, { ITEM0 = p_env, ITEM1 = f["temporary_list"](self, { ITEM0 = f["temporary_list"](self, {}, th), ITEM1 = f["temporary_list"](self, {}, th) }, th), ITEM2 = true }, th), (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self)), 1))
    else
      if V.bool(f["logic_compare"](self, { A = f["list_length"](self, { list = p_node }, th), B = 4, OP = "EQ" }, th)) then
        return (th:call_proc(proc_803f4f62_01e2_4370_b5e6_88cd6ad88290, self, f["list_item"](self, { item = "any", list = p_node, list_index = 4 }, th), f["temporary_list"](self, { ITEM0 = p_env, ITEM1 = f["temporary_list"](self, { ITEM0 = f["temporary_list"](self, {}, th), ITEM1 = f["temporary_list"](self, {}, th) }, th), ITEM2 = true }, th), (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self)), 1))
      end
      return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
    end
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "call", OP = "EQ" }, th)) then
    f["list_append"](self, { list = p_v, list_item_value = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), p_env, f["temporary_list"](self, {}, th))) }, th)
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), list_index = 1 }, th), B = "native", OP = "EQ" }, th)) then
      f["list_append"](self, { list = p_v, list_item_value = (th:call_proc(proc_bfd7e9dd_7ad6_46e2_89c2_9d081462c62c, self, p_env, f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), f["temporary_list"](self, {}, th), f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), list_index = 2 }, th), 1)) }, th)
      return (th:call_proc(proc_923e1ade_6e8f_4d2b_8d72_0bee849299c8, self, f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), list_index = 3 }, th), f["list_item"](self, { item = "any", list = p_v, list_index = 2 }, th), nil, nil, nil, nil, nil, nil, nil, nil))
    elseif V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), list_index = 1 }, th), B = "function", OP = "EQ" }, th)) then
      f["list_append"](self, { list = p_v, list_item_value = (th:call_proc(proc_8836e0fd_6d26_4479_9180_8424267a294e, self, p_env, f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), list_index = 2 }, th), f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), f["temporary_list"](self, { ITEM0 = f["temporary_list"](self, {}, th), ITEM1 = f["temporary_list"](self, {}, th) }, th), 1, f["temporary_list"](self, {}, th))) }, th)
      return (th:call_proc(proc_803f4f62_01e2_4370_b5e6_88cd6ad88290, self, f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), list_index = 3 }, th), f["temporary_list"](self, { ITEM0 = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), list_index = 4 }, th), ITEM1 = f["list_item"](self, { item = "any", list = p_v, list_index = 2 }, th), ITEM2 = false }, th), (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self)), 1))
    else
      return (th:call_proc(proc_fdff4a26_8852_4abb_9cb4_ab94e5d7a174, self, f["text_join"](self, { ADD0 = "\"", ADD1 = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), list_index = 1 }, th), ADD2 = "\"不是一个可调用的值" }, th)))
    end
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "return", OP = "EQ" }, th)) then
    if V.bool(f["logic_compare"](self, { A = f["list_length"](self, { list = p_node }, th), B = 2, OP = "EQ" }, th)) then
      f["list_append"](self, { list = p_v, list_item_value = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), p_env, f["temporary_list"](self, {}, th))) }, th)
      if V.bool(f["logic_negate"](self, { logic = f["variables_get"](self, { variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th) }, th)) then
        f["variables_set"](self, { value = true, variable = "b6b5f7c3-2437-4272-9ccb-1e647362b076" }, th)
      end
      return f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th)
    end
    f["variables_set"](self, { value = true, variable = "b6b5f7c3-2437-4272-9ccb-1e647362b076" }, th)
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "break", OP = "EQ" }, th)) then
    f["variables_set"](self, { value = "break", variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th)
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "throw", OP = "EQ" }, th)) then
    f["variables_set"](self, { value = (th:call_proc(proc_d4a50d54_6168_41f6_a527_491c49c608ef, self, f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), p_env, f["temporary_list"](self, {}, th))), variable = "06f6cc9b-ad2e-44e3-bea6-e4b25cb4cd99" }, th)
    f["variables_set"](self, { value = true, variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "continue", OP = "EQ" }, th)) then
    f["variables_set"](self, { value = "continue", variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th)
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), B = "try", OP = "EQ" }, th)) then
    f["list_append"](self, { list = p_v, list_item_value = (th:call_proc(proc_803f4f62_01e2_4370_b5e6_88cd6ad88290, self, f["list_item"](self, { item = "any", list = p_node, list_index = 3 }, th), f["temporary_list"](self, { ITEM0 = p_env, ITEM1 = f["temporary_list"](self, { ITEM0 = f["temporary_list"](self, {}, th), ITEM1 = f["temporary_list"](self, {}, th) }, th), ITEM2 = true }, th), (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self)), 1)) }, th)
    if V.bool(f["variables_get"](self, { variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)) then
      f["variables_set"](self, { value = false, variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)
      f["variables_set"](self, { value = false, variable = "b6b5f7c3-2437-4272-9ccb-1e647362b076" }, th)
      if V.bool(f["logic_compare"](self, { A = f["list_length"](self, { list = p_node }, th), B = 4, OP = "EQ" }, th)) then
        f["list_append"](self, { list = p_v, list_item_value = (th:call_proc(proc_803f4f62_01e2_4370_b5e6_88cd6ad88290, self, f["list_item"](self, { item = "any", list = p_node, list_index = 4 }, th), f["temporary_list"](self, { ITEM0 = p_env, ITEM1 = (th:call_proc(proc_8836e0fd_6d26_4479_9180_8424267a294e, self, p_env, f["list_item"](self, { item = "any", list = p_node, list_index = 2 }, th), f["temporary_list"](self, { ITEM0 = f["variables_get"](self, { variable = "06f6cc9b-ad2e-44e3-bea6-e4b25cb4cd99" }, th) }, th), f["temporary_list"](self, { ITEM0 = f["temporary_list"](self, {}, th), ITEM1 = f["temporary_list"](self, {}, th) }, th), 1, f["temporary_list"](self, {}, th))), ITEM2 = true }, th), (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self)), 1)) }, th)
        if V.bool(f["variables_get"](self, { variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)) then
          return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
        end
        if V.bool(f["variables_get"](self, { variable = "b6b5f7c3-2437-4272-9ccb-1e647362b076" }, th)) then
          return f["list_item"](self, { item = "last", list = p_v }, th)
        end
      end
    end
    if V.bool(f["variables_get"](self, { variable = "b6b5f7c3-2437-4272-9ccb-1e647362b076" }, th)) then
      return f["list_item"](self, { item = "last", list = p_v }, th)
    end
    return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
  end
  return (th:call_proc(proc_fdff4a26_8852_4abb_9cb4_ab94e5d7a174, self, f["text_join"](self, { ADD0 = "未知的节点：\"", ADD1 = f["list_item"](self, { item = "any", list = p_node, list_index = 1 }, th), ADD2 = "\"" }, th)))
end

proc_d920a649_112b_48f8_a825_4d0498684265 = function(th, self, p_env, p_l)
  -- 过程「e54c0a1f-150c-4e17-b31f-34ae9b8db2b7」 id=d920a649-112b-48f8-a825-4d0498684265
  f["list_append"](self, { list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th), list_index = 1 }, th), list_item_value = f["list_item"](self, { item = "any", list = p_l, list_index = 1 }, th) }, th)
  f["list_append"](self, { list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = p_env, list_index = 2 }, th), list_index = 2 }, th), list_item_value = f["list_item"](self, { item = "any", list = p_l, list_index = 2 }, th) }, th)
end

proc_da9cde44_c87a_45dd_8679_74c712c8300a = function(th, self, p_a, p_b)
  -- 过程「6f0cf1de-15c2-4b94-a8bf-ea954597ac8b」 id=da9cde44-c87a-45dd-8679-74c712c8300a
  if V.bool(f["logic_compare"](self, { A = p_a, B = p_b, OP = "GT" }, th)) then
    return p_a
  end
  return p_b
end

proc_db4375fd_d4a6_4c57_b430_333603f7ba36 = function(th, self, p_mode, p_code, p_v)
  -- 过程「ebe0f2f2-f497-41c9-b8bb-666975413738」 id=db4375fd-d4a6-4c57-b430-333603f7ba36
  do
    local _times_n1 = 1
    while true do
      if _times_n1 <= 0 then break end
      _times_n1 = _times_n1 - 1
      if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = f["list_length"](self, { list = p_code }, th), OP = "GT" }, th)) then
        th:call_proc(proc_e115ca8b_53f0_4844_97a3_a15141c0a242, self, f["text_join"](self, { ADD0 = "未闭合的字符串" }, th), p_v)
        return nil
      end
      f["script_variables"](self, { PARAMS0 = nil, name = "s" }, th)
      f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = p_code, list_index = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"s\"}" }, th)
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "s" }, th), B = p_mode, OP = "EQ" }, th)) then
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "String", ITEM1 = (th:call_proc(proc_cb5a8bce_0c73_448c_ac32_fbb2f7e82149, self, f["list_item"](self, { item = "any", list = p_v, list_index = 2 }, th), "", 1)), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        return nil
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "s" }, th), B = "\\", OP = "EQ" }, th)) then
        if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = "\"", OP = "EQ" }, th)) then
          f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 2 }, th), list_item_value = "\"" }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 2, type = "add" }, th) }, th)
          break
        end
        if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = "'", OP = "EQ" }, th)) then
          f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 2 }, th), list_item_value = "'" }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 2, type = "add" }, th) }, th)
          break
        end
        if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = "n", OP = "EQ" }, th)) then
          f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 2 }, th), list_item_value = "\
" }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 2, type = "add" }, th) }, th)
          break
        end
        if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = "t", OP = "EQ" }, th)) then
          f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 2 }, th), list_item_value = "	" }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 2, type = "add" }, th) }, th)
          break
        end
        if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = "\\", OP = "EQ" }, th)) then
          f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 2 }, th), list_item_value = "\\" }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 2, type = "add" }, th) }, th)
          break
        end
        if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = "u", OP = "EQ" }, th)) then
          f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 2 }, th), list_item_value = f["text_select"](self, { start_index = f["math_arithmetic"](self, { A = f["convert_type"](self, { text = f["text_join"](self, { ADD0 = "0x", ADD1 = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th), ADD2 = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 3, type = "add" }, th) }, th), ADD3 = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 4, type = "add" }, th) }, th), ADD4 = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 5, type = "add" }, th) }, th) }, th), type = "number" }, th), B = 1, type = "add" }, th), text = f["variables_get"](self, { variable = "59416620-c0d2-49a0-9006-a52b1e5bb833" }, th) }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 6, type = "add" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 6, type = "add" }, th) }, th)
          break
        end
        th:call_proc(proc_e115ca8b_53f0_4844_97a3_a15141c0a242, self, f["text_join"](self, { ADD0 = "未知的转义：\"\\", ADD1 = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), ADD2 = "\"" }, th), p_v)
      end
      f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 2 }, th), list_item_value = f["script_variables_value"](self, { TEXT = "s" }, th) }, th)
      f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "s" }, th), B = "\
", OP = "EQ" }, th)) then
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 4, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = 0 }, th)
      else
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
      end
      if th:iter_d() then break end
    end
  end
  th:call_proc(proc_db4375fd_d4a6_4c57_b430_333603f7ba36, self, p_mode, p_code, p_v, nil)
end

proc_dfb1a1a9_094c_4010_a210_76cf972162e9 = function(th, self)
  -- 过程「25ad3b93-0ea8-46ac-8a7c-9ff2e68f56bd」 id=dfb1a1a9-094c-4010-a210-76cf972162e9
  f["self_point_towards"](self, { degrees = 90 }, th)
  f["self_move_to"](self, { x = 0, y = 200 }, th)
  f["self_set_pen_color"](self, { color = "#1a1a1a" }, th)
  f["stamp"](self, { align = "left", size = 1000, text = "█" }, th)
  f["self_point_towards"](self, { degrees = -90 }, th)
  f["self_move_to"](self, { x = 0, y = -200 }, th)
  f["self_set_pen_color"](self, { color = "#1a1a1a" }, th)
  f["stamp"](self, { align = "left", size = 1000, text = "█" }, th)
  f["self_point_towards"](self, { degrees = 0 }, th)
  f["self_move_to"](self, { x = -50, y = 0 }, th)
  f["self_set_pen_color"](self, { color = "#333333" }, th)
  f["stamp"](self, { align = "left", size = 1000, text = "█" }, th)
  f["self_set_pen_color"](self, { color = "#999999" }, th)
  f["self_set_pen_color_property"](self, { scope = "alpha", val = 75 }, th)
  f["self_move_to"](self, { x = -438, y = 258 }, th)
  f["stamp"](self, { align = "left", size = 24, text = "Canvas" }, th)
  f["self_set_pen_color"](self, { color = "#ffffff" }, th)
  f["self_set_pen_color_property"](self, { scope = "alpha", val = 0 }, th)
  f["self_move_to"](self, { x = -440, y = 260 }, th)
  f["stamp"](self, { align = "left", size = 24, text = "Canvas" }, th)
  f["self_set_pen_color"](self, { color = "#999999" }, th)
  f["self_set_pen_color_property"](self, { scope = "alpha", val = 75 }, th)
  f["self_move_to"](self, { x = -18, y = 258 }, th)
  f["stamp"](self, { align = "left", size = 24, text = "Console" }, th)
  f["self_set_pen_color"](self, { color = "#ffffff" }, th)
  f["self_set_pen_color_property"](self, { scope = "alpha", val = 0 }, th)
  f["self_move_to"](self, { x = -20, y = 260 }, th)
  f["stamp"](self, { align = "left", size = 24, text = "Console" }, th)
  f["self_move_to"](self, { x = 390, y = -220 }, th)
  f["image_stamp"](self, {}, th)
end

proc_e115ca8b_53f0_4844_97a3_a15141c0a242 = function(th, self, p_msg, p_v)
  -- 过程「b22a20be-72ca-4dc1-8b8f-ef61fc38b649」 id=e115ca8b-53f0-4844-97a3-a15141c0a242
  f["variables_set"](self, { value = f["temporary_list"](self, { ITEM0 = "dict", ITEM1 = f["temporary_list"](self, { ITEM0 = f["temporary_list"](self, { ITEM0 = "type", ITEM1 = "msg" }, th), ITEM1 = f["temporary_list"](self, { ITEM0 = "SystemError", ITEM1 = f["text_join"](self, { ADD0 = "", ADD1 = p_msg, ADD2 = "，位于行", ADD3 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ADD4 = "，列", ADD5 = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = f["text_length"](self, { text = f["variables_get"](self, { variable = "4819da5c-3e70-45b5-935e-a049951d72b2" }, th) }, th), type = "minus" }, th) }, th) }, th) }, th) }, th), variable = "06f6cc9b-ad2e-44e3-bea6-e4b25cb4cd99" }, th)
  f["variables_set"](self, { value = true, variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)
end

proc_ea2840b0_96b7_4a3c_95e7_bff42dde31b0 = function(th, self, p_code, p_v)
  -- 过程「6c02e7e8-29a0-4066-84d6-6c7dffeb264b」 id=ea2840b0-96b7-4a3c-95e7-bff42dde31b0
  if V.bool(f["variables_get"](self, { variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)) then
    return 0
  end
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = f["list_length"](self, { list = p_code }, th), type = "divide" }, th), B = 10000, type = "multiply" }, th), type = "round" }, th), B = 100, type = "divide" }, th), variable = "ba500ff5-06c1-4d86-858e-2b1f92a17424" }, th)
  do
    local _times_n1 = 1
    while true do
      if _times_n1 <= 0 then break end
      _times_n1 = _times_n1 - 1
      th:call_proc(proc_c5bc63b5_725d_463e_856b_0ec83f60ae9f, self, p_code, p_v)
      if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = f["list_length"](self, { list = p_code }, th), OP = "GT" }, th)) then
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "EOF", ITEM1 = "EOF" }, th) }, th)
        return f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th)
      end
      th:call_proc(proc_c5bc63b5_725d_463e_856b_0ec83f60ae9f, self, p_code, p_v)
      f["script_variables"](self, { PARAMS0 = nil, name = "char" }, th)
      f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = p_code, list_index = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"char\"}" }, th)
      if V.bool((th:call_proc(proc_9186745c_97b7_4607_9dae_9af46b3cd7d2, self, f["script_variables_value"](self, { TEXT = "char" }, th)))) then
        th:call_proc(proc_a4c40a96_8fae_4226_9ec9_b9b9751ba6d9, self, p_code, p_v, nil)
        break
      end
      if V.bool((th:call_proc(proc_61d190fb_f81a_4dbe_83ec_f4b19e214a3b, self, f["script_variables_value"](self, { TEXT = "char" }, th)))) then
        th:call_proc(proc_636b3378_66f6_4cef_9502_9dc7953af847, self, p_code, p_v, nil)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = "\"", OP = "EQ" }, th)) then
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        th:call_proc(proc_db4375fd_d4a6_4c57_b430_333603f7ba36, self, "\"", p_code, p_v, nil)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = "'", OP = "EQ" }, th)) then
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        th:call_proc(proc_db4375fd_d4a6_4c57_b430_333603f7ba36, self, "'", p_code, p_v, nil)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = "=", OP = "EQ" }, th)) then
        if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = "=", OP = "EQ" }, th)) then
          f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Eq", ITEM1 = "==", ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 2, type = "add" }, th) }, th)
          break
        end
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Assign", ITEM1 = f["script_variables_value"](self, { TEXT = "char" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = "(", OP = "EQ" }, th)) then
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "LeftParen", ITEM1 = f["script_variables_value"](self, { TEXT = "char" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = ")", OP = "EQ" }, th)) then
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "RightParen", ITEM1 = f["script_variables_value"](self, { TEXT = "char" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = "{", OP = "EQ" }, th)) then
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "LeftGrace", ITEM1 = f["script_variables_value"](self, { TEXT = "char" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = "}", OP = "EQ" }, th)) then
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "RightGrace", ITEM1 = f["script_variables_value"](self, { TEXT = "char" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = ";", OP = "EQ" }, th)) then
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Semicolon", ITEM1 = f["script_variables_value"](self, { TEXT = "char" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = ",", OP = "EQ" }, th)) then
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Comma", ITEM1 = f["script_variables_value"](self, { TEXT = "char" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = "[", OP = "EQ" }, th)) then
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "LeftSquare", ITEM1 = f["script_variables_value"](self, { TEXT = "char" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = "]", OP = "EQ" }, th)) then
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "RightSquare", ITEM1 = f["script_variables_value"](self, { TEXT = "char" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = ":", OP = "EQ" }, th)) then
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Colon", ITEM1 = f["script_variables_value"](self, { TEXT = "char" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = ".", OP = "EQ" }, th)) then
        if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = ".", OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th), B = ".", OP = "EQ" }, th), type = "and" }, th)) then
          f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Spread", ITEM1 = "...", ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 3, type = "add" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 3, type = "add" }, th) }, th)
          break
        end
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Dot", ITEM1 = f["script_variables_value"](self, { TEXT = "char" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = "+", OP = "EQ" }, th)) then
        if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = "=", OP = "EQ" }, th)) then
          f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Reunite", ITEM1 = "+=", ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), ITEM4 = "Add" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 2, type = "add" }, th) }, th)
          break
        end
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Add", ITEM1 = f["script_variables_value"](self, { TEXT = "char" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = "-", OP = "EQ" }, th)) then
        if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = "=", OP = "EQ" }, th)) then
          f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Reunite", ITEM1 = "-=", ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), ITEM4 = "Sub" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 2, type = "add" }, th) }, th)
          break
        end
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Sub", ITEM1 = f["script_variables_value"](self, { TEXT = "char" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = "*", OP = "EQ" }, th)) then
        if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = "=", OP = "EQ" }, th)) then
          f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Reunite", ITEM1 = "*=", ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), ITEM4 = "Mul" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 2, type = "add" }, th) }, th)
          break
        end
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Mul", ITEM1 = f["script_variables_value"](self, { TEXT = "char" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = "/", OP = "EQ" }, th)) then
        if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = "/", OP = "EQ" }, th)) then
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 2, type = "add" }, th) }, th)
          while true do
            if f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = f["list_length"](self, { list = p_code }, th), OP = "GT" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th) }, th), B = "\
", OP = "EQ" }, th), type = "or" }, th) then break end
            f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
            f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
            if th:iter_d() then break end
          end
          break
        end
        if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = "*", OP = "EQ" }, th)) then
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 2, type = "add" }, th) }, th)
          while true do
            if f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = f["list_length"](self, { list = p_code }, th), OP = "GT" }, th), B = f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th) }, th), B = "*", OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = "/", OP = "EQ" }, th), type = "and" }, th), type = "or" }, th) then break end
            if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th) }, th), B = "\
", OP = "EQ" }, th)) then
              f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
              f["replace_list_item"](self, { item = "any", list = p_v, list_index = 4, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), B = 1, type = "add" }, th) }, th)
              f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = 0 }, th)
            else
              f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
              f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
            end
            if th:iter_d() then break end
          end
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 2, type = "add" }, th) }, th)
          break
        end
        if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = "=", OP = "EQ" }, th)) then
          f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Reunite", ITEM1 = "/=", ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), ITEM4 = "Div" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 2, type = "add" }, th) }, th)
          break
        end
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Div", ITEM1 = f["script_variables_value"](self, { TEXT = "char" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = "^", OP = "EQ" }, th)) then
        if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = "=", OP = "EQ" }, th)) then
          f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Reunite", ITEM1 = "^=", ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), ITEM4 = "Pow" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 2, type = "add" }, th) }, th)
          break
        end
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Pow", ITEM1 = f["script_variables_value"](self, { TEXT = "char" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = "%", OP = "EQ" }, th)) then
        if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = "=", OP = "EQ" }, th)) then
          f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Reunite", ITEM1 = "%=", ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), ITEM4 = "Mod" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 2, type = "add" }, th) }, th)
          break
        end
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Mod", ITEM1 = f["script_variables_value"](self, { TEXT = "char" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = "&", OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = "&", OP = "EQ" }, th), type = "and" }, th)) then
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "And", ITEM1 = "&&", ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 2, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = "|", OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = "|", OP = "EQ" }, th), type = "and" }, th)) then
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Or", ITEM1 = "||", ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 2, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = "?", OP = "EQ" }, th)) then
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Question", ITEM1 = f["script_variables_value"](self, { TEXT = "char" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = ">", OP = "EQ" }, th)) then
        if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = "=", OP = "EQ" }, th)) then
          f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Ge", ITEM1 = ">=", ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 2, type = "add" }, th) }, th)
          break
        end
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Gt", ITEM1 = f["script_variables_value"](self, { TEXT = "char" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = "<", OP = "EQ" }, th)) then
        if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = "=", OP = "EQ" }, th)) then
          f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Le", ITEM1 = "<=", ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 2, type = "add" }, th) }, th)
          break
        end
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Lt", ITEM1 = f["script_variables_value"](self, { TEXT = "char" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        break
      end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "char" }, th), B = "!", OP = "EQ" }, th)) then
        if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_code, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th), B = "=", OP = "EQ" }, th)) then
          f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Ne", ITEM1 = "!=", ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 2, type = "add" }, th) }, th)
          f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 2, type = "add" }, th) }, th)
          break
        end
        f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_v, list_index = 3 }, th), list_item_value = f["temporary_list"](self, { ITEM0 = "Not", ITEM1 = f["script_variables_value"](self, { TEXT = "char" }, th), ITEM2 = f["list_item"](self, { item = "any", list = p_v, list_index = 4 }, th), ITEM3 = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th) }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 1 }, th), B = 1, type = "add" }, th) }, th)
        f["replace_list_item"](self, { item = "any", list = p_v, list_index = 5, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_v, list_index = 5 }, th), B = 1, type = "add" }, th) }, th)
        break
      end
      th:call_proc(proc_e115ca8b_53f0_4844_97a3_a15141c0a242, self, f["text_join"](self, { ADD0 = "未知的字符：\"", ADD1 = f["script_variables_value"](self, { TEXT = "char" }, th), ADD2 = "\"" }, th), p_v)
      if th:iter_d() then break end
    end
  end
  return (th:call_proc(proc_ea2840b0_96b7_4a3c_95e7_bff42dde31b0, self, p_code, p_v, nil))
end

proc_ee7e471d_cfb7_44a8_9328_40c0e6b606f3 = function(th, self, p_tokens, p_global, p_env)
  -- 过程「84dcd644-a634-450f-86a0-51b24a1c4243」 id=ee7e471d-cfb7-44a8-9328-40c0e6b606f3
  f["list_append"](self, { list = p_env, list_item_value = f["temporary_list"](self, {}, th) }, th)
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "RightSquare", OP = "EQ" }, th)) then
    return f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th)
  end
  th:warp_enter()
  while true do
    if false then break end
    if V.bool(f["variables_get"](self, { variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)) then
      th:warp_exit()
      return 0
    end
    f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), list_item_value = (th:call_proc(proc_bfa2f83c_ca7e_405c_a52e_3db0ed532528, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "Comma", OP = "EQ" }, th)) then
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_47888fa6_5576_45a3_a4db_bd570c2a93b6, self, p_tokens, p_global, nil)))
    else
      break
    end
    if th:iter_w() then break end
  end
  th:warp_exit()
  return f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th)
end

proc_f07d943c_fa58_4638_9635_a44accb55f4f = function(th, self, p_tokens, p_global, p_n)
  -- 过程「2678fd3a-e836-4bb9-9221-e049e8005afe」 id=f07d943c-fa58-4638-9635-a44accb55f4f
  return f["list_item"](self, { item = "any", list = p_tokens, list_index = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = p_global, list_index = 1 }, th), B = p_n, type = "add" }, th) }, th)
end

proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8 = function(th, self, p_f)
  -- 过程「db59b22a-8253-4501-8201-98eea89c98c4」 id=f0b9ebb6-e19b-4ac1-baee-a779cbdc89d8
end

proc_f1a134be_67a9_45c8_823e_988d84c3097a = function(th, self, p_tokens, p_global, p_env)
  -- 过程「4f53395a-e976-49d6-8062-2faa7e5865c1」 id=f1a134be-67a9-45c8-823e-988d84c3097a
  f["list_append"](self, { list = p_env, list_item_value = f["temporary_list"](self, {}, th) }, th)
  th:warp_enter()
  while true do
    if f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = (th:call_proc(proc_f07d943c_fa58_4638_9635_a44accb55f4f, self, p_tokens, p_global, 0)), list_index = 1 }, th), B = "EOF", OP = "EQ" }, th) then break end
    if V.bool(f["variables_get"](self, { variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)) then
      th:warp_exit()
      return 0
    end
    f["list_append"](self, { list = f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th), list_item_value = (th:call_proc(proc_8ad455ed_0ad7_4213_aa68_9d8ffe25d346, self, p_tokens, p_global, f["temporary_list"](self, {}, th))) }, th)
    if th:iter_w() then break end
  end
  th:warp_exit()
  return f["list_item"](self, { item = "any", list = p_env, list_index = 1 }, th)
end

proc_fdff4a26_8852_4abb_9cb4_ab94e5d7a174 = function(th, self, p_msg)
  -- 过程「a4919ea8-c79a-4021-9b19-f78cf1724244」 id=fdff4a26-8852-4abb-9cb4-ab94e5d7a174
  f["variables_set"](self, { value = f["temporary_list"](self, { ITEM0 = "dict", ITEM1 = f["temporary_list"](self, { ITEM0 = f["temporary_list"](self, { ITEM0 = "type", ITEM1 = "msg" }, th), ITEM1 = f["temporary_list"](self, { ITEM0 = "SystemError", ITEM1 = p_msg }, th) }, th) }, th), variable = "06f6cc9b-ad2e-44e3-bea6-e4b25cb4cd99" }, th)
  f["variables_set"](self, { value = true, variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)
  return (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self))
end

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 900, 562
M.timer_pos = { x = 720, y = 12 }
M.proc_trampoline = true
M.uses_timer = true
M.timer_hidden_default = true
M.vars = { { current_entity_id = "", cv_id = "", entity_name = "", id = "06f6cc9b-ad2e-44e3-bea6-e4b25cb4cd99", is_global = true, name = "errorMsg", order = 6, position = { x = 0, y = 80 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "1f503b9a-3c74-4a36-8634-bdda5526537d", is_global = true, name = "cleanSignal", order = 14, position = { x = 200, y = 100 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "4819da5c-3e70-45b5-935e-a049951d72b2", is_global = true, name = "head", order = 8, position = { x = 0, y = 240 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "4a9b00a4-d1c3-43b8-a479-123a68cc6972", is_global = true, name = "stopSignal", order = 3, position = { x = 20, y = 260 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "4eefb5ed-46e0-4ccc-8d35-5a43c9fbfbe2", is_global = true, name = "Console", order = 5, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "59416620-c0d2-49a0-9006-a52b1e5bb833", is_global = true, name = "UNICODE", order = 18, position = { x = 200, y = 420 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "6036f773-917a-4fa0-bf9d-34e92e17217a", is_global = true, name = "global", order = 1, position = { x = 20, y = 100 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "87a9ab86-7725-4635-86c0-25fb97538115", is_global = true, name = "code", order = 0, position = { x = 20, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "sUFuVDnS", entity_name = "", id = "8b496ca8-e4df-4a54-a5b2-0e8bb62986f1", is_global = true, name = "cloud", order = 16, position = { x = 200, y = 260 }, scale = 1, style = "default", type = "public", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "934c3963-9fd6-4bad-80ea-fb85fcbb4077", is_global = true, name = "tokens", order = 7, position = { x = 0, y = 160 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "9dcb03e8-dfbb-4cf1-acbf-6a96becbca96", is_global = true, name = "locate", order = 15, position = { x = 200, y = 180 }, scale = 1, style = "default", type = "private", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "b6b5f7c3-2437-4272-9ccb-1e647362b076", is_global = true, name = "returnSignal", order = 2, position = { x = 20, y = 180 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "ba500ff5-06c1-4d86-858e-2b1f92a17424", is_global = true, name = "LexerProgress", order = 12, position = { x = 0, y = 498 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "c9d9feef-dd94-4174-b7da-d8e441b74b27", is_global = true, name = "opNames", order = 10, position = { x = 0, y = 480 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "cb1468b1-eb20-4cc6-bc3e-91b6bfdd2b27", is_global = true, name = "lasttime", order = 11, position = { x = 200, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "f13953cd-e130-4564-a483-1abde875a10a", is_global = true, name = "inputSignal", order = 13, position = { x = 200, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "f5a79007-362b-4620-bee2-efd4f3427d7a", is_global = true, name = "opPrecs", order = 9, position = { x = 0, y = 400 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "f6464b41-87be-42b8-ae2a-55f7eac7a359", is_global = true, name = "updateLocate", order = 17, position = { x = 200, y = 340 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b", is_global = true, name = "loopSignal", order = 4, position = { x = 20, y = 340 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "fec1fa0f-f1a2-41ec-a1e5-02e95bd44ac1", is_global = true, name = "UNICODELIST", order = 19, position = { x = 400, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false } }
M.screens = { { id = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a", name = "背景", screenName = "屏幕", style_index = 4, styles = { "6d0d6c61-a1df-4076-8c19-83ddfdbbca1c", "8c9c1659-8e6f-4622-a78f-2ab088168c45", "5b9686bf-7df7-476e-b858-ca3bc9e0c7aa", "baf741cb-9a3e-4d1b-867f-ca2753aa71e8", "538eaa00-1517-4440-923e-a146ace66ea9" }, visible = true } }
M.cur_scene = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a"
M.actors = { { id = "025dd83c-de62-46a3-86bb-2ab6333e16c2", is_global = true, name = "Execute", order = 1, rotation = 0, scale_x = 0.01, scale_y = 0.01, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "e9792a0f-ae14-4489-90c8-dd0fd6edd6d9", "5a1f9428-61c8-4ff3-984b-78ff34bdf04d", "106119db-7ea0-4d47-a33c-65f3d2a560e1", "509a0c7c-af8b-460f-b9a5-3c273ea8394e", "70cdaef4-bd83-4797-8aec-e1edddec8765" }, visible = false, x = -250, y = 0 }, { id = "06f4367e-503b-45ae-81aa-434371a2904a", is_global = true, name = "新角色", order = 2, rotation = 0, scale_x = 0.25, scale_y = 0.25, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 3, styles = { "ff64c414-85f1-488f-8af4-4ef0d5c42910", "3be2dda0-19e1-48b2-8c76-0c3a225a520b", "e1ba774e-a398-4240-857f-922c2c5759e3" }, visible = false, x = 390, y = -220 }, { id = "fec8c155-db8b-4246-b079-fefb3f7804eb", is_global = true, name = "新角色1", order = 3, rotation = 0, scale_x = 0.2, scale_y = 0.2, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "36cdb780-6a2d-4730-a65a-a47a1b5ca5d6" }, visible = false, x = -420, y = 250 } }
M.assets_dir = "works"
M.assets = { ["106119db-7ea0-4d47-a33c-65f3d2a560e1"] = { adaption = nil, center = nil, file = "assets/106119db-7ea0-4d47-a33c-65f3d2a560e1.png", id = "106119db-7ea0-4d47-a33c-65f3d2a560e1", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/6e4d95aecf7441e6a9885cba405baeaf.png" }, ["36cdb780-6a2d-4730-a65a-a47a1b5ca5d6"] = { adaption = nil, center = nil, file = "assets/36cdb780-6a2d-4730-a65a-a47a1b5ca5d6.png", id = "36cdb780-6a2d-4730-a65a-a47a1b5ca5d6", name = "新角色1", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/FlMZvdT06CGfUn8A81YFLmutHWAq?imageView2/0/format/png" }, ["3be2dda0-19e1-48b2-8c76-0c3a225a520b"] = { adaption = nil, center = nil, file = "assets/3be2dda0-19e1-48b2-8c76-0c3a225a520b.png", id = "3be2dda0-19e1-48b2-8c76-0c3a225a520b", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/FldVAblhAlAn6TlKMK4O8d-ReWoe?imageView2/0/format/png" }, ["509a0c7c-af8b-460f-b9a5-3c273ea8394e"] = { adaption = nil, center = nil, file = "assets/509a0c7c-af8b-460f-b9a5-3c273ea8394e.png", id = "509a0c7c-af8b-460f-b9a5-3c273ea8394e", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/25593adb06d24d988ada59c1d2131de8.png" }, ["538eaa00-1517-4440-923e-a146ace66ea9"] = { adaption = 0, center = { x = 0, y = 0 }, file = "assets/538eaa00-1517-4440-923e-a146ace66ea9.png", id = "538eaa00-1517-4440-923e-a146ace66ea9", name = "", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfNzI3MDA5NV8zMjg5ODE3ODFfMTc4OTkwOTIwMDAwMF9GaF9maDFlbkl5YnNXOXdNQnlBNGlLdnZZUmZo.svg" }, ["5a1f9428-61c8-4ff3-984b-78ff34bdf04d"] = { adaption = nil, center = nil, file = "assets/5a1f9428-61c8-4ff3-984b-78ff34bdf04d.png", id = "5a1f9428-61c8-4ff3-984b-78ff34bdf04d", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/caf8f973dbe240babece35637dcafee8.png" }, ["5b9686bf-7df7-476e-b858-ca3bc9e0c7aa"] = { adaption = nil, center = nil, file = "assets/5b9686bf-7df7-476e-b858-ca3bc9e0c7aa.png", id = "5b9686bf-7df7-476e-b858-ca3bc9e0c7aa", name = "星际空间", styleType = 2, url = "https://creation.codemao.cn/396/1ac0c1799e1c4702856088f528b737bc.png" }, ["6d0d6c61-a1df-4076-8c19-83ddfdbbca1c"] = { adaption = nil, center = nil, file = "assets/6d0d6c61-a1df-4076-8c19-83ddfdbbca1c.jpg", id = "6d0d6c61-a1df-4076-8c19-83ddfdbbca1c", name = "沼泽", styleType = 1, url = "https://creation.codemao.cn/396/8bc3a5b92e934d7287e63f1684b61de6.jpg" }, ["70cdaef4-bd83-4797-8aec-e1edddec8765"] = { adaption = nil, center = nil, file = "assets/70cdaef4-bd83-4797-8aec-e1edddec8765.png", id = "70cdaef4-bd83-4797-8aec-e1edddec8765", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/8aa8cbdbe82a442989b0fadb823444d4.png" }, ["8c9c1659-8e6f-4622-a78f-2ab088168c45"] = { adaption = 0, center = { x = 0, y = 0 }, file = "assets/8c9c1659-8e6f-4622-a78f-2ab088168c45.png", id = "8c9c1659-8e6f-4622-a78f-2ab088168c45", name = "", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfNzI3MDA5NV8zMjg5ODE3ODFfMTc4OTMwODAwMDAwMF9Gc01CSEFfREYtd2VLTEpxTnNmUmRZXy13Z2M0.svg" }, ["baf741cb-9a3e-4d1b-867f-ca2753aa71e8"] = { adaption = 0, center = { x = 0, y = 0 }, file = "assets/baf741cb-9a3e-4d1b-867f-ca2753aa71e8.png", id = "baf741cb-9a3e-4d1b-867f-ca2753aa71e8", name = "", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfNzI3MDA5NV8zMjg5ODE3ODFfMTc4OTg4NzYwMDAwMF9GcTNaRGVPOTVjT0pzY09YcWZTekhoUGxfT25F.svg" }, ["e1ba774e-a398-4240-857f-922c2c5759e3"] = { adaption = nil, center = nil, file = "assets/e1ba774e-a398-4240-857f-922c2c5759e3.png", id = "e1ba774e-a398-4240-857f-922c2c5759e3", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/FlcKC-UdhKL_UqHzucbArSh-ct7e?imageView2/0/format/png" }, ["e9792a0f-ae14-4489-90c8-dd0fd6edd6d9"] = { adaption = nil, center = nil, file = "assets/e9792a0f-ae14-4489-90c8-dd0fd6edd6d9.png", id = "e9792a0f-ae14-4489-90c8-dd0fd6edd6d9", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/c364f36a8dcf42d1a6acbe26c7eb6aaa.png" }, ["ff64c414-85f1-488f-8af4-4ef0d5c42910"] = { adaption = nil, center = { x = 9.3409360818053e-14, y = -4.6704680409026e-14 }, file = "assets/ff64c414-85f1-488f-8af4-4ef0d5c42910.png", id = "ff64c414-85f1-488f-8af4-4ef0d5c42910", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfNzI3MDA5NV8zMjg5ODE3ODFfMTc4OTEzNTIwMDAwMF9GblBBQ3JiZlpaSWoxMVJmdFAxbnF2UDdYb2dT.svg" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_700824a5_44a8_4d03_a7e8_aa95d87e9b2a = ents["700824a5-44a8-4d03-a7e8-aa95d87e9b2a"]
  local e_025dd83c_de62_46a3_86bb_2ab6333e16c2 = ents["025dd83c-de62-46a3-86bb-2ab6333e16c2"]
  local e_06f4367e_503b_45ae_81aa_434371a2904a = ents["06f4367e-503b-45ae-81aa-434371a2904a"]
  local e_fec8c155_db8b_4246_b079_fefb3f7804eb = ents["fec8c155-db8b-4246-b079-fefb3f7804eb"]
  -- -------- 角色 Execute --------
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "on_running_group_activated", {}, function(th, self)
      f["variables_set"](self, { value = 0, variable = "59416620-c0d2-49a0-9006-a52b1e5bb833" }, th)
      f["variables_set"](self, { value = f["text_split"](self, { SPLIT_TEXT = "", TEXT_TO_SPLIT = f["variables_get"](self, { variable = "59416620-c0d2-49a0-9006-a52b1e5bb833" }, th) }, th), variable = "fec1fa0f-f1a2-41ec-a1e5-02e95bd44ac1" }, th)
      f["variables_set"](self, { value = "", variable = "06f6cc9b-ad2e-44e3-bea6-e4b25cb4cd99" }, th)
      f["variables_set"](self, { value = false, variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th)
      f["variables_set"](self, { value = false, variable = "b6b5f7c3-2437-4272-9ccb-1e647362b076" }, th)
      f["variables_set"](self, { value = "", variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th)
      f["variables_set"](self, { value = f["temporary_list"](self, { ITEM0 = "Or", ITEM1 = "And", ITEM10 = "Mul", ITEM11 = "Div", ITEM12 = "Pow", ITEM13 = "Mod", ITEM2 = "Eq", ITEM3 = "Ne", ITEM4 = "Lt", ITEM5 = "Le", ITEM6 = "Gt", ITEM7 = "Ge", ITEM8 = "Add", ITEM9 = "Sub" }, th), variable = "c9d9feef-dd94-4174-b7da-d8e441b74b27" }, th)
      f["variables_set"](self, { value = f["temporary_list"](self, { ITEM0 = 2, ITEM1 = 3, ITEM10 = 7, ITEM11 = 7, ITEM12 = 8, ITEM13 = 7, ITEM2 = 4, ITEM3 = 4, ITEM4 = 5, ITEM5 = 5, ITEM6 = 5, ITEM7 = 5, ITEM8 = 6, ITEM9 = 6 }, th), variable = "f5a79007-362b-4620-bee2-efd4f3427d7a" }, th)
      f["variables_set"](self, { value = f["temporary_list"](self, { ITEM0 = f["temporary_list"](self, {}, th), ITEM1 = f["temporary_list"](self, { ITEM0 = f["temporary_list"](self, {}, th), ITEM1 = f["temporary_list"](self, {}, th) }, th), ITEM2 = true }, th), variable = "6036f773-917a-4fa0-bf9d-34e92e17217a" }, th)
      f["variables_set"](self, { value = f["text_join"](self, { ADD0 = "var Type = {};Type.toString = [\"native\", 1, \"toString\"];Type.toNumber = [\"native\", 1, \"toNumber\"];Type.toBoolean = [\"native\", 1, \"toBoolean\"];Type.typeOf = [\"native\", 1, \"typeOf\"];var List = {};List.get = [\"native\", 2, \"getElement\"];List.length = [\"native\", 1, \"length\"];List.push = [\"native\", 2, \"push\"];function List.insert(list, value, index = -1) {if (index == -1) {List.push(list, value);return;}([\"native\", 3, \"insert\"])(list, value, index);return;}List.set = [\"native\", 3, \"set\"];List.indexOf = [\"native\", 2, \"indexOf\"];List.includes = [\"native\", 2, \"includes\"];List.copy = [\"native\", 1, \"copy\"];List.remove = [\"native\", 2, \"remove\"];List.stringify = [\"native\", 1, \"listFormat\"];function List.sort(list, mode) {function merge(a, b) {var r = [];var i = 0;var j = 0;while (i < List.length(a) && j < List.length(b)) {if (mode) {if (a[i] >= b[j]) {List.push(r, a[i]);i += 1;} else {List.push(r, b[j]);j += 1;}} else {if (a[i] <= b[j]) {List.push(r, a[i]);i += 1;} else {List.push(r, b[j]);j += 1;}}}while (i < List.length(a)) {List.push(r, a[i]);i += 1;}while (j < List.length(b)) {List.push(r, b[j]);j += 1;}return r;}function msort(l) {if (List.length(l) <= 1) {return l;}var mid = Math.floor(List.length(l) / 2);var left = [];var right = [];var i = 0;while (i < mid) {List.push(left, l[i]);i += 1;}while (i < List.length(l)) {List.push(right, l[i]);i += 1;}return merge(msort(left), msort(right));}return msort(list);}var Math = {};Math.PI = 3.141592653589793;Math.E = 2.718281828459045;Math.fact = function(n) {if (n < 2) {return 1;}return n * Math.fact(n - 1);};Math.calculate = [\"native\", 1, \"calculate\"];Math.sin = [\"native\", 1, \"sin\"];Math.cos = [\"native\", 1, \"cos\"];Math.tan = [\"native\", 1, \"tan\"];Math.asin = [\"native\", 1, \"asin\"];Math.acos = [\"native\", 1, \"acos\"];Math.atan = [\"native\", 1, \"atan\"];Math.random = [\"native\", 2, \"random\"];Math.round = [\"native\", 1, \"round\"];Math.floor = [\"native\", 1, \"floor\"];Math.ceil = [\"native\", 1, \"ceil\"];Math.sqrt = [\"native\", 1, \"sqrt\"];Math.log = [\"native\", 2, \"log\"];function Math.max(a, b) {if (a > b) {return a;}return b;}function Math.min(a, b) {if (a > b) {return b;}return a;}var String = {};String.split = [\"native\", 2, \"split\"];function String.slice(str, a, b = -1) {if (b == -1) {return ([\"native\", 3, \"slice\"])(str, a, a);}return ([\"native\", 3, \"slice\"])(str, a, b);}String.length = [\"native\", 1, \"strLength\"];String.includes = [\"native\", 2, \"hasChar\"];function String.format(str, ...args) {var l = String.split(str, \"\");var i = 0;var j = 0;while (true) {if (i >= List.length(l)) {break;}if (l[i] == \"{\" && l[i + 1] == \"}\") {List.remove(l, i);List.set(l, i, args[j]);i += 1;j += 1;}i += 1;}var p = \"\";for (var i = 0; i < List.length(l); i += 1) {p += l[i];}return p;}String.fromUnicode = [\"native\", 1, \"fromCharCode\"];String.toUnicode = [\"native\", 1, \"toCharCode\"];function print(...str) {var s = \"\";for (var i = 0; i < List.length(str); i += 1) {s += str[i];}([\"native\", 1, \"console_log\"])(s);}var input = [\"native\", 1, \"input\"];function error(msg) {return {\"type\": \"UserError\",\"msg\": msg};}var load = [\"native\", 2, \"loadCode\"];var Pen = {};Pen.setSize = [\"native\", 1, \"setPenSize\"];Pen.down = [\"native\", 0, \"penDown\"];Pen.up = [\"native\", 0, \"penUp\"];Pen.goto = [\"native\", 2, \"penGoto\"];Pen.setColorHSVA = [\"native\", 4, \"setHsva\"];Pen.getMouseX = [\"native\", 0, \"fingerX\"];Pen.getMouseY = [\"native\", 0, \"fingerY\"];Pen.getPenX = [\"native\", 0, \"penX\"];Pen.getPenY = [\"native\", 0, \"penY\"];Pen.isPress = [\"native\", 0, \"isPress\"];Pen.clean = [\"native\", 0, \"clean\"];Pen.print = [\"native\", 3, \"printText\"];var Date = {};Date.getTime = [\"native\", 0, \"getTime\"];var equal = [\"native\", 2, \"isEqual\"];var Local = {};Local.write = [\"native\", 2, \"writeLocal\"];Local.read = [\"native\", 1, \"readLocal\"];Local.delete = [\"native\", 1, \"deleteLocal\"];function newEnv(e = [], v = {}, r = false) {return [e, [List.get(List.get(v, 1), 0), List.get(List.get(v, 1), 1)], r];}var envGet = [\"native\", 2, \"envGet\"];" }, th), variable = "4819da5c-3e70-45b5-935e-a049951d72b2" }, th)
      f["self_ask"](self, { text = "NodeCode（请勿使用单行注释）：" }, th)
      f["self_broadcast"](self, { message = "1" }, th)
      f["variables_set"](self, { value = (th:call_proc(proc_ea2840b0_96b7_4a3c_95e7_bff42dde31b0, self, f["text_split"](self, { SPLIT_TEXT = "", TEXT_TO_SPLIT = f["text_join"](self, { ADD0 = f["variables_get"](self, { variable = "4819da5c-3e70-45b5-935e-a049951d72b2" }, th), ADD1 = f["get_answer"](self, {}, th) }, th) }, th), f["temporary_list"](self, { ITEM0 = 1, ITEM1 = f["temporary_list"](self, {}, th), ITEM2 = f["temporary_list"](self, {}, th), ITEM3 = 1, ITEM4 = 0 }, th), nil)), variable = "934c3963-9fd6-4bad-80ea-fb85fcbb4077" }, th)
      f["variables_set"](self, { value = (th:call_proc(proc_f1a134be_67a9_45c8_823e_988d84c3097a, self, f["variables_get"](self, { variable = "934c3963-9fd6-4bad-80ea-fb85fcbb4077" }, th), f["temporary_list"](self, { ITEM0 = 1 }, th), f["temporary_list"](self, {}, th))), variable = "87a9ab86-7725-4635-86c0-25fb97538115" }, th)
      f["self_broadcast"](self, { message = "2" }, th)
      f["variables_set"](self, { value = f["get_timer"](self, {}, th), variable = "cb1468b1-eb20-4cc6-bc3e-91b6bfdd2b27" }, th)
      th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_803f4f62_01e2_4370_b5e6_88cd6ad88290, self, f["variables_get"](self, { variable = "87a9ab86-7725-4635-86c0-25fb97538115" }, th), f["variables_get"](self, { variable = "6036f773-917a-4fa0-bf9d-34e92e17217a" }, th), (th:call_proc(proc_c50c29e1_f1fd_4464_a845_7295a1078080, self)), 1)))
      if V.bool(f["logic_operation"](self, { A = f["logic_operation"](self, { A = f["variables_get"](self, { variable = "4a9b00a4-d1c3-43b8-a479-123a68cc6972" }, th), B = f["variables_get"](self, { variable = "b6b5f7c3-2437-4272-9ccb-1e647362b076" }, th), type = "or" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th), B = "", OP = "NEQ" }, th), type = "or" }, th)) then
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th), B = "", OP = "NEQ" }, th)) then
          th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_fdff4a26_8852_4abb_9cb4_ab94e5d7a174, self, f["text_join"](self, { ADD0 = "在顶层使用", ADD1 = f["variables_get"](self, { variable = "f7debb42-7338-4651-ad5e-a6f7a12e9d2b" }, th) }, th))))
        end
        if V.bool(f["variables_get"](self, { variable = "b6b5f7c3-2437-4272-9ccb-1e647362b076" }, th)) then
          th:call_proc(proc_f0b9ebb6_e19b_4ac1_baee_a779cbdc89d8, self, (th:call_proc(proc_fdff4a26_8852_4abb_9cb4_ab94e5d7a174, self, f["text_join"](self, { ADD0 = "在顶层使用", ADD1 = "return" }, th))))
        end
        f["list_append"](self, { list = f["variables_get"](self, { variable = "4eefb5ed-46e0-4ccc-8d35-5a43c9fbfbe2" }, th), list_item_value = f["variables_get"](self, { variable = "06f6cc9b-ad2e-44e3-bea6-e4b25cb4cd99" }, th) }, th)
        f["variables_set"](self, { value = "", variable = "06f6cc9b-ad2e-44e3-bea6-e4b25cb4cd99" }, th)
      end
      f["list_append"](self, { list = f["variables_get"](self, { variable = "4eefb5ed-46e0-4ccc-8d35-5a43c9fbfbe2" }, th), list_item_value = f["text_join"](self, { ADD0 = "程序运行结束，耗时：", ADD1 = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["get_timer"](self, {}, th), B = f["variables_get"](self, { variable = "cb1468b1-eb20-4cc6-bc3e-91b6bfdd2b27" }, th), type = "minus" }, th), B = 1000, type = "multiply" }, th), ADD2 = "ms" }, th) }, th)
      f["list_append"](self, { list = f["variables_get"](self, { variable = "4eefb5ed-46e0-4ccc-8d35-5a43c9fbfbe2" }, th), list_item_value = "" }, th)
      f["list_append"](self, { list = f["variables_get"](self, { variable = "4eefb5ed-46e0-4ccc-8d35-5a43c9fbfbe2" }, th), list_item_value = "" }, th)
      f["list_append"](self, { list = f["variables_get"](self, { variable = "4eefb5ed-46e0-4ccc-8d35-5a43c9fbfbe2" }, th), list_item_value = "" }, th)
  end)
  -- -------- 角色 新角色 --------
  rt.on(e_06f4367e_503b_45ae_81aa_434371a2904a, "on_running_group_activated", {}, function(th, self)
      f["self_set_effect"](self, { scope = "1", value = 75 }, th)
      f["variables_set"](self, { value = f["temporary_list"](self, {}, th), variable = "4eefb5ed-46e0-4ccc-8d35-5a43c9fbfbe2" }, th)
      th:call_proc(proc_dfb1a1a9_094c_4010_a210_76cf972162e9, self)
  end)
  rt.on(e_06f4367e_503b_45ae_81aa_434371a2904a, "self_listen", { message = "2" }, function(th, self)
      while true do
        if V.bool(f["variables_get"](self, { variable = "1f503b9a-3c74-4a36-8634-bdda5526537d" }, th)) then
          f["clear_drawing"](self, {}, th)
          f["variables_set"](self, { value = false, variable = "1f503b9a-3c74-4a36-8634-bdda5526537d" }, th)
        end
        th:call_proc(proc_dfb1a1a9_094c_4010_a210_76cf972162e9, self)
        f["self_set_pen_color"](self, { color = "#999999" }, th)
        f["self_set_pen_color_property"](self, { scope = "alpha", val = 75 }, th)
        f["self_move_to"](self, { x = -19, y = 229 }, th)
        th:call_proc(proc_100d961a_9778_44ef_b6c3_dccf5b32df15, self, f["variables_get"](self, { variable = "4eefb5ed-46e0-4ccc-8d35-5a43c9fbfbe2" }, th), (th:call_proc(proc_da9cde44_c87a_45dd_8679_74c712c8300a, self, f["math_arithmetic"](self, { A = f["list_length"](self, { list = f["variables_get"](self, { variable = "4eefb5ed-46e0-4ccc-8d35-5a43c9fbfbe2" }, th) }, th), B = 22, type = "minus" }, th), 1)))
        f["self_set_pen_color"](self, { color = "#ffffff" }, th)
        f["self_set_pen_color_property"](self, { scope = "alpha", val = 0 }, th)
        f["self_move_to"](self, { x = -20, y = 230 }, th)
        th:call_proc(proc_100d961a_9778_44ef_b6c3_dccf5b32df15, self, f["variables_get"](self, { variable = "4eefb5ed-46e0-4ccc-8d35-5a43c9fbfbe2" }, th), (th:call_proc(proc_da9cde44_c87a_45dd_8679_74c712c8300a, self, f["math_arithmetic"](self, { A = f["list_length"](self, { list = f["variables_get"](self, { variable = "4eefb5ed-46e0-4ccc-8d35-5a43c9fbfbe2" }, th) }, th), B = 22, type = "minus" }, th), 1)))
        if V.bool(f["variables_get"](self, { variable = "f13953cd-e130-4564-a483-1abde875a10a" }, th)) then
          f["self_broadcast_with_param"](self, { message = "3", param = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), B = 24, type = "add" }, th) }, th)
          while not V.bool(f["logic_negate"](self, { logic = f["variables_get"](self, { variable = "f13953cd-e130-4564-a483-1abde875a10a" }, th) }, th)) do
            if th:iter_n() then break end
          end
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_06f4367e_503b_45ae_81aa_434371a2904a, "self_listen", { message = "1" }, function(th, self)
      while true do
        if f["logic_compare"](self, { A = f["variables_get"](self, { variable = "ba500ff5-06c1-4d86-858e-2b1f92a17424" }, th), B = 100, OP = "GTE" }, th) then break end
        th:call_proc(proc_dfb1a1a9_094c_4010_a210_76cf972162e9, self)
        f["self_set_pen_color"](self, { color = "#999999" }, th)
        f["self_set_pen_color_property"](self, { scope = "alpha", val = 75 }, th)
        f["self_move_to"](self, { x = -19, y = 229 }, th)
        f["stamp"](self, { align = "left", size = 18, text = f["text_join"](self, { ADD0 = "Lexing...", ADD1 = f["variables_get"](self, { variable = "ba500ff5-06c1-4d86-858e-2b1f92a17424" }, th), ADD2 = "%" }, th) }, th)
        f["self_set_pen_color"](self, { color = "#ffffff" }, th)
        f["self_set_pen_color_property"](self, { scope = "alpha", val = 0 }, th)
        f["self_move_to"](self, { x = -20, y = 230 }, th)
        f["stamp"](self, { align = "left", size = 18, text = f["text_join"](self, { ADD0 = "Lexing...", ADD1 = f["variables_get"](self, { variable = "ba500ff5-06c1-4d86-858e-2b1f92a17424" }, th), ADD2 = "%" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 新角色1 --------
  rt.on(e_fec8c155_db8b_4246_b079_fefb3f7804eb, "sprite_on_tap", { sprite = "--self", type = "mouse_click" }, function(th, self)
      f["variables_set"](self, { value = false, variable = "f13953cd-e130-4564-a483-1abde875a10a" }, th)
      f["self_appear"](self, { value = "disappear" }, th)
  end)
  rt.on(e_fec8c155_db8b_4246_b079_fefb3f7804eb, "self_listen_with_param", { message = "3" }, function(th, self)
      f["self_move_to"](self, { x = -35, y = f["self_listen_value"](self, { TEXT = "内容" }, th) }, th)
      f["self_appear"](self, { value = "appear" }, th)
  end)
end

M.requires = {
  "calculate",
  "clear_drawing",
  "convert_type",
  "coordinate_of_sprite",
  "delete_list_item",
  "get_answer",
  "get_mouse_info",
  "get_timer",
  "image_stamp",
  "list_append",
  "list_copy",
  "list_index_of",
  "list_insert_value",
  "list_is_exist",
  "list_item",
  "list_length",
  "logic_compare",
  "logic_negate",
  "logic_operation",
  "math_arithmetic",
  "math_function",
  "math_modulo",
  "math_round",
  "mouse_down",
  "random_num",
  "replace_list_item",
  "script_variables",
  "script_variables_value",
  "self_appear",
  "self_ask",
  "self_broadcast",
  "self_broadcast_with_param",
  "self_change_coordinate_y",
  "self_listen_value",
  "self_move_to",
  "self_pen_down",
  "self_pen_up",
  "self_point_towards",
  "self_set_effect",
  "self_set_pen_color",
  "self_set_pen_color_property",
  "self_set_pen_size",
  "stamp",
  "temporary_list",
  "text_contain",
  "text_join",
  "text_length",
  "text_select",
  "text_split",
  "variables_get",
  "variables_set",
}
return M

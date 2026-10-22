-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：now   version=0.27.4
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用

-- ===== 自定义积木（过程）=====
local proc_02da6cfd_3335_4473_a7f5_37288abf1a8f, proc_05dd2a79_15ed_4a28_a505_0e38db6bda32, proc_13c77434_42c9_468d_a80b_4e9d942bd7ff, proc_1d674402_3284_4bf3_87c9_f03f04d8542e, proc_3f828bd5_c7a9_49bb_b2a1_18706f17bfde, proc_3fbdba65_fc6b_48fb_995f_489568077017, proc_4c20d971_9c2e_4f69_8a28_f808e89f0a62, proc_4f585296_463f_434b_9b48_6d729cd4b39c, proc_6c4772e8_6d87_42e8_93b9_af878ce04a7e, proc_7558af1a_b4f5_4c12_ada1_f3de6e12d0cd, proc_82177fc4_9516_4f2c_90d5_a6b8c584e3f8, proc_8866b182_cf8a_4978_92c2_8cda965613bf, proc_95fe1aad_a69d_434e_a25d_be0f124d7de8, proc_9d8c0e48_e7a1_443c_b5dd_57e5d7f2e7bf, proc_aabf0193_3224_42fd_8f50_2ddcb8495be3, proc_ab9e6f2c_d942_40be_8d4c_e8f19d72383d, proc_acdca734_97cd_4807_947f_a3e65cd9c8b4, proc_b40a764c_79a5_40e4_ba26_f77f45c7a502, proc_b81c7a0d_edae_4cce_b0bf_787193b1602c, proc_bfe2998b_3a71_4599_b05a_8d3aa3d32a26, proc_c2116d3b_38ff_4bf0_a4b6_eec9fe9f1f89, proc_c9cdb104_5f0e_4971_a8ae_fdf321b2aae0, proc_e1d938c6_3ee5_4249_8fe7_18aa24c7d122, proc_eae8d3c4_5e2e_4f78_90db_9f8463348874, proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, proc_ec2362be_da94_4df9_9ea3_72ccff65a8ab, proc_f88f9ad7_6f39_4deb_a9e9_c2f0e242cb39, proc_f92a4bf5_d4e2_488e_87a9_dc2e04d8fd2a, proc_fde38e22_9be0_4d77_8605_5a4e38f5270c

proc_02da6cfd_3335_4473_a7f5_37288abf1a8f = function(th, self, p____, p_x, p_y)
  -- 过程「fbdf0948-70f3-4394-86e3-142ee033e269」 id=02da6cfd-3335-4473-a7f5-37288abf1a8f
  f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
  th:warp_enter()
  f["self_set_rotation_type"](self, { rotation_type = "2" }, th)
  f["variables_set"](self, { value = 0.5, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
  do
    local _times_n1 = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = 3, type = "divide" }, th)
    while true do
      if _times_n1 <= 0 then break end
      _times_n1 = _times_n1 - 1
      f["change_variables"](self, { method = "increase", value = 0.5, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
      do
        local _times_n2 = 12
        while true do
          if _times_n2 <= 0 then break end
          _times_n2 = _times_n2 - 1
          f["self_move_to"](self, { x = p_x, y = p_y }, th)
          f["self_go_forward"](self, { steps = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p____, B = f["script_variables_value"](self, { TEXT = "a" }, th), type = "multiply" }, th), B = 10, type = "divide" }, th) }, th)
          f["self_set_effect"](self, { scope = "1", value = 91.75 }, th)
          f["mirror"](self, { sprite = "--self" }, th)
          f["self_rotate"](self, { degrees = 30 }, th)
          if th:iter_w() then break end
        end
      end
      if th:iter_w() then break end
    end
  end
  f["self_appear"](self, { value = "appear" }, th)
  f["self_move_to"](self, { x = p_x, y = p_y }, th)
  f["self_set_effect"](self, { scope = "1", value = 0 }, th)
  th:warp_exit()
end

proc_05dd2a79_15ed_4a28_a505_0e38db6bda32 = function(th, self)
  -- 过程「e77bc8cb-b75f-41dc-91e8-f23f2a4ecc81」 id=05dd2a79-15ed-4a28-a505-0e38db6bda32
  if V.bool(f["logic_compare"](self, { A = f["get_current_clone_index"](self, {}, th), B = 0, OP = "NEQ" }, th)) then
    f["script_variables"](self, { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, name = "a", names = { "a", "b", "c" } }, th)
    f["variables_set"](self, { value = 1, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
    f["variables_set"](self, { value = f["random_num"](self, { A = 0, B = 1 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"b\"}" }, th)
    f["variables_set"](self, { value = 1, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"c\"}" }, th)
    if V.bool(f["list_is_exist"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th)) then
      f["delete_list_item"](self, { item = "any", list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_index = f["list_index_of"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th) }, th)
    end
    while true do
      if f["out_of_boundary"](self, { boundary = "3" }, th) then break end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "b" }, th), B = 0, OP = "EQ" }, th)) then
        f["self_rotate"](self, { degrees = f["math_arithmetic"](self, { A = f["math_trig"](self, { num = f["script_variables_value"](self, { TEXT = "c" }, th), type = "cos" }, th), B = 1.5, type = "multiply" }, th) }, th)
      else
        f["self_rotate"](self, { degrees = f["math_arithmetic"](self, { A = f["math_trig"](self, { num = f["script_variables_value"](self, { TEXT = "c" }, th), type = "sin" }, th), B = 1.25, type = "multiply" }, th) }, th)
      end
      f["self_change_coordinate_y"](self, { increase = "decrease", value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = 0.5, type = "multiply" }, th) }, th)
      f["self_change_coordinate_x"](self, { increase = "decrease", value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = 0.2, type = "multiply" }, th) }, th)
      f["self_change_effect"](self, { increase = "increase", scope = "1", value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = 25, type = "divide" }, th) }, th)
      f["change_variables"](self, { method = "increase", value = 2, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
      f["change_variables"](self, { method = "increase", value = 1, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"c\"}" }, th)
      if th:iter_d() then break end
    end
    f["dispose_clone"](self, {}, th)
  end
end

proc_13c77434_42c9_468d_a80b_4e9d942bd7ff = function(th, self, p_ID, p_i, p__________)
  -- 过程「7b513aa7-21b7-402f-99c7-229468835b0e」 id=13c77434-42c9-468d-a80b-4e9d942bd7ff
  if V.bool(f["logic_compare"](self, { A = p__________, B = "PP", OP = "EQ" }, th)) then
    if V.bool(f["logic_compare"](self, { A = f["user_info_of_th"](self, { order = p_i, ranking = "4c96c524-f17d-4439-bd49-abe3c754ac00", type = "userId" }, th), B = p_ID, OP = "EQ" }, th)) then
      f["create_stage_dialog"](self, { sprite = "--self", text = f["user_info_of_th"](self, { order = p_i, ranking = "4c96c524-f17d-4439-bd49-abe3c754ac00", type = "score" }, th) }, th)
    elseif V.bool(f["logic_compare"](self, { A = p_i, B = 101, OP = "EQ" }, th)) then
      f["create_stage_dialog"](self, { sprite = "--self", text = "无" }, th)
    else
      f["self_dialog_wait"](self, { text = f["text_join"](self, { ADD0 = p_i, ADD1 = "，", ADD2 = f["user_info_of_th"](self, { order = p_i, ranking = "4c96c524-f17d-4439-bd49-abe3c754ac00", type = "score" }, th) }, th), type = "talk" }, th)
      th:call_proc(proc_13c77434_42c9_468d_a80b_4e9d942bd7ff, self, p_ID, f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th), "PP")
    end
  else
    if V.bool(f["logic_compare"](self, { A = f["user_info_of_th"](self, { order = p_i, ranking = "94f8b950-18d4-404d-b147-f5310d14461d", type = "userId" }, th), B = p_ID, OP = "EQ" }, th)) then
      f["create_stage_dialog"](self, { sprite = "--self", text = f["user_info_of_th"](self, { order = p_i, ranking = "94f8b950-18d4-404d-b147-f5310d14461d", type = "score" }, th) }, th)
    elseif V.bool(f["logic_compare"](self, { A = p_i, B = 101, OP = "EQ" }, th)) then
      f["create_stage_dialog"](self, { sprite = "--self", text = "无" }, th)
    else
      f["self_dialog_wait"](self, { text = f["text_join"](self, { ADD0 = p_i, ADD1 = "，", ADD2 = f["user_info_of_th"](self, { order = p_i, ranking = "94f8b950-18d4-404d-b147-f5310d14461d", type = "score" }, th) }, th), type = "talk" }, th)
      th:call_proc(proc_13c77434_42c9_468d_a80b_4e9d942bd7ff, self, p_ID, f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th), "总分")
    end
  end
end

proc_1d674402_3284_4bf3_87c9_f03f04d8542e = function(th, self, p_______, p____)
  -- 过程「8555fd64-cac4-4aab-932c-0c97deaa57f3」 id=1d674402-3284-4bf3-87c9-f03f04d8542e
  f["wait"](self, { time = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_______, B = 60, type = "multiply" }, th), B = p____, type = "add" }, th) }, th)
end

proc_3f828bd5_c7a9_49bb_b2a1_18706f17bfde = function(th, self, p_______1, p_______2, p_______3)
  -- 过程「818b90f2-0f83-433c-8ef0-d5df570ed486」 id=3f828bd5-c7a9-49bb-b2a1-18706f17bfde
  return f["logic_operation"](self, { A = f["logic_compare"](self, { A = p_______2, B = p_______1, OP = "LT" }, th), B = f["logic_compare"](self, { A = p_______1, B = p_______3, OP = "LT" }, th), type = "and" }, th)
end

proc_3fbdba65_fc6b_48fb_995f_489568077017 = function(th, self, p_i)
  -- 过程「函数_3」 id=3fbdba65-fc6b-48fb-995f-489568077017
  if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = p_i, B = f["list_length"](self, { list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc" }, th), OP = "GT" }, th), B = f["logic_compare"](self, { A = p_i, B = f["math_arithmetic"](self, { A = 9, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "f8aa9107-105b-4298-b1d2-4d4880b9d169" }, th), B = 1, type = "minus" }, th), B = 9, type = "multiply" }, th), type = "add" }, th), OP = "GT" }, th), type = "or" }, th)) then
    return nil
  end
  f["self_set_position_x"](self, { value = -400 }, th)
  f["self_set_pen_color"](self, { color = "#bfbfbf" }, th)
  f["stamp"](self, { align = "left", size = 20, text = p_i }, th)
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc", list_index = p_i }, th), list_index = 1 }, th), B = "在线", OP = "EQ" }, th)) then
    f["self_set_pen_color"](self, { color = "#2dec86" }, th)
  else
    f["self_set_pen_color"](self, { color = "#bfbfbf" }, th)
  end
  f["self_set_position_x"](self, { value = -360 }, th)
  f["self_set_pen_size"](self, { size = 15 }, th)
  f["self_pen_down"](self, {}, th)
  f["self_pen_up"](self, {}, th)
  f["self_set_pen_size"](self, { size = 1 }, th)
  f["self_set_position_x"](self, { value = -340 }, th)
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc", list_index = p_i }, th), list_index = 1 }, th), B = "在线", OP = "EQ" }, th)) then
    f["self_set_pen_color"](self, { color = "#404040" }, th)
  else
    f["self_set_pen_color"](self, { color = "#bfbfbf" }, th)
  end
  f["stamp"](self, { align = "left", size = 24, text = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc", list_index = p_i }, th), list_index = 2 }, th) }, th)
  f["self_set_position_x"](self, { value = -150 }, th)
  f["self_set_pen_color"](self, { color = "#bfbfbf" }, th)
  f["stamp"](self, { align = "left", size = 20, text = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc", list_index = p_i }, th), list_index = 3 }, th) }, th)
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc", list_index = p_i }, th), list_index = 4 }, th), B = "状态异常", OP = "NEQ" }, th)) then
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc", list_index = p_i }, th), list_index = 1 }, th), B = "在线", OP = "EQ" }, th)) then
      f["self_set_position_x"](self, { value = 400 }, th)
      f["self_set_pen_color"](self, { color = "#2dec86" }, th)
      f["stamp"](self, { align = "right", size = 20, text = "在线" }, th)
    else
      f["self_set_position_x"](self, { value = 400 }, th)
      f["self_set_pen_color"](self, { color = "#bfbfbf" }, th)
      f["stamp"](self, { align = "right", size = 20, text = f["text_join"](self, { ADD0 = "", ADD1 = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc", list_index = p_i }, th), list_index = 4 }, th), list_index = 1 }, th), ADD2 = "天", ADD3 = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc", list_index = p_i }, th), list_index = 4 }, th), list_index = 2 }, th), ADD4 = "时", ADD5 = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc", list_index = p_i }, th), list_index = 4 }, th), list_index = 3 }, th), ADD6 = "分" }, th) }, th)
      f["self_set_position_x"](self, { value = 250 }, th)
      f["self_set_pen_color"](self, { color = "#bfbfbf" }, th)
      f["stamp"](self, { align = "right", size = 20, text = "已离线" }, th)
    end
  else
    f["self_set_position_x"](self, { value = 400 }, th)
    f["self_set_pen_color"](self, { color = "#ff8080" }, th)
    f["stamp"](self, { align = "right", size = 20, text = "状态异常" }, th)
  end
  f["self_change_coordinate_y"](self, { increase = "decrease", value = 25 }, th)
  f["self_set_position_x"](self, { value = -425 }, th)
  f["self_set_pen_color"](self, { color = "#bfbfbf" }, th)
  f["self_pen_down"](self, {}, th)
  f["self_set_position_x"](self, { value = 425 }, th)
  f["self_pen_up"](self, {}, th)
  f["self_change_coordinate_y"](self, { increase = "decrease", value = 25 }, th)
  th:call_proc(proc_3fbdba65_fc6b_48fb_995f_489568077017, self, f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th))
end

proc_4c20d971_9c2e_4f69_8a28_f808e89f0a62 = function(th, self)
  -- 过程「00cb1c73-ce9b-4491-b675-1aa9c21c5106」 id=4c20d971-9c2e-4f69-8a28-f808e89f0a62
  f["delete_list_item"](self, { item = "all", list = "7d5cbf9a-8853-4978-9d03-9edda234d600" }, th)
  f["delete_list_item"](self, { item = "all", list = "ab2d62af-3efc-4829-9b65-9798ef93bc35" }, th)
  f["delete_list_item"](self, { item = "all", list = "3903dbe9-8860-4a00-8525-c4ab27118f77" }, th)
  f["delete_list_item"](self, { item = "all", list = "480b6739-cc49-4427-b56c-1720766bfd09" }, th)
end

proc_4f585296_463f_434b_9b48_6d729cd4b39c = function(th, self, p_a, p_b, p_______, p_n, p_t)
  -- 过程「函数_数_字符_1」 id=4f585296-463f-434b-9b48-6d729cd4b39c
  if V.bool(f["logic_compare"](self, { A = p_______, B = "渐陡n次", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), B = p_n, type = "power" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "渐缓n次", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_arithmetic"](self, { A = 1, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 1, B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "minus" }, th), B = p_n, type = "power" }, th), type = "minus" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "三角函数", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 1, B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 360, B = f["math_arithmetic"](self, { A = p_n, B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "multiply" }, th), B = 90, type = "minus" }, th), type = "sin" }, th), type = "add" }, th), B = 2, type = "divide" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "三角缓入", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 90, B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "sin" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "三角缓出", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_arithmetic"](self, { A = 1, B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 90, B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "cos" }, th), type = "minus" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "掉落弹跳", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_b, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_a, B = p_b, type = "minus" }, th), B = f["math_arithmetic"](self, { A = f["math_function"](self, { num = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 180, B = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = p_n }, th), list_index = 1 }, th), B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "multiply" }, th), type = "sin" }, th), type = "1" }, th), B = f["math_arithmetic"](self, { A = 2.718281828, B = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = p_n }, th), list_index = 2 }, th), B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "power" }, th), type = "multiply" }, th), type = "multiply" }, th), type = "add" }, th)
  else
    return 0
  end
end

proc_6c4772e8_6d87_42e8_93b9_af878ce04a7e = function(th, self, p_x, p_y, p__________, p_______, p_i)
  -- 过程「函数_1」 id=6c4772e8-6d87-42e8-93b9-af878ce04a7e
  f["script_variables"](self, { PARAMS0 = nil, name = "大小" }, th)
  f["variables_set"](self, { value = 169, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"大小\"}" }, th)
  if V.bool(f["logic_compare"](self, { A = p_i, B = 0, OP = "EQ" }, th)) then
    f["self_move_to"](self, { x = p_x, y = f["math_arithmetic"](self, { A = p_y, B = f["script_variables_value"](self, { TEXT = "大小" }, th), type = "minus" }, th) }, th)
    f["self_pen_down"](self, {}, th)
    th:call_proc(proc_6c4772e8_6d87_42e8_93b9_af878ce04a7e, self, p_x, p_y, p__________, p_______, f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th), nil)
  else
    if V.bool(f["logic_compare"](self, { A = p_i, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p__________, B = 100, type = "divide" }, th), B = 360, type = "multiply" }, th), B = p_______, type = "divide" }, th), OP = "LTE" }, th)) then
      f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = p_x, B = f["math_arithmetic"](self, { A = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = p_i, B = p_______, type = "multiply" }, th), type = "sin" }, th), B = f["script_variables_value"](self, { TEXT = "大小" }, th), type = "multiply" }, th), type = "add" }, th), y = f["math_arithmetic"](self, { A = p_y, B = f["math_arithmetic"](self, { A = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = p_i, B = p_______, type = "multiply" }, th), type = "cos" }, th), B = f["script_variables_value"](self, { TEXT = "大小" }, th), type = "multiply" }, th), type = "minus" }, th) }, th)
      th:call_proc(proc_6c4772e8_6d87_42e8_93b9_af878ce04a7e, self, p_x, p_y, p__________, p_______, f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th), nil)
    else
      f["self_pen_up"](self, {}, th)
      f["self_move_to"](self, { x = 0, y = -225 }, th)
      f["stamp"](self, { align = "center", size = 24, text = f["text_join"](self, { ADD0 = f["variables_get"](self, { variable = "702f182e-81cb-4eb3-b3ea-ae0d954ded36" }, th), ADD1 = "%", ADD2 = " | ", ADD3 = "此为真加载，不相信请扒源代码" }, th) }, th)
    end
  end
end

proc_7558af1a_b4f5_4c12_ada1_f3de6e12d0cd = function(th, self, p____, p_______)
  -- 过程「函数_数_字符_24」 id=7558af1a-b4f5-4c12-ada1-f3de6e12d0cd
  return f["math_arithmetic"](self, { A = f["math_round"](self, { num = f["math_arithmetic"](self, { A = p____, B = f["math_arithmetic"](self, { A = 10, B = p_______, type = "power" }, th), type = "multiply" }, th), type = "round" }, th), B = f["math_arithmetic"](self, { A = 10, B = p_______, type = "power" }, th), type = "divide" }, th)
end

proc_82177fc4_9516_4f2c_90d5_a6b8c584e3f8 = function(th, self)
  -- 过程「函数_数_字符_2」 id=82177fc4-9516-4f2c-90d5-a6b8c584e3f8
  th:warp_enter()
  f["script_variables"](self, { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, PARAMS3 = nil, PARAMS4 = nil, name = "闰年数", names = { "闰年数", "平年天数表", "闰年天数表", "当年第几天", "总天数" } }, th)
  f["variables_set"](self, { value = f["temporary_list"](self, { ITEM0 = 31, ITEM1 = 28, ITEM10 = 30, ITEM11 = 31, ITEM2 = 31, ITEM3 = 30, ITEM4 = 31, ITEM5 = 30, ITEM6 = 31, ITEM7 = 31, ITEM8 = 30, ITEM9 = 31 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"平年天数表\"}" }, th)
  f["variables_set"](self, { value = f["temporary_list"](self, { ITEM0 = 31, ITEM1 = 29, ITEM10 = 30, ITEM11 = 31, ITEM2 = 31, ITEM3 = 30, ITEM4 = 31, ITEM5 = 30, ITEM6 = 31, ITEM7 = 31, ITEM8 = 30, ITEM9 = 31 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"闰年天数表\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["get_time"](self, { time = "year" }, th), B = 1, type = "minus" }, th), B = 4, type = "divide" }, th), type = "round_down" }, th), B = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["get_time"](self, { time = "year" }, th), B = 1, type = "minus" }, th), B = 100, type = "divide" }, th), type = "round_down" }, th), type = "minus" }, th), B = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["get_time"](self, { time = "year" }, th), B = 1, type = "minus" }, th), B = 400, type = "divide" }, th), type = "round_down" }, th), type = "add" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"闰年数\"}" }, th)
  if V.bool(f["logic_operation"](self, { A = f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["math_modulo"](self, { A = f["get_time"](self, { time = "year" }, th), B = 4 }, th), B = 0, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["math_modulo"](self, { A = f["get_time"](self, { time = "year" }, th), B = 100 }, th), B = 0, OP = "NEQ" }, th), type = "and" }, th), B = f["logic_compare"](self, { A = f["math_modulo"](self, { A = f["get_time"](self, { time = "year" }, th), B = 400 }, th), B = 0, OP = "EQ" }, th), type = "or" }, th)) then
    do
      local _from_n1, _to_n1 = tonumber(1), tonumber(f["math_arithmetic"](self, { A = f["get_time"](self, { time = "month" }, th), B = 1, type = "minus" }, th))
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
          f["change_variables"](self, { method = "increase", value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, { TEXT = "闰年天数表" }, th), list_index = _p_n1 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"当年第几天\"}" }, th)
            th:pop_param()
            _p_n1 = _p_n1 + _by_n1
            if th:iter_w() then break end
          end
        end
      end
    end
  else
    do
      local _from_n2, _to_n2 = tonumber(1), tonumber(f["math_arithmetic"](self, { A = f["get_time"](self, { time = "month" }, th), B = 1, type = "minus" }, th))
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
          f["change_variables"](self, { method = "increase", value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, { TEXT = "平年天数表" }, th), list_index = _p_n2 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"当年第几天\"}" }, th)
            th:pop_param()
            _p_n2 = _p_n2 + _by_n2
            if th:iter_w() then break end
          end
        end
      end
    end
  end
  f["change_variables"](self, { method = "increase", value = f["get_time"](self, { time = "date" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"当年第几天\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 365, B = f["math_arithmetic"](self, { A = f["get_time"](self, { time = "year" }, th), B = 1, type = "minus" }, th), type = "multiply" }, th), B = f["script_variables_value"](self, { TEXT = "闰年数" }, th), type = "add" }, th), B = f["script_variables_value"](self, { TEXT = "当年第几天" }, th), type = "add" }, th), B = 739252, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"总天数\"}" }, th)
  th:warp_exit()
  return f["script_variables_value"](self, { TEXT = "总天数" }, th)
end

proc_8866b182_cf8a_4978_92c2_8cda965613bf = function(th, self, p_______)
  -- 过程「31a5ac50-2447-448a-aa96-d3397c59099f」 id=8866b182-cf8a-4978-92c2-8cda965613bf
  f["variables_set"](self, { value = f["random_num"](self, { A = 0, B = 2 }, th), variable = "7fdf438d-fd13-4d83-9727-f89e1ec11469" }, th)
  f["variables_set"](self, { value = p_______, variable = "90168479-24c3-43a1-a88e-932699476b44" }, th)
  f["self_set_effect"](self, { scope = "1", value = 100 }, th)
  f["play_audio"](self, { audio_id = "f827ecbf-a526-45db-8125-b5da570609a5" }, th)
  f["variables_set"](self, { value = 1, variable = "9498bf81-e46e-43f7-847b-0b3ffd0ebeb1" }, th)
  do
    local _times_n1 = f["variables_get"](self, { variable = "90168479-24c3-43a1-a88e-932699476b44" }, th)
    while true do
      if _times_n1 <= 0 then break end
      _times_n1 = _times_n1 - 1
      f["mirror"](self, { sprite = "--self" }, th)
      f["mirror"](self, { sprite = "946ace71-fa8a-4c30-b470-ccfe7c2a6551" }, th)
      if th:iter_d() then break end
    end
  end
  f["wait"](self, { time = 10 }, th)
  f["variables_set"](self, { value = 0, variable = "9498bf81-e46e-43f7-847b-0b3ffd0ebeb1" }, th)
end

proc_95fe1aad_a69d_434e_a25d_be0f124d7de8 = function(th, self)
  -- 过程「e77bc8cb-b75f-41dc-91e8-f23f2a4ecc81」 id=95fe1aad-a69d-434e-a25d-be0f124d7de8
  if V.bool(f["logic_compare"](self, { A = f["get_current_clone_index"](self, {}, th), B = 0, OP = "NEQ" }, th)) then
    f["script_variables"](self, { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, PARAMS3 = nil, PARAMS4 = nil, PARAMS5 = nil, name = "a", names = { "a", "b", "c", "d", "e", "f" } }, th)
    f["variables_set"](self, { value = 1, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
    f["variables_set"](self, { value = f["random_num"](self, { A = 0, B = 1 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"b\"}" }, th)
    f["variables_set"](self, { value = 1, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"c\"}" }, th)
    if V.bool(f["list_is_exist"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th)) then
      f["delete_list_item"](self, { item = "any", list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_index = f["list_index_of"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th) }, th)
    end
    do
      local _times_n1 = 100
      while true do
        if _times_n1 <= 0 then break end
        _times_n1 = _times_n1 - 1
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "d" }, th), B = 0.7, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"d\"}" }, th)
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "e" }, th), B = 0.7, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"e\"}" }, th)
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "f" }, th), B = 0.7, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"f\"}" }, th)
        f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 500, B = f["appearance_of_sprite"](self, { appearance = "width", sprite = "--self" }, th), type = "minus" }, th), B = 0.5, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"d\"}" }, th)
        f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 0, B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.5, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"e\"}" }, th)
        f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 0, B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 0.5, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"f\"}" }, th)
        f["self_change_coordinate_x"](self, { increase = "increase", value = f["script_variables_value"](self, { TEXT = "e" }, th) }, th)
        f["self_change_coordinate_y"](self, { increase = "increase", value = f["script_variables_value"](self, { TEXT = "f" }, th) }, th)
        f["add_width_height_scale"](self, { increase = "increase", type = "width", value = f["script_variables_value"](self, { TEXT = "d" }, th) }, th)
        f["add_width_height_scale"](self, { increase = "increase", type = "height", value = f["script_variables_value"](self, { TEXT = "d" }, th) }, th)
        if th:iter_d() then break end
      end
    end
    f["wait"](self, { time = 5 }, th)
    while true do
      if f["out_of_boundary"](self, { boundary = "3" }, th) then break end
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "b" }, th), B = 0, OP = "EQ" }, th)) then
        f["self_rotate"](self, { degrees = f["math_arithmetic"](self, { A = f["math_trig"](self, { num = f["script_variables_value"](self, { TEXT = "c" }, th), type = "cos" }, th), B = 1.5, type = "multiply" }, th) }, th)
      else
        f["self_rotate"](self, { degrees = f["math_arithmetic"](self, { A = f["math_trig"](self, { num = f["script_variables_value"](self, { TEXT = "c" }, th), type = "sin" }, th), B = 1.25, type = "multiply" }, th) }, th)
      end
      f["self_change_coordinate_y"](self, { increase = "decrease", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = 0.5, type = "multiply" }, th), B = f["variables_get"](self, { variable = "4c5bdc5f-d670-4691-a80e-44e85ad2ded3" }, th), type = "multiply" }, th) }, th)
      f["self_change_coordinate_x"](self, { increase = "decrease", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = 0.75, type = "multiply" }, th), B = f["variables_get"](self, { variable = "4c5bdc5f-d670-4691-a80e-44e85ad2ded3" }, th), type = "multiply" }, th) }, th)
      f["self_change_effect"](self, { increase = "increase", scope = "1", value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = 25, type = "divide" }, th) }, th)
      f["change_variables"](self, { method = "increase", value = 2, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
      f["change_variables"](self, { method = "increase", value = 1, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"c\"}" }, th)
      if th:iter_d() then break end
    end
    f["dispose_clone"](self, {}, th)
  end
end

proc_9d8c0e48_e7a1_443c_b5dd_57e5d7f2e7bf = function(th, self, p_fps)
  -- 过程「cad2454b-c4b1-4508-875e-c42a7617737f」 id=9d8c0e48-e7a1-443c-b5dd-57e5d7f2e7bf
  do
    local _times_n1 = p_fps
    while true do
      if _times_n1 <= 0 then break end
      _times_n1 = _times_n1 - 1
      f["wait"](self, { time = 0 }, th)
      if th:iter_d() then break end
    end
  end
end

proc_aabf0193_3224_42fd_8f50_2ddcb8495be3 = function(th, self, p_______)
  -- 过程「f98f2c1c-b114-4693-9a21-41f347e9c26f」 id=aabf0193-3224-42fd-8f50-2ddcb8495be3
  f["play_audio"](self, { audio_id = p_______ }, th)
end

proc_ab9e6f2c_d942_40be_8d4c_e8f19d72383d = function(th, self)
  -- 过程「6c4808cf-8de7-4cd2-9637-2a5757403861」 id=ab9e6f2c-d942-40be-8d4c-e8f19d72383d
  f["play_audio"](self, { audio_id = "7505e790-1555-4178-acee-00766f02d3ac" }, th)
  f["wait"](self, { time = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 60, B = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "ad9ad2e0-bf30-48fd-9a36-cc64092abce3" }, th), B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "multiply" }, th), type = "divide" }, th), B = f["variables_get"](self, { variable = "1f8a4269-f7f9-4790-be36-e39dfa16cca2" }, th), type = "add" }, th) }, th)
  f["play_audio"](self, { audio_id = "d50533bc-15b4-4e37-9109-e856e6a4b701" }, th)
  f["wait"](self, { time = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 60, B = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "ad9ad2e0-bf30-48fd-9a36-cc64092abce3" }, th), B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "multiply" }, th), type = "divide" }, th), B = f["variables_get"](self, { variable = "1f8a4269-f7f9-4790-be36-e39dfa16cca2" }, th), type = "add" }, th) }, th)
  f["play_audio"](self, { audio_id = "d50533bc-15b4-4e37-9109-e856e6a4b701" }, th)
  f["wait"](self, { time = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 60, B = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "ad9ad2e0-bf30-48fd-9a36-cc64092abce3" }, th), B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "multiply" }, th), type = "divide" }, th), B = f["variables_get"](self, { variable = "1f8a4269-f7f9-4790-be36-e39dfa16cca2" }, th), type = "add" }, th) }, th)
  f["play_audio"](self, { audio_id = "d50533bc-15b4-4e37-9109-e856e6a4b701" }, th)
  f["wait"](self, { time = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 60, B = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "ad9ad2e0-bf30-48fd-9a36-cc64092abce3" }, th), B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "multiply" }, th), type = "divide" }, th), B = f["variables_get"](self, { variable = "1f8a4269-f7f9-4790-be36-e39dfa16cca2" }, th), type = "add" }, th) }, th)
end

proc_acdca734_97cd_4807_947f_a3e65cd9c8b4 = function(th, self, p_a, p_b, p_______, p_n, p_t)
  -- 过程「函数_数_字符_1」 id=acdca734-97cd-4807-947f-a3e65cd9c8b4
  if V.bool(f["logic_compare"](self, { A = p_______, B = "渐陡n次", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), B = p_n, type = "power" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "渐缓n次", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_arithmetic"](self, { A = 1, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 1, B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "minus" }, th), B = p_n, type = "power" }, th), type = "minus" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "三角函数", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 1, B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 360, B = f["math_arithmetic"](self, { A = p_n, B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "multiply" }, th), B = 90, type = "minus" }, th), type = "sin" }, th), type = "add" }, th), B = 2, type = "divide" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "三角缓入", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 90, B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "sin" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "三角缓出", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_arithmetic"](self, { A = 1, B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 90, B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "cos" }, th), type = "minus" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "掉落弹跳", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_b, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_a, B = p_b, type = "minus" }, th), B = f["math_arithmetic"](self, { A = f["math_function"](self, { num = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 180, B = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = p_n }, th), list_index = 1 }, th), B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "multiply" }, th), type = "sin" }, th), type = "1" }, th), B = f["math_arithmetic"](self, { A = 2.718281828, B = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = p_n }, th), list_index = 2 }, th), B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "power" }, th), type = "multiply" }, th), type = "multiply" }, th), type = "add" }, th)
  else
    return 0
  end
end

proc_b40a764c_79a5_40e4_ba26_f77f45c7a502 = function(th, self, p_______, p________2, p________3)
  -- 过程「e2f64ca4-530b-406b-b8c3-6a73056de228」 id=b40a764c-79a5-40e4-ba26-f77f45c7a502
  f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
  while true do
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = 0.7, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
    if V.bool(f["bump_into"](self, { sprite = "--self", sprite1 = "--mouse" }, th)) then
      if V.bool(f["mouse_down"](self, { sprite = "--self", type = "down" }, th)) then
        f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p________3, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 0.5, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
      else
        f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p________2, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 0.5, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
      end
    else
      f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_______, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 0.5, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
    end
    f["self_change_scale"](self, { increase = "increase", scale = f["script_variables_value"](self, { TEXT = "a" }, th) }, th)
    if th:iter_d() then break end
  end
end

proc_b81c7a0d_edae_4cce_b0bf_787193b1602c = function(th, self, p_fps)
  -- 过程「cad2454b-c4b1-4508-875e-c42a7617737f」 id=b81c7a0d-edae-4cce-b0bf-787193b1602c
  do
    local _times_n1 = p_fps
    while true do
      if _times_n1 <= 0 then break end
      _times_n1 = _times_n1 - 1
      f["wait"](self, { time = 0 }, th)
      if th:iter_d() then break end
    end
  end
end

proc_bfe2998b_3a71_4599_b05a_8d3aa3d32a26 = function(th, self, p_______1, p_______2, p_______3)
  -- 过程「818b90f2-0f83-433c-8ef0-d5df570ed486」 id=bfe2998b-3a71-4599-b05a-8d3aa3d32a26
  if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = p_______2, B = p_______1, OP = "LT" }, th), B = f["logic_compare"](self, { A = p_______1, B = p_______3, OP = "LT" }, th), type = "and" }, th)) then
    return "true"
  else
    return "false"
  end
end

proc_c2116d3b_38ff_4bf0_a4b6_eec9fe9f1f89 = function(th, self)
  -- 过程「622d24f2-9eba-4c72-bc4d-245bf05a41b0」 id=c2116d3b-38ff-4bf0-a4b6-eec9fe9f1f89
  f["play_audio"](self, { audio_id = "b8a319a1-d660-4e97-92a5-ac9261924da3" }, th)
end

proc_c9cdb104_5f0e_4971_a8ae_fdf321b2aae0 = function(th, self, p_______, p________2, p________3)
  -- 过程「e2f64ca4-530b-406b-b8c3-6a73056de228」 id=c9cdb104-5f0e-4971-a8ae-fdf321b2aae0
  f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
  while true do
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = 0.6, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
    if V.bool(f["bump_into"](self, { sprite = "--self", sprite1 = "--mouse" }, th)) then
      if V.bool(f["mouse_down"](self, { sprite = "--self", type = "down" }, th)) then
        f["self_change_scale"](self, { increase = "increase", scale = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p________3, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 0.0666, type = "multiply" }, th) }, th)
      else
        f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p________2, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 0.4, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
      end
    else
      f["self_change_scale"](self, { increase = "increase", scale = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_______, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 0.1333, type = "multiply" }, th) }, th)
    end
    f["self_change_scale"](self, { increase = "increase", scale = f["script_variables_value"](self, { TEXT = "a" }, th) }, th)
    if th:iter_d() then break end
  end
end

proc_e1d938c6_3ee5_4249_8fe7_18aa24c7d122 = function(th, self, p_a, p_b, p_______, p_n, p_t)
  -- 过程「函数_数_字符_1」 id=e1d938c6-3ee5-4249-8fe7-18aa24c7d122
  if V.bool(f["logic_compare"](self, { A = p_______, B = "渐陡n次", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), B = p_n, type = "power" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "渐缓n次", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_arithmetic"](self, { A = 1, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 1, B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "minus" }, th), B = p_n, type = "power" }, th), type = "minus" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "三角函数", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 1, B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 360, B = f["math_arithmetic"](self, { A = p_n, B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "multiply" }, th), B = 90, type = "minus" }, th), type = "sin" }, th), type = "add" }, th), B = 2, type = "divide" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "三角缓入", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 90, B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "sin" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "三角缓出", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_arithmetic"](self, { A = 1, B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 90, B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "cos" }, th), type = "minus" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "掉落弹跳", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_b, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_a, B = p_b, type = "minus" }, th), B = f["math_arithmetic"](self, { A = f["math_function"](self, { num = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 180, B = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = p_n }, th), list_index = 1 }, th), B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "multiply" }, th), type = "sin" }, th), type = "1" }, th), B = f["math_arithmetic"](self, { A = 2.718281828, B = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = p_n }, th), list_index = 2 }, th), B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "power" }, th), type = "multiply" }, th), type = "multiply" }, th), type = "add" }, th)
  else
    return 0
  end
end

proc_eae8d3c4_5e2e_4f78_90db_9f8463348874 = function(th, self, p_a, p_b, p_______, p_n, p_t)
  -- 过程「函数_数_字符_1」 id=eae8d3c4-5e2e-4f78-90db-9f8463348874
  if V.bool(f["logic_compare"](self, { A = p_______, B = "渐陡n次", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), B = p_n, type = "power" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "渐缓n次", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_arithmetic"](self, { A = 1, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 1, B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "minus" }, th), B = p_n, type = "power" }, th), type = "minus" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "三角函数", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 1, B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 360, B = f["math_arithmetic"](self, { A = p_n, B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "multiply" }, th), B = 90, type = "minus" }, th), type = "sin" }, th), type = "add" }, th), B = 2, type = "divide" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "三角缓入", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 90, B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "sin" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "三角缓出", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_arithmetic"](self, { A = 1, B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 90, B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "cos" }, th), type = "minus" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "掉落弹跳", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_b, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_a, B = p_b, type = "minus" }, th), B = f["math_arithmetic"](self, { A = f["math_function"](self, { num = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 180, B = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = p_n }, th), list_index = 1 }, th), B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "multiply" }, th), type = "sin" }, th), type = "1" }, th), B = f["math_arithmetic"](self, { A = 2.718281828, B = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = p_n }, th), list_index = 2 }, th), B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "power" }, th), type = "multiply" }, th), type = "multiply" }, th), type = "add" }, th)
  else
    return 0
  end
end

proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40 = function(th, self, p_______, p________2, p______________________)
  -- 过程「da8c4c26-27f1-4f55-bef5-b32deed89252」 id=eb9a4d4e-2b88-4999-a8af-a05ca21e7c40
  th:warp_enter()
  f["variables_set"](self, { value = p________2, variable = "cde26d07-94a9-4006-b9f6-7a2dd17edb44" }, th)
  f["list_copy"](self, { list = f["text_split"](self, { SPLIT_TEXT = "|", TEXT_TO_SPLIT = f["variables_get"](self, { variable = "cde26d07-94a9-4006-b9f6-7a2dd17edb44" }, th) }, th), target_list = "7d5cbf9a-8853-4978-9d03-9edda234d600" }, th)
  f["variables_set"](self, { value = 2, variable = "661345c6-cc87-4b50-9937-dec0fc714cfd" }, th)
  while true do
    if f["logic_compare"](self, { A = f["variables_get"](self, { variable = "661345c6-cc87-4b50-9937-dec0fc714cfd" }, th), B = f["list_length"](self, { list = "7d5cbf9a-8853-4978-9d03-9edda234d600" }, th), OP = "EQ" }, th) then break end
    if V.bool(f["list_is_exist"](self, { list = "5d99aa00-43fe-4471-b284-639286a8dc0e", list_item_value = f["variables_get"](self, { variable = "661345c6-cc87-4b50-9937-dec0fc714cfd" }, th) }, th)) then
      f["list_append"](self, { list = "ab2d62af-3efc-4829-9b65-9798ef93bc35", list_item_value = f["list_item"](self, { item = "any", list = "7d5cbf9a-8853-4978-9d03-9edda234d600", list_index = f["variables_get"](self, { variable = "661345c6-cc87-4b50-9937-dec0fc714cfd" }, th) }, th) }, th)
    elseif V.bool(f["list_is_exist"](self, { list = "77f2cb30-b659-4351-b04d-0f5ff168bf58", list_item_value = f["variables_get"](self, { variable = "661345c6-cc87-4b50-9937-dec0fc714cfd" }, th) }, th)) then
      f["list_append"](self, { list = "3903dbe9-8860-4a00-8525-c4ab27118f77", list_item_value = f["list_item"](self, { item = "any", list = "7d5cbf9a-8853-4978-9d03-9edda234d600", list_index = f["variables_get"](self, { variable = "661345c6-cc87-4b50-9937-dec0fc714cfd" }, th) }, th) }, th)
    elseif V.bool(f["list_is_exist"](self, { list = "6a4619d9-d26e-4ea0-a4f6-6e7b2dd396e9", list_item_value = f["variables_get"](self, { variable = "661345c6-cc87-4b50-9937-dec0fc714cfd" }, th) }, th)) then
      f["list_append"](self, { list = "480b6739-cc49-4427-b56c-1720766bfd09", list_item_value = f["list_item"](self, { item = "any", list = "7d5cbf9a-8853-4978-9d03-9edda234d600", list_index = f["variables_get"](self, { variable = "661345c6-cc87-4b50-9937-dec0fc714cfd" }, th) }, th) }, th)
    end
    f["change_variables"](self, { method = "increase", value = 1, variable = "661345c6-cc87-4b50-9937-dec0fc714cfd" }, th)
    if th:iter_w() then break end
  end
  th:warp_exit()
  f["list_append"](self, { list = "ab2d62af-3efc-4829-9b65-9798ef93bc35", list_item_value = f["list_item"](self, { item = "last", list = "7d5cbf9a-8853-4978-9d03-9edda234d600" }, th) }, th)
  f["self_text_effect_size"](self, { size = 24 }, th)
  f["self_text_effect_color"](self, { color = "#ffffff" }, th)
  f["set_timer_state"](self, { type = "start" }, th)
  f["show_hide_timer"](self, { showHide = "hide" }, th)
  if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "636f5999-3b33-4e0c-809d-ccf0da3c5550" }, th), B = 0, OP = "EQ" }, th)) then
    f["play_audio"](self, { audio_id = p_______ }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "ba610640-3c96-4773-9c54-caf7e1847d47" }, th), B = 1, OP = "EQ" }, th)) then
    do
      local _times_n1 = f["list_length"](self, { list = "3903dbe9-8860-4a00-8525-c4ab27118f77" }, th)
      while true do
        if _times_n1 <= 0 then break end
        _times_n1 = _times_n1 - 1
        while not V.bool(f["logic_compare"](self, { A = f["timer"](self, {}, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = "3903dbe9-8860-4a00-8525-c4ab27118f77", list_index = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 1, type = "add" }, th) }, th), B = 60, type = "multiply" }, th), B = f["list_item"](self, { item = "any", list = "480b6739-cc49-4427-b56c-1720766bfd09", list_index = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 1, type = "add" }, th) }, th), type = "add" }, th), OP = "GTE" }, th)) do
          if th:iter_n() then break end
        end
        f["change_variables"](self, { method = "increase", value = 1, variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th)
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "3928c2ca-4cf5-4dd2-a48e-41d7ebf7b197" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.1 }, th)
          f["self_text_effect_text"](self, { text = f["list_item"](self, { item = "any", list = "ab2d62af-3efc-4829-9b65-9798ef93bc35", list_index = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th) }, th) }, th)
          f["self_gradually_show_hide"](self, { show_hide = "show", time = 0.1 }, th)
        else
          f["self_text_effect_text"](self, { text = f["list_item"](self, { item = "any", list = "ab2d62af-3efc-4829-9b65-9798ef93bc35", list_index = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th) }, th) }, th)
        end
        if th:iter_d() then break end
      end
    end
    f["wait"](self, { time = p______________________ }, th)
    f["variables_set"](self, { value = 1, variable = "d202368b-a5de-405e-9702-fec08ac22b34" }, th)
  end
end

proc_ec2362be_da94_4df9_9ea3_72ccff65a8ab = function(th, self, p_a, p_b, p_______, p_n, p_t)
  -- 过程「函数_数_字符_1」 id=ec2362be-da94-4df9-9ea3-72ccff65a8ab
  if V.bool(f["logic_compare"](self, { A = p_______, B = "渐陡n次", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), B = p_n, type = "power" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "渐缓n次", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_arithmetic"](self, { A = 1, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 1, B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "minus" }, th), B = p_n, type = "power" }, th), type = "minus" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "三角函数", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 1, B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 360, B = f["math_arithmetic"](self, { A = p_n, B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "multiply" }, th), B = 90, type = "minus" }, th), type = "sin" }, th), type = "add" }, th), B = 2, type = "divide" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "三角缓入", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 90, B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "sin" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "三角缓出", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_a, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_b, B = p_a, type = "minus" }, th), B = f["math_arithmetic"](self, { A = 1, B = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 90, B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "cos" }, th), type = "minus" }, th), type = "multiply" }, th), type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = "掉落弹跳", OP = "EQ" }, th)) then
    return f["math_arithmetic"](self, { A = p_b, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_a, B = p_b, type = "minus" }, th), B = f["math_arithmetic"](self, { A = f["math_function"](self, { num = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = 180, B = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = p_n }, th), list_index = 1 }, th), B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "multiply" }, th), type = "sin" }, th), type = "1" }, th), B = f["math_arithmetic"](self, { A = 2.718281828, B = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = p_n }, th), list_index = 2 }, th), B = f["math_arithmetic"](self, { A = p_t, B = 100, type = "divide" }, th), type = "multiply" }, th), type = "power" }, th), type = "multiply" }, th), type = "multiply" }, th), type = "add" }, th)
  else
    return 0
  end
end

proc_f88f9ad7_6f39_4deb_a9e9_c2f0e242cb39 = function(th, self, p_i, p_______)
  -- 过程「f343d72e-8b99-48a5-8f5c-2d846526aacb」 id=f88f9ad7-6f39-4deb-a9e9-c2f0e242cb39
  if V.bool(f["logic_compare"](self, { A = p_______, B = 0, OP = "EQ" }, th)) then
    if V.bool(f["logic_compare"](self, { A = f["list_length"](self, { list = "5d99aa00-43fe-4471-b284-639286a8dc0e" }, th), B = 999, OP = "NEQ" }, th)) then
      f["list_append"](self, { list = "5d99aa00-43fe-4471-b284-639286a8dc0e", list_item_value = f["math_arithmetic"](self, { A = p_i, B = 3, type = "add" }, th) }, th)
      th:call_proc(proc_f88f9ad7_6f39_4deb_a9e9_c2f0e242cb39, self, f["math_arithmetic"](self, { A = p_i, B = 3, type = "add" }, th), 0)
      f["variables_set"](self, { value = (th:call_proc(proc_7558af1a_b4f5_4c12_ada1_f3de6e12d0cd, self, f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_length"](self, { list = "5d99aa00-43fe-4471-b284-639286a8dc0e" }, th), B = 999, type = "divide" }, th), B = 100, type = "multiply" }, th), B = 3, type = "divide" }, th), 2)), variable = "702f182e-81cb-4eb3-b3ea-ae0d954ded36" }, th)
    else
      th:call_proc(proc_f88f9ad7_6f39_4deb_a9e9_c2f0e242cb39, self, 2, 1)
    end
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = 1, OP = "EQ" }, th)) then
    if V.bool(f["logic_compare"](self, { A = f["list_length"](self, { list = "77f2cb30-b659-4351-b04d-0f5ff168bf58" }, th), B = 999, OP = "NEQ" }, th)) then
      f["list_append"](self, { list = "77f2cb30-b659-4351-b04d-0f5ff168bf58", list_item_value = f["math_arithmetic"](self, { A = p_i, B = 3, type = "add" }, th) }, th)
      th:call_proc(proc_f88f9ad7_6f39_4deb_a9e9_c2f0e242cb39, self, f["math_arithmetic"](self, { A = p_i, B = 3, type = "add" }, th), 1)
      f["variables_set"](self, { value = (th:call_proc(proc_7558af1a_b4f5_4c12_ada1_f3de6e12d0cd, self, f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_length"](self, { list = "77f2cb30-b659-4351-b04d-0f5ff168bf58" }, th), B = 999, type = "divide" }, th), B = 100, type = "multiply" }, th), B = 3, type = "divide" }, th), 2)), variable = "702f182e-81cb-4eb3-b3ea-ae0d954ded36" }, th)
    else
      th:call_proc(proc_f88f9ad7_6f39_4deb_a9e9_c2f0e242cb39, self, 3, 2)
    end
  elseif V.bool(f["logic_compare"](self, { A = p_______, B = 2, OP = "EQ" }, th)) then
    if V.bool(f["logic_compare"](self, { A = f["list_length"](self, { list = "6a4619d9-d26e-4ea0-a4f6-6e7b2dd396e9" }, th), B = 999, OP = "NEQ" }, th)) then
      f["list_append"](self, { list = "6a4619d9-d26e-4ea0-a4f6-6e7b2dd396e9", list_item_value = f["math_arithmetic"](self, { A = p_i, B = 3, type = "add" }, th) }, th)
      th:call_proc(proc_f88f9ad7_6f39_4deb_a9e9_c2f0e242cb39, self, f["math_arithmetic"](self, { A = p_i, B = 3, type = "add" }, th), 2)
      f["variables_set"](self, { value = (th:call_proc(proc_7558af1a_b4f5_4c12_ada1_f3de6e12d0cd, self, f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_length"](self, { list = "6a4619d9-d26e-4ea0-a4f6-6e7b2dd396e9" }, th), B = 999, type = "divide" }, th), B = 100, type = "multiply" }, th), B = 3, type = "divide" }, th), 2)), variable = "702f182e-81cb-4eb3-b3ea-ae0d954ded36" }, th)
    else
      f["variables_set"](self, { value = 100, variable = "702f182e-81cb-4eb3-b3ea-ae0d954ded36" }, th)
      do
        local _from_n1, _to_n1 = tonumber(1), tonumber(100)
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
            f["self_set_effect"](self, { scope = "1", value = (th:call_proc(proc_4f585296_463f_434b_9b48_6d729cd4b39c, self, 0, 100, "渐缓n次", 15, _p_n1)) }, th)
            f["set_width_height_scale"](self, { type = "height", value = (th:call_proc(proc_4f585296_463f_434b_9b48_6d729cd4b39c, self, 100, 1, "渐缓n次", 15, _p_n1)) }, th)
            f["set_width_height_scale"](self, { type = "width", value = (th:call_proc(proc_4f585296_463f_434b_9b48_6d729cd4b39c, self, 100, 1, "渐缓n次", 5, _p_n1)) }, th)
            f["self_move_to"](self, { x = (th:call_proc(proc_4f585296_463f_434b_9b48_6d729cd4b39c, self, 0, -350, "渐缓n次", 5, _p_n1)), y = (th:call_proc(proc_4f585296_463f_434b_9b48_6d729cd4b39c, self, 0, -200, "渐缓n次", 5, _p_n1)) }, th)
              th:pop_param()
              _p_n1 = _p_n1 + _by_n1
              if th:iter_d() then break end
            end
          end
        end
      end
      f["self_appear"](self, { value = "disappear" }, th)
    end
  end
end

proc_f92a4bf5_d4e2_488e_87a9_dc2e04d8fd2a = function(th, self)
  -- 过程「8e0d7960-a55a-4298-a46d-34f57eea3045」 id=f92a4bf5-d4e2-488e-87a9-dc2e04d8fd2a
  f["play_audio"](self, { audio_id = "4d1ddd5d-adb0-44d1-b17d-a255c6f5405d" }, th)
  f["wait"](self, { time = f["math_arithmetic"](self, { A = 60, B = 135, type = "divide" }, th) }, th)
  f["play_audio"](self, { audio_id = "4d1ddd5d-adb0-44d1-b17d-a255c6f5405d" }, th)
  f["wait"](self, { time = f["math_arithmetic"](self, { A = 60, B = 135, type = "divide" }, th) }, th)
  f["play_audio"](self, { audio_id = "4d1ddd5d-adb0-44d1-b17d-a255c6f5405d" }, th)
  f["wait"](self, { time = f["math_arithmetic"](self, { A = 60, B = 135, type = "divide" }, th) }, th)
  f["play_audio"](self, { audio_id = "559b378e-5ea8-4cfb-bacc-f4be7db36ac1" }, th)
  f["wait"](self, { time = f["math_arithmetic"](self, { A = 60, B = 135, type = "divide" }, th) }, th)
end

proc_fde38e22_9be0_4d77_8605_5a4e38f5270c = function(th, self)
  -- 过程「5ca73d08-2e66-4f24-9102-54a4e655f0f7」 id=fde38e22-9be0-4d77-8605-5a4e38f5270c
  while true do
    if V.bool(f["bump_into"](self, { sprite = "--self", sprite1 = "--mouse" }, th)) then
      if V.bool(f["mouse_down"](self, { sprite = "--self", type = "down" }, th)) then
        f["self_change_effect"](self, { increase = "increase", scope = "2", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 105, B = f["effect_of_sprite"](self, { effect = "2", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
      else
        f["self_change_effect"](self, { increase = "increase", scope = "2", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 120, B = f["effect_of_sprite"](self, { effect = "2", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
      end
    else
      f["self_change_effect"](self, { increase = "increase", scope = "2", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = f["effect_of_sprite"](self, { effect = "2", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
    end
    if th:iter_d() then break end
  end
end

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 900, 562
M.timer_pos = { x = 720, y = 12 }
M.proc_trampoline = true
M.uses_timer = true
M.timer_hidden_default = false
M.vars = { { current_entity_id = "", cv_id = "", entity_name = "", id = "01e09819-e806-496f-b88c-8d472d437f9d", is_global = true, name = "miss次数", order = 8, position = { x = 220, y = 327 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "0673923e-1920-4e2c-8197-ed44db4c7243", is_global = true, name = "手动选择mod", order = 20, position = { x = 577, y = 260 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "074e8e18-1e0f-460e-9cc2-b286de92d78a", is_global = true, name = "鼠标上一帧y坐标", order = 88, position = { x = 654, y = 423 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "0d334e44-f97e-4c6e-bf88-025706398657", is_global = true, name = "开始游戏中", order = 115, position = { x = 694, y = 87 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "0d867230-f0d8-4115-bc7b-81cf2db5a9a3", is_global = true, name = "盘子基准速度", order = 50, position = { x = 580, y = 420 }, scale = 1, style = "default", type = "private", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "0e5b8264-119d-4030-8b02-ac263239ad6b", is_global = true, name = "自定义难度", order = 58, position = { x = 694, y = 87 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "0f86fbf8-f15a-49ba-b08f-5e0a3af39d11", is_global = true, name = "rawPP", order = 23, position = { x = 701, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "11945cca-fa65-4aea-8325-3d1d00c8da21", is_global = true, name = "曲", order = 31, position = { x = 701, y = 423 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "136bfda7-419e-46c7-8ba1-dca80f8721f3", is_global = true, name = "总note", order = 10, position = { x = 220, y = 487 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "16f5bf5a-64a9-4ad1-9052-d34b3e677e99", is_global = true, name = "背景亮度", order = 61, position = { x = 694, y = 314 }, scale = 1, style = "default", type = "private", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "18a437b0-0ab5-4dc7-b144-363707cdad1c", is_global = true, name = "谱面读取", order = 52, position = { x = 628, y = 87 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "19b1dec6-5fb5-4e67-b31c-e63f1070d435", is_global = true, name = "下坠列表", order = 112, position = { x = 694, y = 423 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "1a41a792-98e4-42c2-9647-e57bc7a45f5a", is_global = true, name = "谱面难度升级51-100", order = 17, position = { x = 577, y = 20 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "1c7bff85-38c5-4cbd-928a-40b3f2b56836", is_global = true, name = "在线人数", order = 97, position = { x = 704, y = 490 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "1edbe62e-38fe-4d98-996c-eb04b57ed57e", is_global = true, name = "谱面难度升级101-200", order = 18, position = { x = 577, y = 100 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "1efc0077-8db0-4702-bf36-22dcd92460d9", is_global = true, name = "x", order = 53, position = { x = 628, y = 154 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "1f8a4269-f7f9-4790-be36-e39dfa16cca2", is_global = true, name = "音频延迟", order = 32, position = { x = 701, y = 490 }, scale = 1, style = "default", type = "private", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "1f9decff-97e1-4f33-8ae8-28b8e121229d", is_global = true, name = "鼠标x速度", order = 89, position = { x = 654, y = 490 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "230adc73-6e89-4cdb-be49-6fbde4dce1da", is_global = true, name = "帧", order = 110, position = { x = 694, y = 288 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "23d0e95f-17d8-43b1-b0d1-40df0bc915d5", is_global = true, name = "鸣谢看了", order = 80, position = { x = 603, y = 423 }, scale = 1, style = "default", type = "private", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "24f22fa4-08bb-40be-a069-3a77d7b49bd6", is_global = true, name = "本地谱面", order = 69, position = { x = 675, y = 221 }, scale = 1, style = "default", type = "private", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "253775dc-1fbb-4102-9046-9616d6e37f7a", is_global = true, name = "简单在线", order = 101, position = { x = 732, y = 221 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "281cbc78-8d58-4963-87b4-7f6502e9069c", is_global = true, name = "广告主题", order = 123, position = { x = 713, y = 87 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "28212a58-3dd5-4497-b5d7-ff619cd52f8f", is_global = true, name = "hit次数", order = 9, position = { x = 220, y = 407 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "289b6904-2e10-4d69-88a3-c9d91e32d4dc", is_global = true, name = "在线列表", order = 102, position = { x = 732, y = 288 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "27839e28-7a5d-400b-b8ad-1d0f58686fba", cv_id = "", entity_name = "退出", id = "2aec488e-6f97-423a-87a0-c7c89991c802", is_global = false, name = "退出进度", order = 79, position = { x = 603, y = 356 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "2c976bf3-7a3a-4f50-a7b7-915266ce1aa7", is_global = true, name = "总分", order = 13, position = { x = 420, y = 180 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "FSyVfBxw", entity_name = "", id = "388276cd-04f0-4be1-91be-92c33b2d6f71", is_global = true, name = "宜刻乐代打总成绩", order = 48, position = { x = 580, y = 180 }, scale = 1, style = "default", type = "public", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "3903dbe9-8860-4a00-8525-c4ab27118f77", is_global = true, name = "m", order = 33, position = { x = 780, y = 20 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "3928c2ca-4cf5-4dd2-a48e-41d7ebf7b197", is_global = true, name = "歌词过渡", order = 113, position = { x = 694, y = 490 }, scale = 1, style = "default", type = "private", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "3a064750-07fd-4c4a-95a2-271c3b091da8", is_global = true, name = "歌曲", order = 42, position = { x = 713, y = 288 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "3c180ab0-af0b-4f97-9e2f-7d4a1b5a9d09", is_global = true, name = "改时间神人列表", order = 111, position = { x = 694, y = 356 }, scale = 1, style = "default", type = "list", value = { 1918335247, 677423120, 1847567784, 603025034, 184409462 }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057", is_global = true, name = "HP", order = 26, position = { x = 556, y = 407 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "3cfd462f-655e-4fd0-98dd-71391586fe0a", is_global = true, name = "鼠标速度", order = 91, position = { x = 704, y = 87 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "3ded2f9d-1a42-43bc-b34d-4b202ef6cca7", is_global = true, name = "流速", order = 67, position = { x = 540, y = 448 }, scale = 1, style = "default", type = "private", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "3e0c81bd-95da-4454-816f-21a689fd5f58", is_global = true, name = "高级移动", order = 92, position = { x = 704, y = 154 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "3ef85efc-ea88-45ed-b6f7-8126cb76477e", is_global = true, name = "滑动条状态", order = 86, position = { x = 654, y = 288 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "3fc9d1cc-d568-45d0-973e-1a7178ce9a0d", is_global = true, name = "时间", order = 54, position = { x = 628, y = 221 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "418bb17d-5d87-4588-8982-29bf95f3f997", is_global = true, name = "FPS", order = 109, position = { x = 694, y = 221 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "346d958e-5f8c-4eb4-9b8b-368fa49d5703", cv_id = "", entity_name = "涟漪", id = "41ba8271-f9f4-4a34-a1af-6470409c7763", is_global = false, name = "x", order = 84, position = { x = 654, y = 154 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "475f4ace-928d-44ae-9cd4-653730db6e1f", is_global = true, name = "combo", order = 0, position = { x = 20, y = 180 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "480b6739-cc49-4427-b56c-1720766bfd09", is_global = true, name = "s", order = 39, position = { x = 780, y = 87 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "4c3a9fa3-347b-4fc8-9fd0-4ad8acee6668", is_global = true, name = "Auto Play", order = 30, position = { x = 701, y = 221 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "4e0bf06f-b180-48d9-9f10-687f65611991", is_global = true, name = "差时", order = 96, position = { x = 704, y = 423 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "4f001481-87b9-4b59-b50a-87fc1ed45738", is_global = true, name = "谱面难度升级0-50", order = 16, position = { x = 420, y = 420 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "4f521286-82c5-4924-ac41-22152513b097", is_global = true, name = "左中右全局", order = 78, position = { x = 603, y = 288 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "505b32e2-ae1d-4d28-add2-e5c5fa4a920f", is_global = true, name = "曲面数量-1", order = 43, position = { x = 713, y = 356 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "58c2cc61-971e-4108-a31f-d8db8c050145", is_global = true, name = "当前歌词", order = 37, position = { x = 713, y = 288 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "5c47c536-5bc8-47dd-8902-3619ab3fb7cf", is_global = true, name = "滑条长度", order = 57, position = { x = 732, y = 20 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "5d99aa00-43fe-4471-b284-639286a8dc0e", is_global = true, name = "1", order = 116, position = { x = 694, y = 154 }, scale = 1, style = "default", type = "private_list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "5f4b09b8-8a57-4d1e-87b3-f71d8fb5563d", is_global = true, name = "简单在线统计", order = 99, position = { x = 732, y = 87 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "6092a2df-3e87-4447-8b09-b36e55b4310c", is_global = true, name = "Hard Core", order = 28, position = { x = 701, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "61c6de7f-432c-48fc-b3d8-e14a59f273ba", is_global = true, name = "盘子速度", order = 15, position = { x = 420, y = 340 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "636f5999-3b33-4e0c-809d-ccf0da3c5550", is_global = true, name = "静音", order = 40, position = { x = 780, y = 154 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "661345c6-cc87-4b50-9937-dec0fc714cfd", is_global = true, name = "i", order = 38, position = { x = 713, y = 356 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "6a4619d9-d26e-4ea0-a4f6-6e7b2dd396e9", is_global = true, name = "3", order = 118, position = { x = 694, y = 288 }, scale = 1, style = "default", type = "private_list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "6a6d0ee2-2fd4-42ca-b5d4-8c6484bc8750", is_global = true, name = "历史上线过的", order = 104, position = { x = 732, y = 423 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "6b4406f7-382e-4c5c-9cc2-254fd3a793f7", is_global = true, name = "允许miss显示", order = 2, position = { x = 20, y = 340 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "6d4177f9-c6ba-4ad1-9b05-602c8e323c17", is_global = true, name = "统计", order = 94, position = { x = 704, y = 288 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "6e7bfb18-fe24-4d8b-962d-127254283c9d", is_global = true, name = "时间序列", order = 95, position = { x = 704, y = 356 }, scale = 1, style = "default", type = "private", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "702f182e-81cb-4eb3-b3ea-ae0d954ded36", is_global = true, name = "歌词加载进度", order = 68, position = { x = 675, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "70b1eb77-cf13-44c5-909b-1268a3672002", is_global = true, name = "combo序列", order = 4, position = { x = 220, y = 20 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "71676bd4-3fa4-473b-aa5b-97f49d44528a", is_global = true, name = "难度选择", order = 45, position = { x = 713, y = 490 }, scale = 1, style = "default", type = "any", value = 2, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "7366bfe4-8f93-48d5-9111-5b8e77da869c", is_global = true, name = "在线差异统计", order = 100, position = { x = 732, y = 154 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "76acb1a2-e19a-4b72-8636-1ef70256e584", is_global = true, name = "奖励判定", order = 12, position = { x = 420, y = 100 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "77f2cb30-b659-4351-b04d-0f5ff168bf58", is_global = true, name = "2", order = 117, position = { x = 694, y = 221 }, scale = 1, style = "default", type = "private_list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "7ab0b7da-3530-4260-8d68-5f082298c892", is_global = true, name = "设置主题", order = 122, position = { x = 713, y = 20 }, scale = 1, style = "default", type = "any", value = 3, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "7d5cbf9a-8853-4978-9d03-9edda234d600", is_global = true, name = "预处理", order = 35, position = { x = 780, y = 154 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "7e0f49e9-ddda-4aa3-ba02-6812ac0a9f50", is_global = true, name = "预加载", order = 59, position = { x = 694, y = 167 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "7fdf438d-fd13-4d83-9727-f89e1ec11469", is_global = true, name = "星星喷泉方向", order = 63, position = { x = 675, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "346d958e-5f8c-4eb4-9b8b-368fa49d5703", cv_id = "", entity_name = "涟漪", id = "881b7c03-ac25-4adb-afdf-b2a09908c7a9", is_global = false, name = "结束使用", order = 83, position = { x = 654, y = 87 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "8873b32e-8677-4c05-a854-178cde7a8bbf", is_global = true, name = "鼠标上一帧x坐标", order = 87, position = { x = 654, y = 356 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "888845c3-2f09-456c-841f-19164ac74dd2", is_global = true, name = "acc", order = 11, position = { x = 420, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "90168479-24c3-43a1-a88e-932699476b44", is_global = true, name = "星星喷泉每个喷泉克隆体数量", order = 64, position = { x = 540, y = 87 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "909d3297-1da6-4886-b8c8-fe0f46183722", is_global = true, name = "主菜单状态", order = 106, position = { x = 694, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "917e09a7-2fc4-4a48-b3c3-6d8e11cedaeb", is_global = true, name = "滑动条接管", order = 85, position = { x = 654, y = 221 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "932ebbc7-efcb-4bd4-8ed3-a361bffde8c7", is_global = true, name = "maxcombo", order = 1, position = { x = 20, y = 260 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "93fb9521-33b9-41c0-a246-5e77dcbf2143", is_global = true, name = "难度", order = 46, position = { x = 768, y = 20 }, scale = 1, style = "default", type = "list", value = { "Eazy", 0.5, 1, 1.5, 2, "Hard Core" }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "9498bf81-e46e-43f7-847b-0b3ffd0ebeb1", is_global = true, name = "Kiai", order = 65, position = { x = 540, y = 154 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "961c59df-040f-44d3-91c6-6a0330ead0d2", is_global = true, name = "可以开始", order = 107, position = { x = 694, y = 87 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "9a1370ff-40f6-4ef6-bb25-4865fb357307", is_global = true, name = "显示星星喷泉", order = 73, position = { x = 675, y = 503 }, scale = 1, style = "default", type = "private", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "a0f605c5-1fe0-49ee-8724-d148ae1a3197", is_global = true, name = "主题", order = 120, position = { x = 656, y = 423 }, scale = 1, style = "default", type = "any", value = 2, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "a2015a4c-a332-4150-a00b-68ebe70aef8c", is_global = true, name = "鼠标y速度", order = 90, position = { x = 704, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "a27f3ca2-bd4a-47b8-a161-87a39d14f03a", is_global = true, name = "盘子加速速度", order = 51, position = { x = 628, y = 20 }, scale = 1, style = "default", type = "private", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "a4be6507-0f07-4ea1-85e0-7f24ca32a712", is_global = true, name = "在线差异", order = 103, position = { x = 732, y = 356 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "a5318ba4-122b-4ffb-977c-cc82ec6318bb", is_global = true, name = "难度", order = 7, position = { x = 220, y = 247 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "95aa8ac8-def0-4f3e-9a85-4f6ac3719f4c", cv_id = "", entity_name = "雪", id = "a55912d4-c043-4ff3-9840-2ca7e0e0e184", is_global = false, name = "左or中or右？", order = 77, position = { x = 603, y = 221 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "a5d5ee23-9522-4cb9-a849-6421bd7a01e2", is_global = true, name = "歌曲昵称", order = 44, position = { x = 713, y = 423 }, scale = 1, style = "default", type = "list", value = { "Reol - No title (Cut Ver.)", "柊マグネタイト - 雑魚(feat. 亞北ネル)", "ピノキオピー - T氏の話を信じるな", "DECO*27 - テレパシ", "雨良 Amala - ダイダイダイダイダイキライ", "DECO*27 - モニタリング (Best Friend Remix)", "ピノキオピー - 愛属性", "cosMo@暴走P - 初音ミクの消失", "EmoCosine - MAGENTA POTION", "ピノキオピー - 転生林檎", "cosMo@暴走P - ダイジョブですか？", "DECO*27 - マシュマロ", "DECO*27 - カイコ", "Atena - DREAMMODE", "DECO*27 - Aimai Elegy (Reloaded)", "Kry.exe / nm-y - Retribution", "姜米條 - 重生", "d0tc0mmie - I Can't Wait", "Galaxy - Under The Tower", "无律 - Grey World", "ZAR-Voxseed - Light & Shadow", "DECO*27 - 爱言叶V", "雨良 Amala - ダダダダダル", "NIJUUGO*A - Voices In My Head", "ピノキオピー - 歌姬失格", "STEAKA - ぐちゃぐちゃぬるぽ" }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "a61379ab-9e9f-4e5b-a0c1-fbf8975fef61", is_global = true, name = "bpm", order = 114, position = { x = 766, y = 20 }, scale = 1, style = "default", type = "list", value = { 200, 135, 143, 205, 130, 132, 146, 240, 150, 145, 127, 100, 152, 134, 105, 190, 195, 127, 95, 150, 100, 139, 124, 190, 147, 144 }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "a6902c01-7506-4fba-9d72-6c505ce77a61", is_global = true, name = "报应异象", order = 93, position = { x = 704, y = 221 }, scale = 1, style = "default", type = "private", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "a7ed459f-07be-4a1b-89ae-76522c2a6759", is_global = true, name = "PP", order = 22, position = { x = 577, y = 420 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "a8005045-a1e7-48b8-8eda-07b7fab54ad3", is_global = true, name = "鸣谢内容", order = 81, position = { x = 603, y = 490 }, scale = 1, style = "default", type = "list", value = { "$感谢每一个为now提供功能或帮助的人", "排名不分先后", "如果你想退出，请点击背景", "", "少年楷", "未来世界302", "imaginary number", "方圆圆", "旁观者JErS", "宜刻乐", "尖端放火", "小澄ABCD", "Deepseek", "FishishOuO", "蒟蒻Oler", "", "$now" }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "ab2d62af-3efc-4829-9b65-9798ef93bc35", is_global = true, name = "歌词", order = 34, position = { x = 780, y = 87 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "ad9ad2e0-bf30-48fd-9a36-cc64092abce3", is_global = true, name = "bpm", order = 21, position = { x = 577, y = 340 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "b3145a6b-660c-4ab0-8a52-6075eb193af2", is_global = true, name = "Octopus AI", order = 62, position = { x = 580, y = 461 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "b8ef25ae-109f-42d5-80fd-14a73270ba6e", is_global = true, name = "在线统计", order = 98, position = { x = 732, y = 20 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "ba610640-3c96-4773-9c54-caf7e1847d47", is_global = true, name = "歌词显示", order = 41, position = { x = 713, y = 221 }, scale = 1, style = "default", type = "any", value = 1, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "bf37302d-a9a9-415c-9137-7f0297ecc100", is_global = true, name = "PP倍率", order = 24, position = { x = 701, y = 180 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "bae5e67c-2737-4f16-b263-cd2c7fe72436", cv_id = "", entity_name = "circle", id = "c06ec284-e9a2-4623-8583-77ec252a830d", is_global = false, name = "没了", order = 71, position = { x = 675, y = 368 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "f05fb825-9496-4164-b7e2-7b7511774512", cv_id = "", entity_name = "鸣谢打印", id = "c43f0a60-ac94-4431-8b8f-287e139391b5", is_global = false, name = "鸣谢i", order = 82, position = { x = 654, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "c98714d1-a642-42d7-b108-e0d763d1415e", is_global = true, name = "No Fail", order = 27, position = { x = 556, y = 474 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "c9d0fc4b-f607-4b77-829d-41361fbcabe9", is_global = true, name = "Relax", order = 14, position = { x = 420, y = 260 }, scale = 1, style = "default", type = "any", value = 1, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "cbf08b77-0b7f-43cb-81c0-6d68e8695793", is_global = true, name = "不显示接住动画", order = 74, position = { x = 656, y = 20 }, scale = 1, style = "default", type = "private", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "cde26d07-94a9-4006-b9f6-7a2dd17edb44", is_global = true, name = "歌词", order = 36, position = { x = 780, y = 221 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "ce0cbfad-4568-4497-83a8-e423c872cdb1", is_global = true, name = "Eazy", order = 29, position = { x = 701, y = 154 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "ce76233f-335c-462d-82a3-4b17fd07a2e3", is_global = true, name = "支持者时间", order = 49, position = { x = 580, y = 260 }, scale = 1, style = "default", type = "private", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "d202368b-a5de-405e-9702-fec08ac22b34", is_global = true, name = "over", order = 3, position = { x = 20, y = 420 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "d60f5cc4-3fe1-4a2f-b9d6-04602006c007", is_global = true, name = "曾经加载过歌词", order = 119, position = { x = 656, y = 356 }, scale = 1, style = "default", type = "private", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "d89543ac-8dc2-4b43-b979-94b2f25084a4", is_global = true, name = "首页奖励", order = 70, position = { x = 675, y = 301 }, scale = 1, style = "default", type = "private", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "d8d07b25-ec97-4e40-adee-a2ffc386549f", is_global = true, name = "来过主页", order = 108, position = { x = 694, y = 154 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "dd5934c5-10d3-4807-9205-cd6fcfb5d8e4", is_global = true, name = "总combo", order = 19, position = { x = 577, y = 180 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "de704f61-3833-409d-8de2-f9a3852a822b", is_global = true, name = "time", order = 5, position = { x = 220, y = 100 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "bc6dac92-9220-4e38-8fbc-1ccd0cd99da3", cv_id = "", entity_name = "circle粒子", id = "e4184d1d-c4f8-4320-bbc6-602a4808e474", is_global = false, name = "m", order = 6, position = { x = 220, y = 180 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "95aa8ac8-def0-4f3e-9a85-4f6ac3719f4c", cv_id = "", entity_name = "雪", id = "e5b0fecb-2763-4742-946e-c2a0fecbec9f", is_global = false, name = "时间1", order = 76, position = { x = 603, y = 154 }, scale = 1, style = "default", type = "list", value = { 0 }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "e63f579e-11c5-4d78-a976-e9c0e37912bc", is_global = true, name = "总PP", order = 25, position = { x = 701, y = 260 }, scale = 1, style = "default", type = "private", value = 0, visible = false }, { current_entity_id = "95aa8ac8-def0-4f3e-9a85-4f6ac3719f4c", cv_id = "", entity_name = "雪", id = "e7736fb0-19dd-4f1d-87ac-5f9b736fa727", is_global = false, name = "点or顿，大or小？", order = 75, position = { x = 603, y = 87 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "e784dfc1-2cc4-4bfe-874d-f19dced31dc4", is_global = true, name = "克隆体列表", order = 60, position = { x = 694, y = 247 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "e8646259-c570-469d-a18b-0d625fee88c0", is_global = true, name = "谱面已生成数量", order = 56, position = { x = 628, y = 356 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "e9353244-50bb-4a60-bce5-583c58f245f2", is_global = true, name = "克隆体编号", order = 66, position = { x = 540, y = 381 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "ecd8d09a-b4c1-4df6-8258-320957f8e280", is_global = true, name = "谱面", order = 55, position = { x = 628, y = 288 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "efbd5674-1882-4100-8bdf-0da4fd837f2a", is_global = true, name = "Logo主题", order = 121, position = { x = 656, y = 490 }, scale = 1, style = "default", type = "any", value = 3, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "f50e3c35-16b8-4143-8d93-70bf79d3ebfa", is_global = true, name = "宜刻乐模式", order = 47, position = { x = 652, y = 100 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "f8aa9107-105b-4298-b1d2-4d4880b9d169", is_global = true, name = "页", order = 105, position = { x = 732, y = 490 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "fb1eed48-70de-47aa-bb36-89104591cbaf", is_global = true, name = "游戏节拍器", order = 72, position = { x = 675, y = 436 }, scale = 1, style = "default", type = "private", value = 0, visible = false } }
M.screens = { { id = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a", name = "背景", screenName = "游戏", style_index = 1, styles = { "d7a1f0a5-0cee-40da-b54b-9cfced716e6b", "577d802b-9fb9-4211-ba96-e4563a422499", "4a0e8f7e-5717-4c07-b500-d4fa46886888", "0a258df1-2fa8-40ef-bd92-3b92541880ca", "217f05d1-d466-4195-9033-d81d345029fa", "c72977aa-723a-422a-b048-474d5e2a1300", "7aa4f597-7728-4ecc-af94-60641a438c9a", "642c91d2-7ed4-46ef-a05c-82cd864b2efc", "c78242a9-7842-42ea-8839-749672b00e23", "44f989a7-fbf2-41d0-a2eb-9406d61c0488", "9f66924f-f5ec-411f-9b5d-1e554a5db438", "2ede425c-27cd-42eb-bed3-fcc819789f2c", "a5f335cb-90bd-441d-a6cb-9e575d591dae", "24d8f33b-34c1-4412-a945-35c90e8af70f", "9512c24d-5034-4d27-a98e-4991a2be27ba", "024b9649-a89b-40dd-bda7-004b8b4608de", "2d543fa9-dfb4-46f9-8152-f50d174e7ba8", "01b0f1a4-08d8-4691-9378-79b31d8b5f32", "bb362228-7ff0-4129-b0ff-892d9d2ce0f2", "7148d591-70f8-47ad-91aa-3e541ae5cccb", "e2bb1c9a-4166-4f45-90bd-4a362833b37e", "052bb922-d548-47e7-b2db-b15444cbd66f", "feb5bab1-f55d-476f-bef9-67128063a9ab", "c7ee9f85-110f-476c-a222-1b6cac2a47ec", "a1647f02-34d2-41de-bee6-918a8ea3f005", "367ff127-dafc-4f30-b4cf-8d9393a1ec0d" }, visible = true }, { id = "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f", name = "背景", screenName = "开始", style_index = 1, styles = { "25d5f2b0-eb8c-45e8-88c6-507816d35a08", "13682e8d-36a7-4007-81c4-6dfd1d2024b8", "91e20e1b-be58-491c-97f4-6adb57e213bc", "5d2c0662-a57c-4ce1-81fa-daca7ee0a5de", "8d6a59ab-e8c0-4543-9d5c-3549a4a2a206", "e791f6b8-4030-492b-93ec-3c39dd7cae9d", "72b937e8-8baa-45b9-8dbc-7e26317f7aaf", "36aa6a75-b049-4a9d-8014-3661ff15433d", "b6ec3861-85e8-446a-9326-ca4d476e3066", "ee2187e7-cdab-435b-a2a0-3a67f72a3261", "2fbccc5b-c214-42a3-92d0-9026be6e119e", "0a8b3d97-f145-4efb-9bf4-092d67b003d0", "eb89a1bb-ea1f-48f8-944c-2a9bf0f1a1a3", "b25ce7bc-9127-411e-87c0-94c1a7043c99", "d5dbf1d0-b7c7-492c-949b-989a31345f79", "ca2436b1-1074-4336-b5e8-70cabf68d591", "0890d8db-d20d-4654-a557-df5b7ed15272", "89fbb360-2ae8-41dc-9e19-e910a90e0ea0", "e18a0ae0-5c35-425a-962f-b7e87c29308f", "d980b93e-8b83-4f00-842c-c67b027eed55", "fd59d0be-6915-4cea-b210-745edd032427", "f9d75150-c17e-4270-af86-a5901ab13b2e", "3e8dc32f-a01c-4a7b-a49a-cd28918e1fdd", "c39e18ac-93d5-4ddd-8085-b60958e88306", "c8054aa4-d63f-47fe-a438-e6dbc3b9b65a", "ba500e67-a12d-439b-bf90-3dc135fa4cd0" }, visible = false }, { id = "9d583a2a-486d-4997-abd6-3e3a058288e1", name = "背景", screenName = "偏移量（Offset）设置向导", style_index = 1, styles = { "71a5eef7-1712-4d96-8674-0cc206f20e86" }, visible = true }, { id = "13c1f24a-0f92-4d49-adf1-93dc4e4816cb", name = "背景", screenName = "开始1", style_index = 1, styles = { "40bd85af-ffe3-4049-88b4-5079b714ccb8" }, visible = true }, { id = "cb8ad9c4-3817-49a8-b7cb-112e9b6e4d51", name = "背景", screenName = "选歌", style_index = 1, styles = { "55d2bda8-7fee-4cf7-9139-9e0377eb6cbf", "2600ecbe-1b17-48c7-bc2e-9a362ccb1187", "00313b5b-0896-44dd-955f-20aeca241ead", "34917556-b7dc-4290-9b6e-2e9014b04bbd", "021e4210-80d6-4c23-85e7-73e54d811674", "85cd5323-b7f7-433c-a69c-e5c4d1a4c3d2", "a1e87e3a-b552-4ece-afbd-f74faf1d249f", "ce860baa-eaef-4f4c-9fdf-3762497de5cb", "181b4067-f499-4f01-aaa0-62ee4c1854a3", "18168fb7-301a-4b4f-bfad-c303b48ddda7", "1e5f5f44-43e7-420e-bbc2-cf0b8ce1fdbb", "ea506487-99a8-40bd-9f1e-084b0b137b8f", "0342eb18-31da-4d5e-ad42-67475dda3212", "382e5874-f421-4d73-acc3-d20d63d3857f", "1183830d-584f-4b03-a948-6cae8525dbf7", "4bbbb9a6-a19a-438e-94ca-c800e1b0ca5f", "aaf1fd55-a58f-4ab8-9072-3dcd3ecbe71d", "b8a83725-c96e-4770-9328-76a60d994c86", "2aecdc6b-06af-49fd-841d-fbdb5c22f3de", "ab52dbc8-7de9-4ce7-ac99-c48b9f580fd8", "e7ecded2-5bd8-4a96-b4cc-bfc72210e88c", "bb08b5d4-17f3-4456-8d62-fffc3190fc91", "6345d07b-b96e-4876-bc28-da8086e81bbb", "cba6799d-981c-46c1-9ab6-f82956001b48", "5d8b7307-98dd-469a-b2d1-252c4a5aec18", "c909df51-7479-40f5-97f0-85a62d3af3db" }, visible = true }, { id = "1c387224-c473-489b-aaad-782662b8860e", name = "背景", screenName = "结算", style_index = 1, styles = { "97605d6c-0902-4e83-adb9-d9a733ab0465", "86523ec6-7126-409a-888f-3edee01dfae6", "f0e90b5f-33e6-4370-9942-481a7a566755", "bbb87ffd-caf9-4ff8-82f9-a6421b236ca5", "20862ce4-ee29-4b96-9da4-223f3e785493", "cda6a9bd-7f48-47cf-8827-e1f533ed3fe3", "88f601a2-53aa-44e2-9037-8b211da25224", "83df6964-0c5e-4bb9-96ac-f962334772e2", "91448eca-2c59-4faf-9c58-27d4cbaa5be1", "ff38150f-6d6b-43be-a92a-d66de6057c4a", "1d327a90-59ff-47af-83af-1163023027e6", "69c5c7fa-5343-47df-a461-386854a5f081", "4b8848e0-0c9d-4216-a7f2-ae8a98e8c2b2", "8e774f91-4595-4be3-82bd-9d529624bc3a", "b1c5516d-2ac3-451b-9ee8-f1aa81a53cc0", "f8262995-b77d-43a1-88a0-0cc68a6faa5a", "c3efc622-4180-4ba1-b634-b5096b721d83", "f72377f2-a798-42fc-b1ef-8859ab861d04", "f348307d-af33-4984-82d8-d1b8a06d3b67", "f0be2031-c375-4ac4-ab3d-7b4fe5561583", "e7f07667-1e04-44e9-8ce2-792bfd3a1812", "77c152ec-bf4f-444d-b1fc-2f937f9d2e3e", "2b04721d-e494-4e06-84ce-5de0dd5f8701", "147e7c12-94e3-4227-ade5-7def25f1e083", "b7f1480a-f9d8-44ee-a7d0-4fd9ad505e08", "39edfaeb-0769-4cd9-b939-a7d4878b96bb" }, visible = true }, { id = "a24ee163-9852-4208-850f-bd87d3aea79f", name = "背景", screenName = "支持者", style_index = 1, styles = { "8677f17a-c57c-47b7-9d42-d9555e2c49ba" }, visible = true }, { id = "75ae2a24-41fe-4d2b-9907-1af40e55aec3", name = "背景", screenName = "鸣谢", style_index = 1, styles = { "e89e6f1a-f278-48ed-bc5b-2b674b8bb8bb" }, visible = true }, { id = "080ff01f-de3f-47b9-97ac-af9a656ec4f2", name = "背景", screenName = "在线列表", style_index = 1, styles = { "0cde78b4-ae7b-43b3-9070-b75ecbfd60b0" }, visible = true } }
M.cur_scene = "13c1f24a-0f92-4d49-adf1-93dc4e4816cb"
M.actors = { { id = "b9d12dc0-4a4d-4a5c-8326-01cea04b9759", is_global = false, name = "轨道", order = 4, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "c994398d-1253-41c7-b760-ca9ef4db2f70" }, visible = true, x = 0, y = -175 }, { id = "bae5e67c-2737-4f16-b263-cd2c7fe72436", is_global = false, name = "circle", order = 6, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "fac8e6c6-b927-4a08-8c01-1d1ec7bc8a85", "8ec28a0a-5402-4814-8506-ff184edf105c" }, visible = true, x = 400, y = 500 }, { id = "58eadc2b-0e03-4346-bf4f-ba964fa14080", is_global = false, name = "combo", order = 8, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "d1448c60-a1cf-4a64-a004-1db4d39dfa5d" }, visible = true, x = 0, y = 50 }, { id = "3455f327-6d7e-4d65-ba42-c86119348064", is_global = false, name = "maxcombo", order = 9, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "83cdd33f-1bb8-4955-a34c-d4e91eb8d4c0" }, visible = false, x = 0, y = 0 }, { id = "02812331-bdb9-4137-8da6-c404e96a6d44", is_global = false, name = "判定盘子", order = 7, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "0847ce7f-d4f3-44e7-97f4-01a035f27096", "f4045fe6-7447-4944-9d8d-53fa485fc125" }, visible = true, x = 0, y = -175 }, { id = "bc6dac92-9220-4e38-8fbc-1ccd0cd99da3", is_global = false, name = "circle粒子", order = 5, rotation = 0, scale_x = 0.3, scale_y = 0.3, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "7887e5c7-b82d-4015-8d18-0642ed13fe0e" }, visible = true, x = 0, y = 500 }, { id = "732e3434-f07d-43e1-993b-e50b96038c21", is_global = false, name = "now", order = 12, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 3, styles = { "97580ddf-38a5-40bb-9f6b-3d8adf9a7f89", "07dd6ded-e48e-4b8f-b246-b56194bb2733", "50067d4c-1718-4e94-9283-f20cf3c7562a" }, visible = true, x = 0, y = 0 }, { id = "323d1935-4d82-4c9a-87f2-3d47e8592d30", is_global = false, name = "星", order = 9, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 1, styles = { "275a7b31-e8e7-4921-a974-4f343c296e6b" }, visible = true, x = 0, y = -180 }, { id = "c1af39b1-f7d2-4a95-bc40-37cd94c16816", is_global = false, name = "开始", order = 5, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 2, styles = { "62c284d7-2759-4c2c-9027-d91aed7d50f5", "e5e29f3e-24cb-450f-8095-f3b05048f1c9" }, visible = false, x = 50, y = 0 }, { id = "811ce580-0510-4d39-88a4-bc3729f497f3", is_global = false, name = "acc", order = 12, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "cac35bfd-cf61-44ca-8402-8033266e6c04" }, visible = true, x = -300, y = 145 }, { id = "bcc769e8-a805-43fa-a3a6-e87bdcb502b6", is_global = false, name = "总分", order = 11, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "80a76146-d246-40c1-91e4-166097699ce0" }, visible = true, x = -300, y = 210 }, { id = "0c8dc1eb-36a6-4968-a6f0-02b0574215f9", is_global = false, name = "mod设定", order = 6, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 2, styles = { "ad2a9575-bc6e-45b9-920a-125d97b3a8b1", "e3ac7574-449e-4736-8fe9-0776ead09fcb" }, visible = false, x = 200, y = 0 }, { id = "0d213613-8c5d-4529-8456-dcb60efaefd9", is_global = false, name = "PP计算", order = 13, rotation = 1.5707963267949, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "882a5555-9167-4bca-8e81-04d8fe3a1390" }, visible = true, x = -170, y = 180 }, { id = "0c9ea944-856c-449e-af72-76d509d360bd", is_global = false, name = "总PP", order = 16, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 1, styles = { "e4614770-d81a-4ff3-b895-c71a460951cd" }, visible = true, x = 0, y = -225 }, { id = "e1f00058-a341-4755-ad37-63e9d70b4610", is_global = false, name = "设置", order = 4, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 3, styles = { "c8d29569-1027-4e12-af27-cfc774794f54", "ba8d24e9-cd47-468b-bb66-4ce6f306f751", "244d4074-26df-46ac-9462-20bb03b3fc95" }, visible = false, x = -250, y = 0 }, { id = "be7204ca-fa8d-4181-b56b-6583b19290a5", is_global = false, name = "HP", order = 14, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "85b248af-465a-45d0-b0b7-76936c71d1d9" }, visible = true, x = -450, y = 281 }, { id = "142d7973-7637-4b94-94d3-1d816b2c2df4", is_global = false, name = "HPF", order = 15, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "c00a15ef-003b-4151-8db9-01ebccbc0dcc" }, visible = true, x = 415, y = 250 }, { id = "810d5972-9f94-47ac-a461-4df7e286dba4", is_global = false, name = "circle", order = 10, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 1, styles = { "f33c78ab-1d87-4be4-9ffc-b5c26c5b7490" }, visible = true, x = 0, y = 0 }, { id = "388bcb4b-71dc-464d-869d-96a4d70067f8", is_global = false, name = "FPS", order = 2, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 1, styles = { "5c35f914-8be3-4b83-9084-2b490edf626c" }, visible = true, x = 0, y = -265 }, { id = "45c8d7e3-e13f-475b-a885-98a2aff839b7", is_global = false, name = "曲", order = 7, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 2, styles = { "c58f259c-ad37-47ce-8b87-6633ed1a769f", "6d92c9f0-2bd5-46a7-9ca0-7d48d0d1c74d" }, visible = false, x = 350, y = 0 }, { id = "ccd1fd87-8c2f-4e17-aedb-d3a96ae128f3", is_global = false, name = "HP特效", order = 2, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 2, styles = { "2fa79260-bfc4-4258-9748-b018a0f1c217", "4af4ec14-17f7-4877-a93f-dcb626abf45c" }, visible = false, x = -8.3628275915639e-14, y = 8.3628275915639e-14 }, { id = "79fcfeea-02a9-4cc3-87e7-b0e3a163b524", is_global = false, name = "轨道", order = 3, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "9d583a2a-486d-4997-abd6-3e3a058288e1" }, style_index = 1, styles = { "5add3f28-d41e-4b72-a763-bb29ddb847bc" }, visible = true, x = 0, y = -175 }, { id = "8f49f29a-5834-4630-96a3-464ffc5896c9", is_global = false, name = "判定盘子", order = 4, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "9d583a2a-486d-4997-abd6-3e3a058288e1" }, style_index = 1, styles = { "2aa74e86-ca1f-47be-baaa-b5388c373da1" }, visible = true, x = 0, y = -175 }, { id = "86f003a3-78f9-47ed-9ce0-0552f08c6d53", is_global = false, name = "Offset", order = 5, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "9d583a2a-486d-4997-abd6-3e3a058288e1" }, style_index = 1, styles = { "3dfbaaed-08e9-4c81-bc87-ffe7a1c4e4d2" }, visible = true, x = 0, y = 500 }, { id = "79a5d117-4e2c-4bfc-933c-602fd8cdebc0", is_global = false, name = "tips", order = 2, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "9d583a2a-486d-4997-abd6-3e3a058288e1" }, style_index = 1, styles = { "0c8f105a-c88d-447b-a389-2d3061f9e747" }, visible = true, x = 0, y = -225 }, { id = "4150aa3e-61c0-4f08-8ae3-aee9b6e56c3c", is_global = false, name = "FPS-非初始", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "9d583a2a-486d-4997-abd6-3e3a058288e1" }, style_index = 1, styles = { "624461ee-2267-4bac-81c6-79ad44820fa8" }, visible = true, x = 0, y = -265 }, { id = "c73c5c69-2217-4d2b-a3b8-87c9aa01109c", is_global = false, name = "特效", order = 11, rotation = 0, scale_x = 1.75, scale_y = 1.75, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 1, styles = { "74724772-7de1-43e2-8fff-e662f6b42c93" }, visible = true, x = 0, y = 0 }, { id = "cb9067dc-cf1d-4561-89e6-0c7e3b2d4ff8", is_global = false, name = "歌词", order = 16, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "11524a84-f54e-400f-aca9-273831a2d811" }, visible = true, x = 0, y = -220 }, { id = "77abc2fe-1f5f-4261-9df3-99c7e0094c20", is_global = false, name = "静音", order = 18, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 1, styles = { "99a0082e-2c02-48ff-b5ca-e954c000461e", "c4ce6fce-cc12-40da-84c6-cc4b92037561" }, visible = true, x = 500, y = 225 }, { id = "5a49795d-a089-4076-afc5-2f5762aca3d3", is_global = false, name = "曲目", order = 4, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "cb8ad9c4-3817-49a8-b7cb-112e9b6e4d51" }, style_index = 1, styles = { "d6431dfb-856e-4c1d-a7b7-079185b05f05" }, visible = false, x = -200, y = 0 }, { id = "72263c92-6082-4280-b989-275482ef48b4", is_global = false, name = "曲目打印", order = 5, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "cb8ad9c4-3817-49a8-b7cb-112e9b6e4d51" }, style_index = 1, styles = { "6c672677-bc9c-424c-93ff-0bddff7d57f7" }, visible = true, x = -200, y = 0 }, { id = "290c4c73-11b5-4ed6-bbe3-7c68ecf7fcf4", is_global = false, name = "难度", order = 6, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "cb8ad9c4-3817-49a8-b7cb-112e9b6e4d51" }, style_index = 1, styles = { "7cf3b4c3-0ee6-4a77-b424-892c6d870a9a" }, visible = false, x = 200, y = 0 }, { id = "88f3d867-1412-4f85-8b46-19323d086974", is_global = false, name = "难度打印", order = 7, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "cb8ad9c4-3817-49a8-b7cb-112e9b6e4d51" }, style_index = 1, styles = { "c82c953f-4816-48b0-9d54-80b56a5dc22f" }, visible = true, x = 200, y = 0 }, { id = "fa1d14b9-7fe6-4771-af59-7b1cf21febfc", is_global = false, name = "分", order = 2, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "1c387224-c473-489b-aaad-782662b8860e" }, style_index = 1, styles = { "c0d4515b-e962-48cf-b7e1-a71fd38e51e1" }, visible = true, x = -250, y = 0 }, { id = "81d5d728-b9fd-4272-8b58-0aa1ce7e2271", is_global = false, name = "分2", order = 3, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "1c387224-c473-489b-aaad-782662b8860e" }, style_index = 1, styles = { "7f1f7ebb-5ff4-418d-85ab-1441dfc61232" }, visible = true, x = 250, y = 0 }, { id = "6107cddf-e22c-4045-b5eb-209a7e896a17", is_global = false, name = "评级底", order = 4, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "1c387224-c473-489b-aaad-782662b8860e" }, style_index = 1, styles = { "5f4b3b36-0a77-41cf-b201-35e2a8ce8fd3" }, visible = true, x = -300, y = 0 }, { id = "90f07778-a861-4dd1-90f0-a4c364c78d55", is_global = false, name = "评级", order = 5, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "1c387224-c473-489b-aaad-782662b8860e" }, style_index = 1, styles = { "b7a798d7-abfb-4cdb-9b89-1d1fed555119" }, visible = true, x = -300, y = 0 }, { id = "0c86e074-e893-43b3-a3d7-99060cf7aa7f", is_global = false, name = "打击、小姐、难度", order = 8, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "1c387224-c473-489b-aaad-782662b8860e" }, style_index = 1, styles = { "36200a8f-b646-4807-b7d2-c52568e76f67" }, visible = true, x = 200, y = -100 }, { id = "3001a293-b662-4514-bb57-d8b2c0d86e5f", is_global = false, name = "评分", order = 7, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "1c387224-c473-489b-aaad-782662b8860e" }, style_index = 1, styles = { "41ea06d1-2de4-48e2-b7ae-a2fa52db9218" }, visible = true, x = 200, y = 160 }, { id = "81856d00-5a71-430b-9465-728835fa193a", is_global = false, name = "连击系列", order = 9, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "1c387224-c473-489b-aaad-782662b8860e" }, style_index = 1, styles = { "852839ee-2332-46d1-8d85-697156627af3" }, visible = true, x = 200, y = -150 }, { id = "290a49df-8703-4c08-affb-12f4839b6214", is_global = false, name = "总系列", order = 10, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "1c387224-c473-489b-aaad-782662b8860e" }, style_index = 1, styles = { "9203e66a-6193-42a7-880a-965e706fe04d" }, visible = true, x = 200, y = -200 }, { id = "bea6f71b-f5d0-48b0-8b5d-2c7f055d3112", is_global = false, name = "PP", order = 11, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "1c387224-c473-489b-aaad-782662b8860e" }, style_index = 1, styles = { "2ce59e4a-6f4a-4f0f-814c-a79f61e6f766" }, visible = true, x = 200, y = -250 }, { id = "72378a7d-81d6-4757-9859-cf67c0d67067", is_global = false, name = "返回", order = 12, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "1c387224-c473-489b-aaad-782662b8860e" }, style_index = 1, styles = { "d46f9443-0976-4fff-9339-0ba0635c3a25" }, visible = true, x = 375, y = 0 }, { id = "b92ed11d-9f0d-48ac-9c23-834a35b07635", is_global = false, name = "Acc", order = 6, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "1c387224-c473-489b-aaad-782662b8860e" }, style_index = 1, styles = { "9ac44982-7d8f-444c-8aef-7c40ed478a7a" }, visible = true, x = -300, y = -60 }, { id = "20d5357d-f7e4-40e5-adbf-d7425fc4575c", is_global = false, name = "宜刻乐", order = 17, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 1, styles = { "6ea9c6b2-daa3-434a-9b2e-0f4c0751650d" }, visible = true, x = 0, y = -500 }, { id = "482cd58c-e986-4290-b775-5be3824501a7", is_global = false, name = "now", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "a24ee163-9852-4208-850f-bd87d3aea79f" }, style_index = 3, styles = { "a8a269f4-4350-456f-b81c-0f2ae92d6b41", "ffc6afc9-ad4d-41d8-ae69-a7e3359d2a57", "8719c089-c5ba-4ebb-aca9-b0e6e90e3ed2" }, visible = true, x = -250, y = 0 }, { id = "153df064-77d9-4a72-a32e-97122908ccbb", is_global = false, name = "1", order = 2, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "a24ee163-9852-4208-850f-bd87d3aea79f" }, style_index = 1, styles = { "7f5f9233-2e0e-4933-baa2-2bb28ab0f3e1" }, visible = true, x = 165, y = 100 }, { id = "859004d2-17ce-4480-a27e-d41f87103a80", is_global = false, name = "2", order = 3, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "a24ee163-9852-4208-850f-bd87d3aea79f" }, style_index = 1, styles = { "8d8513fb-5031-45f2-8e5f-69f11e11507f" }, visible = true, x = 75, y = 0 }, { id = "cf5996d0-ce13-4fd6-a697-20330cfe8c70", is_global = false, name = "buy", order = 4, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "a24ee163-9852-4208-850f-bd87d3aea79f" }, style_index = 1, styles = { "932dae01-e670-4d1a-af00-4e092d23e582" }, visible = true, x = 20, y = -100 }, { id = "d7f3224d-cb3f-446f-8e27-ff4e89b7e3f3", is_global = false, name = "osucircle", order = 8, rotation = 0, scale_x = 0.63, scale_y = 0.63, scenes = { "cb8ad9c4-3817-49a8-b7cb-112e9b6e4d51" }, style_index = 1, styles = { "6ab4bff5-7b2e-4078-aadc-90d8088e2057" }, visible = true, x = -435, y = -275 }, { id = "5f2d3188-f919-4139-9a87-0a2e52f7d66e", is_global = false, name = "遮罩", order = 2, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "cb8ad9c4-3817-49a8-b7cb-112e9b6e4d51" }, style_index = 1, styles = { "2c7077b1-a9ad-4a72-a878-295453d9e975" }, visible = true, x = 0, y = 0 }, { id = "ea4e3fef-3091-4773-8025-d207b9310113", is_global = false, name = "遮罩", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 1, styles = { "320ce8e9-18ba-4979-81d8-8cca4b4eaa1e" }, visible = true, x = 0, y = 0 }, { id = "4e9b6cd2-ef52-49b4-89ff-e228449d18eb", is_global = false, name = "遮罩", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "43bb81b3-9c64-4e30-b427-4797e564c559" }, visible = true, x = 0, y = 0 }, { id = "7462b472-977c-4ca8-98be-5f97dffbd11a", is_global = false, name = "遮罩", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "1c387224-c473-489b-aaad-782662b8860e" }, style_index = 1, styles = { "a74b5276-ad9b-42d9-b222-d64285b20d87" }, visible = true, x = 0, y = 0 }, { id = "56dd2bee-76bc-4f64-a53d-3967177cb6c4", is_global = false, name = "提示", order = 9, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "cb8ad9c4-3817-49a8-b7cb-112e9b6e4d51" }, style_index = 1, styles = { "197a64e9-069c-4bed-9eb5-48ac230f6d58" }, visible = true, x = 0, y = -200 }, { id = "59c0adac-290c-4360-b0bd-c8a5459f70c4", is_global = false, name = "横幅通知", order = 17, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "37da56e5-a513-49b8-8f4e-57a4ec250235" }, visible = true, x = 0, y = 0 }, { id = "3fa2d77f-f8e2-4918-aaa5-a9272494dcc6", is_global = false, name = "横幅文字", order = 18, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "66468923-b730-48d0-b112-f50921bb0c37" }, visible = false, x = 0, y = 0 }, { id = "946ace71-fa8a-4c30-b470-ccfe7c2a6551", is_global = false, name = "星星喷泉左", order = 19, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 2, styles = { "2f5de028-0999-418a-9b65-a4df37b97e0a", "36be7763-cbb3-4e02-9586-50af92e74991", "0c2524e6-d9b0-45aa-99cb-5f317c40ce53" }, visible = false, x = -250, y = 0 }, { id = "54785748-f51a-456f-9225-e6cbf11b955d", is_global = false, name = "星星喷泉右", order = 20, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 2, styles = { "47e68607-4841-4527-8815-849a379bbf57", "2c95d00e-d370-4d8e-bd30-a704657f5cfa", "6b1bbce9-1fea-4bb0-bc06-240b372164e7" }, visible = false, x = 250, y = 0 }, { id = "f5d13c9f-b53c-4f5b-9d29-c9488bf94b0a", is_global = false, name = "矩形", order = 3, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 2, styles = { "a235566d-a70b-42ec-aac5-b320391aae9b", "ec7aeaca-87a5-4ded-b749-09a604bf1d66" }, visible = false, x = 0, y = 0 }, { id = "13c821e9-2d8e-4434-9937-56c54b21ecf7", is_global = false, name = "monitoring", order = 15, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 2, styles = { "28de83f6-768d-4604-912d-64e27ba22e9c", "60b38e87-2143-4180-a5e0-7583f6b51967" }, visible = false, x = -500, y = -225 }, { id = "6263c102-e379-498d-b9c5-2038b8450c59", is_global = false, name = "提示", order = 21, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "22017908-625f-4579-9bd0-ee6459918a1b" }, visible = true, x = 0, y = -225 }, { id = "ba96713e-7238-4f0e-afc0-4f43a0a4c9b6", is_global = false, name = "支持者背景", order = 19, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 4, styles = { "09e004f4-d4af-47a1-99b6-d81f7151e619", "0554a7fb-795f-47b3-9cdb-e5a99d1085f1", "842c948d-37fb-47cd-aaec-828b00d19266", "eecc5988-ed47-441b-a113-5050748544b0" }, visible = false, x = -425, y = 225 }, { id = "8e7b1e19-f6ae-4f28-836a-19067dccf67e", is_global = false, name = "心", order = 20, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 1, styles = { "f936de01-4ad4-4357-a87b-3db6120f4eb6" }, visible = true, x = -425, y = 225 }, { id = "f514c5ad-4529-4447-9405-6c953cb44137", is_global = false, name = "支持者内容", order = 21, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 1, styles = { "13c07da1-23c9-4462-9119-b6be17a01b38" }, visible = false, x = -215, y = 225 }, { id = "1729f8cf-df6e-4420-8217-7881b696e340", is_global = false, name = "锁定", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "cb8ad9c4-3817-49a8-b7cb-112e9b6e4d51" }, style_index = 1, styles = { "4640abe2-ecfd-4ad8-9ab7-d0f8831c8dbf" }, visible = false, x = 0, y = 0 }, { id = "0d3cb358-caba-4bd9-9ec7-77ba6d5d91c7", is_global = false, name = "广告", order = 28, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 16, styles = { "d6c5734d-d73d-4f5e-8e0c-7dec80890e18", "920e1447-9465-4696-85ad-b102d4506535", "136391d4-e4bd-492c-bfbd-60a6f5c4590c", "894f2cf0-22da-4867-b202-542006575764", "e8cb357b-4cf4-4db7-bd2a-6f0a0db20852", "b2cc3d5d-e17e-43ed-89c8-ddb27953a384", "fafbfc03-d051-41d4-b504-3f4289b51a19", "5b108421-03dd-46db-b426-4d4552083d70", "18deacc0-cc12-4064-ae9c-5641c682f91d", "c19a023a-f966-4f49-8cb7-a7ec836168a7", "78a4cb0d-cfbd-4d45-b7f9-ab73b887c64b", "fe4f3ad5-504c-48de-94d4-a11f6d4b7242", "c2413218-a94e-4dc7-aed4-5644d902d292", "c0db503c-2321-4623-9eb9-ed724acc033c", "f94c95e5-aa15-4c50-9585-7dee88bccfef", "815fab65-8f15-485d-b630-033fa15f7d80" }, visible = false, x = 0, y = 0 }, { id = "021f6559-beec-4abc-8013-8a0b6b6125ee", is_global = false, name = "Adobe", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "13c1f24a-0f92-4d49-adf1-93dc4e4816cb" }, style_index = 3, styles = { "a7a215e7-e1e2-4c45-829a-1162d1354e84", "5dfbeff5-2092-49f0-8dcc-4edeb7a11f35", "1c5ec5a1-6273-4282-89fd-0e61858e6e78" }, visible = true, x = 0, y = 0 }, { id = "14d734a5-daa3-4a14-8ccf-5a01dd522300", is_global = false, name = "logo", order = 2, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "13c1f24a-0f92-4d49-adf1-93dc4e4816cb" }, style_index = 1, styles = { "c3bd36cb-5373-4459-b85a-ba1e205abf22", "df3fb28c-e167-444f-b8d1-dc28536f5017", "07996e2d-df03-4759-81e9-040ab57d838c" }, visible = false, x = 117, y = 2 }, { id = "dfa1f38a-ea1d-4c3d-b109-48029c256268", is_global = false, name = "选中指示", order = 3, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "cb8ad9c4-3817-49a8-b7cb-112e9b6e4d51" }, style_index = 1, styles = { "3c66b745-1914-491e-bd35-447c3517da6b" }, visible = true, x = 0, y = 0 }, { id = "914c4d45-c6e4-424b-aff5-ad3a824b6a1b", is_global = false, name = "排行榜", order = 13, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 2, styles = { "9dc7a841-14f8-418a-9f23-75e065684152", "eb54fd6a-b383-4501-9671-c42fee46fb2f" }, visible = false, x = -350, y = 0 }, { id = "95aa8ac8-def0-4f3e-9a85-4f6ac3719f4c", is_global = false, name = "雪", order = 29, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 1, styles = { "0bed02a5-a617-4690-a2ed-b2513e5d7dad" }, visible = true, x = 0, y = 350 }, { id = "27839e28-7a5d-400b-b8ad-1d0f58686fba", is_global = false, name = "退出", order = 22, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "f008b06d-143e-4725-9e2e-ec8630334214" }, visible = false, x = 0, y = 0 }, { id = "f05fb825-9496-4164-b7e2-7b7511774512", is_global = false, name = "鸣谢打印", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "75ae2a24-41fe-4d2b-9907-1af40e55aec3" }, style_index = 1, styles = { "69913435-aa62-45db-ae2c-b90c0d327cd6" }, visible = true, x = 0, y = -350 }, { id = "346d958e-5f8c-4eb4-9b8b-368fa49d5703", is_global = false, name = "涟漪", order = 8, rotation = 0, scale_x = 0.01, scale_y = 0.01, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 1, styles = { "5894663f-e95b-4e9c-983e-d8fe407062e2", "7cec3c63-d0be-46ee-8a8e-2f15b0c73072", "2464dc90-db37-4010-b13f-68b4ef342177", "dfe5a411-2046-4f8a-a890-e8148cb643e7", "9cc4569a-51ac-40bf-8192-d51e9bef3b6b", "a1667b8d-702f-4dbc-bc38-c996c027ef72", "785d3a15-9031-43fa-9169-a60919e48083", "e93a9428-addf-439d-af90-7e10c5000403", "7d76ca87-85d6-4904-a974-1c95f5d24ace" }, visible = false, x = 0, y = 0 }, { id = "4fc1f2cb-2dc5-4e47-a2c8-ab07519da1d1", is_global = false, name = "滑动条底", order = 10, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "cb8ad9c4-3817-49a8-b7cb-112e9b6e4d51" }, style_index = 1, styles = { "4b7d5c12-ad81-46a7-9394-64ac777b6293", "4a80cb4b-70cd-4985-9459-f4f6b72136d1" }, visible = true, x = 500, y = 0 }, { id = "fa225791-3758-4dc6-933f-fb2de01de032", is_global = false, name = "滑动球", order = 11, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "cb8ad9c4-3817-49a8-b7cb-112e9b6e4d51" }, style_index = 1, styles = { "7743572e-8c15-4740-81f4-459c76a83e29", "c4cd5de6-f7a9-451b-a0b4-34bd78f63388" }, visible = true, x = 500, y = 250 }, { id = "d268e9fd-3f9b-423a-8130-0e2281e35eeb", is_global = false, name = "在线人数", order = 22, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 1, styles = { "4b76cc42-7ae1-4abf-aa66-0bae850a6dbb" }, visible = true, x = 0, y = 0 }, { id = "9e324a05-c70d-4b1b-927f-00f2ccccbd36", is_global = false, name = "通知", order = 23, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 1, styles = { "c35723a7-c232-4db1-a591-531f139bbd3f" }, visible = true, x = 600, y = 210 }, { id = "073a1839-8466-4838-80b4-69673d2c6588", is_global = false, name = "文本", order = 24, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 1, styles = { "5ee26315-68cd-43bd-b4c0-a8ab624000f0" }, visible = true, x = 0, y = 0 }, { id = "58825666-11bf-4755-abdf-62505a487764", is_global = false, name = "通知", order = 23, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "fd25e56c-a4a9-4d4d-ae6e-c54f6edb45d1" }, visible = true, x = 600, y = 210 }, { id = "e381eae0-9ac3-4265-bad8-7fa7acef65d8", is_global = false, name = "文本", order = 24, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "edad0177-f2fa-4ea7-a5ee-30e2a12b72fd" }, visible = true, x = 0, y = 0 }, { id = "069da2b2-28a0-4b9d-85c4-347e86276d6d", is_global = false, name = "下一页", order = 1, rotation = -1.5707963267949, scale_x = 0.35, scale_y = 0.35, scenes = { "080ff01f-de3f-47b9-97ac-af9a656ec4f2" }, style_index = 1, styles = { "6aec5b3f-c651-42f7-a952-25932dd016b2" }, visible = false, x = 400, y = 240 }, { id = "2f536974-1483-454f-87f6-5f367d4f7e25", is_global = false, name = "上一页", order = 2, rotation = 1.5707963267949, scale_x = 0.35, scale_y = 0.35, scenes = { "080ff01f-de3f-47b9-97ac-af9a656ec4f2" }, style_index = 1, styles = { "48ad7958-130d-41c8-995b-fa4f112a9cbf" }, visible = false, x = 275, y = 240 }, { id = "e8ba2ded-bafb-4a7e-9da9-5c52099f73d1", is_global = false, name = "在线人数", order = 25, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "28f19514-7c83-4059-8cdb-d3fd0e900100" }, visible = true, x = 0, y = 0 }, { id = "33aeb73d-9c2b-4093-b849-9bae59206156", is_global = false, name = "在线人数", order = 4, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "080ff01f-de3f-47b9-97ac-af9a656ec4f2" }, style_index = 1, styles = { "6351388d-0a98-4ed2-a4e4-acaceba3c2a1" }, visible = true, x = 0, y = 0 }, { id = "625a7787-130a-4062-aba0-c32e6673e740", is_global = false, name = "歌词", order = 25, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 1, styles = { "9501ff15-6e50-4f13-aca1-be2d7b69f2fe" }, visible = true, x = 0, y = -135 }, { id = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506", is_global = false, name = "手指", order = 30, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 1, styles = { "2a925fec-394a-4ecc-934d-d5e34a3dcd68" }, visible = true, x = 0, y = 0 }, { id = "3194ad1f-740d-421d-b3db-cb8a42602a01", is_global = false, name = "一阶编程猫跳跳", order = 3, rotation = 0, scale_x = 0.1, scale_y = 0.1, scenes = { "080ff01f-de3f-47b9-97ac-af9a656ec4f2" }, style_index = 1, styles = { "bb440b68-39c4-4df8-a6e7-d8e265556576", "fb33c6cc-a23e-4374-be61-fe7d3fd0ef62", "0886746a-1d94-453e-bfa1-3dc5dc998024", "d1f3c340-2de4-43f2-b495-c0f7170c7d4b", "463dc548-1d3e-47a5-9fc2-5b5c7c5e09fe" }, visible = false, x = -400, y = 230 }, { id = "0276aae8-9443-4b20-8c09-b5aea970438e", is_global = false, name = "当前歌曲作者显示", order = 26, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 1, styles = { "388f8234-515e-4bc5-b18b-7b8ebc1f0b06" }, visible = true, x = 0, y = 155 }, { id = "ade8a5d0-e108-476b-8b13-5732a69d5682", is_global = false, name = "当前歌曲显示", order = 27, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 1, styles = { "47703908-4bed-4dbe-bbd5-f7ba7bfa9ffd" }, visible = true, x = 0, y = 175 }, { id = "e7d95181-ca3e-4d2c-be28-bc36e6393f1b", is_global = false, name = "hat", order = 14, rotation = 0.26179938779915, scale_x = 0.3, scale_y = 0.3, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 1, styles = { "3a83ec08-d51d-4de0-8793-4f456675cae3" }, visible = false, x = -100, y = 125 }, { id = "07cc3840-fd98-4316-b4d0-2961194a2aaf", is_global = false, name = "手写计时器", order = 31, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, style_index = 1, styles = { "f82d96a6-d429-4f8f-a1d2-3db939e2c239" }, visible = false, x = 0, y = 0 }, { id = "3069d4bb-2bbd-4d44-906f-63279a0325b2", is_global = false, name = "FPS", order = 3, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "a5cbd064-d8e0-4a4e-b974-a2c7419f6cf4" }, visible = true, x = 0, y = -265 }, { id = "5059b4be-4906-4e3c-b5a7-86b4746f7ec3", is_global = false, name = "手写计时器", order = 26, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "e9090dec-ece5-48c0-a618-a78f9b3504a4" }, visible = false, x = 0, y = 0 }, { id = "5e558578-132d-45c0-a48d-46d15a672e3e", is_global = false, name = "FPS", order = 6, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "9d583a2a-486d-4997-abd6-3e3a058288e1" }, style_index = 1, styles = { "2922bf6e-f851-41b8-837b-09c57a18ac4a" }, visible = true, x = 0, y = -265 }, { id = "bd2e6ffa-b23c-451b-afb9-a5d472067bee", is_global = false, name = "手写计时器", order = 7, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "9d583a2a-486d-4997-abd6-3e3a058288e1" }, style_index = 1, styles = { "fee55a1e-8cc1-4447-bfd7-805152f9d59e" }, visible = false, x = 0, y = 0 }, { id = "e2d6e418-cb83-4db6-97ab-49a9fd505b3d", is_global = false, name = "FPS", order = 2, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "75ae2a24-41fe-4d2b-9907-1af40e55aec3" }, style_index = 1, styles = { "243de300-4d17-42d5-967e-faed4e192f5b" }, visible = true, x = 0, y = -265 }, { id = "811b7dbd-7e8d-4506-997a-a8063ac1086b", is_global = false, name = "手写计时器", order = 3, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "75ae2a24-41fe-4d2b-9907-1af40e55aec3" }, style_index = 1, styles = { "9f73c76f-99cd-4223-8556-12a2c8274718" }, visible = false, x = 0, y = 0 }, { id = "d80f3ef1-ca03-47c8-a1ad-e5dd1c1d471d", is_global = false, name = "HP特效2", order = 27, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "6c5f04cb-513f-442e-883d-644e691375a5" }, visible = false, x = 900, y = 0 }, { id = "554d5aa6-5385-486b-8b50-2a83b3b455e1", is_global = false, name = "HUD", order = 10, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 3, styles = { "443be381-09eb-42ef-ba0a-758fc67bcc4a", "b5741627-1761-4871-8b74-0c066d7a1286", "9f5d9b09-a6ee-4967-9783-603d5a0a09f4" }, visible = true, x = -270, y = 180.00071492404 } }
M.assets_dir = "works"
M.assets = { ["00313b5b-0896-44dd-955f-20aeca241ead"] = { adaption = nil, center = nil, file = "assets/00313b5b-0896-44dd-955f-20aeca241ead.jpeg", id = "00313b5b-0896-44dd-955f-20aeca241ead", name = "e3e43ede3d0d379f294a3bfc4a8730e07047da8b", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0Z1NlJqMmRGbEpqNXI5eEFoZXViS0ZOdVBBY3Y=.jpeg" }, ["01b0f1a4-08d8-4691-9378-79b31d8b5f32"] = { adaption = nil, center = nil, file = "assets/01b0f1a4-08d8-4691-9378-79b31d8b5f32.jpeg", id = "01b0f1a4-08d8-4691-9378-79b31d8b5f32", name = "04e40ffb1696b9d5f22d846c076647f32e327d98", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY1ODc5MjAwMDAwX0ZzWHhsVFBVa3dBSWZKenhaVjdhUWN5TTZrLWQ=.jpeg" }, ["021e4210-80d6-4c23-85e7-73e54d811674"] = { adaption = nil, center = nil, file = "assets/021e4210-80d6-4c23-85e7-73e54d811674.jpeg", id = "021e4210-80d6-4c23-85e7-73e54d811674", name = "fd885be84d32fbfa4328a59cb40cb47034ec18e6", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0ZvTmJBRENUcjZnVkpFbTM0UmhyekFqc2FEd1I=.jpeg" }, ["024b9649-a89b-40dd-bda7-004b8b4608de"] = { adaption = nil, center = nil, file = "assets/024b9649-a89b-40dd-bda7-004b8b4608de.jpeg", id = "024b9649-a89b-40dd-bda7-004b8b4608de", name = "7ce7c78c048992cfe3a2d3c9ce019662ffe264f11", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY1NTk0ODAwMDAwX0ZvRnBTQmhLUFUyZnBGc1ZMUm1CSklydnUwUEI=.jpeg" }, ["0342eb18-31da-4d5e-ad42-67475dda3212"] = { adaption = nil, center = nil, file = "assets/0342eb18-31da-4d5e-ad42-67475dda3212.jpeg", id = "0342eb18-31da-4d5e-ad42-67475dda3212", name = "7a880427d016d72d58be3923dd8c33a0c81b839b1", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYyNTIwNDAwMDAwX0ZwOUpXeXdPUVlnbzlSMG92ZF9PUjB0S185ZVo=.jpeg" }, ["052bb922-d548-47e7-b2db-b15444cbd66f"] = { adaption = nil, center = nil, file = "assets/052bb922-d548-47e7-b2db-b15444cbd66f.jpeg", id = "052bb922-d548-47e7-b2db-b15444cbd66f", name = "a364d7b182b71a43bef66816ec5e21307d1d24fa2", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzcyNDM0ODAwMDAwX0Zud3JxTE5EOVpmbWNKRWR5Y0d2OGVXMkVxd0I=.jpeg" }, ["0554a7fb-795f-47b3-9cdb-e5a99d1085f1"] = { adaption = nil, center = nil, file = "assets/0554a7fb-795f-47b3-9cdb-e5a99d1085f1.png", id = "0554a7fb-795f-47b3-9cdb-e5a99d1085f1", name = "按钮 Light@1x (5)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY0NzUyNDAwMDAwX0ZsWWh1Y2JQdkZpRUpQNVVzWndyNmxwV2MtQ3g=.png" }, ["07996e2d-df03-4759-81e9-040ab57d838c"] = { adaption = nil, center = nil, file = "assets/07996e2d-df03-4759-81e9-040ab57d838c.png", id = "07996e2d-df03-4759-81e9-040ab57d838c", name = "newlogo@1x (4)2", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc4NDE0NDAwMDAwX0Z0LW53VEdyVnZPNDFsSE9iWTU2QVQtNU11dzE=.png" }, ["07dd6ded-e48e-4b8f-b246-b56194bb2733"] = { adaption = nil, center = nil, file = "assets/07dd6ded-e48e-4b8f-b246-b56194bb2733.png", id = "07dd6ded-e48e-4b8f-b246-b56194bb2733", name = "logo1 (1)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/FrtuGpcm2c9KkTNyoPa9XcfHVOdT.png" }, ["0847ce7f-d4f3-44e7-97f4-01a035f27096"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/0847ce7f-d4f3-44e7-97f4-01a035f27096.png", id = "0847ce7f-d4f3-44e7-97f4-01a035f27096", name = "盘子1", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FhHYhgA-I7fiXvW6-7e2E02_5G6K.svg" }, ["0886746a-1d94-453e-bfa1-3dc5dc998024"] = { adaption = nil, center = nil, file = "assets/0886746a-1d94-453e-bfa1-3dc5dc998024.png", id = "0886746a-1d94-453e-bfa1-3dc5dc998024", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/6e4d95aecf7441e6a9885cba405baeaf.png" }, ["0890d8db-d20d-4654-a557-df5b7ed15272"] = { adaption = nil, center = nil, file = "assets/0890d8db-d20d-4654-a557-df5b7ed15272.jpeg", id = "0890d8db-d20d-4654-a557-df5b7ed15272", name = "d6f15b167abda579f2a9fafb94f7ba451618ae68", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY1NTk0ODAwMDAwX0ZqcDZ0NmROdnpVbUtVWkxTclNDdW1NdWpTSW4=.jpeg" }, ["09e004f4-d4af-47a1-99b6-d81f7151e619"] = { adaption = nil, center = nil, file = "assets/09e004f4-d4af-47a1-99b6-d81f7151e619.png", id = "09e004f4-d4af-47a1-99b6-d81f7151e619", name = "支持者背景", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI4NzIyMTU0OV8xNzYwNzU2NDAwMDAwX0ZsYTFOU3ZxcGd2Uk1Nei1NajdyVUE2VUJrV2c=.png" }, ["0a258df1-2fa8-40ef-bd92-3b92541880ca"] = { adaption = nil, center = nil, file = "assets/0a258df1-2fa8-40ef-bd92-3b92541880ca.jpeg", id = "0a258df1-2fa8-40ef-bd92-3b92541880ca", name = "02dae0d6f830ade998a29b3a567e0d8a7f158205", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0ZpSEF0MkludHFyUUZ4U2pDdTNwWnhoMUo2LVY=.jpeg" }, ["0a8b3d97-f145-4efb-9bf4-092d67b003d0"] = { adaption = nil, center = nil, file = "assets/0a8b3d97-f145-4efb-9bf4-092d67b003d0.jpeg", id = "0a8b3d97-f145-4efb-9bf4-092d67b003d0", name = "709d1cd3f6fd765741e970739b927e985638f91d", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYwNTIyNDAwMDAwX0ZqZWV2QU44WUpKYmtGQm9QZDYyYjZWV2NRX1I=.jpeg" }, ["0bed02a5-a617-4690-a2ed-b2513e5d7dad"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/0bed02a5-a617-4690-a2ed-b2513e5d7dad.png", id = "0bed02a5-a617-4690-a2ed-b2513e5d7dad", name = "雪", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FvCuELJ0HCh_bcSUFHchLTcG6VWU.svg" }, ["0c2524e6-d9b0-45aa-99cb-5f317c40ce53"] = { adaption = nil, center = nil, file = "assets/0c2524e6-d9b0-45aa-99cb-5f317c40ce53.png", id = "0c2524e6-d9b0-45aa-99cb-5f317c40ce53", name = "容器 1@1x (41)1", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzcwNjEzMjAwMDAwX0Z2MVZoUmJVRHhRRVRnM1QtR2syemdoRlBNaEE=.png" }, ["0c8f105a-c88d-447b-a389-2d3061f9e747"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/0c8f105a-c88d-447b-a389-2d3061f9e747.png", id = "0c8f105a-c88d-447b-a389-2d3061f9e747", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["0cde78b4-ae7b-43b3-9070-b75ecbfd60b0"] = { adaption = nil, center = nil, file = "assets/0cde78b4-ae7b-43b3-9070-b75ecbfd60b0.png", id = "0cde78b4-ae7b-43b3-9070-b75ecbfd60b0", name = "背景", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/img_stage_defult_landscape.png" }, ["11524a84-f54e-400f-aca9-273831a2d811"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/11524a84-f54e-400f-aca9-273831a2d811.png", id = "11524a84-f54e-400f-aca9-273831a2d811", name = "歌词", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["1183830d-584f-4b03-a948-6cae8525dbf7"] = { adaption = nil, center = nil, file = "assets/1183830d-584f-4b03-a948-6cae8525dbf7.jpeg", id = "1183830d-584f-4b03-a948-6cae8525dbf7", name = "fb92c3e699a1128af0c8199888fb39afda985cd2", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY0NjY5NjAwMDAwX0ZqcWhqYVRQdWJ3R3FJbmROMk9oNU5nUmhhR0c=.jpeg" }, ["136391d4-e4bd-492c-bfbd-60a6f5c4590c"] = { adaption = nil, center = nil, file = "assets/136391d4-e4bd-492c-bfbd-60a6f5c4590c.png", id = "136391d4-e4bd-492c-bfbd-60a6f5c4590c", name = "幻灯片 16_9 - 3@1x", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYyNTA5NjAwMDAwX0ZtS0NWLWpZTERoaVlHM25yeDk3M1FGcXhxR3A=.png" }, ["13682e8d-36a7-4007-81c4-6dfd1d2024b8"] = { adaption = nil, center = nil, file = "assets/13682e8d-36a7-4007-81c4-6dfd1d2024b8.jpeg", id = "13682e8d-36a7-4007-81c4-6dfd1d2024b8", name = "4db7e5d286deea0d48a00382b482c9af155f5567", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0ZrVDd5WTJTajdZS3U0blp1M2hHV3hGWUpWczY=.jpeg" }, ["13c07da1-23c9-4462-9119-b6be17a01b38"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/13c07da1-23c9-4462-9119-b6be17a01b38.png", id = "13c07da1-23c9-4462-9119-b6be17a01b38", name = "支持者内容", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["147e7c12-94e3-4227-ade5-7def25f1e083"] = { adaption = nil, center = nil, file = "assets/147e7c12-94e3-4227-ade5-7def25f1e083.jpeg", id = "147e7c12-94e3-4227-ade5-7def25f1e083", name = "c830536db65292d85161df12b54090522ddb1979", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc3NzAxNjAwMDAwX0ZyNTVjVDd2bG1jWXFydktTUVhhaEdYZktzS3E=.jpeg" }, ["18168fb7-301a-4b4f-bfad-c303b48ddda7"] = { adaption = nil, center = nil, file = "assets/18168fb7-301a-4b4f-bfad-c303b48ddda7.jpeg", id = "18168fb7-301a-4b4f-bfad-c303b48ddda7", name = "f663f121d01426c4883f6894ef09006b807e7708", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5ODIwNDAwMDAwX0Z0X1o1M25nOUxncW9WckNhdkZqbDU1a1ZVdXk=.jpeg" }, ["181b4067-f499-4f01-aaa0-62ee4c1854a3"] = { adaption = nil, center = nil, file = "assets/181b4067-f499-4f01-aaa0-62ee4c1854a3.jpeg", id = "181b4067-f499-4f01-aaa0-62ee4c1854a3", name = "109951166593375787", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5NzI2ODAwMDAwX0ZxUVg4NmNRUlU4b2J2NE41RlpxNmxlSjRkTFM=.jpeg" }, ["18deacc0-cc12-4064-ae9c-5641c682f91d"] = { adaption = nil, center = nil, file = "assets/18deacc0-cc12-4064-ae9c-5641c682f91d.png", id = "18deacc0-cc12-4064-ae9c-5641c682f91d", name = "幻灯片 16_9 - 8@1x (1)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY3MjQwMDAwMDAwX0ZyNF95WC04dU15a1pqTEs2MWpSTUtyaXMzZlY=.png" }, ["197a64e9-069c-4bed-9eb5-48ac230f6d58"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/197a64e9-069c-4bed-9eb5-48ac230f6d58.png", id = "197a64e9-069c-4bed-9eb5-48ac230f6d58", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["1c5ec5a1-6273-4282-89fd-0e61858e6e78"] = { adaption = nil, center = nil, file = "assets/1c5ec5a1-6273-4282-89fd-0e61858e6e78.png", id = "1c5ec5a1-6273-4282-89fd-0e61858e6e78", name = "容器 3@1x", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzg4NTgwODAwMDAwX0ZycEFtLUJlUHM3OUJGc1M0emxYZlFDeDI1RUc=.png" }, ["1d327a90-59ff-47af-83af-1163023027e6"] = { adaption = nil, center = nil, file = "assets/1d327a90-59ff-47af-83af-1163023027e6.jpeg", id = "1d327a90-59ff-47af-83af-1163023027e6", name = "109951169154205063", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYwMjY2ODAwMDAwX0ZtaUNMTEN4dmwyVFM0d0ctd1d0aGZhREFYSjk=.jpeg" }, ["1e5f5f44-43e7-420e-bbc2-cf0b8ce1fdbb"] = { adaption = nil, center = nil, file = "assets/1e5f5f44-43e7-420e-bbc2-cf0b8ce1fdbb.jpeg", id = "1e5f5f44-43e7-420e-bbc2-cf0b8ce1fdbb", name = "109951169154205061", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYwMjY2ODAwMDAwX0ZtaUNMTEN4dmwyVFM0d0ctd1d0aGZhREFYSjk=.jpeg" }, ["20862ce4-ee29-4b96-9da4-223f3e785493"] = { adaption = nil, center = nil, file = "assets/20862ce4-ee29-4b96-9da4-223f3e785493.jpeg", id = "20862ce4-ee29-4b96-9da4-223f3e785493", name = "fd885be84d32fbfa4328a59cb40cb47034ec18e9", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0ZvTmJBRENUcjZnVkpFbTM0UmhyekFqc2FEd1I=.jpeg" }, ["217f05d1-d466-4195-9033-d81d345029fa"] = { adaption = nil, center = nil, file = "assets/217f05d1-d466-4195-9033-d81d345029fa.jpeg", id = "217f05d1-d466-4195-9033-d81d345029fa", name = "fd885be84d32fbfa4328a59cb40cb47034ec18e8", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0ZvTmJBRENUcjZnVkpFbTM0UmhyekFqc2FEd1I=.jpeg" }, ["22017908-625f-4579-9bd0-ee6459918a1b"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/22017908-625f-4579-9bd0-ee6459918a1b.png", id = "22017908-625f-4579-9bd0-ee6459918a1b", name = "提示", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["243de300-4d17-42d5-967e-faed4e192f5b"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/243de300-4d17-42d5-967e-faed4e192f5b.png", id = "243de300-4d17-42d5-967e-faed4e192f5b", name = "FPS", styleType = nil, url = "https://static.codemao.cn/neko/painter/img/emptyFrame.png" }, ["244d4074-26df-46ac-9462-20bb03b3fc95"] = { adaption = nil, center = nil, file = "assets/244d4074-26df-46ac-9462-20bb03b3fc95.png", id = "244d4074-26df-46ac-9462-20bb03b3fc95", name = "按钮 Light@1x (3)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY0NzUyNDAwMDAwX0ZqeW4yRUVFX25hRnBINHFDVlpWdEFqRFFPUnM=.png" }, ["2464dc90-db37-4010-b13f-68b4ef342177"] = { adaption = nil, center = nil, file = "assets/2464dc90-db37-4010-b13f-68b4ef342177.png", id = "2464dc90-db37-4010-b13f-68b4ef342177", name = "涟漪", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI5NDUzNjYwNF8xNzY0NzUyNDAwMDAwX0ZtSFk2bDNRSW1hSUQyTEtSN1AtTGM3bUEzSVE=.png" }, ["24d8f33b-34c1-4412-a945-35c90e8af70f"] = { adaption = nil, center = nil, file = "assets/24d8f33b-34c1-4412-a945-35c90e8af70f.jpeg", id = "24d8f33b-34c1-4412-a945-35c90e8af70f", name = "18e20f809318dfcd0901f29dedc606ee51b2f7ee2", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYyNjgyNDAwMDAwX0ZrMFlrME02SDBXcDJTVVlLMUc0T2JuR0txQUw=.jpeg" }, ["25d5f2b0-eb8c-45e8-88c6-507816d35a08"] = { adaption = nil, center = nil, file = "assets/25d5f2b0-eb8c-45e8-88c6-507816d35a08.jpeg", id = "25d5f2b0-eb8c-45e8-88c6-507816d35a08", name = "Insanae1", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0ZxRG5FTHRPNEhSeWNPajZVQndRd2JCZDV1Um4=.jpeg" }, ["2600ecbe-1b17-48c7-bc2e-9a362ccb1187"] = { adaption = nil, center = nil, file = "assets/2600ecbe-1b17-48c7-bc2e-9a362ccb1187.jpeg", id = "2600ecbe-1b17-48c7-bc2e-9a362ccb1187", name = "4db7e5d286deea0d48a00382b482c9af155f5566", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0ZrVDd5WTJTajdZS3U0blp1M2hHV3hGWUpWczY=.jpeg" }, ["275a7b31-e8e7-4921-a974-4f343c296e6b"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/275a7b31-e8e7-4921-a974-4f343c296e6b.png", id = "275a7b31-e8e7-4921-a974-4f343c296e6b", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["28de83f6-768d-4604-912d-64e27ba22e9c"] = { adaption = nil, center = nil, file = "assets/28de83f6-768d-4604-912d-64e27ba22e9c.png", id = "28de83f6-768d-4604-912d-64e27ba22e9c", name = "水印0", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5NTcyMDAwMDAwX0ZpRzZ1T2p2QW9BaTNjUXBBWDMzX2xHZzctQlo=.png" }, ["28f19514-7c83-4059-8cdb-d3fd0e900100"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/28f19514-7c83-4059-8cdb-d3fd0e900100.png", id = "28f19514-7c83-4059-8cdb-d3fd0e900100", name = "在线人数", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["2922bf6e-f851-41b8-837b-09c57a18ac4a"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/2922bf6e-f851-41b8-837b-09c57a18ac4a.png", id = "2922bf6e-f851-41b8-837b-09c57a18ac4a", name = "FPS", styleType = nil, url = "https://static.codemao.cn/neko/painter/img/emptyFrame.png" }, ["2a925fec-394a-4ecc-934d-d5e34a3dcd68"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/2a925fec-394a-4ecc-934d-d5e34a3dcd68.png", id = "2a925fec-394a-4ecc-934d-d5e34a3dcd68", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["2aa74e86-ca1f-47be-baaa-b5388c373da1"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/2aa74e86-ca1f-47be-baaa-b5388c373da1.png", id = "2aa74e86-ca1f-47be-baaa-b5388c373da1", name = "判定盘子", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FhHYhgA-I7fiXvW6-7e2E02_5G6K.svg" }, ["2aecdc6b-06af-49fd-841d-fbdb5c22f3de"] = { adaption = nil, center = nil, file = "assets/2aecdc6b-06af-49fd-841d-fbdb5c22f3de.png", id = "2aecdc6b-06af-49fd-841d-fbdb5c22f3de", name = "image1", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY2OTk4ODAwMDAwX0ZzdnFhNHFaYW44YjJHLTZDSlJYV2x5aTdsUnE=.png" }, ["2b04721d-e494-4e06-84ce-5de0dd5f8701"] = { adaption = nil, center = nil, file = "assets/2b04721d-e494-4e06-84ce-5de0dd5f8701.jpeg", id = "2b04721d-e494-4e06-84ce-5de0dd5f8701", name = "7aa17e01cf42591bded567dffbbb38063fe77290", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc1MDE5NjAwMDAwX0ZwdVpDcUZzbVkxUlJJbERhcVFyZ1VfMUNBdkQ=.jpeg" }, ["2c7077b1-a9ad-4a72-a878-295453d9e975"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/2c7077b1-a9ad-4a72-a878-295453d9e975.png", id = "2c7077b1-a9ad-4a72-a878-295453d9e975", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0Zrb1dtZ0RLTmJOZHM2dEpKVUxQbVNYbFE0Z04=.svg" }, ["2c95d00e-d370-4d8e-bd30-a704657f5cfa"] = { adaption = nil, center = nil, file = "assets/2c95d00e-d370-4d8e-bd30-a704657f5cfa.png", id = "2c95d00e-d370-4d8e-bd30-a704657f5cfa", name = "star-solid-full@1x", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzcwNjEzMjAwMDAwX0ZrSG9wM21ZNHBwdmJiel95YkFnMFBGd3BhQmo=.png" }, ["2ce59e4a-6f4a-4f0f-814c-a79f61e6f766"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/2ce59e4a-6f4a-4f0f-814c-a79f61e6f766.png", id = "2ce59e4a-6f4a-4f0f-814c-a79f61e6f766", name = "PP", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["2d543fa9-dfb4-46f9-8152-f50d174e7ba8"] = { adaption = nil, center = nil, file = "assets/2d543fa9-dfb4-46f9-8152-f50d174e7ba8.jpeg", id = "2d543fa9-dfb4-46f9-8152-f50d174e7ba8", name = "d6f15b167abda579f2a9fafb94f7ba451618ae70", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY1NTk0ODAwMDAwX0ZqcDZ0NmROdnpVbUtVWkxTclNDdW1NdWpTSW4=.jpeg" }, ["2ede425c-27cd-42eb-bed3-fcc819789f2c"] = { adaption = nil, center = nil, file = "assets/2ede425c-27cd-42eb-bed3-fcc819789f2c.jpeg", id = "2ede425c-27cd-42eb-bed3-fcc819789f2c", name = "709d1cd3f6fd765741e970739b927e985638f91d2", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYwNTIyNDAwMDAwX0ZqZWV2QU44WUpKYmtGQm9QZDYyYjZWV2NRX1I=.jpeg" }, ["2f5de028-0999-418a-9b65-a4df37b97e0a"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/2f5de028-0999-418a-9b65-a4df37b97e0a.png", id = "2f5de028-0999-418a-9b65-a4df37b97e0a", name = "星星喷泉左", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["2fa79260-bfc4-4258-9748-b018a0f1c217"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/2fa79260-bfc4-4258-9748-b018a0f1c217.png", id = "2fa79260-bfc4-4258-9748-b018a0f1c217", name = "新角色", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FildVSLBLW8CFsiu-yJ3NLvJIBUT.svg" }, ["2fbccc5b-c214-42a3-92d0-9026be6e119e"] = { adaption = nil, center = nil, file = "assets/2fbccc5b-c214-42a3-92d0-9026be6e119e.jpeg", id = "2fbccc5b-c214-42a3-92d0-9026be6e119e", name = "109951169154205060", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYwMjY2ODAwMDAwX0ZtaUNMTEN4dmwyVFM0d0ctd1d0aGZhREFYSjk=.jpeg" }, ["320ce8e9-18ba-4979-81d8-8cca4b4eaa1e"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/320ce8e9-18ba-4979-81d8-8cca4b4eaa1e.png", id = "320ce8e9-18ba-4979-81d8-8cca4b4eaa1e", name = "遮罩", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0Zrb1dtZ0RLTmJOZHM2dEpKVUxQbVNYbFE0Z04=.svg" }, ["34917556-b7dc-4290-9b6e-2e9014b04bbd"] = { adaption = nil, center = nil, file = "assets/34917556-b7dc-4290-9b6e-2e9014b04bbd.jpeg", id = "34917556-b7dc-4290-9b6e-2e9014b04bbd", name = "02dae0d6f830ade998a29b3a567e0d8a7f158203", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0ZpSEF0MkludHFyUUZ4U2pDdTNwWnhoMUo2LVY=.jpeg" }, ["36200a8f-b646-4807-b7d2-c52568e76f67"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/36200a8f-b646-4807-b7d2-c52568e76f67.png", id = "36200a8f-b646-4807-b7d2-c52568e76f67", name = "打击、小姐", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["367ff127-dafc-4f30-b4cf-8d9393a1ec0d"] = { adaption = nil, center = nil, file = "assets/367ff127-dafc-4f30-b4cf-8d9393a1ec0d.jpeg", id = "367ff127-dafc-4f30-b4cf-8d9393a1ec0d", name = "c2f96caea62bd65ce6fcdd597fdd720e6cef6436", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzg4NTgwODAwMDAwX0Z1dW4xaTY0QnowUkZXelZYUFFLeHJ1SUlhNzc=.jpeg" }, ["36aa6a75-b049-4a9d-8014-3661ff15433d"] = { adaption = nil, center = nil, file = "assets/36aa6a75-b049-4a9d-8014-3661ff15433d.jpeg", id = "36aa6a75-b049-4a9d-8014-3661ff15433d", name = "asdsadsadsadasd", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5NjYyMDAwMDAwX0ZySUMxZ0w4RnFjYzhkVEdBc0pVWGhvOFJXUlQ=.jpeg" }, ["36be7763-cbb3-4e02-9586-50af92e74991"] = { adaption = nil, center = nil, file = "assets/36be7763-cbb3-4e02-9586-50af92e74991.png", id = "36be7763-cbb3-4e02-9586-50af92e74991", name = "star-solid-full@1x1", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzcwNjEzMjAwMDAwX0ZrSG9wM21ZNHBwdmJiel95YkFnMFBGd3BhQmo=.png" }, ["37da56e5-a513-49b8-8f4e-57a4ec250235"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/37da56e5-a513-49b8-8f4e-57a4ec250235.png", id = "37da56e5-a513-49b8-8f4e-57a4ec250235", name = "横幅通知", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/Fu84tfpiL-6-nP_-DK6wMsZSRxjY?imageView2/0/format/png" }, ["382e5874-f421-4d73-acc3-d20d63d3857f"] = { adaption = nil, center = nil, file = "assets/382e5874-f421-4d73-acc3-d20d63d3857f.jpeg", id = "382e5874-f421-4d73-acc3-d20d63d3857f", name = "18e20f809318dfcd0901f29dedc606ee51b2f7ee1", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYyNjgyNDAwMDAwX0ZrMFlrME02SDBXcDJTVVlLMUc0T2JuR0txQUw=.jpeg" }, ["388f8234-515e-4bc5-b18b-7b8ebc1f0b06"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/388f8234-515e-4bc5-b18b-7b8ebc1f0b06.png", id = "388f8234-515e-4bc5-b18b-7b8ebc1f0b06", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["39edfaeb-0769-4cd9-b939-a7d4878b96bb"] = { adaption = nil, center = nil, file = "assets/39edfaeb-0769-4cd9-b939-a7d4878b96bb.jpeg", id = "39edfaeb-0769-4cd9-b939-a7d4878b96bb", name = "c2f96caea62bd65ce6fcdd597fdd720e6cef6437", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzg4NTgwODAwMDAwX0Z1dW4xaTY0QnowUkZXelZYUFFLeHJ1SUlhNzc=.jpeg" }, ["3a83ec08-d51d-4de0-8793-4f456675cae3"] = { adaption = nil, center = { x = 8.5075902529358e-14, y = 0 }, file = "assets/3a83ec08-d51d-4de0-8793-4f456675cae3.png", id = "3a83ec08-d51d-4de0-8793-4f456675cae3", name = "hat", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY2MjA2ODAwMDAwX0ZnWUMxX0RnUTFyaFJaY0lQZ3FhSFk4eGRVUVM=.svg" }, ["3c66b745-1914-491e-bd35-447c3517da6b"] = { adaption = nil, center = nil, file = "assets/3c66b745-1914-491e-bd35-447c3517da6b.png", id = "3c66b745-1914-491e-bd35-447c3517da6b", name = "矩形 3@1x (3)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYyNTEzMjAwMDAwX0ZreDhaejNUSXJnZW9CZU5WaGlLckgwODBkQ2Q=.png" }, ["3dfbaaed-08e9-4c81-bc87-ffe7a1c4e4d2"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/3dfbaaed-08e9-4c81-bc87-ffe7a1c4e4d2.png", id = "3dfbaaed-08e9-4c81-bc87-ffe7a1c4e4d2", name = "新角色", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FiTbwQbXHSKcPExUJsyYw0bAwVAh.svg" }, ["3e8dc32f-a01c-4a7b-a49a-cd28918e1fdd"] = { adaption = nil, center = nil, file = "assets/3e8dc32f-a01c-4a7b-a49a-cd28918e1fdd.jpeg", id = "3e8dc32f-a01c-4a7b-a49a-cd28918e1fdd", name = "7aa17e01cf42591bded567dffbbb38063fe77287", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc1MDE5NjAwMDAwX0ZwdVpDcUZzbVkxUlJJbERhcVFyZ1VfMUNBdkQ=.jpeg" }, ["40bd85af-ffe3-4049-88b4-5079b714ccb8"] = { adaption = 0, center = { x = 0, y = 0 }, file = "assets/40bd85af-ffe3-4049-88b4-5079b714ccb8.png", id = "40bd85af-ffe3-4049-88b4-5079b714ccb8", name = "背景", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FpDcw1Lq3CWXS5wQx9HllkrRr12k.svg" }, ["41ea06d1-2de4-48e2-b7ae-a2fa52db9218"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/41ea06d1-2de4-48e2-b7ae-a2fa52db9218.png", id = "41ea06d1-2de4-48e2-b7ae-a2fa52db9218", name = "评分", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["43bb81b3-9c64-4e30-b427-4797e564c559"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/43bb81b3-9c64-4e30-b427-4797e564c559.png", id = "43bb81b3-9c64-4e30-b427-4797e564c559", name = "遮罩", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0Zrb1dtZ0RLTmJOZHM2dEpKVUxQbVNYbFE0Z04=.svg" }, ["443be381-09eb-42ef-ba0a-758fc67bcc4a"] = { adaption = nil, center = nil, file = "assets/443be381-09eb-42ef-ba0a-758fc67bcc4a.png", id = "443be381-09eb-42ef-ba0a-758fc67bcc4a", name = "HUD", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc4MTE5MjAwMDAwX0ZsdEMxV2FvNFlsbkxQMzJaWW4yMk83N04xcnA=.png" }, ["44f989a7-fbf2-41d0-a2eb-9406d61c0488"] = { adaption = nil, center = nil, file = "assets/44f989a7-fbf2-41d0-a2eb-9406d61c0488.jpeg", id = "44f989a7-fbf2-41d0-a2eb-9406d61c0488", name = "f663f121d01426c4883f6894ef09006b807e7709", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5ODIwNDAwMDAwX0Z0X1o1M25nOUxncW9WckNhdkZqbDU1a1ZVdXk=.jpeg" }, ["463dc548-1d3e-47a5-9fc2-5b5c7c5e09fe"] = { adaption = nil, center = nil, file = "assets/463dc548-1d3e-47a5-9fc2-5b5c7c5e09fe.png", id = "463dc548-1d3e-47a5-9fc2-5b5c7c5e09fe", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/8aa8cbdbe82a442989b0fadb823444d4.png" }, ["4640abe2-ecfd-4ad8-9ab7-d0f8831c8dbf"] = { adaption = nil, center = nil, file = "assets/4640abe2-ecfd-4ad8-9ab7-d0f8831c8dbf.png", id = "4640abe2-ecfd-4ad8-9ab7-d0f8831c8dbf", name = "容器 1@1x (31)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYwNzU2NDAwMDAwX0Z0N0tENG1xUUdfbmZicDV0OExpbnRsTW1lM2Q=.png" }, ["47703908-4bed-4dbe-bbd5-f7ba7bfa9ffd"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/47703908-4bed-4dbe-bbd5-f7ba7bfa9ffd.png", id = "47703908-4bed-4dbe-bbd5-f7ba7bfa9ffd", name = "当前歌曲显示1", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["47e68607-4841-4527-8815-849a379bbf57"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/47e68607-4841-4527-8815-849a379bbf57.png", id = "47e68607-4841-4527-8815-849a379bbf57", name = "星星喷泉右", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["48ad7958-130d-41c8-995b-fa4f112a9cbf"] = { adaption = nil, center = nil, file = "assets/48ad7958-130d-41c8-995b-fa4f112a9cbf.png", id = "48ad7958-130d-41c8-995b-fa4f112a9cbf", name = "上一页", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/FgZukZb0PHduZEWTkbOfD9K5j3qT?imageView2/0/format/png" }, ["4a0e8f7e-5717-4c07-b500-d4fa46886888"] = { adaption = nil, center = nil, file = "assets/4a0e8f7e-5717-4c07-b500-d4fa46886888.jpeg", id = "4a0e8f7e-5717-4c07-b500-d4fa46886888", name = "e3e43ede3d0d379f294a3bfc4a8730e07047da8b2", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0Z1NlJqMmRGbEpqNXI5eEFoZXViS0ZOdVBBY3Y=.jpeg" }, ["4a80cb4b-70cd-4985-9459-f4f6b72136d1"] = { adaption = nil, center = nil, file = "assets/4a80cb4b-70cd-4985-9459-f4f6b72136d1.png", id = "4a80cb4b-70cd-4985-9459-f4f6b72136d1", name = "矩形 2@1x (2)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY1Mjc0NDAwMDAwX0ZyR092bXV4YUcyUk9pLV9MUmF2NXFnZGpIR3g=.png" }, ["4af4ec14-17f7-4877-a93f-dcb626abf45c"] = { adaption = nil, center = nil, file = "assets/4af4ec14-17f7-4877-a93f-dcb626abf45c.png", id = "4af4ec14-17f7-4877-a93f-dcb626abf45c", name = "容器 1@1x (38)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY5MzI4MDAwMDAwX0ZsSVRWLW1nVG10azIyNkIxaE00N21CcHFtUEg=.png" }, ["4b76cc42-7ae1-4abf-aa66-0bae850a6dbb"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/4b76cc42-7ae1-4abf-aa66-0bae850a6dbb.png", id = "4b76cc42-7ae1-4abf-aa66-0bae850a6dbb", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["4b7d5c12-ad81-46a7-9394-64ac777b6293"] = { adaption = nil, center = nil, file = "assets/4b7d5c12-ad81-46a7-9394-64ac777b6293.png", id = "4b7d5c12-ad81-46a7-9394-64ac777b6293", name = "矩形 1@1x (7)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY1Mjc0NDAwMDAwX0ZwbEJ5MWNFekJNajJ4LTVFNXFpRkZ1V01ZU2M=.png" }, ["4b8848e0-0c9d-4216-a7f2-ae8a98e8c2b2"] = { adaption = nil, center = nil, file = "assets/4b8848e0-0c9d-4216-a7f2-ae8a98e8c2b2.jpeg", id = "4b8848e0-0c9d-4216-a7f2-ae8a98e8c2b2", name = "7a880427d016d72d58be3923dd8c33a0c81b839b3", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYyNTIwNDAwMDAwX0ZwOUpXeXdPUVlnbzlSMG92ZF9PUjB0S185ZVo=.jpeg" }, ["4bbbb9a6-a19a-438e-94ca-c800e1b0ca5f"] = { adaption = nil, center = nil, file = "assets/4bbbb9a6-a19a-438e-94ca-c800e1b0ca5f.jpeg", id = "4bbbb9a6-a19a-438e-94ca-c800e1b0ca5f", name = "7ce7c78c048992cfe3a2d3c9ce019662ffe264f10", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY1NTk0ODAwMDAwX0ZvRnBTQmhLUFUyZnBGc1ZMUm1CSklydnUwUEI=.jpeg" }, ["50067d4c-1718-4e94-9283-f20cf3c7562a"] = { adaption = nil, center = nil, file = "assets/50067d4c-1718-4e94-9283-f20cf3c7562a.png", id = "50067d4c-1718-4e94-9283-f20cf3c7562a", name = "newlogo@1x (4)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc4NDE0NDAwMDAwX0Z0LW53VEdyVnZPNDFsSE9iWTU2QVQtNU11dzE=.png" }, ["55d2bda8-7fee-4cf7-9139-9e0377eb6cbf"] = { adaption = nil, center = nil, file = "assets/55d2bda8-7fee-4cf7-9139-9e0377eb6cbf.jpeg", id = "55d2bda8-7fee-4cf7-9139-9e0377eb6cbf", name = "Insanae", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0ZxRG5FTHRPNEhSeWNPajZVQndRd2JCZDV1Um4=.jpeg" }, ["577d802b-9fb9-4211-ba96-e4563a422499"] = { adaption = nil, center = nil, file = "assets/577d802b-9fb9-4211-ba96-e4563a422499.jpeg", id = "577d802b-9fb9-4211-ba96-e4563a422499", name = "4db7e5d286deea0d48a00382b482c9af155f5568", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0ZrVDd5WTJTajdZS3U0blp1M2hHV3hGWUpWczY=.jpeg" }, ["5894663f-e95b-4e9c-983e-d8fe407062e2"] = { adaption = nil, center = nil, file = "assets/5894663f-e95b-4e9c-983e-d8fe407062e2.png", id = "5894663f-e95b-4e9c-983e-d8fe407062e2", name = "涟漪", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI5NDUzNjYwNF8xNzY0NzUyNDAwMDAwX0ZwTWR0a0RrUmtyRDVMZDFhdUUzTWJLUS1fLTk=.png" }, ["5add3f28-d41e-4b72-a763-bb29ddb847bc"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/5add3f28-d41e-4b72-a763-bb29ddb847bc.png", id = "5add3f28-d41e-4b72-a763-bb29ddb847bc", name = "轨道", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FvCuELJ0HCh_bcSUFHchLTcG6VWU.svg" }, ["5b108421-03dd-46db-b426-4d4552083d70"] = { adaption = nil, center = nil, file = "assets/5b108421-03dd-46db-b426-4d4552083d70.png", id = "5b108421-03dd-46db-b426-4d4552083d70", name = "幻灯片 16_9 - 8@1x", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY3MDAyNDAwMDAwX0ZraXgzM1BWa01zdUFDVDg5czZqRGJjNFcwc0E=.png" }, ["5c35f914-8be3-4b83-9084-2b490edf626c"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/5c35f914-8be3-4b83-9084-2b490edf626c.png", id = "5c35f914-8be3-4b83-9084-2b490edf626c", name = "FPS", styleType = nil, url = "https://static.codemao.cn/neko/painter/img/emptyFrame.png" }, ["5d2c0662-a57c-4ce1-81fa-daca7ee0a5de"] = { adaption = nil, center = nil, file = "assets/5d2c0662-a57c-4ce1-81fa-daca7ee0a5de.jpeg", id = "5d2c0662-a57c-4ce1-81fa-daca7ee0a5de", name = "02dae0d6f830ade998a29b3a567e0d8a7f158204", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0ZpSEF0MkludHFyUUZ4U2pDdTNwWnhoMUo2LVY=.jpeg" }, ["5d8b7307-98dd-469a-b2d1-252c4a5aec18"] = { adaption = nil, center = nil, file = "assets/5d8b7307-98dd-469a-b2d1-252c4a5aec18.jpeg", id = "5d8b7307-98dd-469a-b2d1-252c4a5aec18", name = "ad3d2076840545e82ad3707668b934c5c71733f10", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc4OTA0MDAwMDAwX0ZoSy1RWHFKSEV6eERiLTJPSEQ0YVJydTNNLXQ=.jpeg" }, ["5dfbeff5-2092-49f0-8dcc-4edeb7a11f35"] = { adaption = nil, center = nil, file = "assets/5dfbeff5-2092-49f0-8dcc-4edeb7a11f35.png", id = "5dfbeff5-2092-49f0-8dcc-4edeb7a11f35", name = "容器 3@1x (10)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc4NDE0NDAwMDAwX0ZuaHp2OGdfQ3htT21HX2VCQ25qVDFmR0ZiRnU=.png" }, ["5ee26315-68cd-43bd-b4c0-a8ab624000f0"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/5ee26315-68cd-43bd-b4c0-a8ab624000f0.png", id = "5ee26315-68cd-43bd-b4c0-a8ab624000f0", name = "文本", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["5f4b3b36-0a77-41cf-b201-35e2a8ce8fd3"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/5f4b3b36-0a77-41cf-b201-35e2a8ce8fd3.png", id = "5f4b3b36-0a77-41cf-b201-35e2a8ce8fd3", name = "评级底", styleType = nil, url = "https://creation.codemao.cn/922/user-files/Fo6SVU_c2j1NimRq41AIUwNe4GYh.svg" }, ["60b38e87-2143-4180-a5e0-7583f6b51967"] = { adaption = nil, center = nil, file = "assets/60b38e87-2143-4180-a5e0-7583f6b51967.png", id = "60b38e87-2143-4180-a5e0-7583f6b51967", name = "按钮 Dark", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc3NTUwNDAwMDAwX0Zna0JSZE10c2dVNEo1LW11Ti1TSnAxa3kxRXc=.png" }, ["624461ee-2267-4bac-81c6-79ad44820fa8"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/624461ee-2267-4bac-81c6-79ad44820fa8.png", id = "624461ee-2267-4bac-81c6-79ad44820fa8", name = "FPS-非初始", styleType = nil, url = "https://static.codemao.cn/neko/painter/img/emptyFrame.png" }, ["62c284d7-2759-4c2c-9027-d91aed7d50f5"] = { adaption = nil, center = nil, file = "assets/62c284d7-2759-4c2c-9027-d91aed7d50f5.png", id = "62c284d7-2759-4c2c-9027-d91aed7d50f5", name = "开始游戏0", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5NTcyMDAwMDAwX0ZpYzJXNTIzb1FBaGMwY0V5TXZ5a1JaT2owaGg=.png" }, ["6345d07b-b96e-4876-bc28-da8086e81bbb"] = { adaption = nil, center = nil, file = "assets/6345d07b-b96e-4876-bc28-da8086e81bbb.jpeg", id = "6345d07b-b96e-4876-bc28-da8086e81bbb", name = "7aa17e01cf42591bded567dffbbb38063fe77288", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc1MDE5NjAwMDAwX0ZwdVpDcUZzbVkxUlJJbERhcVFyZ1VfMUNBdkQ=.jpeg" }, ["6351388d-0a98-4ed2-a4e4-acaceba3c2a1"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/6351388d-0a98-4ed2-a4e4-acaceba3c2a1.png", id = "6351388d-0a98-4ed2-a4e4-acaceba3c2a1", name = "在线人数", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["642c91d2-7ed4-46ef-a05c-82cd864b2efc"] = { adaption = nil, center = nil, file = "assets/642c91d2-7ed4-46ef-a05c-82cd864b2efc.jpeg", id = "642c91d2-7ed4-46ef-a05c-82cd864b2efc", name = "asdsadsadsadasd2", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5NjYyMDAwMDAwX0ZySUMxZ0w4RnFjYzhkVEdBc0pVWGhvOFJXUlQ=.jpeg" }, ["66468923-b730-48d0-b112-f50921bb0c37"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/66468923-b730-48d0-b112-f50921bb0c37.png", id = "66468923-b730-48d0-b112-f50921bb0c37", name = "横幅文字", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["69913435-aa62-45db-ae2c-b90c0d327cd6"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/69913435-aa62-45db-ae2c-b90c0d327cd6.png", id = "69913435-aa62-45db-ae2c-b90c0d327cd6", name = "鸣谢打印", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["69c5c7fa-5343-47df-a461-386854a5f081"] = { adaption = nil, center = nil, file = "assets/69c5c7fa-5343-47df-a461-386854a5f081.jpeg", id = "69c5c7fa-5343-47df-a461-386854a5f081", name = "709d1cd3f6fd765741e970739b927e985638f91d3", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYwNTIyNDAwMDAwX0ZqZWV2QU44WUpKYmtGQm9QZDYyYjZWV2NRX1I=.jpeg" }, ["6ab4bff5-7b2e-4078-aadc-90d8088e2057"] = { adaption = nil, center = { x = -8.3628275915639e-14, y = -8.3628275915639e-14 }, file = "assets/6ab4bff5-7b2e-4078-aadc-90d8088e2057.png", id = "6ab4bff5-7b2e-4078-aadc-90d8088e2057", name = "osucircle", styleType = nil, url = "https://creation.codemao.cn/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU1MDQ5NjA0ODQxX0ZyaEwwZTVRVWRCYXFfMXNwZU5IQXNSaHp6VWM=.svg" }, ["6aec5b3f-c651-42f7-a952-25932dd016b2"] = { adaption = nil, center = nil, file = "assets/6aec5b3f-c651-42f7-a952-25932dd016b2.png", id = "6aec5b3f-c651-42f7-a952-25932dd016b2", name = "下一页", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/FgZukZb0PHduZEWTkbOfD9K5j3qT?imageView2/0/format/png" }, ["6b1bbce9-1fea-4bb0-bc06-240b372164e7"] = { adaption = nil, center = nil, file = "assets/6b1bbce9-1fea-4bb0-bc06-240b372164e7.png", id = "6b1bbce9-1fea-4bb0-bc06-240b372164e7", name = "容器 1@1x (41)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzcwNjEzMjAwMDAwX0Z2MVZoUmJVRHhRRVRnM1QtR2syemdoRlBNaEE=.png" }, ["6c5f04cb-513f-442e-883d-644e691375a5"] = { adaption = nil, center = nil, file = "assets/6c5f04cb-513f-442e-883d-644e691375a5.png", id = "6c5f04cb-513f-442e-883d-644e691375a5", name = "矩形 3@1x (5)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY5MzI4MDAwMDAwX0ZwVnJ1bUM0Y2ExUnIxX0NRNmNRVUwtY3lnc1U=.png" }, ["6c672677-bc9c-424c-93ff-0bddff7d57f7"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/6c672677-bc9c-424c-93ff-0bddff7d57f7.png", id = "6c672677-bc9c-424c-93ff-0bddff7d57f7", name = "曲目打印", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FmCh8Y1DG4VVCoeg66l_hMDGXG9x.svg" }, ["6d92c9f0-2bd5-46a7-9ca0-7d48d0d1c74d"] = { adaption = nil, center = nil, file = "assets/6d92c9f0-2bd5-46a7-9ca0-7d48d0d1c74d.png", id = "6d92c9f0-2bd5-46a7-9ca0-7d48d0d1c74d", name = "按钮 Light@1x", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY0NzUyNDAwMDAwX0ZwSC0yNFpxVUZueEdDZVJyWHNacDFDX1J3Zkw=.png" }, ["6ea9c6b2-daa3-434a-9b2e-0f4c0751650d"] = { adaption = nil, center = nil, file = "assets/6ea9c6b2-daa3-434a-9b2e-0f4c0751650d.png", id = "6ea9c6b2-daa3-434a-9b2e-0f4c0751650d", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/Fhmo_GqCxbTymw8_jktYHDMp3aM-?imageView2/0/format/png" }, ["7148d591-70f8-47ad-91aa-3e541ae5cccb"] = { adaption = nil, center = nil, file = "assets/7148d591-70f8-47ad-91aa-3e541ae5cccb.png", id = "7148d591-70f8-47ad-91aa-3e541ae5cccb", name = "GW2", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY3MDAyNDAwMDAwX0ZsOEI5Ui14dUtzOG1Xbm1nVzB1dDlhTmlJb0E=.png" }, ["71a5eef7-1712-4d96-8674-0cc206f20e86"] = { adaption = 0, center = { x = 0, y = 0 }, file = "assets/71a5eef7-1712-4d96-8674-0cc206f20e86.png", id = "71a5eef7-1712-4d96-8674-0cc206f20e86", name = "背景", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FvTD75oWur_ny8PRrEwjxiXRqaie.svg" }, ["72b937e8-8baa-45b9-8dbc-7e26317f7aaf"] = { adaption = nil, center = nil, file = "assets/72b937e8-8baa-45b9-8dbc-7e26317f7aaf.jpeg", id = "72b937e8-8baa-45b9-8dbc-7e26317f7aaf", name = "56bafa53c974f4c60dc258dd42c8f1e9df278488", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5NTU3NjAwMDAwX0ZvQnVJS0hBUk5GUHhWLWNtS3EtSC1jNGc0SEY=.jpeg" }, ["74724772-7de1-43e2-8fff-e662f6b42c93"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/74724772-7de1-43e2-8fff-e662f6b42c93.png", id = "74724772-7de1-43e2-8fff-e662f6b42c93", name = "新角色", styleType = nil, url = "https://creation.codemao.cn/922/user-files/Ftw4pVFIwB02SSxDJqk4O0CcCLRo.svg" }, ["7743572e-8c15-4740-81f4-459c76a83e29"] = { adaption = nil, center = nil, file = "assets/7743572e-8c15-4740-81f4-459c76a83e29.png", id = "7743572e-8c15-4740-81f4-459c76a83e29", name = "矩形 2@1x (3)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY1Mjc0NDAwMDAwX0ZqTDFIUGJOWVR0bV9FdGNucVdSZzNYY09GRTM=.png" }, ["77c152ec-bf4f-444d-b1fc-2f937f9d2e3e"] = { adaption = nil, center = nil, file = "assets/77c152ec-bf4f-444d-b1fc-2f937f9d2e3e.jpeg", id = "77c152ec-bf4f-444d-b1fc-2f937f9d2e3e", name = "a364d7b182b71a43bef66816ec5e21307d1d24fa3", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzcyNDM0ODAwMDAwX0Zud3JxTE5EOVpmbWNKRWR5Y0d2OGVXMkVxd0I=.jpeg" }, ["785d3a15-9031-43fa-9169-a60919e48083"] = { adaption = nil, center = nil, file = "assets/785d3a15-9031-43fa-9169-a60919e48083.png", id = "785d3a15-9031-43fa-9169-a60919e48083", name = "涟漪", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI5NDUzNjYwNF8xNzY0NzUyNDAwMDAwX0Z0R1JIZlUzdEQ1a2RvLTNGZWhUSUlYUDJ2Mmc=.png" }, ["7887e5c7-b82d-4015-8d18-0642ed13fe0e"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/7887e5c7-b82d-4015-8d18-0642ed13fe0e.png", id = "7887e5c7-b82d-4015-8d18-0642ed13fe0e", name = "新角色", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FoNdmUVyuq_xnml3QhGztKW7s2cI.svg" }, ["78a4cb0d-cfbd-4d45-b7f9-ab73b887c64b"] = { adaption = nil, center = nil, file = "assets/78a4cb0d-cfbd-4d45-b7f9-ab73b887c64b.png", id = "78a4cb0d-cfbd-4d45-b7f9-ab73b887c64b", name = "幻灯片 16_9 - 10@1x", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc1MDIzMjAwMDAwX0ZoUFc0WWV3Y3lCOHF1enRSem1jQ3RwLVZ6a1c=.png" }, ["7aa4f597-7728-4ecc-af94-60641a438c9a"] = { adaption = nil, center = nil, file = "assets/7aa4f597-7728-4ecc-af94-60641a438c9a.jpeg", id = "7aa4f597-7728-4ecc-af94-60641a438c9a", name = "56bafa53c974f4c60dc258dd42c8f1e9df278490", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5NTU3NjAwMDAwX0ZvQnVJS0hBUk5GUHhWLWNtS3EtSC1jNGc0SEY=.jpeg" }, ["7cec3c63-d0be-46ee-8a8e-2f15b0c73072"] = { adaption = nil, center = nil, file = "assets/7cec3c63-d0be-46ee-8a8e-2f15b0c73072.png", id = "7cec3c63-d0be-46ee-8a8e-2f15b0c73072", name = "涟漪", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI5NDUzNjYwNF8xNzY0NzUyNDAwMDAwX0ZwTWR0a0RrUmtyRDVMZDFhdUUzTWJLUS1fLTk=.png" }, ["7cf3b4c3-0ee6-4a77-b424-892c6d870a9a"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/7cf3b4c3-0ee6-4a77-b424-892c6d870a9a.png", id = "7cf3b4c3-0ee6-4a77-b424-892c6d870a9a", name = "难度", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FmCh8Y1DG4VVCoeg66l_hMDGXG9x.svg" }, ["7d76ca87-85d6-4904-a974-1c95f5d24ace"] = { adaption = nil, center = nil, file = "assets/7d76ca87-85d6-4904-a974-1c95f5d24ace.png", id = "7d76ca87-85d6-4904-a974-1c95f5d24ace", name = "涟漪", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI5NDUzNjYwNF8xNzY0NzUyNDAwMDAwX0ZsS3RuMGFCOW9sODAtODNyRy1BOUxoM3RVYmU=.png" }, ["7f1f7ebb-5ff4-418d-85ab-1441dfc61232"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/7f1f7ebb-5ff4-418d-85ab-1441dfc61232.png", id = "7f1f7ebb-5ff4-418d-85ab-1441dfc61232", name = "分2", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FgyFf14et832tcoy_rVsySfSSwb1.svg" }, ["7f5f9233-2e0e-4933-baa2-2bb28ab0f3e1"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/7f5f9233-2e0e-4933-baa2-2bb28ab0f3e1.png", id = "7f5f9233-2e0e-4933-baa2-2bb28ab0f3e1", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["80a76146-d246-40c1-91e4-166097699ce0"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/80a76146-d246-40c1-91e4-166097699ce0.png", id = "80a76146-d246-40c1-91e4-166097699ce0", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["815fab65-8f15-485d-b630-033fa15f7d80"] = { adaption = nil, center = nil, file = "assets/815fab65-8f15-485d-b630-033fa15f7d80.png", id = "815fab65-8f15-485d-b630-033fa15f7d80", name = "幻灯片 16_9 - 14@1x (1)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzg4NjUyODAwMDAwX0ZzMjdOdjJyYTdFWDlSeTJXVm95aGVnRTEzU0g=.png" }, ["83cdd33f-1bb8-4955-a34c-d4e91eb8d4c0"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/83cdd33f-1bb8-4955-a34c-d4e91eb8d4c0.png", id = "83cdd33f-1bb8-4955-a34c-d4e91eb8d4c0", name = "combo1", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FvCuELJ0HCh_bcSUFHchLTcG6VWU.svg" }, ["83df6964-0c5e-4bb9-96ac-f962334772e2"] = { adaption = nil, center = nil, file = "assets/83df6964-0c5e-4bb9-96ac-f962334772e2.jpeg", id = "83df6964-0c5e-4bb9-96ac-f962334772e2", name = "asdsadsadsadasd3", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5NjYyMDAwMDAwX0ZySUMxZ0w4RnFjYzhkVEdBc0pVWGhvOFJXUlQ=.jpeg" }, ["842c948d-37fb-47cd-aaec-828b00d19266"] = { adaption = nil, center = nil, file = "assets/842c948d-37fb-47cd-aaec-828b00d19266.png", id = "842c948d-37fb-47cd-aaec-828b00d19266", name = "按钮 Light@1x (6)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY0NzUyNDAwMDAwX0ZpaVJ6bzBwdEM4UUtsNTZ4Y1ZKM1FQbVFqNXE=.png" }, ["852839ee-2332-46d1-8d85-697156627af3"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/852839ee-2332-46d1-8d85-697156627af3.png", id = "852839ee-2332-46d1-8d85-697156627af3", name = "连击系列", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["85b248af-465a-45d0-b0b7-76936c71d1d9"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/85b248af-465a-45d0-b0b7-76936c71d1d9.png", id = "85b248af-465a-45d0-b0b7-76936c71d1d9", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["85cd5323-b7f7-433c-a69c-e5c4d1a4c3d2"] = { adaption = nil, center = nil, file = "assets/85cd5323-b7f7-433c-a69c-e5c4d1a4c3d2.jpeg", id = "85cd5323-b7f7-433c-a69c-e5c4d1a4c3d2", name = "90aa2fb1a20f53fb8d5616e6e2d51898d54f1168", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU3MTM0ODAwMDAwX0ZsQ1A4X3JORndjSkYxSE9BaUxSdXFjb3NZdmk=.jpeg" }, ["86523ec6-7126-409a-888f-3edee01dfae6"] = { adaption = nil, center = nil, file = "assets/86523ec6-7126-409a-888f-3edee01dfae6.jpeg", id = "86523ec6-7126-409a-888f-3edee01dfae6", name = "4db7e5d286deea0d48a00382b482c9af155f5569", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0ZrVDd5WTJTajdZS3U0blp1M2hHV3hGWUpWczY=.jpeg" }, ["8677f17a-c57c-47b7-9d42-d9555e2c49ba"] = { adaption = 0, center = { x = 0, y = 0 }, file = "assets/8677f17a-c57c-47b7-9d42-d9555e2c49ba.png", id = "8677f17a-c57c-47b7-9d42-d9555e2c49ba", name = "背景", styleType = nil, url = "https://creation.codemao.cn/922/user-files/Fmhbtb2pZeqGYLePbx7Mu-Ar0Sih.svg" }, ["8719c089-c5ba-4ebb-aca9-b0e6e90e3ed2"] = { adaption = nil, center = nil, file = "assets/8719c089-c5ba-4ebb-aca9-b0e6e90e3ed2.png", id = "8719c089-c5ba-4ebb-aca9-b0e6e90e3ed2", name = "newlogo@1x (4)1", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc4NDE0NDAwMDAwX0Z0LW53VEdyVnZPNDFsSE9iWTU2QVQtNU11dzE=.png" }, ["882a5555-9167-4bca-8e81-04d8fe3a1390"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/882a5555-9167-4bca-8e81-04d8fe3a1390.png", id = "882a5555-9167-4bca-8e81-04d8fe3a1390", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["88f601a2-53aa-44e2-9037-8b211da25224"] = { adaption = nil, center = nil, file = "assets/88f601a2-53aa-44e2-9037-8b211da25224.jpeg", id = "88f601a2-53aa-44e2-9037-8b211da25224", name = "56bafa53c974f4c60dc258dd42c8f1e9df278491", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5NTU3NjAwMDAwX0ZvQnVJS0hBUk5GUHhWLWNtS3EtSC1jNGc0SEY=.jpeg" }, ["894f2cf0-22da-4867-b202-542006575764"] = { adaption = nil, center = nil, file = "assets/894f2cf0-22da-4867-b202-542006575764.png", id = "894f2cf0-22da-4867-b202-542006575764", name = "幻灯片 16_9 - 4@1x", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYyNTYwMDAwMDAwX0ZsVzhuMnYxd2M1U2pvWGc5bjhLMnBpSGthVFE=.png" }, ["89fbb360-2ae8-41dc-9e19-e910a90e0ea0"] = { adaption = nil, center = nil, file = "assets/89fbb360-2ae8-41dc-9e19-e910a90e0ea0.jpeg", id = "89fbb360-2ae8-41dc-9e19-e910a90e0ea0", name = "04e40ffb1696b9d5f22d846c076647f32e327d96", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY1ODc5MjAwMDAwX0ZzWHhsVFBVa3dBSWZKenhaVjdhUWN5TTZrLWQ=.jpeg" }, ["8d6a59ab-e8c0-4543-9d5c-3549a4a2a206"] = { adaption = nil, center = nil, file = "assets/8d6a59ab-e8c0-4543-9d5c-3549a4a2a206.jpeg", id = "8d6a59ab-e8c0-4543-9d5c-3549a4a2a206", name = "fd885be84d32fbfa4328a59cb40cb47034ec18e7", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0ZvTmJBRENUcjZnVkpFbTM0UmhyekFqc2FEd1I=.jpeg" }, ["8d8513fb-5031-45f2-8e5f-69f11e11507f"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/8d8513fb-5031-45f2-8e5f-69f11e11507f.png", id = "8d8513fb-5031-45f2-8e5f-69f11e11507f", name = "2", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["8e774f91-4595-4be3-82bd-9d529624bc3a"] = { adaption = nil, center = nil, file = "assets/8e774f91-4595-4be3-82bd-9d529624bc3a.jpeg", id = "8e774f91-4595-4be3-82bd-9d529624bc3a", name = "18e20f809318dfcd0901f29dedc606ee51b2f7ee3", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYyNjgyNDAwMDAwX0ZrMFlrME02SDBXcDJTVVlLMUc0T2JuR0txQUw=.jpeg" }, ["8ec28a0a-5402-4814-8506-ff184edf105c"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/8ec28a0a-5402-4814-8506-ff184edf105c.png", id = "8ec28a0a-5402-4814-8506-ff184edf105c", name = "新角色1", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FnkO9R7krmetfl4bG6kNuAB4fUX5.svg" }, ["91448eca-2c59-4faf-9c58-27d4cbaa5be1"] = { adaption = nil, center = nil, file = "assets/91448eca-2c59-4faf-9c58-27d4cbaa5be1.jpeg", id = "91448eca-2c59-4faf-9c58-27d4cbaa5be1", name = "109951166593375789", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5NzI2ODAwMDAwX0ZxUVg4NmNRUlU4b2J2NE41RlpxNmxlSjRkTFM=.jpeg" }, ["91e20e1b-be58-491c-97f4-6adb57e213bc"] = { adaption = nil, center = nil, file = "assets/91e20e1b-be58-491c-97f4-6adb57e213bc.jpeg", id = "91e20e1b-be58-491c-97f4-6adb57e213bc", name = "e3e43ede3d0d379f294a3bfc4a8730e07047da8b1", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0Z1NlJqMmRGbEpqNXI5eEFoZXViS0ZOdVBBY3Y=.jpeg" }, ["9203e66a-6193-42a7-880a-965e706fe04d"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/9203e66a-6193-42a7-880a-965e706fe04d.png", id = "9203e66a-6193-42a7-880a-965e706fe04d", name = "总系列", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["920e1447-9465-4696-85ad-b102d4506535"] = { adaption = nil, center = nil, file = "assets/920e1447-9465-4696-85ad-b102d4506535.png", id = "920e1447-9465-4696-85ad-b102d4506535", name = "幻灯片 16_9 - 1@1x (4)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYxNTY2NDAwMDAwX0Z1NEVCemNiaE1uUHo5bVZkNnE4TW5IVi1VTm4=.png" }, ["932dae01-e670-4d1a-af00-4e092d23e582"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/932dae01-e670-4d1a-af00-4e092d23e582.png", id = "932dae01-e670-4d1a-af00-4e092d23e582", name = "新角色", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FpyJFaXxPXn11mJJqp2r5f1hetxN.svg" }, ["9501ff15-6e50-4f13-aca1-be2d7b69f2fe"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/9501ff15-6e50-4f13-aca1-be2d7b69f2fe.png", id = "9501ff15-6e50-4f13-aca1-be2d7b69f2fe", name = "歌词", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["9512c24d-5034-4d27-a98e-4991a2be27ba"] = { adaption = nil, center = nil, file = "assets/9512c24d-5034-4d27-a98e-4991a2be27ba.jpeg", id = "9512c24d-5034-4d27-a98e-4991a2be27ba", name = "fb92c3e699a1128af0c8199888fb39afda985cd3", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY0NjY5NjAwMDAwX0ZqcWhqYVRQdWJ3R3FJbmROMk9oNU5nUmhhR0c=.jpeg" }, ["97580ddf-38a5-40bb-9f6b-3d8adf9a7f89"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/97580ddf-38a5-40bb-9f6b-3d8adf9a7f89.png", id = "97580ddf-38a5-40bb-9f6b-3d8adf9a7f89", name = "组 1@035x (4)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/Fv73onyMLoO6J7hTwHPWBoaB-ied.png" }, ["97605d6c-0902-4e83-adb9-d9a733ab0465"] = { adaption = nil, center = nil, file = "assets/97605d6c-0902-4e83-adb9-d9a733ab0465.jpeg", id = "97605d6c-0902-4e83-adb9-d9a733ab0465", name = "Insanae3", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0ZxRG5FTHRPNEhSeWNPajZVQndRd2JCZDV1Um4=.jpeg" }, ["99a0082e-2c02-48ff-b5ca-e954c000461e"] = { adaption = nil, center = nil, file = "assets/99a0082e-2c02-48ff-b5ca-e954c000461e.png", id = "99a0082e-2c02-48ff-b5ca-e954c000461e", name = "静音@1x (1)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY1MzcxNjAwMDAwX0ZyRWpZVWRCemQtOXlnU1NQR3VzSjBvUG84bjI=.png" }, ["9ac44982-7d8f-444c-8aef-7c40ed478a7a"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/9ac44982-7d8f-444c-8aef-7c40ed478a7a.png", id = "9ac44982-7d8f-444c-8aef-7c40ed478a7a", name = "评级1", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["9cc4569a-51ac-40bf-8192-d51e9bef3b6b"] = { adaption = nil, center = nil, file = "assets/9cc4569a-51ac-40bf-8192-d51e9bef3b6b.png", id = "9cc4569a-51ac-40bf-8192-d51e9bef3b6b", name = "涟漪", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI5NDUzNjYwNF8xNzY0NzUyNDAwMDAwX0ZpLTZyZGVhblJJRllSb0R6QXRUU2F3T01FaW4=.png" }, ["9dc7a841-14f8-418a-9f23-75e065684152"] = { adaption = nil, center = nil, file = "assets/9dc7a841-14f8-418a-9f23-75e065684152.png", id = "9dc7a841-14f8-418a-9f23-75e065684152", name = "排行榜@1x", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYyNTIwNDAwMDAwX0ZnY2gwTGF0ZGxvREFKTDFkRUZzNFNVbE1lVEQ=.png" }, ["9f5d9b09-a6ee-4967-9783-603d5a0a09f4"] = { adaption = nil, center = nil, file = "assets/9f5d9b09-a6ee-4967-9783-603d5a0a09f4.png", id = "9f5d9b09-a6ee-4967-9783-603d5a0a09f4", name = "HUD (2)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc4MTE5MjAwMDAwX0ZqYWZqN0RQRG1DMUp6dldPNUhqZGVTR3NqaXY=.png" }, ["9f66924f-f5ec-411f-9b5d-1e554a5db438"] = { adaption = nil, center = nil, file = "assets/9f66924f-f5ec-411f-9b5d-1e554a5db438.jpeg", id = "9f66924f-f5ec-411f-9b5d-1e554a5db438", name = "109951169154205062", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYwMjY2ODAwMDAwX0ZtaUNMTEN4dmwyVFM0d0ctd1d0aGZhREFYSjk=.jpeg" }, ["9f73c76f-99cd-4223-8556-12a2c8274718"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/9f73c76f-99cd-4223-8556-12a2c8274718.png", id = "9f73c76f-99cd-4223-8556-12a2c8274718", name = "手写计时器", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMzM0OTM3OF8yOTcyMzk5MTlfMTc2NjIyMTIwMDAwMF9GbE5FT21qVzA0OUY1RDYyeG43OG5YWkFtcFVN.svg" }, ["a1647f02-34d2-41de-bee6-918a8ea3f005"] = { adaption = nil, center = nil, file = "assets/a1647f02-34d2-41de-bee6-918a8ea3f005.jpeg", id = "a1647f02-34d2-41de-bee6-918a8ea3f005", name = "ad3d2076840545e82ad3707668b934c5c71733f11", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc4OTA0MDAwMDAwX0ZoSy1RWHFKSEV6eERiLTJPSEQ0YVJydTNNLXQ=.jpeg" }, ["a1667b8d-702f-4dbc-bc38-c996c027ef72"] = { adaption = nil, center = nil, file = "assets/a1667b8d-702f-4dbc-bc38-c996c027ef72.png", id = "a1667b8d-702f-4dbc-bc38-c996c027ef72", name = "涟漪", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI5NDUzNjYwNF8xNzY0NzUyNDAwMDAwX0ZyVlN5azNNZG1HSld0TzJEZE13YVJ2b3Y2c2U=.png" }, ["a1e87e3a-b552-4ece-afbd-f74faf1d249f"] = { adaption = nil, center = nil, file = "assets/a1e87e3a-b552-4ece-afbd-f74faf1d249f.jpeg", id = "a1e87e3a-b552-4ece-afbd-f74faf1d249f", name = "56bafa53c974f4c60dc258dd42c8f1e9df278489", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5NTU3NjAwMDAwX0ZvQnVJS0hBUk5GUHhWLWNtS3EtSC1jNGc0SEY=.jpeg" }, ["a235566d-a70b-42ec-aac5-b320391aae9b"] = { adaption = nil, center = nil, file = "assets/a235566d-a70b-42ec-aac5-b320391aae9b.png", id = "a235566d-a70b-42ec-aac5-b320391aae9b", name = "矩形 60", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5NTcyMDAwMDAwX0ZtbzFVOGFON2g5Z3RzTEZFM2hmeU1QbzNqWDc=.png" }, ["a5cbd064-d8e0-4a4e-b974-a2c7419f6cf4"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/a5cbd064-d8e0-4a4e-b974-a2c7419f6cf4.png", id = "a5cbd064-d8e0-4a4e-b974-a2c7419f6cf4", name = "FPS", styleType = nil, url = "https://static.codemao.cn/neko/painter/img/emptyFrame.png" }, ["a5f335cb-90bd-441d-a6cb-9e575d591dae"] = { adaption = nil, center = nil, file = "assets/a5f335cb-90bd-441d-a6cb-9e575d591dae.jpeg", id = "a5f335cb-90bd-441d-a6cb-9e575d591dae", name = "7a880427d016d72d58be3923dd8c33a0c81b839b2", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYyNTIwNDAwMDAwX0ZwOUpXeXdPUVlnbzlSMG92ZF9PUjB0S185ZVo=.jpeg" }, ["a74b5276-ad9b-42d9-b222-d64285b20d87"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/a74b5276-ad9b-42d9-b222-d64285b20d87.png", id = "a74b5276-ad9b-42d9-b222-d64285b20d87", name = "遮罩", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0Zrb1dtZ0RLTmJOZHM2dEpKVUxQbVNYbFE0Z04=.svg" }, ["a7a215e7-e1e2-4c45-829a-1162d1354e84"] = { adaption = nil, center = nil, file = "assets/a7a215e7-e1e2-4c45-829a-1162d1354e84.png", id = "a7a215e7-e1e2-4c45-829a-1162d1354e84", name = "Adobe", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI4OTk4ODU4MV8xNzYyMjQ2ODAwMDAwX0ZxWVg0NW9PTWhiclFYSDNGbVJfa0ZYU2ZEWTQ=.png" }, ["a8a269f4-4350-456f-b81c-0f2ae92d6b41"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/a8a269f4-4350-456f-b81c-0f2ae92d6b41.png", id = "a8a269f4-4350-456f-b81c-0f2ae92d6b41", name = "now", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/Fv73onyMLoO6J7hTwHPWBoaB-ied.png" }, ["aaf1fd55-a58f-4ab8-9072-3dcd3ecbe71d"] = { adaption = nil, center = nil, file = "assets/aaf1fd55-a58f-4ab8-9072-3dcd3ecbe71d.jpeg", id = "aaf1fd55-a58f-4ab8-9072-3dcd3ecbe71d", name = "d6f15b167abda579f2a9fafb94f7ba451618ae69", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY1NTk0ODAwMDAwX0ZqcDZ0NmROdnpVbUtVWkxTclNDdW1NdWpTSW4=.jpeg" }, ["ab52dbc8-7de9-4ce7-ac99-c48b9f580fd8"] = { adaption = nil, center = nil, file = "assets/ab52dbc8-7de9-4ce7-ac99-c48b9f580fd8.png", id = "ab52dbc8-7de9-4ce7-ac99-c48b9f580fd8", name = "GW1", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY2OTk4ODAwMDAwX0ZsOEI5Ui14dUtzOG1Xbm1nVzB1dDlhTmlJb0E=.png" }, ["ad2a9575-bc6e-45b9-920a-125d97b3a8b1"] = { adaption = nil, center = nil, file = "assets/ad2a9575-bc6e-45b9-920a-125d97b3a8b1.png", id = "ad2a9575-bc6e-45b9-920a-125d97b3a8b1", name = "开始游戏@05x", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5NTcyMDAwMDAwX0ZsV0t0NzJoY082dWlhVnQ2Sy04QlJsZV9QMFk=.png" }, ["b1c5516d-2ac3-451b-9ee8-f1aa81a53cc0"] = { adaption = nil, center = nil, file = "assets/b1c5516d-2ac3-451b-9ee8-f1aa81a53cc0.jpeg", id = "b1c5516d-2ac3-451b-9ee8-f1aa81a53cc0", name = "fb92c3e699a1128af0c8199888fb39afda985cd4", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY0NjY5NjAwMDAwX0ZqcWhqYVRQdWJ3R3FJbmROMk9oNU5nUmhhR0c=.jpeg" }, ["b25ce7bc-9127-411e-87c0-94c1a7043c99"] = { adaption = nil, center = nil, file = "assets/b25ce7bc-9127-411e-87c0-94c1a7043c99.jpeg", id = "b25ce7bc-9127-411e-87c0-94c1a7043c99", name = "18e20f809318dfcd0901f29dedc606ee51b2f7ee", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYyNjgyNDAwMDAwX0ZrMFlrME02SDBXcDJTVVlLMUc0T2JuR0txQUw=.jpeg" }, ["b2cc3d5d-e17e-43ed-89c8-ddb27953a384"] = { adaption = nil, center = nil, file = "assets/b2cc3d5d-e17e-43ed-89c8-ddb27953a384.png", id = "b2cc3d5d-e17e-43ed-89c8-ddb27953a384", name = "幻灯片 16_9 - 6@1x (1)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY0NjY5NjAwMDAwX0ZqbTA2aURnbmtaeEEtVFpqekpVM1ZVNktkak4=.png" }, ["b5741627-1761-4871-8b74-0c066d7a1286"] = { adaption = nil, center = nil, file = "assets/b5741627-1761-4871-8b74-0c066d7a1286.png", id = "b5741627-1761-4871-8b74-0c066d7a1286", name = "HUD (1)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc4MTE5MjAwMDAwX0ZuSGUyeHNVbTBnNmNMZWgzYUJmbzFRMkJZUWE=.png" }, ["b6ec3861-85e8-446a-9326-ca4d476e3066"] = { adaption = nil, center = nil, file = "assets/b6ec3861-85e8-446a-9326-ca4d476e3066.jpeg", id = "b6ec3861-85e8-446a-9326-ca4d476e3066", name = "109951166593375786", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5NzI2ODAwMDAwX0ZxUVg4NmNRUlU4b2J2NE41RlpxNmxlSjRkTFM=.jpeg" }, ["b7a798d7-abfb-4cdb-9b89-1d1fed555119"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/b7a798d7-abfb-4cdb-9b89-1d1fed555119.png", id = "b7a798d7-abfb-4cdb-9b89-1d1fed555119", name = "评级", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["b7f1480a-f9d8-44ee-a7d0-4fd9ad505e08"] = { adaption = nil, center = nil, file = "assets/b7f1480a-f9d8-44ee-a7d0-4fd9ad505e08.jpeg", id = "b7f1480a-f9d8-44ee-a7d0-4fd9ad505e08", name = "ad3d2076840545e82ad3707668b934c5c71733f12", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc4OTA0MDAwMDAwX0ZoSy1RWHFKSEV6eERiLTJPSEQ0YVJydTNNLXQ=.jpeg" }, ["b8a83725-c96e-4770-9328-76a60d994c86"] = { adaption = nil, center = nil, file = "assets/b8a83725-c96e-4770-9328-76a60d994c86.jpeg", id = "b8a83725-c96e-4770-9328-76a60d994c86", name = "04e40ffb1696b9d5f22d846c076647f32e327d97", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY1ODc5MjAwMDAwX0ZzWHhsVFBVa3dBSWZKenhaVjdhUWN5TTZrLWQ=.jpeg" }, ["ba500e67-a12d-439b-bf90-3dc135fa4cd0"] = { adaption = nil, center = nil, file = "assets/ba500e67-a12d-439b-bf90-3dc135fa4cd0.jpeg", id = "ba500e67-a12d-439b-bf90-3dc135fa4cd0", name = "c2f96caea62bd65ce6fcdd597fdd720e6cef6434", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzg4NTgwODAwMDAwX0Z1dW4xaTY0QnowUkZXelZYUFFLeHJ1SUlhNzc=.jpeg" }, ["ba8d24e9-cd47-468b-bb66-4ce6f306f751"] = { adaption = nil, center = nil, file = "assets/ba8d24e9-cd47-468b-bb66-4ce6f306f751.png", id = "ba8d24e9-cd47-468b-bb66-4ce6f306f751", name = "设置0", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5NTcyMDAwMDAwX0ZuSVpFVlNvOUxoVWNoTVJDaDB1QkJoa0IxOHk=.png" }, ["bb08b5d4-17f3-4456-8d62-fffc3190fc91"] = { adaption = nil, center = nil, file = "assets/bb08b5d4-17f3-4456-8d62-fffc3190fc91.jpeg", id = "bb08b5d4-17f3-4456-8d62-fffc3190fc91", name = "a364d7b182b71a43bef66816ec5e21307d1d24fa1", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzcyNDM0ODAwMDAwX0Zud3JxTE5EOVpmbWNKRWR5Y0d2OGVXMkVxd0I=.jpeg" }, ["bb362228-7ff0-4129-b0ff-892d9d2ce0f2"] = { adaption = nil, center = nil, file = "assets/bb362228-7ff0-4129-b0ff-892d9d2ce0f2.png", id = "bb362228-7ff0-4129-b0ff-892d9d2ce0f2", name = "image2", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY3MDAyNDAwMDAwX0ZzdnFhNHFaYW44YjJHLTZDSlJYV2x5aTdsUnE=.png" }, ["bb440b68-39c4-4df8-a6e7-d8e265556576"] = { adaption = nil, center = nil, file = "assets/bb440b68-39c4-4df8-a6e7-d8e265556576.png", id = "bb440b68-39c4-4df8-a6e7-d8e265556576", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/c364f36a8dcf42d1a6acbe26c7eb6aaa.png" }, ["bbb87ffd-caf9-4ff8-82f9-a6421b236ca5"] = { adaption = nil, center = nil, file = "assets/bbb87ffd-caf9-4ff8-82f9-a6421b236ca5.jpeg", id = "bbb87ffd-caf9-4ff8-82f9-a6421b236ca5", name = "02dae0d6f830ade998a29b3a567e0d8a7f158206", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0ZpSEF0MkludHFyUUZ4U2pDdTNwWnhoMUo2LVY=.jpeg" }, ["c00a15ef-003b-4151-8db9-01ebccbc0dcc"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/c00a15ef-003b-4151-8db9-01ebccbc0dcc.png", id = "c00a15ef-003b-4151-8db9-01ebccbc0dcc", name = "新角色", styleType = nil, url = "https://creation.codemao.cn/922/user-files/Fv1pWmSJVWHRFG9cC39BDOkGopLn.svg" }, ["c0d4515b-e962-48cf-b7e1-a71fd38e51e1"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/c0d4515b-e962-48cf-b7e1-a71fd38e51e1.png", id = "c0d4515b-e962-48cf-b7e1-a71fd38e51e1", name = "分", styleType = nil, url = "https://creation.codemao.cn/922/user-files/Fpptp9SADyOkGRbH7z7lkQ2jBUlk.svg" }, ["c0db503c-2321-4623-9eb9-ed724acc033c"] = { adaption = nil, center = nil, file = "assets/c0db503c-2321-4623-9eb9-ed724acc033c.png", id = "c0db503c-2321-4623-9eb9-ed724acc033c", name = "幻灯片 16_9 - 13@1x", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzgxNDg1MjAwMDAwX0ZwVTVzT3I0bHdaRFlfVHJvWlRZM0VxVUxVSEw=.png" }, ["c19a023a-f966-4f49-8cb7-a7ec836168a7"] = { adaption = nil, center = nil, file = "assets/c19a023a-f966-4f49-8cb7-a7ec836168a7.png", id = "c19a023a-f966-4f49-8cb7-a7ec836168a7", name = "幻灯片 16_9 - 9@1x", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzcyNDM4NDAwMDAwX0ZsY0RVZS1NdGtEZm1aQ2laeENBWDNmM1VIOVU=.png" }, ["c2413218-a94e-4dc7-aed4-5644d902d292"] = { adaption = nil, center = nil, file = "assets/c2413218-a94e-4dc7-aed4-5644d902d292.png", id = "c2413218-a94e-4dc7-aed4-5644d902d292", name = "幻灯片 16_9 - 12@1x", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc4OTA0MDAwMDAwX0ZqWDdfYzUtWmtwbXVvcUlfWnNFYWRnVmxCN2c=.png" }, ["c35723a7-c232-4db1-a591-531f139bbd3f"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/c35723a7-c232-4db1-a591-531f139bbd3f.png", id = "c35723a7-c232-4db1-a591-531f139bbd3f", name = "通知", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FkPTuGhzQfRuDyTaaa_QvteD0L3b.svg" }, ["c39e18ac-93d5-4ddd-8085-b60958e88306"] = { adaption = nil, center = nil, file = "assets/c39e18ac-93d5-4ddd-8085-b60958e88306.jpeg", id = "c39e18ac-93d5-4ddd-8085-b60958e88306", name = "c830536db65292d85161df12b54090522ddb1976", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc3NzAxNjAwMDAwX0ZyNTVjVDd2bG1jWXFydktTUVhhaEdYZktzS3E=.jpeg" }, ["c3bd36cb-5373-4459-b85a-ba1e205abf22"] = { adaption = nil, center = nil, file = "assets/c3bd36cb-5373-4459-b85a-ba1e205abf22.png", id = "c3bd36cb-5373-4459-b85a-ba1e205abf22", name = "组 1 (1)@1x@1x", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYzMTc5MjAwMDAwX0Z1eDM2VEhtSUp4QV8xS0lZT0dtYkxFQXlHNnA=.png" }, ["c3efc622-4180-4ba1-b634-b5096b721d83"] = { adaption = nil, center = nil, file = "assets/c3efc622-4180-4ba1-b634-b5096b721d83.jpeg", id = "c3efc622-4180-4ba1-b634-b5096b721d83", name = "d6f15b167abda579f2a9fafb94f7ba451618ae71", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY1NTk0ODAwMDAwX0ZqcDZ0NmROdnpVbUtVWkxTclNDdW1NdWpTSW4=.jpeg" }, ["c4cd5de6-f7a9-451b-a0b4-34bd78f63388"] = { adaption = nil, center = nil, file = "assets/c4cd5de6-f7a9-451b-a0b4-34bd78f63388.png", id = "c4cd5de6-f7a9-451b-a0b4-34bd78f63388", name = "矩形 2@1x (4)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY1Mjc0NDAwMDAwX0Znemt0MGtuMjhPWVlXb2Z4bEVvaEMtZ0ZKYVE=.png" }, ["c4ce6fce-cc12-40da-84c6-cc4b92037561"] = { adaption = nil, center = nil, file = "assets/c4ce6fce-cc12-40da-84c6-cc4b92037561.png", id = "c4ce6fce-cc12-40da-84c6-cc4b92037561", name = "取消静音@1x (1)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY1MzcxNjAwMDAwX0ZscndiemhzX0tUNVl2RFhObWJqNWxpbVdkMmY=.png" }, ["c58f259c-ad37-47ce-8b87-6633ed1a769f"] = { adaption = nil, center = nil, file = "assets/c58f259c-ad37-47ce-8b87-6633ed1a769f.png", id = "c58f259c-ad37-47ce-8b87-6633ed1a769f", name = "选择曲目0", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5NTcyMDAwMDAwX0ZyVm1IZ3BZWXdrSmdHMmZTWFlqMmNrQXBpdWg=.png" }, ["c72977aa-723a-422a-b048-474d5e2a1300"] = { adaption = nil, center = nil, file = "assets/c72977aa-723a-422a-b048-474d5e2a1300.jpeg", id = "c72977aa-723a-422a-b048-474d5e2a1300", name = "90aa2fb1a20f53fb8d5616e6e2d51898d54f1169", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU3MTM0ODAwMDAwX0ZsQ1A4X3JORndjSkYxSE9BaUxSdXFjb3NZdmk=.jpeg" }, ["c78242a9-7842-42ea-8839-749672b00e23"] = { adaption = nil, center = nil, file = "assets/c78242a9-7842-42ea-8839-749672b00e23.jpeg", id = "c78242a9-7842-42ea-8839-749672b00e23", name = "109951166593375788", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5NzI2ODAwMDAwX0ZxUVg4NmNRUlU4b2J2NE41RlpxNmxlSjRkTFM=.jpeg" }, ["c7ee9f85-110f-476c-a222-1b6cac2a47ec"] = { adaption = nil, center = nil, file = "assets/c7ee9f85-110f-476c-a222-1b6cac2a47ec.jpeg", id = "c7ee9f85-110f-476c-a222-1b6cac2a47ec", name = "c830536db65292d85161df12b54090522ddb1978", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc3NzAxNjAwMDAwX0ZyNTVjVDd2bG1jWXFydktTUVhhaEdYZktzS3E=.jpeg" }, ["c8054aa4-d63f-47fe-a438-e6dbc3b9b65a"] = { adaption = nil, center = nil, file = "assets/c8054aa4-d63f-47fe-a438-e6dbc3b9b65a.jpeg", id = "c8054aa4-d63f-47fe-a438-e6dbc3b9b65a", name = "ad3d2076840545e82ad3707668b934c5c71733f9", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc4OTA0MDAwMDAwX0ZoSy1RWHFKSEV6eERiLTJPSEQ0YVJydTNNLXQ=.jpeg" }, ["c82c953f-4816-48b0-9d54-80b56a5dc22f"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/c82c953f-4816-48b0-9d54-80b56a5dc22f.png", id = "c82c953f-4816-48b0-9d54-80b56a5dc22f", name = "难度打印", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FmCh8Y1DG4VVCoeg66l_hMDGXG9x.svg" }, ["c8d29569-1027-4e12-af27-cfc774794f54"] = { adaption = nil, center = { x = 2.0091824779732e-13, y = 8.5390255313862e-13 }, file = "assets/c8d29569-1027-4e12-af27-cfc774794f54.png", id = "c8d29569-1027-4e12-af27-cfc774794f54", name = "新角色", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FgUBs2g3rgMAr5ltiOtmBmKsWbLI.svg" }, ["c909df51-7479-40f5-97f0-85a62d3af3db"] = { adaption = nil, center = nil, file = "assets/c909df51-7479-40f5-97f0-85a62d3af3db.jpeg", id = "c909df51-7479-40f5-97f0-85a62d3af3db", name = "c2f96caea62bd65ce6fcdd597fdd720e6cef6435", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzg4NTgwODAwMDAwX0Z1dW4xaTY0QnowUkZXelZYUFFLeHJ1SUlhNzc=.jpeg" }, ["c994398d-1253-41c7-b760-ca9ef4db2f70"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/c994398d-1253-41c7-b760-ca9ef4db2f70.png", id = "c994398d-1253-41c7-b760-ca9ef4db2f70", name = "新角色", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FvCuELJ0HCh_bcSUFHchLTcG6VWU.svg" }, ["ca2436b1-1074-4336-b5e8-70cabf68d591"] = { adaption = nil, center = nil, file = "assets/ca2436b1-1074-4336-b5e8-70cabf68d591.jpeg", id = "ca2436b1-1074-4336-b5e8-70cabf68d591", name = "7ce7c78c048992cfe3a2d3c9ce019662ffe264f9", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY1NTk0ODAwMDAwX0ZvRnBTQmhLUFUyZnBGc1ZMUm1CSklydnUwUEI=.jpeg" }, ["cac35bfd-cf61-44ca-8402-8033266e6c04"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/cac35bfd-cf61-44ca-8402-8033266e6c04.png", id = "cac35bfd-cf61-44ca-8402-8033266e6c04", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["cba6799d-981c-46c1-9ab6-f82956001b48"] = { adaption = nil, center = nil, file = "assets/cba6799d-981c-46c1-9ab6-f82956001b48.jpeg", id = "cba6799d-981c-46c1-9ab6-f82956001b48", name = "c830536db65292d85161df12b54090522ddb1977", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc3NzAxNjAwMDAwX0ZyNTVjVDd2bG1jWXFydktTUVhhaEdYZktzS3E=.jpeg" }, ["cda6a9bd-7f48-47cf-8827-e1f533ed3fe3"] = { adaption = nil, center = nil, file = "assets/cda6a9bd-7f48-47cf-8827-e1f533ed3fe3.jpeg", id = "cda6a9bd-7f48-47cf-8827-e1f533ed3fe3", name = "90aa2fb1a20f53fb8d5616e6e2d51898d54f1170", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU3MTM0ODAwMDAwX0ZsQ1A4X3JORndjSkYxSE9BaUxSdXFjb3NZdmk=.jpeg" }, ["ce860baa-eaef-4f4c-9fdf-3762497de5cb"] = { adaption = nil, center = nil, file = "assets/ce860baa-eaef-4f4c-9fdf-3762497de5cb.jpeg", id = "ce860baa-eaef-4f4c-9fdf-3762497de5cb", name = "asdsadsadsadasd1", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5NjYyMDAwMDAwX0ZySUMxZ0w4RnFjYzhkVEdBc0pVWGhvOFJXUlQ=.jpeg" }, ["d1448c60-a1cf-4a64-a004-1db4d39dfa5d"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/d1448c60-a1cf-4a64-a004-1db4d39dfa5d.png", id = "d1448c60-a1cf-4a64-a004-1db4d39dfa5d", name = "新角色", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FvCuELJ0HCh_bcSUFHchLTcG6VWU.svg" }, ["d1f3c340-2de4-43f2-b495-c0f7170c7d4b"] = { adaption = nil, center = nil, file = "assets/d1f3c340-2de4-43f2-b495-c0f7170c7d4b.png", id = "d1f3c340-2de4-43f2-b495-c0f7170c7d4b", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/25593adb06d24d988ada59c1d2131de8.png" }, ["d46f9443-0976-4fff-9339-0ba0635c3a25"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/d46f9443-0976-4fff-9339-0ba0635c3a25.png", id = "d46f9443-0976-4fff-9339-0ba0635c3a25", name = "返回", styleType = nil, url = "https://creation.codemao.cn/922/user-files/Fuz8Qw_hqxJj1tzY1iSXlnIft9dP.svg" }, ["d5dbf1d0-b7c7-492c-949b-989a31345f79"] = { adaption = nil, center = nil, file = "assets/d5dbf1d0-b7c7-492c-949b-989a31345f79.jpeg", id = "d5dbf1d0-b7c7-492c-949b-989a31345f79", name = "fb92c3e699a1128af0c8199888fb39afda985cd1", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY0NjY5NjAwMDAwX0ZqcWhqYVRQdWJ3R3FJbmROMk9oNU5nUmhhR0c=.jpeg" }, ["d6431dfb-856e-4c1d-a7b7-079185b05f05"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/d6431dfb-856e-4c1d-a7b7-079185b05f05.png", id = "d6431dfb-856e-4c1d-a7b7-079185b05f05", name = "曲目", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FmCh8Y1DG4VVCoeg66l_hMDGXG9x.svg" }, ["d6c5734d-d73d-4f5e-8e0c-7dec80890e18"] = { adaption = nil, center = nil, file = "assets/d6c5734d-d73d-4f5e-8e0c-7dec80890e18.png", id = "d6c5734d-d73d-4f5e-8e0c-7dec80890e18", name = "广告", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI4NjkxNjczNl8xNzYwNjA4ODAwMDAwX0ZnNjFRQUprUGduTUlsY2t2d0xoSTlGZWpJbXA=.png" }, ["d7a1f0a5-0cee-40da-b54b-9cfced716e6b"] = { adaption = nil, center = nil, file = "assets/d7a1f0a5-0cee-40da-b54b-9cfced716e6b.jpeg", id = "d7a1f0a5-0cee-40da-b54b-9cfced716e6b", name = "Insanae2", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0ZxRG5FTHRPNEhSeWNPajZVQndRd2JCZDV1Um4=.jpeg" }, ["d980b93e-8b83-4f00-842c-c67b027eed55"] = { adaption = nil, center = nil, file = "assets/d980b93e-8b83-4f00-842c-c67b027eed55.png", id = "d980b93e-8b83-4f00-842c-c67b027eed55", name = "GW", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY2OTk4ODAwMDAwX0ZsOEI5Ui14dUtzOG1Xbm1nVzB1dDlhTmlJb0E=.png" }, ["df3fb28c-e167-444f-b8d1-dc28536f5017"] = { adaption = nil, center = nil, file = "assets/df3fb28c-e167-444f-b8d1-dc28536f5017.png", id = "df3fb28c-e167-444f-b8d1-dc28536f5017", name = "logo1 (3)@1x", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYyNTA5NjAwMDAwX0ZzOTJWTEJuZHpmcDdFQXVrdVFiS1Fxeng1eFo=.png" }, ["dfe5a411-2046-4f8a-a890-e8148cb643e7"] = { adaption = nil, center = nil, file = "assets/dfe5a411-2046-4f8a-a890-e8148cb643e7.png", id = "dfe5a411-2046-4f8a-a890-e8148cb643e7", name = "涟漪", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI5NDUzNjYwNF8xNzY0NzUyNDAwMDAwX0ZxTThtR3FRck0zV0NkQktVMlJORzBEemZPTnY=.png" }, ["e18a0ae0-5c35-425a-962f-b7e87c29308f"] = { adaption = nil, center = nil, file = "assets/e18a0ae0-5c35-425a-962f-b7e87c29308f.png", id = "e18a0ae0-5c35-425a-962f-b7e87c29308f", name = "image", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY2OTk4ODAwMDAwX0ZzdnFhNHFaYW44YjJHLTZDSlJYV2x5aTdsUnE=.png" }, ["e2bb1c9a-4166-4f45-90bd-4a362833b37e"] = { adaption = nil, center = nil, file = "assets/e2bb1c9a-4166-4f45-90bd-4a362833b37e.jpeg", id = "e2bb1c9a-4166-4f45-90bd-4a362833b37e", name = "AgAAEXbO8Zg8v0_iCt9B4JmUTX3qNjnL2", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY3MDAyNDAwMDAwX0ZpZzUtN25EQTdTcnpqM25CeHFMVnVsdTNPdGU=.jpeg" }, ["e3ac7574-449e-4736-8fe9-0776ead09fcb"] = { adaption = nil, center = nil, file = "assets/e3ac7574-449e-4736-8fe9-0776ead09fcb.png", id = "e3ac7574-449e-4736-8fe9-0776ead09fcb", name = "按钮 Light@1x (1)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY0NzUyNDAwMDAwX0ZsMFVXN0ZHa1RSdDNPVHZjX2Z4QjdJY3VDazE=.png" }, ["e4614770-d81a-4ff3-b895-c71a460951cd"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/e4614770-d81a-4ff3-b895-c71a460951cd.png", id = "e4614770-d81a-4ff3-b895-c71a460951cd", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["e5e29f3e-24cb-450f-8095-f3b05048f1c9"] = { adaption = nil, center = nil, file = "assets/e5e29f3e-24cb-450f-8095-f3b05048f1c9.png", id = "e5e29f3e-24cb-450f-8095-f3b05048f1c9", name = "按钮 Light@1x (2)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY0NzUyNDAwMDAwX0ZvcGNPUnRoaFdXWm54MlRCdFFCM3pyU19qcmY=.png" }, ["e791f6b8-4030-492b-93ec-3c39dd7cae9d"] = { adaption = nil, center = nil, file = "assets/e791f6b8-4030-492b-93ec-3c39dd7cae9d.jpeg", id = "e791f6b8-4030-492b-93ec-3c39dd7cae9d", name = "90aa2fb1a20f53fb8d5616e6e2d51898d54f1167", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU3MTM0ODAwMDAwX0ZsQ1A4X3JORndjSkYxSE9BaUxSdXFjb3NZdmk=.jpeg" }, ["e7ecded2-5bd8-4a96-b4cc-bfc72210e88c"] = { adaption = nil, center = nil, file = "assets/e7ecded2-5bd8-4a96-b4cc-bfc72210e88c.jpeg", id = "e7ecded2-5bd8-4a96-b4cc-bfc72210e88c", name = "AgAAEXbO8Zg8v0_iCt9B4JmUTX3qNjnL1", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY2OTk4ODAwMDAwX0ZpZzUtN25EQTdTcnpqM25CeHFMVnVsdTNPdGU=.jpeg" }, ["e7f07667-1e04-44e9-8ce2-792bfd3a1812"] = { adaption = nil, center = nil, file = "assets/e7f07667-1e04-44e9-8ce2-792bfd3a1812.jpeg", id = "e7f07667-1e04-44e9-8ce2-792bfd3a1812", name = "AgAAEXbO8Zg8v0_iCt9B4JmUTX3qNjnL3", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY3MDAyNDAwMDAwX0ZpZzUtN25EQTdTcnpqM25CeHFMVnVsdTNPdGU=.jpeg" }, ["e89e6f1a-f278-48ed-bc5b-2b674b8bb8bb"] = { adaption = nil, center = nil, file = "assets/e89e6f1a-f278-48ed-bc5b-2b674b8bb8bb.png", id = "e89e6f1a-f278-48ed-bc5b-2b674b8bb8bb", name = "背景", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/img_stage_defult_landscape.png" }, ["e8cb357b-4cf4-4db7-bd2a-6f0a0db20852"] = { adaption = nil, center = nil, file = "assets/e8cb357b-4cf4-4db7-bd2a-6f0a0db20852.png", id = "e8cb357b-4cf4-4db7-bd2a-6f0a0db20852", name = "幻灯片 16_9 - 5@1x", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYyNjgyNDAwMDAwX0ZoMnFSWXhyRkU1NnhDWFFrUm5sUm56NzkwZUw=.png" }, ["e9090dec-ece5-48c0-a618-a78f9b3504a4"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/e9090dec-ece5-48c0-a618-a78f9b3504a4.png", id = "e9090dec-ece5-48c0-a618-a78f9b3504a4", name = "手写计时器", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMzM0OTM3OF8yOTcyMzk5MTlfMTc2NjIyMTIwMDAwMF9GbE5FT21qVzA0OUY1RDYyeG43OG5YWkFtcFVN.svg" }, ["e93a9428-addf-439d-af90-7e10c5000403"] = { adaption = nil, center = nil, file = "assets/e93a9428-addf-439d-af90-7e10c5000403.png", id = "e93a9428-addf-439d-af90-7e10c5000403", name = "涟漪", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI5NDUzNjYwNF8xNzY0NzUyNDAwMDAwX0Z1NUxwSVhDTV9tWl95eFdtb3F1Tk93SDVpZk0=.png" }, ["ea506487-99a8-40bd-9f1e-084b0b137b8f"] = { adaption = nil, center = nil, file = "assets/ea506487-99a8-40bd-9f1e-084b0b137b8f.jpeg", id = "ea506487-99a8-40bd-9f1e-084b0b137b8f", name = "709d1cd3f6fd765741e970739b927e985638f91d1", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYwNTIyNDAwMDAwX0ZqZWV2QU44WUpKYmtGQm9QZDYyYjZWV2NRX1I=.jpeg" }, ["eb54fd6a-b383-4501-9671-c42fee46fb2f"] = { adaption = nil, center = nil, file = "assets/eb54fd6a-b383-4501-9671-c42fee46fb2f.png", id = "eb54fd6a-b383-4501-9671-c42fee46fb2f", name = "按钮 Light@1x (4)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY0NzUyNDAwMDAwX0ZtVVpKZERoTkJrajhOZjJINml6OEoyMHJBeWs=.png" }, ["eb89a1bb-ea1f-48f8-944c-2a9bf0f1a1a3"] = { adaption = nil, center = nil, file = "assets/eb89a1bb-ea1f-48f8-944c-2a9bf0f1a1a3.jpeg", id = "eb89a1bb-ea1f-48f8-944c-2a9bf0f1a1a3", name = "7a880427d016d72d58be3923dd8c33a0c81b839b", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYyNTIwNDAwMDAwX0ZwOUpXeXdPUVlnbzlSMG92ZF9PUjB0S185ZVo=.jpeg" }, ["ec7aeaca-87a5-4ded-b749-09a604bf1d66"] = { adaption = nil, center = nil, file = "assets/ec7aeaca-87a5-4ded-b749-09a604bf1d66.png", id = "ec7aeaca-87a5-4ded-b749-09a604bf1d66", name = "矩形 15@1x", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY0NzUyNDAwMDAwX0ZsYUhKRWV0N0JsOG10NW9Dbjhfdkw5cTBnRkw=.png" }, ["edad0177-f2fa-4ea7-a5ee-30e2a12b72fd"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/edad0177-f2fa-4ea7-a5ee-30e2a12b72fd.png", id = "edad0177-f2fa-4ea7-a5ee-30e2a12b72fd", name = "文本", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["ee2187e7-cdab-435b-a2a0-3a67f72a3261"] = { adaption = nil, center = nil, file = "assets/ee2187e7-cdab-435b-a2a0-3a67f72a3261.jpeg", id = "ee2187e7-cdab-435b-a2a0-3a67f72a3261", name = "f663f121d01426c4883f6894ef09006b807e7707", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5ODIwNDAwMDAwX0Z0X1o1M25nOUxncW9WckNhdkZqbDU1a1ZVdXk=.jpeg" }, ["eecc5988-ed47-441b-a113-5050748544b0"] = { adaption = nil, center = nil, file = "assets/eecc5988-ed47-441b-a113-5050748544b0.png", id = "eecc5988-ed47-441b-a113-5050748544b0", name = "按钮 Light@1x (7)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc3NTU0MDAwMDAwX0ZnLU80REVDX2ZQcGhGdEhuQi1rSU5BaHo2RUs=.png" }, ["f008b06d-143e-4725-9e2e-ec8630334214"] = { adaption = nil, center = nil, file = "assets/f008b06d-143e-4725-9e2e-ec8630334214.png", id = "f008b06d-143e-4725-9e2e-ec8630334214", name = "矩形 3@1x (4)", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzYzMTIxNjAwMDAwX0ZnUi1FNnd0bzVfaUF0MWlidk9jTEpzVDVCLXM=.png" }, ["f0be2031-c375-4ac4-ab3d-7b4fe5561583"] = { adaption = nil, center = nil, file = "assets/f0be2031-c375-4ac4-ab3d-7b4fe5561583.png", id = "f0be2031-c375-4ac4-ab3d-7b4fe5561583", name = "GW3", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY3MDAyNDAwMDAwX0ZsOEI5Ui14dUtzOG1Xbm1nVzB1dDlhTmlJb0E=.png" }, ["f0e90b5f-33e6-4370-9942-481a7a566755"] = { adaption = nil, center = nil, file = "assets/f0e90b5f-33e6-4370-9942-481a7a566755.jpeg", id = "f0e90b5f-33e6-4370-9942-481a7a566755", name = "e3e43ede3d0d379f294a3bfc4a8730e07047da8b3", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU2NzIwODAwMDAwX0Z1NlJqMmRGbEpqNXI5eEFoZXViS0ZOdVBBY3Y=.jpeg" }, ["f33c78ab-1d87-4be4-9ffc-b5c26c5b7490"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/f33c78ab-1d87-4be4-9ffc-b5c26c5b7490.png", id = "f33c78ab-1d87-4be4-9ffc-b5c26c5b7490", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc3NTkwMDAwMDAwX0ZvOFhycWJhNUQ0cUVMcHpGUHp0NnVWaDZieHA=.svg" }, ["f348307d-af33-4984-82d8-d1b8a06d3b67"] = { adaption = nil, center = nil, file = "assets/f348307d-af33-4984-82d8-d1b8a06d3b67.png", id = "f348307d-af33-4984-82d8-d1b8a06d3b67", name = "image3", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY3MDAyNDAwMDAwX0ZzdnFhNHFaYW44YjJHLTZDSlJYV2x5aTdsUnE=.png" }, ["f4045fe6-7447-4944-9d8d-53fa485fc125"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/f4045fe6-7447-4944-9d8d-53fa485fc125.png", id = "f4045fe6-7447-4944-9d8d-53fa485fc125", name = "盘子1", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FkYK-X9C5hYNhIJ3IGrt3zVtnoau.svg" }, ["f72377f2-a798-42fc-b1ef-8859ab861d04"] = { adaption = nil, center = nil, file = "assets/f72377f2-a798-42fc-b1ef-8859ab861d04.jpeg", id = "f72377f2-a798-42fc-b1ef-8859ab861d04", name = "04e40ffb1696b9d5f22d846c076647f32e327d99", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY1ODc5MjAwMDAwX0ZzWHhsVFBVa3dBSWZKenhaVjdhUWN5TTZrLWQ=.jpeg" }, ["f8262995-b77d-43a1-88a0-0cc68a6faa5a"] = { adaption = nil, center = nil, file = "assets/f8262995-b77d-43a1-88a0-0cc68a6faa5a.jpeg", id = "f8262995-b77d-43a1-88a0-0cc68a6faa5a", name = "7ce7c78c048992cfe3a2d3c9ce019662ffe264f12", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY1NTk0ODAwMDAwX0ZvRnBTQmhLUFUyZnBGc1ZMUm1CSklydnUwUEI=.jpeg" }, ["f82d96a6-d429-4f8f-a1d2-3db939e2c239"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/f82d96a6-d429-4f8f-a1d2-3db939e2c239.png", id = "f82d96a6-d429-4f8f-a1d2-3db939e2c239", name = "手写计时器", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMzM0OTM3OF8yOTcyMzk5MTlfMTc2NjIyMTIwMDAwMF9GbE5FT21qVzA0OUY1RDYyeG43OG5YWkFtcFVN.svg" }, ["f936de01-4ad4-4357-a87b-3db6120f4eb6"] = { adaption = nil, center = nil, file = "assets/f936de01-4ad4-4357-a87b-3db6120f4eb6.png", id = "f936de01-4ad4-4357-a87b-3db6120f4eb6", name = "心", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI4NzIyMTU0OV8xNzYwNzU2NDAwMDAwX0ZvR1ZqemNPNWExVmZIWVk1VTB5ZGFfYm45bko=.png" }, ["f94c95e5-aa15-4c50-9585-7dee88bccfef"] = { adaption = nil, center = nil, file = "assets/f94c95e5-aa15-4c50-9585-7dee88bccfef.png", id = "f94c95e5-aa15-4c50-9585-7dee88bccfef", name = "幻灯片 16_9 - 14@1x", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzg4NTgwODAwMDAwX0ZxeHVhazZ0X1JGY0Y4ZDV3ckFIbUVmMkxRQng=.png" }, ["f9d75150-c17e-4270-af86-a5901ab13b2e"] = { adaption = nil, center = nil, file = "assets/f9d75150-c17e-4270-af86-a5901ab13b2e.jpeg", id = "f9d75150-c17e-4270-af86-a5901ab13b2e", name = "a364d7b182b71a43bef66816ec5e21307d1d24fa", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzcyNDM0ODAwMDAwX0Zud3JxTE5EOVpmbWNKRWR5Y0d2OGVXMkVxd0I=.jpeg" }, ["fac8e6c6-b927-4a08-8c01-1d1ec7bc8a85"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/fac8e6c6-b927-4a08-8c01-1d1ec7bc8a85.png", id = "fac8e6c6-b927-4a08-8c01-1d1ec7bc8a85", name = "新角色1", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FoNdmUVyuq_xnml3QhGztKW7s2cI.svg" }, ["fafbfc03-d051-41d4-b504-3f4289b51a19"] = { adaption = nil, center = nil, file = "assets/fafbfc03-d051-41d4-b504-3f4289b51a19.png", id = "fafbfc03-d051-41d4-b504-3f4289b51a19", name = "幻灯片 16_9 - 7@1x", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY1NTk0ODAwMDAwX0ZwY2pndGxpaHJPMHNMWHkyaEJ2OGdhdWJPZFc=.png" }, ["fb33c6cc-a23e-4374-be61-fe7d3fd0ef62"] = { adaption = nil, center = nil, file = "assets/fb33c6cc-a23e-4374-be61-fe7d3fd0ef62.png", id = "fb33c6cc-a23e-4374-be61-fe7d3fd0ef62", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/caf8f973dbe240babece35637dcafee8.png" }, ["fd25e56c-a4a9-4d4d-ae6e-c54f6edb45d1"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/fd25e56c-a4a9-4d4d-ae6e-c54f6edb45d1.png", id = "fd25e56c-a4a9-4d4d-ae6e-c54f6edb45d1", name = "通知", styleType = nil, url = "https://creation.codemao.cn/922/user-files/FkPTuGhzQfRuDyTaaa_QvteD0L3b.svg" }, ["fd59d0be-6915-4cea-b210-745edd032427"] = { adaption = nil, center = nil, file = "assets/fd59d0be-6915-4cea-b210-745edd032427.jpeg", id = "fd59d0be-6915-4cea-b210-745edd032427", name = "AgAAEXbO8Zg8v0_iCt9B4JmUTX3qNjnL", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzY2OTk4ODAwMDAwX0ZpZzUtN25EQTdTcnpqM25CeHFMVnVsdTNPdGU=.jpeg" }, ["fe4f3ad5-504c-48de-94d4-a11f6d4b7242"] = { adaption = nil, center = nil, file = "assets/fe4f3ad5-504c-48de-94d4-a11f6d4b7242.png", id = "fe4f3ad5-504c-48de-94d4-a11f6d4b7242", name = "幻灯片 16_9 - 11@1x", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc3NzAxNjAwMDAwX0ZpaV9TeEVnOUswdmdHd0FMUG04aXp6Vkl3V1c=.png" }, ["feb5bab1-f55d-476f-bef9-67128063a9ab"] = { adaption = nil, center = nil, file = "assets/feb5bab1-f55d-476f-bef9-67128063a9ab.jpeg", id = "feb5bab1-f55d-476f-bef9-67128063a9ab", name = "7aa17e01cf42591bded567dffbbb38063fe77289", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzc1MDE5NjAwMDAwX0ZwdVpDcUZzbVkxUlJJbERhcVFyZ1VfMUNBdkQ=.jpeg" }, ["fee55a1e-8cc1-4447-bfd7-805152f9d59e"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/fee55a1e-8cc1-4447-bfd7-805152f9d59e.png", id = "fee55a1e-8cc1-4447-bfd7-805152f9d59e", name = "手写计时器", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMzM0OTM3OF8yOTcyMzk5MTlfMTc2NjIyMTIwMDAwMF9GbE5FT21qVzA0OUY1RDYyeG43OG5YWkFtcFVN.svg" }, ["ff38150f-6d6b-43be-a92a-d66de6057c4a"] = { adaption = nil, center = nil, file = "assets/ff38150f-6d6b-43be-a92a-d66de6057c4a.jpeg", id = "ff38150f-6d6b-43be-a92a-d66de6057c4a", name = "f663f121d01426c4883f6894ef09006b807e7710", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTU3MDkwMzQ3XzI3Mzk4ODM3OV8xNzU5ODIwNDAwMDAwX0Z0X1o1M25nOUxncW9WckNhdkZqbDU1a1ZVdXk=.jpeg" }, ["ffc6afc9-ad4d-41d8-ae69-a7e3359d2a57"] = { adaption = nil, center = nil, file = "assets/ffc6afc9-ad4d-41d8-ae69-a7e3359d2a57.png", id = "ffc6afc9-ad4d-41d8-ae69-a7e3359d2a57", name = "now", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/FrtuGpcm2c9KkTNyoPa9XcfHVOdT.png" } }
M.audios = { ["0ec7a2b9-b251-4f73-99d0-b5bf7dcd1aa1"] = { file = "assets/0ec7a2b9-b251-4f73-99d0-b5bf7dcd1aa1.mp3", id = "0ec7a2b9-b251-4f73-99d0-b5bf7dcd1aa1", name = "obj_wo3DlMOGwrbDjj7DisKw_61842516057_504", url = "https://creation.bcmcdn.com/922/user-files/lmw8kwloylGL_zukAds4Oo5IZ3DP.mp3" }, ["1bc00556-cb31-4b91-a552-712242e0e2b9"] = { file = "assets/1bc00556-cb31-4b91-a552-712242e0e2b9.mp3", id = "1bc00556-cb31-4b91-a552-712242e0e2b9", name = "catch-banana", url = "https://creation.bcmcdn.com/922/user-files/FoaJbC7gXsFbO32ubvHOsEG8qlwL.mp3" }, ["1caba689-7ad2-488a-895b-a576a5df083a"] = { file = "assets/1caba689-7ad2-488a-895b-a576a5df083a.mp3", id = "1caba689-7ad2-488a-895b-a576a5df083a", name = "obj_wo3DlMOGwrbDjj7DisKw_14721630878_822", url = "https://creation.bcmcdn.com/922/user-files/lp2Li3V0BZAnwh-9q5Qb_BXm2YYM.mp3" }, ["21b4a689-e8e8-4b10-b8aa-ab8952d149d5"] = { file = "assets/21b4a689-e8e8-4b10-b8aa-ab8952d149d5.mp3", id = "21b4a689-e8e8-4b10-b8aa-ab8952d149d5", name = "obj_wo3DlMOGwrbDjj7DisKw_76869326268_f12", url = "https://creation.bcmcdn.com/922/user-files/lm0Z4yO9r5RImuAd2tsCB9YgjmV5.mp3" }, ["269d3ce1-a19a-4ff2-b6ca-71d388794d2f"] = { file = "assets/269d3ce1-a19a-4ff2-b6ca-71d388794d2f.mp3", id = "269d3ce1-a19a-4ff2-b6ca-71d388794d2f", name = "obj_wo3DlMOGwrbDjj7DisKw_63736655971_432", url = "https://creation.bcmcdn.com/922/user-files/loRy26qZmncHmZR4CgcLPVga2kU1.mp3" }, ["3292a2b0-6bae-4e2e-813a-fff8f1050661"] = { file = "assets/3292a2b0-6bae-4e2e-813a-fff8f1050661.mp3", id = "3292a2b0-6bae-4e2e-813a-fff8f1050661", name = "obj_wo3DlMOGwrbDjj7DisKw_27248926143_dba", url = "https://creation.bcmcdn.com/922/user-files/lgQAJ7UY1qMZ9MKGC0OLMiAr2765.mp3" }, ["34796d1c-89a8-4148-be2c-50144c75f4fb"] = { file = "assets/34796d1c-89a8-4148-be2c-50144c75f4fb.mp3", id = "34796d1c-89a8-4148-be2c-50144c75f4fb", name = "obj_wo3DlMOGwrbDjj7DisKw_58859796636_c56", url = "https://creation.bcmcdn.com/922/user-files/lm3pV-2eW8HHbWX3rEQCnXt62-dW.mp3" }, ["52c3a1d6-3b66-4b9c-976e-9f13d451b32a"] = { file = "assets/52c3a1d6-3b66-4b9c-976e-9f13d451b32a.mp3", id = "52c3a1d6-3b66-4b9c-976e-9f13d451b32a", name = "545b_060c_025b_c102003bb01f5e60665d5158d", url = "https://creation.bcmcdn.com/922/user-files/lrYUocICl23V-FHHyIn6kAS1h98r.mp3" }, ["5f6ae325-bc60-4eb4-b14e-39c96305b38c"] = { file = "assets/5f6ae325-bc60-4eb4-b14e-39c96305b38c.mp3", id = "5f6ae325-bc60-4eb4-b14e-39c96305b38c", name = "obj_wo3DlMOGwrbDjj7DisKw_77040696272_520", url = "https://creation.bcmcdn.com/922/user-files/FvLOs50gDy6047r5tIVBKQ84wXgd.mp3" }, ["6cff184f-8e07-48e8-8022-26469f6534ad"] = { file = "assets/6cff184f-8e07-48e8-8022-26469f6534ad.mp3", id = "6cff184f-8e07-48e8-8022-26469f6534ad", name = "audio", url = "https://creation.bcmcdn.com/922/user-files/Fq7yz6-KoEUcEP8MN8dQQDlzOt1N.mp3" }, ["6d5a1e00-c9eb-4f72-b259-0649b6296623"] = { file = "assets/6d5a1e00-c9eb-4f72-b259-0649b6296623.mp3", id = "6d5a1e00-c9eb-4f72-b259-0649b6296623", name = "obj_wo3DlMOGwrbDjj7DisKw_62755997048_76d", url = "https://creation.bcmcdn.com/922/user-files/lk-9X9WQmC5Zr7Pdt0DIa0VVN0F0.mp3" }, ["7505e790-1555-4178-acee-00766f02d3ac"] = { file = "assets/7505e790-1555-4178-acee-00766f02d3ac.mp3", id = "7505e790-1555-4178-acee-00766f02d3ac", name = "osu-logo-downbeat", url = "https://creation.bcmcdn.com/922/user-files/FvYinPgPMXsFpRDyZfUNk2bpkdLH.mp3" }, ["80b29e32-3522-42e6-b167-e14cd541cb68"] = { file = "assets/80b29e32-3522-42e6-b167-e14cd541cb68.mp3", id = "80b29e32-3522-42e6-b167-e14cd541cb68", name = "obj_wo3DlMOGwrbDjj7DisKw_58820788056_937", url = "https://creation.bcmcdn.com/922/user-files/loranNPnwhw_M05SBzY5jTJyv_Yl.mp3" }, ["8338e16d-8e54-4e24-a78f-758963d00d53"] = { file = "assets/8338e16d-8e54-4e24-a78f-758963d00d53.mp3", id = "8338e16d-8e54-4e24-a78f-758963d00d53", name = "obj_wo3DlMOGwrbDjj7DisKw_32050098295_9eb", url = "https://creation.bcmcdn.com/922/user-files/ljryxBR5AApeG7o_USA2mIzeTF7d.mp3" }, ["98613659-03ef-4002-80d1-e4ee63db267a"] = { file = "assets/98613659-03ef-4002-80d1-e4ee63db267a.mp3", id = "98613659-03ef-4002-80d1-e4ee63db267a", name = "obj_wo3DlMOGwrbDjj7DisKw_78909514048_714", url = "https://creation.bcmcdn.com/922/user-files/lhgE5NDm-XQK7P846fLygHOOYvvb.mp3" }, ["98a759df-e44d-46f4-926d-d113315b9fd8"] = { file = "assets/98a759df-e44d-46f4-926d-d113315b9fd8.mp3", id = "98a759df-e44d-46f4-926d-d113315b9fd8", name = "obj_wo3DlMOGwrbDjj7DisKw_62669711733_959", url = "https://creation.bcmcdn.com/922/user-files/lttF2117bjrEPeDgs1cOOcv9GDBm.mp3" }, ["9d8ca29c-5cb5-4c1e-bc0f-fd60dfbec3ab"] = { file = "assets/9d8ca29c-5cb5-4c1e-bc0f-fd60dfbec3ab.mp3", id = "9d8ca29c-5cb5-4c1e-bc0f-fd60dfbec3ab", name = "obj_wo3DlMOGwrbDjj7DisKw_77954395033_831", url = "https://creation.bcmcdn.com/922/user-files/lsgsFLC_ldmGJJ3coPxYiotbRDjJ.mp3" }, ["9e467d8a-cd62-4c74-8066-1c9eddc91883"] = { file = "assets/9e467d8a-cd62-4c74-8066-1c9eddc91883.mp3", id = "9e467d8a-cd62-4c74-8066-1c9eddc91883", name = "[Lightech独占] Grey World——无律", url = "https://creation.bcmcdn.com/922/user-files/lq2121_1UeanW7Cn0vUIUfPJWoNK.mp3" }, ["a24c2598-dce3-4a7e-85de-bfdca46bcb78"] = { file = "assets/a24c2598-dce3-4a7e-85de-bfdca46bcb78.mp3", id = "a24c2598-dce3-4a7e-85de-bfdca46bcb78", name = "soft-hitnormal", url = "https://creation.bcmcdn.com/922/user-files/FnuQlkWbg6Qd_ShV4j6cqjCfVyGL.mp3" }, ["a4dfc0d2-23b5-4bbb-b42b-6921375d3da4"] = { file = "assets/a4dfc0d2-23b5-4bbb-b42b-6921375d3da4.mp3", id = "a4dfc0d2-23b5-4bbb-b42b-6921375d3da4", name = "obj_wo3DlMOGwrbDjj7DisKw_62983904169_fb3", url = "https://creation.bcmcdn.com/922/user-files/ln86d-3k6gt0e3Jz77cT8F9L4G9I.mp3" }, ["a7fb23ed-aa4b-4f84-ad3d-9d7625d9b8cf"] = { file = "assets/a7fb23ed-aa4b-4f84-ad3d-9d7625d9b8cf.mp3", id = "a7fb23ed-aa4b-4f84-ad3d-9d7625d9b8cf", name = "obj_wo3DlMOGwrbDjj7DisKw_80038005177_889", url = "https://creation.bcmcdn.com/922/user-files/lnyBP8HoOAr7Ct8wDqe-QgYCGwRr.mp3" }, ["a872dc90-0c7f-45c3-8adb-8daac62c6f73"] = { file = "assets/a872dc90-0c7f-45c3-8adb-8daac62c6f73.mp3", id = "a872dc90-0c7f-45c3-8adb-8daac62c6f73", name = "shousitu", url = "https://creation.bcmcdn.com/922/user-files/lqnW07zN15zAB4AyJ4SgxQvLN6Sk.mp3" }, ["b02bdbe4-007b-41f8-a1de-14a5ab6c9e88"] = { file = "assets/b02bdbe4-007b-41f8-a1de-14a5ab6c9e88.mp3", id = "b02bdbe4-007b-41f8-a1de-14a5ab6c9e88", name = "normal-hitnormal", url = "https://creation.bcmcdn.com/922/user-files/Fu0_8opoO0aiDt_eQx1kRLLdIa9O.mp3" }, ["b034ce40-89ad-4d9d-b993-34b9e4465aa6"] = { file = "assets/b034ce40-89ad-4d9d-b993-34b9e4465aa6.mp3", id = "b034ce40-89ad-4d9d-b993-34b9e4465aa6", name = "obj_wo3DlMOGwrbDjj7DisKw_60647039210_1dd", url = "https://creation.bcmcdn.com/922/user-files/lhtPjeu9xBjunuCkqia-eDbzgIPU.mp3" }, ["b8a319a1-d660-4e97-92a5-ac9261924da3"] = { file = "assets/b8a319a1-d660-4e97-92a5-ac9261924da3.mp3", id = "b8a319a1-d660-4e97-92a5-ac9261924da3", name = "combobreak", url = "https://creation.bcmcdn.com/922/user-files/FgoyaezkAvPZLBh-bFL9KigHhZ1N.mp3" }, ["bfad287b-d541-4d4d-a35f-67893b0cdb69"] = { file = "assets/bfad287b-d541-4d4d-a35f-67893b0cdb69.mp3", id = "bfad287b-d541-4d4d-a35f-67893b0cdb69", name = "failsound", url = "https://creation.bcmcdn.com/922/user-files/FqqxPs9NNrLOf6GJ0sejQoJwJODO.mp3" }, ["c89e0442-aee5-4adc-a919-8f42db702896"] = { file = "assets/c89e0442-aee5-4adc-a919-8f42db702896.mp3", id = "c89e0442-aee5-4adc-a919-8f42db702896", name = "obj_wo3DlMOGwrbDjj7DisKw_61565823635_e8f", url = "https://creation.bcmcdn.com/922/user-files/lmSYT0N4OvOV36UpjHcar9csavsj.mp3" }, ["ca53dc72-f5fd-4a04-a5b9-feb18adf1289"] = { file = "assets/ca53dc72-f5fd-4a04-a5b9-feb18adf1289.mp3", id = "ca53dc72-f5fd-4a04-a5b9-feb18adf1289", name = "LS", url = "https://creation.bcmcdn.com/922/user-files/ltSQZoJ_106tobZzbe5oYvqBMsLx.mp3" }, ["ca956ee0-1ebd-4949-b33e-7cd9400330c2"] = { file = "assets/ca956ee0-1ebd-4949-b33e-7cd9400330c2.mp3", id = "ca956ee0-1ebd-4949-b33e-7cd9400330c2", name = "drum-hitnormal", url = "https://creation.bcmcdn.com/922/user-files/FgOiZzlJ9c_qBpFNXksUX0r5svuY.mp3" }, ["d171249a-72d9-43b3-94fd-606c527faab4"] = { file = "assets/d171249a-72d9-43b3-94fd-606c527faab4.mp3", id = "d171249a-72d9-43b3-94fd-606c527faab4", name = "obj_wo3DlMOGwrbDjj7DisKw_78158451695_256", url = "https://creation.bcmcdn.com/922/user-files/lv0acxSvDv_kGWxRp32XGM_q-8iI.mp3" }, ["d50533bc-15b4-4e37-9109-e856e6a4b701"] = { file = "assets/d50533bc-15b4-4e37-9109-e856e6a4b701.mp3", id = "d50533bc-15b4-4e37-9109-e856e6a4b701", name = "osu-logo-heartbeat", url = "https://creation.bcmcdn.com/922/user-files/FjCKILcGCAs-c39_F7_6W6ItzWAE.mp3" }, ["d6ccf04b-2e71-4274-a07e-9771f46ca1a9"] = { file = "assets/d6ccf04b-2e71-4274-a07e-9771f46ca1a9.mp3", id = "d6ccf04b-2e71-4274-a07e-9771f46ca1a9", name = "obj_wo3DlMOGwrbDjj7DisKw_58070501303_1c5", url = "https://creation.bcmcdn.com/922/user-files/lt80G85g8-JGgY_qKP8gQT0PEzjB.mp3" }, ["dce51e54-e57c-4283-ad8a-d8979a046263"] = { file = "assets/dce51e54-e57c-4283-ad8a-d8979a046263.mp3", id = "dce51e54-e57c-4283-ad8a-d8979a046263", name = "UnderTheTower_[cut_148sec]", url = "https://creation.bcmcdn.com/922/user-files/ls4if3tVvXNeNYahQUvipeVSa-5s.mp3" }, ["ee026257-194d-48e3-b338-f2e53230bb0c"] = { file = "assets/ee026257-194d-48e3-b338-f2e53230bb0c.mp3", id = "ee026257-194d-48e3-b338-f2e53230bb0c", name = "No title", url = "https://creation.bcmcdn.com/922/user-files/FoFWYlIpr-OOLE9Q4Yen_EIrz5SD.mp3" }, ["f827ecbf-a526-45db-8125-b5da570609a5"] = { file = "assets/f827ecbf-a526-45db-8125-b5da570609a5.mp3", id = "f827ecbf-a526-45db-8125-b5da570609a5", name = "fountain-shoot", url = "https://creation.bcmcdn.com/922/user-files/FgohTcnSa_Gc3cdAdqYGXUnqBVFi.mp3" } }

function M.register(rt, game, ents)
  f = rt.f
  local e_700824a5_44a8_4d03_a7e8_aa95d87e9b2a = ents["700824a5-44a8-4d03-a7e8-aa95d87e9b2a"]
  local e_6c9fdf0c_4483_4cd6_b886_c059b7c2b58f = ents["6c9fdf0c-4483-4cd6-b886-c059b7c2b58f"]
  local e_9d583a2a_486d_4997_abd6_3e3a058288e1 = ents["9d583a2a-486d-4997-abd6-3e3a058288e1"]
  local e_13c1f24a_0f92_4d49_adf1_93dc4e4816cb = ents["13c1f24a-0f92-4d49-adf1-93dc4e4816cb"]
  local e_cb8ad9c4_3817_49a8_b7cb_112e9b6e4d51 = ents["cb8ad9c4-3817-49a8-b7cb-112e9b6e4d51"]
  local e_1c387224_c473_489b_aaad_782662b8860e = ents["1c387224-c473-489b-aaad-782662b8860e"]
  local e_a24ee163_9852_4208_850f_bd87d3aea79f = ents["a24ee163-9852-4208-850f-bd87d3aea79f"]
  local e_75ae2a24_41fe_4d2b_9907_1af40e55aec3 = ents["75ae2a24-41fe-4d2b-9907-1af40e55aec3"]
  local e_080ff01f_de3f_47b9_97ac_af9a656ec4f2 = ents["080ff01f-de3f-47b9-97ac-af9a656ec4f2"]
  local e_b9d12dc0_4a4d_4a5c_8326_01cea04b9759 = ents["b9d12dc0-4a4d-4a5c-8326-01cea04b9759"]
  local e_bae5e67c_2737_4f16_b263_cd2c7fe72436 = ents["bae5e67c-2737-4f16-b263-cd2c7fe72436"]
  local e_58eadc2b_0e03_4346_bf4f_ba964fa14080 = ents["58eadc2b-0e03-4346-bf4f-ba964fa14080"]
  local e_3455f327_6d7e_4d65_ba42_c86119348064 = ents["3455f327-6d7e-4d65-ba42-c86119348064"]
  local e_02812331_bdb9_4137_8da6_c404e96a6d44 = ents["02812331-bdb9-4137-8da6-c404e96a6d44"]
  local e_bc6dac92_9220_4e38_8fbc_1ccd0cd99da3 = ents["bc6dac92-9220-4e38-8fbc-1ccd0cd99da3"]
  local e_732e3434_f07d_43e1_993b_e50b96038c21 = ents["732e3434-f07d-43e1-993b-e50b96038c21"]
  local e_323d1935_4d82_4c9a_87f2_3d47e8592d30 = ents["323d1935-4d82-4c9a-87f2-3d47e8592d30"]
  local e_c1af39b1_f7d2_4a95_bc40_37cd94c16816 = ents["c1af39b1-f7d2-4a95-bc40-37cd94c16816"]
  local e_811ce580_0510_4d39_88a4_bc3729f497f3 = ents["811ce580-0510-4d39-88a4-bc3729f497f3"]
  local e_bcc769e8_a805_43fa_a3a6_e87bdcb502b6 = ents["bcc769e8-a805-43fa-a3a6-e87bdcb502b6"]
  local e_0c8dc1eb_36a6_4968_a6f0_02b0574215f9 = ents["0c8dc1eb-36a6-4968-a6f0-02b0574215f9"]
  local e_0d213613_8c5d_4529_8456_dcb60efaefd9 = ents["0d213613-8c5d-4529-8456-dcb60efaefd9"]
  local e_0c9ea944_856c_449e_af72_76d509d360bd = ents["0c9ea944-856c-449e-af72-76d509d360bd"]
  local e_e1f00058_a341_4755_ad37_63e9d70b4610 = ents["e1f00058-a341-4755-ad37-63e9d70b4610"]
  local e_be7204ca_fa8d_4181_b56b_6583b19290a5 = ents["be7204ca-fa8d-4181-b56b-6583b19290a5"]
  local e_142d7973_7637_4b94_94d3_1d816b2c2df4 = ents["142d7973-7637-4b94-94d3-1d816b2c2df4"]
  local e_810d5972_9f94_47ac_a461_4df7e286dba4 = ents["810d5972-9f94-47ac-a461-4df7e286dba4"]
  local e_388bcb4b_71dc_464d_869d_96a4d70067f8 = ents["388bcb4b-71dc-464d-869d-96a4d70067f8"]
  local e_45c8d7e3_e13f_475b_a885_98a2aff839b7 = ents["45c8d7e3-e13f-475b-a885-98a2aff839b7"]
  local e_ccd1fd87_8c2f_4e17_aedb_d3a96ae128f3 = ents["ccd1fd87-8c2f-4e17-aedb-d3a96ae128f3"]
  local e_79fcfeea_02a9_4cc3_87e7_b0e3a163b524 = ents["79fcfeea-02a9-4cc3-87e7-b0e3a163b524"]
  local e_8f49f29a_5834_4630_96a3_464ffc5896c9 = ents["8f49f29a-5834-4630-96a3-464ffc5896c9"]
  local e_86f003a3_78f9_47ed_9ce0_0552f08c6d53 = ents["86f003a3-78f9-47ed-9ce0-0552f08c6d53"]
  local e_79a5d117_4e2c_4bfc_933c_602fd8cdebc0 = ents["79a5d117-4e2c-4bfc-933c-602fd8cdebc0"]
  local e_4150aa3e_61c0_4f08_8ae3_aee9b6e56c3c = ents["4150aa3e-61c0-4f08-8ae3-aee9b6e56c3c"]
  local e_c73c5c69_2217_4d2b_a3b8_87c9aa01109c = ents["c73c5c69-2217-4d2b-a3b8-87c9aa01109c"]
  local e_cb9067dc_cf1d_4561_89e6_0c7e3b2d4ff8 = ents["cb9067dc-cf1d-4561-89e6-0c7e3b2d4ff8"]
  local e_77abc2fe_1f5f_4261_9df3_99c7e0094c20 = ents["77abc2fe-1f5f-4261-9df3-99c7e0094c20"]
  local e_5a49795d_a089_4076_afc5_2f5762aca3d3 = ents["5a49795d-a089-4076-afc5-2f5762aca3d3"]
  local e_72263c92_6082_4280_b989_275482ef48b4 = ents["72263c92-6082-4280-b989-275482ef48b4"]
  local e_290c4c73_11b5_4ed6_bbe3_7c68ecf7fcf4 = ents["290c4c73-11b5-4ed6-bbe3-7c68ecf7fcf4"]
  local e_88f3d867_1412_4f85_8b46_19323d086974 = ents["88f3d867-1412-4f85-8b46-19323d086974"]
  local e_fa1d14b9_7fe6_4771_af59_7b1cf21febfc = ents["fa1d14b9-7fe6-4771-af59-7b1cf21febfc"]
  local e_81d5d728_b9fd_4272_8b58_0aa1ce7e2271 = ents["81d5d728-b9fd-4272-8b58-0aa1ce7e2271"]
  local e_6107cddf_e22c_4045_b5eb_209a7e896a17 = ents["6107cddf-e22c-4045-b5eb-209a7e896a17"]
  local e_90f07778_a861_4dd1_90f0_a4c364c78d55 = ents["90f07778-a861-4dd1-90f0-a4c364c78d55"]
  local e_0c86e074_e893_43b3_a3d7_99060cf7aa7f = ents["0c86e074-e893-43b3-a3d7-99060cf7aa7f"]
  local e_3001a293_b662_4514_bb57_d8b2c0d86e5f = ents["3001a293-b662-4514-bb57-d8b2c0d86e5f"]
  local e_81856d00_5a71_430b_9465_728835fa193a = ents["81856d00-5a71-430b-9465-728835fa193a"]
  local e_290a49df_8703_4c08_affb_12f4839b6214 = ents["290a49df-8703-4c08-affb-12f4839b6214"]
  local e_bea6f71b_f5d0_48b0_8b5d_2c7f055d3112 = ents["bea6f71b-f5d0-48b0-8b5d-2c7f055d3112"]
  local e_72378a7d_81d6_4757_9859_cf67c0d67067 = ents["72378a7d-81d6-4757-9859-cf67c0d67067"]
  local e_b92ed11d_9f0d_48ac_9c23_834a35b07635 = ents["b92ed11d-9f0d-48ac-9c23-834a35b07635"]
  local e_20d5357d_f7e4_40e5_adbf_d7425fc4575c = ents["20d5357d-f7e4-40e5-adbf-d7425fc4575c"]
  local e_482cd58c_e986_4290_b775_5be3824501a7 = ents["482cd58c-e986-4290-b775-5be3824501a7"]
  local e_153df064_77d9_4a72_a32e_97122908ccbb = ents["153df064-77d9-4a72-a32e-97122908ccbb"]
  local e_859004d2_17ce_4480_a27e_d41f87103a80 = ents["859004d2-17ce-4480-a27e-d41f87103a80"]
  local e_cf5996d0_ce13_4fd6_a697_20330cfe8c70 = ents["cf5996d0-ce13-4fd6-a697-20330cfe8c70"]
  local e_d7f3224d_cb3f_446f_8e27_ff4e89b7e3f3 = ents["d7f3224d-cb3f-446f-8e27-ff4e89b7e3f3"]
  local e_5f2d3188_f919_4139_9a87_0a2e52f7d66e = ents["5f2d3188-f919-4139-9a87-0a2e52f7d66e"]
  local e_ea4e3fef_3091_4773_8025_d207b9310113 = ents["ea4e3fef-3091-4773-8025-d207b9310113"]
  local e_4e9b6cd2_ef52_49b4_89ff_e228449d18eb = ents["4e9b6cd2-ef52-49b4-89ff-e228449d18eb"]
  local e_7462b472_977c_4ca8_98be_5f97dffbd11a = ents["7462b472-977c-4ca8-98be-5f97dffbd11a"]
  local e_56dd2bee_76bc_4f64_a53d_3967177cb6c4 = ents["56dd2bee-76bc-4f64-a53d-3967177cb6c4"]
  local e_59c0adac_290c_4360_b0bd_c8a5459f70c4 = ents["59c0adac-290c-4360-b0bd-c8a5459f70c4"]
  local e_3fa2d77f_f8e2_4918_aaa5_a9272494dcc6 = ents["3fa2d77f-f8e2-4918-aaa5-a9272494dcc6"]
  local e_946ace71_fa8a_4c30_b470_ccfe7c2a6551 = ents["946ace71-fa8a-4c30-b470-ccfe7c2a6551"]
  local e_54785748_f51a_456f_9225_e6cbf11b955d = ents["54785748-f51a-456f-9225-e6cbf11b955d"]
  local e_f5d13c9f_b53c_4f5b_9d29_c9488bf94b0a = ents["f5d13c9f-b53c-4f5b-9d29-c9488bf94b0a"]
  local e_13c821e9_2d8e_4434_9937_56c54b21ecf7 = ents["13c821e9-2d8e-4434-9937-56c54b21ecf7"]
  local e_6263c102_e379_498d_b9c5_2038b8450c59 = ents["6263c102-e379-498d-b9c5-2038b8450c59"]
  local e_ba96713e_7238_4f0e_afc0_4f43a0a4c9b6 = ents["ba96713e-7238-4f0e-afc0-4f43a0a4c9b6"]
  local e_8e7b1e19_f6ae_4f28_836a_19067dccf67e = ents["8e7b1e19-f6ae-4f28-836a-19067dccf67e"]
  local e_f514c5ad_4529_4447_9405_6c953cb44137 = ents["f514c5ad-4529-4447-9405-6c953cb44137"]
  local e_1729f8cf_df6e_4420_8217_7881b696e340 = ents["1729f8cf-df6e-4420-8217-7881b696e340"]
  local e_0d3cb358_caba_4bd9_9ec7_77ba6d5d91c7 = ents["0d3cb358-caba-4bd9-9ec7-77ba6d5d91c7"]
  local e_021f6559_beec_4abc_8013_8a0b6b6125ee = ents["021f6559-beec-4abc-8013-8a0b6b6125ee"]
  local e_14d734a5_daa3_4a14_8ccf_5a01dd522300 = ents["14d734a5-daa3-4a14-8ccf-5a01dd522300"]
  local e_dfa1f38a_ea1d_4c3d_b109_48029c256268 = ents["dfa1f38a-ea1d-4c3d-b109-48029c256268"]
  local e_914c4d45_c6e4_424b_aff5_ad3a824b6a1b = ents["914c4d45-c6e4-424b-aff5-ad3a824b6a1b"]
  local e_95aa8ac8_def0_4f3e_9a85_4f6ac3719f4c = ents["95aa8ac8-def0-4f3e-9a85-4f6ac3719f4c"]
  local e_27839e28_7a5d_400b_b8ad_1d0f58686fba = ents["27839e28-7a5d-400b-b8ad-1d0f58686fba"]
  local e_f05fb825_9496_4164_b7e2_7b7511774512 = ents["f05fb825-9496-4164-b7e2-7b7511774512"]
  local e_346d958e_5f8c_4eb4_9b8b_368fa49d5703 = ents["346d958e-5f8c-4eb4-9b8b-368fa49d5703"]
  local e_4fc1f2cb_2dc5_4e47_a2c8_ab07519da1d1 = ents["4fc1f2cb-2dc5-4e47-a2c8-ab07519da1d1"]
  local e_fa225791_3758_4dc6_933f_fb2de01de032 = ents["fa225791-3758-4dc6-933f-fb2de01de032"]
  local e_d268e9fd_3f9b_423a_8130_0e2281e35eeb = ents["d268e9fd-3f9b-423a-8130-0e2281e35eeb"]
  local e_9e324a05_c70d_4b1b_927f_00f2ccccbd36 = ents["9e324a05-c70d-4b1b-927f-00f2ccccbd36"]
  local e_073a1839_8466_4838_80b4_69673d2c6588 = ents["073a1839-8466-4838-80b4-69673d2c6588"]
  local e_58825666_11bf_4755_abdf_62505a487764 = ents["58825666-11bf-4755-abdf-62505a487764"]
  local e_e381eae0_9ac3_4265_bad8_7fa7acef65d8 = ents["e381eae0-9ac3-4265-bad8-7fa7acef65d8"]
  local e_069da2b2_28a0_4b9d_85c4_347e86276d6d = ents["069da2b2-28a0-4b9d-85c4-347e86276d6d"]
  local e_2f536974_1483_454f_87f6_5f367d4f7e25 = ents["2f536974-1483-454f-87f6-5f367d4f7e25"]
  local e_e8ba2ded_bafb_4a7e_9da9_5c52099f73d1 = ents["e8ba2ded-bafb-4a7e-9da9-5c52099f73d1"]
  local e_33aeb73d_9c2b_4093_b849_9bae59206156 = ents["33aeb73d-9c2b-4093-b849-9bae59206156"]
  local e_625a7787_130a_4062_aba0_c32e6673e740 = ents["625a7787-130a-4062-aba0-c32e6673e740"]
  local e_8d8fda5b_94fe_4c44_bbbd_79d2707a0506 = ents["8d8fda5b-94fe-4c44-bbbd-79d2707a0506"]
  local e_3194ad1f_740d_421d_b3db_cb8a42602a01 = ents["3194ad1f-740d-421d-b3db-cb8a42602a01"]
  local e_0276aae8_9443_4b20_8c09_b5aea970438e = ents["0276aae8-9443-4b20-8c09-b5aea970438e"]
  local e_ade8a5d0_e108_476b_8b13_5732a69d5682 = ents["ade8a5d0-e108-476b-8b13-5732a69d5682"]
  local e_e7d95181_ca3e_4d2c_be28_bc36e6393f1b = ents["e7d95181-ca3e-4d2c-be28-bc36e6393f1b"]
  local e_07cc3840_fd98_4316_b4d0_2961194a2aaf = ents["07cc3840-fd98-4316-b4d0-2961194a2aaf"]
  local e_3069d4bb_2bbd_4d44_906f_63279a0325b2 = ents["3069d4bb-2bbd-4d44-906f-63279a0325b2"]
  local e_5059b4be_4906_4e3c_b5a7_86b4746f7ec3 = ents["5059b4be-4906-4e3c-b5a7-86b4746f7ec3"]
  local e_5e558578_132d_45c0_a48d_46d15a672e3e = ents["5e558578-132d-45c0-a48d-46d15a672e3e"]
  local e_bd2e6ffa_b23c_451b_afb9_a5d472067bee = ents["bd2e6ffa-b23c-451b-afb9-a5d472067bee"]
  local e_e2d6e418_cb83_4db6_97ab_49a9fd505b3d = ents["e2d6e418-cb83-4db6-97ab-49a9fd505b3d"]
  local e_811b7dbd_7e8d_4506_997a_a8063ac1086b = ents["811b7dbd-7e8d-4506-997a-a8063ac1086b"]
  local e_d80f3ef1_ca03_47c8_a1ad_e5dd1c1d471d = ents["d80f3ef1-ca03-47c8-a1ad-e5dd1c1d471d"]
  local e_554d5aa6_5385_486b_8b50_2a83b3b455e1 = ents["554d5aa6-5385-486b-8b50-2a83b3b455e1"]
  -- -------- 屏幕 背景 --------
  rt.on(e_700824a5_44a8_4d03_a7e8_aa95d87e9b2a, "on_running_group_activated", {}, function(th, self)
      while true do
        f["set_sprite_style"](self, { style_id = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "3a064750-07fd-4c4a-95a2-271c3b091da8" }, th), B = 1, type = "add" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_700824a5_44a8_4d03_a7e8_aa95d87e9b2a, "on_running_group_activated", {}, function(th, self)
      while not V.bool(f["logic_compare"](self, { A = f["timer"](self, {}, th), B = 0, OP = "NEQ" }, th)) do
        if th:iter_n() then break end
      end
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "fb1eed48-70de-47aa-bb36-89104591cbaf" }, th), B = 1, OP = "EQ" }, th)) then
          th:call_proc(proc_ab9e6f2c_d942_40be_8d4c_e8f19d72383d, self)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_700824a5_44a8_4d03_a7e8_aa95d87e9b2a, "on_running_group_activated", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, PARAMS1 = nil, name = "a", names = { "a", "b" } }, th)
      f["variables_set"](self, { value = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
      f["variables_set"](self, { value = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"b\"}" }, th)
      while true do
        f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "02812331-bdb9-4137-8da6-c404e96a6d44" }, th), B = 5, type = "divide" }, th), type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 15, type = "divide" }, th) }, th)
        if V.bool(f["logic_compare"](self, { A = f["get_clone_num"](self, { sprite = "bae5e67c-2737-4f16-b263-cd2c7fe72436" }, th), B = 0, OP = "NEQ" }, th)) then
          f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "b" }, th), B = f["math_arithmetic"](self, { A = f["get_clone_index_property"](self, { attribute = "y", index = f["list_item"](self, { item = "any", list = "e784dfc1-2cc4-4bfe-874d-f19dced31dc4", list_index = 1 }, th), sprite = "bae5e67c-2737-4f16-b263-cd2c7fe72436" }, th), B = 10, type = "divide" }, th), type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 15, type = "divide" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 屏幕 背景 --------
  rt.on(e_6c9fdf0c_4483_4cd6_b886_c059b7c2b58f, "on_running_group_activated", {}, function(th, self)
      f["set_sprite_style"](self, { style_id = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "3a064750-07fd-4c4a-95a2-271c3b091da8" }, th), B = 1, type = "add" }, th) }, th)
      f["self_appear"](self, { value = "appear" }, th)
      while true do
        f["set_sprite_style"](self, { style_id = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "3a064750-07fd-4c4a-95a2-271c3b091da8" }, th), B = 1, type = "add" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_6c9fdf0c_4483_4cd6_b886_c059b7c2b58f, "on_running_group_activated", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, PARAMS1 = nil, name = "a", names = { "a", "b" } }, th)
      f["variables_set"](self, { value = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
      f["variables_set"](self, { value = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"b\"}" }, th)
      while true do
        f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = f["math_arithmetic"](self, { A = f["get_mouse_info"](self, { type = "x" }, th), B = 15, type = "divide" }, th), type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 15, type = "divide" }, th) }, th)
        f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "b" }, th), B = f["math_arithmetic"](self, { A = f["get_mouse_info"](self, { type = "y" }, th), B = 15, type = "divide" }, th), type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 15, type = "divide" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_6c9fdf0c_4483_4cd6_b886_c059b7c2b58f, "on_running_group_activated", {}, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "16f5bf5a-64a9-4ad1-9052-d34b3e677e99" }, th), B = 0, OP = "EQ" }, th)) then
        f["variables_set"](self, { value = 50, variable = "16f5bf5a-64a9-4ad1-9052-d34b3e677e99" }, th)
      end
  end)
  rt.on(e_6c9fdf0c_4483_4cd6_b886_c059b7c2b58f, "on_running_group_activated", {}, function(th, self)
      f["self_set_effect"](self, { scope = "2", value = 200 }, th)
      while true do
        if f["logic_compare"](self, { A = f["math_round"](self, { num = f["effect_of_sprite"](self, { effect = "2", sprite = "--self" }, th), type = "round" }, th), B = 100, OP = "EQ" }, th) then break end
        f["self_change_effect"](self, { increase = "increase", scope = "2", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = f["effect_of_sprite"](self, { effect = "2", sprite = "--self" }, th), type = "minus" }, th), B = 7.5, type = "divide" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 屏幕 背景 --------
  rt.on(e_cb8ad9c4_3817_49a8_b7cb_112e9b6e4d51, "on_running_group_activated", {}, function(th, self)
      while true do
        while true do
          if f["logic_compare"](self, { A = f["math_round"](self, { num = f["effect_of_sprite"](self, { effect = "2", sprite = "--self" }, th), type = "round" }, th), B = 100, OP = "EQ" }, th) then break end
          f["self_change_effect"](self, { increase = "increase", scope = "2", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = f["effect_of_sprite"](self, { effect = "2", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
          if th:iter_n() then break end
        end
        if V.bool(f["logic_compare"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "3a064750-07fd-4c4a-95a2-271c3b091da8" }, th), B = 1, type = "add" }, th), B = f["style_of_sprite"](self, { sprite = "--self" }, th), OP = "NEQ" }, th)) then
          while true do
            if f["logic_compare"](self, { A = f["math_round"](self, { num = f["effect_of_sprite"](self, { effect = "2", sprite = "--self" }, th), type = "round" }, th), B = 200, OP = "EQ" }, th) then break end
            f["self_change_effect"](self, { increase = "increase", scope = "2", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 200, B = f["effect_of_sprite"](self, { effect = "2", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
            if th:iter_n() then break end
          end
          f["set_sprite_style"](self, { style_id = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "3a064750-07fd-4c4a-95a2-271c3b091da8" }, th), B = 1, type = "add" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 屏幕 背景 --------
  rt.on(e_1c387224_c473_489b_aaad_782662b8860e, "on_running_group_activated", {}, function(th, self)
      while true do
        f["set_sprite_style"](self, { style_id = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "3a064750-07fd-4c4a-95a2-271c3b091da8" }, th), B = 1, type = "add" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 屏幕 背景 --------
  rt.on(e_a24ee163_9852_4208_850f_bd87d3aea79f, "sprite_on_tap", { sprite = "--self", type = "mouse_click" }, function(th, self)
      f["create_stage_dialog"](self, { sprite = "--self", text = "获取支持者权限后，你可以获得更多曲目和特效功能" }, th)
  end)
  -- -------- 屏幕 背景 --------
  rt.on(e_080ff01f_de3f_47b9_97ac_af9a656ec4f2, "sprite_on_tap", { sprite = "--self", type = "mouse_click" }, function(th, self)
      f["switch_to_screen"](self, { screen_id = "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, th)
  end)
  -- -------- 角色 轨道 --------
  rt.on(e_b9d12dc0_4a4d_4a5c_8326_01cea04b9759, "on_running_group_activated", {}, function(th, self)
      f["self_set_pen_color"](self, { color = "#ffffff" }, th)
      f["self_set_pen_size"](self, { size = 3 }, th)
      f["self_set_pen_color_property"](self, { scope = "alpha", val = 50 }, th)
      f["set_pen_layer"](self, { layer = "peak" }, th)
      f["self_pen_down"](self, {}, th)
      while true do
        f["clear_drawing"](self, {}, th)
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057" }, th), B = 1, OP = "GTE" }, th)) then
          f["self_set_position_x"](self, { value = -450 }, th)
          f["self_set_position_x"](self, { value = 450 }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 circle --------
  rt.on(e_bae5e67c_2737_4f16_b263_cd2c7fe72436, "on_running_group_activated", {}, function(th, self)
      f["self_set_effect"](self, { scope = "1", value = 25 }, th)
      th:warp_enter()
      do
        local _from_n1, _to_n1 = tonumber(0), tonumber(50)
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
            f["list_append"](self, { list = "4f001481-87b9-4b59-b50a-87fc1ed45738", list_item_value = _p_n1 }, th)
              th:pop_param()
              _p_n1 = _p_n1 + _by_n1
              if th:iter_w() then break end
            end
          end
        end
      end
      do
        local _from_n2, _to_n2 = tonumber(51), tonumber(100)
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
            f["list_append"](self, { list = "1a41a792-98e4-42c2-9647-e57bc7a45f5a", list_item_value = _p_n2 }, th)
              th:pop_param()
              _p_n2 = _p_n2 + _by_n2
              if th:iter_w() then break end
            end
          end
        end
      end
      do
        local _from_n3, _to_n3 = tonumber(101), tonumber(200)
        if _from_n3 ~= _from_n3 or _to_n3 ~= _to_n3 then
          -- NaN from/to: official warning; no iterations
        else
          if _from_n3 <= _to_n3 then _from_n3 = math.ceil(_from_n3); if _from_n3 > _to_n3 then _from_n3 = _to_n3 + 1 end
          else _from_n3 = math.floor(_from_n3); if _from_n3 < _to_n3 then _from_n3 = _to_n3 - 1 end end
          local _by_n3 = 1
          if _by_n3 == nil then _by_n3 = 1 end
          _by_n3 = tonumber(_by_n3)
          if _by_n3 == nil or _by_n3 ~= _by_n3 or _by_n3 <= 0 then _by_n3 = 0 else _by_n3 = math.abs(math.floor(_by_n3 + 0.5)) end
          if _by_n3 > 0 then
            local _p_n3 = _from_n3
            while (_from_n3 <= _to_n3 and _p_n3 <= _to_n3) or (_from_n3 > _to_n3 and _p_n3 >= _to_n3) do
              local _i_n3 = _p_n3
              th:push_param(_p_n3)
            f["list_append"](self, { list = "1edbe62e-38fe-4d98-996c-eb04b57ed57e", list_item_value = _p_n3 }, th)
              th:pop_param()
              _p_n3 = _p_n3 + _by_n3
              if th:iter_w() then break end
            end
          end
        end
      end
      th:warp_exit()
      f["wait"](self, { time = 0 }, th)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 0, OP = "NEQ" }, th)) then
        while not V.bool(f["logic_compare"](self, { A = f["timer"](self, {}, th), B = 0, OP = "NEQ" }, th)) do
          if th:iter_n() then break end
        end
      end
      f["script_variables"](self, { PARAMS0 = nil, PARAMS1 = nil, name = "a", names = { "a", "b" } }, th)
      f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 60, B = f["variables_get"](self, { variable = "ad9ad2e0-bf30-48fd-9a36-cc64092abce3" }, th), type = "divide" }, th), B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "divide" }, th), B = f["variables_get"](self, { variable = "1f8a4269-f7f9-4790-be36-e39dfa16cca2" }, th), type = "add" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"b\"}" }, th)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "0e5b8264-119d-4030-8b02-ac263239ad6b" }, th), B = 0, OP = "EQ" }, th)) then
        while true do
          if V.bool(f["list_is_exist"](self, { list = "4f001481-87b9-4b59-b50a-87fc1ed45738", list_item_value = f["variables_get"](self, { variable = "dd5934c5-10d3-4807-9205-cd6fcfb5d8e4" }, th) }, th)) then
            f["self_set_position_x"](self, { value = f["random_num"](self, { A = -150, B = 150 }, th) }, th)
            f["self_set_effect"](self, { scope = "0", value = 0 }, th)
          elseif V.bool(f["list_is_exist"](self, { list = "1a41a792-98e4-42c2-9647-e57bc7a45f5a", list_item_value = f["variables_get"](self, { variable = "dd5934c5-10d3-4807-9205-cd6fcfb5d8e4" }, th) }, th)) then
            f["self_set_position_x"](self, { value = f["random_num"](self, { A = -250, B = 250 }, th) }, th)
            f["self_set_effect"](self, { scope = "0", value = 30 }, th)
          elseif V.bool(f["list_is_exist"](self, { list = "1edbe62e-38fe-4d98-996c-eb04b57ed57e", list_item_value = f["variables_get"](self, { variable = "dd5934c5-10d3-4807-9205-cd6fcfb5d8e4" }, th) }, th)) then
            f["self_set_position_x"](self, { value = f["random_num"](self, { A = -350, B = 350 }, th) }, th)
            f["self_set_effect"](self, { scope = "0", value = 60 }, th)
          elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "dd5934c5-10d3-4807-9205-cd6fcfb5d8e4" }, th), B = 201, OP = "GTE" }, th)) then
            f["self_set_position_x"](self, { value = f["random_num"](self, { A = -400, B = 400 }, th) }, th)
            f["self_set_effect"](self, { scope = "0", value = 120 }, th)
          else
            f["self_set_position_x"](self, { value = f["random_num"](self, { A = -400, B = 400 }, th) }, th)
            f["self_set_effect"](self, { scope = "0", value = 120 }, th)
          end
          f["set_scale"](self, { scale = 63 }, th)
          f["mirror"](self, { sprite = "--self" }, th)
          f["variables_set"](self, { value = f["timer"](self, {}, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
          while not V.bool(f["logic_compare"](self, { A = f["timer"](self, {}, th), B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = f["script_variables_value"](self, { TEXT = "b" }, th), type = "add" }, th), OP = "GTE" }, th)) do
            if th:iter_n() then break end
          end
          if th:iter_n() then break end
        end
      else
        f["wait"](self, { time = 0 }, th)
        f["set_scale"](self, { scale = 63 }, th)
        while true do
          if f["logic_compare"](self, { A = f["variables_get"](self, { variable = "e8646259-c570-469d-a18b-0d625fee88c0" }, th), B = f["list_length"](self, { list = "1efc0077-8db0-4702-bf36-22dcd92460d9" }, th), OP = "EQ" }, th) then break end
          if V.bool(f["logic_compare"](self, { A = f["math_round"](self, { num = f["list_item"](self, { item = "any", list = "3fc9d1cc-d568-45d0-973e-1a7178ce9a0d", list_index = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "e8646259-c570-469d-a18b-0d625fee88c0" }, th), B = 1, type = "add" }, th) }, th), type = "round" }, th), B = f["variables_get"](self, { variable = "de704f61-3833-409d-8de2-f9a3852a822b" }, th), OP = "LTE" }, th)) then
            f["self_set_position_x"](self, { value = f["math_arithmetic"](self, { A = -256, B = f["list_item"](self, { item = "any", list = "1efc0077-8db0-4702-bf36-22dcd92460d9", list_index = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "e8646259-c570-469d-a18b-0d625fee88c0" }, th), B = 1, type = "add" }, th) }, th), type = "add" }, th) }, th)
            f["mirror"](self, { sprite = "--self" }, th)
            f["list_append"](self, { list = "e784dfc1-2cc4-4bfe-874d-f19dced31dc4", list_item_value = f["get_current_clone_index"](self, {}, th) }, th)
            if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = "5c47c536-5bc8-47dd-8902-3619ab3fb7cf", list_index = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "e8646259-c570-469d-a18b-0d625fee88c0" }, th), B = 1, type = "add" }, th) }, th), B = 0, OP = "NEQ" }, th)) then
              f["self_change_coordinate_y"](self, { increase = "increase", value = f["list_item"](self, { item = "any", list = "5c47c536-5bc8-47dd-8902-3619ab3fb7cf", list_index = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "e8646259-c570-469d-a18b-0d625fee88c0" }, th), B = 1, type = "add" }, th) }, th) }, th)
              f["mirror"](self, { sprite = "--self" }, th)
              f["list_append"](self, { list = "e784dfc1-2cc4-4bfe-874d-f19dced31dc4", list_item_value = f["get_current_clone_index"](self, {}, th) }, th)
              f["self_change_coordinate_y"](self, { increase = "decrease", value = f["list_item"](self, { item = "any", list = "5c47c536-5bc8-47dd-8902-3619ab3fb7cf", list_index = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "e8646259-c570-469d-a18b-0d625fee88c0" }, th), B = 1, type = "add" }, th) }, th) }, th)
            end
            f["change_variables"](self, { method = "increase", value = 1, variable = "e8646259-c570-469d-a18b-0d625fee88c0" }, th)
          end
          if th:iter_n() then break end
        end
      end
  end)
  rt.on(e_bae5e67c_2737_4f16_b263_cd2c7fe72436, "start_as_a_mirror", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, name = "位置" }, th)
      f["variables_set"](self, { value = 1, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"位置\"}" }, th)
      while true do
        if V.bool(f["logic_operation"](self, { A = f["bump_into"](self, { sprite = "--self", sprite1 = "02812331-bdb9-4137-8da6-c404e96a6d44" }, th), B = f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "c06ec284-e9a2-4623-8583-77ec252a830d" }, th), B = 0, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), B = -160, OP = "LTE" }, th), type = "and" }, th), type = "and" }, th)) then
          f["variables_set"](self, { value = 1, variable = "c06ec284-e9a2-4623-8583-77ec252a830d" }, th)
          if V.bool(f["logic_compare"](self, { A = f["style_of_sprite"](self, { sprite = "--self" }, th), B = 2, OP = "EQ" }, th)) then
            f["change_variables"](self, { method = "increase", value = 1, variable = "475f4ace-928d-44ae-9cd4-653730db6e1f" }, th)
            f["change_variables"](self, { method = "increase", value = 1, variable = "dd5934c5-10d3-4807-9205-cd6fcfb5d8e4" }, th)
            f["change_variables"](self, { method = "increase", value = 1, variable = "28212a58-3dd5-4497-b5d7-ff619cd52f8f" }, th)
            if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "6092a2df-3e87-4447-8b09-b36e55b4310c" }, th), B = 1, OP = "EQ" }, th)) then
              f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = 5, B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "divide" }, th), variable = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057" }, th)
            elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "ce0cbfad-4568-4497-83a8-e423c872cdb1" }, th), B = 1, OP = "EQ" }, th)) then
              f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = 20, B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "divide" }, th), variable = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057" }, th)
            else
              f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = 10, B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "divide" }, th), variable = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057" }, th)
            end
          else
            f["change_variables"](self, { method = "increase", value = 1, variable = "475f4ace-928d-44ae-9cd4-653730db6e1f" }, th)
            f["change_variables"](self, { method = "increase", value = 1, variable = "dd5934c5-10d3-4807-9205-cd6fcfb5d8e4" }, th)
            f["change_variables"](self, { method = "increase", value = 1, variable = "28212a58-3dd5-4497-b5d7-ff619cd52f8f" }, th)
            if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "6092a2df-3e87-4447-8b09-b36e55b4310c" }, th), B = 1, OP = "EQ" }, th)) then
              f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = 2.5, B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "divide" }, th), variable = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057" }, th)
            elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "ce0cbfad-4568-4497-83a8-e423c872cdb1" }, th), B = 1, OP = "EQ" }, th)) then
              f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = 10, B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "divide" }, th), variable = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057" }, th)
            else
              f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = 5, B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "divide" }, th), variable = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057" }, th)
            end
          end
          if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "636f5999-3b33-4e0c-809d-ccf0da3c5550" }, th), B = 0, OP = "EQ" }, th)) then
            f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
            f["variables_set"](self, { value = f["random_num"](self, { A = 1, B = 3 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
            if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = 1, OP = "EQ" }, th)) then
              f["play_audio_and_wait"](self, { audio_id = "a24c2598-dce3-4a7e-85de-bfdca46bcb78" }, th)
            elseif V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = 2, OP = "EQ" }, th)) then
              f["play_audio_and_wait"](self, { audio_id = "b02bdbe4-007b-41f8-a1de-14a5ab6c9e88" }, th)
            else
              f["play_audio_and_wait"](self, { audio_id = "ca956ee0-1ebd-4949-b33e-7cd9400330c2" }, th)
            end
          end
        else
          if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "c06ec284-e9a2-4623-8583-77ec252a830d" }, th), B = 1, OP = "NEQ" }, th)) then
            if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "位置" }, th), B = 676, OP = "LT" }, th)) then
              f["self_set_position_y"](self, { value = f["list_item"](self, { item = "any", list = "19b1dec6-5fb5-4e67-b31c-e63f1070d435", list_index = f["script_variables_value"](self, { TEXT = "位置" }, th) }, th) }, th)
              if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), B = 1, OP = "GTE" }, th)) then
                f["change_variables"](self, { method = "increase", value = f["variables_get"](self, { variable = "3ded2f9d-1a42-43bc-b34d-4b202ef6cca7" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"位置\"}" }, th)
              else
                f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "3ded2f9d-1a42-43bc-b34d-4b202ef6cca7" }, th), B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"位置\"}" }, th)
              end
            else
              f["variables_set"](self, { value = 676, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"位置\"}" }, th)
              f["variables_set"](self, { value = 1, variable = "c06ec284-e9a2-4623-8583-77ec252a830d" }, th)
              f["variables_set"](self, { value = 1, variable = "6b4406f7-382e-4c5c-9cc2-254fd3a793f7" }, th)
              f["variables_set"](self, { value = 0, variable = "475f4ace-928d-44ae-9cd4-653730db6e1f" }, th)
              f["change_variables"](self, { method = "increase", value = 1, variable = "01e09819-e806-496f-b88c-8d472d437f9d" }, th)
              f["dispose_clone"](self, {}, th)
            end
          end
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_bae5e67c_2737_4f16_b263_cd2c7fe72436, "start_as_a_mirror", {}, function(th, self)
      while true do
        if V.bool(f["list_is_exist"](self, { list = "70b1eb77-cf13-44c5-909b-1268a3672002", list_item_value = f["get_current_clone_index"](self, {}, th) }, th)) then
          f["set_sprite_style"](self, { style_id = "8ec28a0a-5402-4814-8506-ff184edf105c" }, th)
        else
          f["set_sprite_style"](self, { style_id = "fac8e6c6-b927-4a08-8c01-1d1ec7bc8a85" }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_bae5e67c_2737_4f16_b263_cd2c7fe72436, "start_as_a_mirror", {}, function(th, self)
      f["list_append"](self, { list = "e784dfc1-2cc4-4bfe-874d-f19dced31dc4", list_item_value = f["get_current_clone_index"](self, {}, th) }, th)
      while true do
        if V.bool(f["logic_operation"](self, { A = f["logic_operation"](self, { A = f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["style_of_sprite"](self, { sprite = "--self" }, th), B = 2, OP = "EQ" }, th), B = f["bump_into"](self, { sprite = "--self", sprite1 = "02812331-bdb9-4137-8da6-c404e96a6d44" }, th), type = "and" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "c06ec284-e9a2-4623-8583-77ec252a830d" }, th), B = 0, OP = "EQ" }, th), type = "and" }, th), B = f["list_is_exist"](self, { list = "70b1eb77-cf13-44c5-909b-1268a3672002", list_item_value = f["get_current_clone_index"](self, {}, th) }, th), type = "and" }, th)) then
          do
            local _times_n1 = f["random_num"](self, { A = 5, B = 10 }, th)
            while true do
              if _times_n1 <= 0 then break end
              _times_n1 = _times_n1 - 1
              f["mirror"](self, { sprite = "bc6dac92-9220-4e38-8fbc-1ccd0cd99da3" }, th)
              if th:iter_n() then break end
            end
          end
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_bae5e67c_2737_4f16_b263_cd2c7fe72436, "start_as_a_mirror", {}, function(th, self)
      f["wait"](self, { time = 12 }, th)
      f["dispose_clone"](self, {}, th)
  end)
  rt.on(e_bae5e67c_2737_4f16_b263_cd2c7fe72436, "on_running_group_activated", {}, function(th, self)
      while true do
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "28212a58-3dd5-4497-b5d7-ff619cd52f8f" }, th), B = f["variables_get"](self, { variable = "01e09819-e806-496f-b88c-8d472d437f9d" }, th), type = "add" }, th), variable = "136bfda7-419e-46c7-8ba1-dca80f8721f3" }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_bae5e67c_2737_4f16_b263_cd2c7fe72436, "start_as_a_mirror", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "9498bf81-e46e-43f7-847b-0b3ffd0ebeb1" }, th), B = 1, OP = "EQ" }, th)) then
          do
            local _times_n1 = 10
            while true do
              if _times_n1 <= 0 then break end
              _times_n1 = _times_n1 - 1
              f["self_set_effect"](self, { scope = "2", value = 105 }, th)
              f["wait"](self, { time = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 60, B = f["variables_get"](self, { variable = "ad9ad2e0-bf30-48fd-9a36-cc64092abce3" }, th), type = "divide" }, th), B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "divide" }, th), B = f["variables_get"](self, { variable = "1f8a4269-f7f9-4790-be36-e39dfa16cca2" }, th), type = "add" }, th) }, th)
              f["self_set_effect"](self, { scope = "2", value = 100 }, th)
              f["wait"](self, { time = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 60, B = f["variables_get"](self, { variable = "ad9ad2e0-bf30-48fd-9a36-cc64092abce3" }, th), type = "divide" }, th), B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "divide" }, th), B = f["variables_get"](self, { variable = "1f8a4269-f7f9-4790-be36-e39dfa16cca2" }, th), type = "add" }, th) }, th)
              if th:iter_n() then break end
            end
          end
          while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "9498bf81-e46e-43f7-847b-0b3ffd0ebeb1" }, th), B = 0, OP = "EQ" }, th)) do
            if th:iter_n() then break end
          end
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_bae5e67c_2737_4f16_b263_cd2c7fe72436, "start_as_a_mirror", {}, function(th, self)
      while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "c06ec284-e9a2-4623-8583-77ec252a830d" }, th), B = 1, OP = "EQ" }, th)) do
        if th:iter_n() then break end
      end
      f["delete_list_item"](self, { item = "any", list = "e784dfc1-2cc4-4bfe-874d-f19dced31dc4", list_index = f["list_index_of"](self, { list = "e784dfc1-2cc4-4bfe-874d-f19dced31dc4", list_item_value = f["get_current_clone_index"](self, {}, th) }, th) }, th)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "cbf08b77-0b7f-43cb-81c0-6d68e8695793" }, th), B = 0, OP = "EQ" }, th)) then
        do
          local _from_n1, _to_n1 = tonumber(1), tonumber(100)
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
              f["self_set_position_y"](self, { value = (th:call_proc(proc_ec2362be_da94_4df9_9ea3_72ccff65a8ab, self, -175, -180, "渐陡n次", 8.75, _p_n1)) }, th)
              f["self_set_effect"](self, { scope = "1", value = (th:call_proc(proc_ec2362be_da94_4df9_9ea3_72ccff65a8ab, self, 25, 100, "渐缓n次", 35, _p_n1)) }, th)
              f["set_scale"](self, { scale = (th:call_proc(proc_ec2362be_da94_4df9_9ea3_72ccff65a8ab, self, 63, 1, "渐缓n次", 35, _p_n1)) }, th)
                th:pop_param()
                _p_n1 = _p_n1 + _by_n1
                if th:iter_n() then break end
              end
            end
          end
        end
      end
      f["dispose_clone"](self, {}, th)
  end)
  rt.on(e_bae5e67c_2737_4f16_b263_cd2c7fe72436, "on_running_group_activated", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      f["variables_set"](self, { value = 500, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
      th:warp_enter()
      do
        local _times_n2 = 676
        while true do
          if _times_n2 <= 0 then break end
          _times_n2 = _times_n2 - 1
          f["list_append"](self, { list = "19b1dec6-5fb5-4e67-b31c-e63f1070d435", list_item_value = f["script_variables_value"](self, { TEXT = "a" }, th) }, th)
          f["change_variables"](self, { method = "decrease", value = 1, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
          if th:iter_w() then break end
        end
      end
      th:warp_exit()
  end)
  -- -------- 角色 combo --------
  rt.on(e_58eadc2b_0e03_4346_bf4f_ba964fa14080, "on_running_group_activated", {}, function(th, self)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      f["self_text_effect_size"](self, { size = 50 }, th)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "475f4ace-928d-44ae-9cd4-653730db6e1f" }, th), B = 0, OP = "NEQ" }, th)) then
          f["self_text_effect_color"](self, { color = "#ffffff" }, th)
          f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = f["variables_get"](self, { variable = "475f4ace-928d-44ae-9cd4-653730db6e1f" }, th), ADD1 = "x" }, th) }, th)
          f["wait"](self, { time = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 60, B = f["variables_get"](self, { variable = "ad9ad2e0-bf30-48fd-9a36-cc64092abce3" }, th), type = "divide" }, th), B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "divide" }, th) }, th)
          f["self_text_effect_size"](self, { size = 50 }, th)
        elseif V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "6b4406f7-382e-4c5c-9cc2-254fd3a793f7" }, th), B = 1, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "475f4ace-928d-44ae-9cd4-653730db6e1f" }, th), B = 0, OP = "EQ" }, th), type = "and" }, th)) then
          f["self_text_effect_color"](self, { color = "#ff0000" }, th)
          f["self_text_effect_size"](self, { size = 50 }, th)
          f["self_text_effect_text"](self, { text = "miss!" }, th)
          if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "6092a2df-3e87-4447-8b09-b36e55b4310c" }, th), B = 0, OP = "EQ" }, th)) then
            f["change_variables"](self, { method = "decrease", value = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), B = f["variables_get"](self, { variable = "01e09819-e806-496f-b88c-8d472d437f9d" }, th), type = "multiply" }, th), variable = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057" }, th)
          elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "ce0cbfad-4568-4497-83a8-e423c872cdb1" }, th), B = 1, OP = "EQ" }, th)) then
            f["change_variables"](self, { method = "decrease", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), B = f["variables_get"](self, { variable = "01e09819-e806-496f-b88c-8d472d437f9d" }, th), type = "multiply" }, th), B = 9, type = "divide" }, th), variable = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057" }, th)
          else
            f["change_variables"](self, { method = "decrease", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), B = f["variables_get"](self, { variable = "01e09819-e806-496f-b88c-8d472d437f9d" }, th), type = "multiply" }, th), B = 9, type = "multiply" }, th), variable = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057" }, th)
          end
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_58eadc2b_0e03_4346_bf4f_ba964fa14080, "on_running_group_activated", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "475f4ace-928d-44ae-9cd4-653730db6e1f" }, th), B = f["script_variables_value"](self, { TEXT = "a" }, th), OP = "NEQ" }, th)) then
          f["self_text_effect_size"](self, { size = 60 }, th)
          f["variables_set"](self, { value = f["variables_get"](self, { variable = "475f4ace-928d-44ae-9cd4-653730db6e1f" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_58eadc2b_0e03_4346_bf4f_ba964fa14080, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "475f4ace-928d-44ae-9cd4-653730db6e1f" }, th), B = f["variables_get"](self, { variable = "932ebbc7-efcb-4bd4-8ed3-a361bffde8c7" }, th), OP = "GT" }, th)) then
          f["variables_set"](self, { value = f["variables_get"](self, { variable = "475f4ace-928d-44ae-9cd4-653730db6e1f" }, th), variable = "932ebbc7-efcb-4bd4-8ed3-a361bffde8c7" }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_58eadc2b_0e03_4346_bf4f_ba964fa14080, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_set_position_x"](self, { value = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "02812331-bdb9-4137-8da6-c404e96a6d44" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_58eadc2b_0e03_4346_bf4f_ba964fa14080, "on_running_group_activated", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      while true do
        while not V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "6b4406f7-382e-4c5c-9cc2-254fd3a793f7" }, th), B = 1, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "475f4ace-928d-44ae-9cd4-653730db6e1f" }, th), B = 0, OP = "EQ" }, th), type = "and" }, th)) do
          if th:iter_n() then break end
        end
        f["variables_set"](self, { value = f["variables_get"](self, { variable = "475f4ace-928d-44ae-9cd4-653730db6e1f" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "6b4406f7-382e-4c5c-9cc2-254fd3a793f7" }, th), B = 1, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "475f4ace-928d-44ae-9cd4-653730db6e1f" }, th), B = 0, OP = "EQ" }, th), type = "and" }, th)) then
          if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "636f5999-3b33-4e0c-809d-ccf0da3c5550" }, th), B = 0, OP = "EQ" }, th)) then
            th:call_proc(proc_c2116d3b_38ff_4bf0_a4b6_eec9fe9f1f89, self)
          end
          while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "475f4ace-928d-44ae-9cd4-653730db6e1f" }, th), B = f["script_variables_value"](self, { TEXT = "a" }, th), OP = "NEQ" }, th)) do
            if th:iter_n() then break end
          end
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 maxcombo --------
  rt.on(e_3455f327_6d7e_4d65_ba42_c86119348064, "on_running_group_activated", {}, function(th, self)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      f["self_text_effect_size"](self, { size = 24 }, th)
      while true do
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "932ebbc7-efcb-4bd4-8ed3-a361bffde8c7" }, th), B = 0, OP = "NEQ" }, th)) do
          if th:iter_n() then break end
        end
        f["self_appear"](self, { value = "appear" }, th)
        f["self_text_effect_color"](self, { color = "#ffffff" }, th)
        f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = "MC:", ADD1 = f["variables_get"](self, { variable = "932ebbc7-efcb-4bd4-8ed3-a361bffde8c7" }, th), ADD2 = "x" }, th) }, th)
        f["wait"](self, { time = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 60, B = f["variables_get"](self, { variable = "ad9ad2e0-bf30-48fd-9a36-cc64092abce3" }, th), type = "divide" }, th), B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "divide" }, th) }, th)
        f["self_text_effect_size"](self, { size = 24 }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_3455f327_6d7e_4d65_ba42_c86119348064, "on_running_group_activated", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "932ebbc7-efcb-4bd4-8ed3-a361bffde8c7" }, th), B = f["script_variables_value"](self, { TEXT = "a" }, th), OP = "NEQ" }, th)) then
          f["self_text_effect_size"](self, { size = 28 }, th)
          f["variables_set"](self, { value = f["variables_get"](self, { variable = "932ebbc7-efcb-4bd4-8ed3-a361bffde8c7" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_3455f327_6d7e_4d65_ba42_c86119348064, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_set_position_x"](self, { value = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "02812331-bdb9-4137-8da6-c404e96a6d44" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 判定盘子 --------
  rt.on(e_02812331_bdb9_4137_8da6_c404e96a6d44, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), B = 376, OP = "GTE" }, th)) then
          f["self_set_position_x"](self, { value = 375 }, th)
        elseif V.bool(f["logic_compare"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), B = -376, OP = "LTE" }, th)) then
          f["self_set_position_x"](self, { value = -375 }, th)
        else
          if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "c9d0fc4b-f607-4b77-829d-41361fbcabe9" }, th), B = 0, OP = "EQ" }, th), B = f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "4c3a9fa3-347b-4fc8-9fd0-4ad8acee6668" }, th), B = 0, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "b3145a6b-660c-4ab0-8a52-6075eb193af2" }, th), B = 0, OP = "EQ" }, th), type = "and" }, th), type = "and" }, th)) then
            if V.bool(f["check_key"](self, { key = "65", type = "down" }, th)) then
              f["self_change_coordinate_x"](self, { increase = "decrease", value = f["variables_get"](self, { variable = "61c6de7f-432c-48fc-b3d8-e14a59f273ba" }, th) }, th)
            elseif V.bool(f["check_key"](self, { key = "83", type = "down" }, th)) then
              f["self_change_coordinate_x"](self, { increase = "increase", value = f["variables_get"](self, { variable = "61c6de7f-432c-48fc-b3d8-e14a59f273ba" }, th) }, th)
            elseif V.bool(f["check_key"](self, { key = "68", type = "down" }, th)) then
              f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "0d867230-f0d8-4115-bc7b-81cf2db5a9a3" }, th), B = f["variables_get"](self, { variable = "a27f3ca2-bd4a-47b8-a161-87a39d14f03a" }, th), type = "add" }, th), variable = "61c6de7f-432c-48fc-b3d8-e14a59f273ba" }, th)
              f["set_sprite_style"](self, { style_id = "f4045fe6-7447-4944-9d8d-53fa485fc125" }, th)
            else
              f["variables_set"](self, { value = f["variables_get"](self, { variable = "0d867230-f0d8-4115-bc7b-81cf2db5a9a3" }, th), variable = "61c6de7f-432c-48fc-b3d8-e14a59f273ba" }, th)
              f["set_sprite_style"](self, { style_id = "0847ce7f-d4f3-44e7-97f4-01a035f27096" }, th)
            end
          elseif V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "c9d0fc4b-f607-4b77-829d-41361fbcabe9" }, th), B = 1, OP = "EQ" }, th), B = f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "4c3a9fa3-347b-4fc8-9fd0-4ad8acee6668" }, th), B = 0, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "b3145a6b-660c-4ab0-8a52-6075eb193af2" }, th), B = 0, OP = "EQ" }, th), type = "and" }, th), type = "and" }, th)) then
            if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "3e0c81bd-95da-4454-816f-21a689fd5f58" }, th), B = 0, OP = "EQ" }, th)) then
              if V.bool(f["logic_compare"](self, { A = f["get_mouse_info"](self, { type = "x" }, th), B = 376, OP = "GTE" }, th)) then
                f["self_set_position_x"](self, { value = 375 }, th)
              elseif V.bool(f["logic_compare"](self, { A = f["get_mouse_info"](self, { type = "x" }, th), B = -376, OP = "LTE" }, th)) then
                f["self_set_position_x"](self, { value = -375 }, th)
              else
                f["self_set_position_x"](self, { value = f["get_mouse_info"](self, { type = "x" }, th) }, th)
              end
            else
              if V.bool(f["logic_compare"](self, { A = f["get_mouse_info"](self, { type = "x" }, th), B = 376, OP = "GTE" }, th)) then
                f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 375, B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = f["math_arithmetic"](self, { A = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "1f9decff-97e1-4f33-8ae8-28b8e121229d" }, th), B = 1, type = "add" }, th), type = "1" }, th), B = 1, type = "add" }, th), type = "divide" }, th) }, th)
              elseif V.bool(f["logic_compare"](self, { A = f["get_mouse_info"](self, { type = "x" }, th), B = -376, OP = "LTE" }, th)) then
                f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = -375, B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = f["math_arithmetic"](self, { A = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "1f9decff-97e1-4f33-8ae8-28b8e121229d" }, th), B = 1, type = "add" }, th), type = "1" }, th), B = 1, type = "add" }, th), type = "divide" }, th) }, th)
              else
                f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["get_mouse_info"](self, { type = "x" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = f["math_arithmetic"](self, { A = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "1f9decff-97e1-4f33-8ae8-28b8e121229d" }, th), B = 1, type = "add" }, th), type = "1" }, th), B = 1, type = "add" }, th), type = "divide" }, th) }, th)
              end
            end
          end
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_02812331_bdb9_4137_8da6_c404e96a6d44, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), B = 0, OP = "EQ" }, th)) then
          f["variables_set"](self, { value = 1, variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_02812331_bdb9_4137_8da6_c404e96a6d44, "on_running_group_activated", {}, function(th, self)
      th:warp_enter()
      do
        local _from_n2, _to_n2 = tonumber(1), tonumber(100)
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
            f["list_append"](self, { list = "70b1eb77-cf13-44c5-909b-1268a3672002", list_item_value = f["math_arithmetic"](self, { A = 25, B = _p_n2, type = "multiply" }, th) }, th)
              th:pop_param()
              _p_n2 = _p_n2 + _by_n2
              if th:iter_w() then break end
            end
          end
        end
      end
      th:warp_exit()
  end)
  rt.on(e_02812331_bdb9_4137_8da6_c404e96a6d44, "on_running_group_activated", {}, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 0, OP = "EQ" }, th)) then
        f["set_timer_state"](self, { type = "start" }, th)
      end
      while true do
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["timer"](self, {}, th), B = 1000, type = "multiply" }, th), variable = "de704f61-3833-409d-8de2-f9a3852a822b" }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_02812331_bdb9_4137_8da6_c404e96a6d44, "on_running_group_activated", {}, function(th, self)
      while not V.bool(f["logic_compare"](self, { A = f["get_clone_num"](self, { sprite = "bae5e67c-2737-4f16-b263-cd2c7fe72436" }, th), B = 0, OP = "NEQ" }, th)) do
        if th:iter_n() then break end
      end
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "4c3a9fa3-347b-4fc8-9fd0-4ad8acee6668" }, th), B = 1, OP = "EQ" }, th)) then
          if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "0e5b8264-119d-4030-8b02-ac263239ad6b" }, th), B = 0, OP = "NEQ" }, th)) then
            if V.bool(f["logic_compare"](self, { A = f["list_length"](self, { list = "e784dfc1-2cc4-4bfe-874d-f19dced31dc4" }, th), B = f["variables_get"](self, { variable = "dd5934c5-10d3-4807-9205-cd6fcfb5d8e4" }, th), OP = "GTE" }, th)) then
              if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th), B = 45, OP = "LTE" }, th)) then
                f["self_set_position_x"](self, { value = f["get_clone_index_property"](self, { attribute = "x", index = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "dd5934c5-10d3-4807-9205-cd6fcfb5d8e4" }, th), B = f["math_arithmetic"](self, { A = 1, B = f["variables_get"](self, { variable = "01e09819-e806-496f-b88c-8d472d437f9d" }, th), type = "add" }, th), type = "add" }, th), sprite = "bae5e67c-2737-4f16-b263-cd2c7fe72436" }, th) }, th)
              else
                f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["get_clone_index_property"](self, { attribute = "x", index = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "dd5934c5-10d3-4807-9205-cd6fcfb5d8e4" }, th), B = f["math_arithmetic"](self, { A = 1, B = f["variables_get"](self, { variable = "01e09819-e806-496f-b88c-8d472d437f9d" }, th), type = "add" }, th), type = "add" }, th), sprite = "bae5e67c-2737-4f16-b263-cd2c7fe72436" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 2, type = "divide" }, th) }, th)
              end
            end
          else
            if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th), B = 45, OP = "LTE" }, th)) then
              f["self_set_position_x"](self, { value = f["get_clone_index_property"](self, { attribute = "x", index = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "dd5934c5-10d3-4807-9205-cd6fcfb5d8e4" }, th), B = f["math_arithmetic"](self, { A = 1, B = f["variables_get"](self, { variable = "01e09819-e806-496f-b88c-8d472d437f9d" }, th), type = "add" }, th), type = "add" }, th), sprite = "bae5e67c-2737-4f16-b263-cd2c7fe72436" }, th) }, th)
            else
              f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["get_clone_index_property"](self, { attribute = "x", index = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "dd5934c5-10d3-4807-9205-cd6fcfb5d8e4" }, th), B = f["math_arithmetic"](self, { A = 1, B = f["variables_get"](self, { variable = "01e09819-e806-496f-b88c-8d472d437f9d" }, th), type = "add" }, th), type = "add" }, th), sprite = "bae5e67c-2737-4f16-b263-cd2c7fe72436" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 2, type = "divide" }, th) }, th)
            end
          end
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_02812331_bdb9_4137_8da6_c404e96a6d44, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "c9d0fc4b-f607-4b77-829d-41361fbcabe9" }, th), B = 0, OP = "EQ" }, th), B = f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "4c3a9fa3-347b-4fc8-9fd0-4ad8acee6668" }, th), B = 0, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "b3145a6b-660c-4ab0-8a52-6075eb193af2" }, th), B = 0, OP = "EQ" }, th), type = "and" }, th), type = "and" }, th)) then
          if V.bool(f["check_key"](self, { key = "68", type = "down" }, th)) then
            f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "0d867230-f0d8-4115-bc7b-81cf2db5a9a3" }, th), B = f["variables_get"](self, { variable = "a27f3ca2-bd4a-47b8-a161-87a39d14f03a" }, th), type = "add" }, th), variable = "61c6de7f-432c-48fc-b3d8-e14a59f273ba" }, th)
            f["set_sprite_style"](self, { style_id = "f4045fe6-7447-4944-9d8d-53fa485fc125" }, th)
          else
            f["variables_set"](self, { value = f["variables_get"](self, { variable = "0d867230-f0d8-4115-bc7b-81cf2db5a9a3" }, th), variable = "61c6de7f-432c-48fc-b3d8-e14a59f273ba" }, th)
            f["set_sprite_style"](self, { style_id = "0847ce7f-d4f3-44e7-97f4-01a035f27096" }, th)
          end
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_02812331_bdb9_4137_8da6_c404e96a6d44, "on_running_group_activated", {}, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "b3145a6b-660c-4ab0-8a52-6075eb193af2" }, th), B = 1, OP = "EQ" }, th)) then
        while not V.bool(f["logic_compare"](self, { A = f["get_clone_num"](self, { sprite = "bae5e67c-2737-4f16-b263-cd2c7fe72436" }, th), B = 0, OP = "NEQ" }, th)) do
          if th:iter_n() then break end
        end
        f["script_variables"](self, { PARAMS0 = nil, PARAMS1 = nil, name = "距离", names = { "距离", "距离备份" } }, th)
        while true do
          f["self_dialog_wait"](self, { text = f["text_join"](self, { ADD0 = f["script_variables_value"](self, { TEXT = "距离" }, th), ADD1 = ",", ADD2 = f["variables_get"](self, { variable = "a7ed459f-07be-4a1b-89ae-76522c2a6759" }, th), ADD3 = "PP" }, th), type = "talk" }, th)
          f["variables_set"](self, { value = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), B = f["get_clone_index_property"](self, { attribute = "x", index = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "dd5934c5-10d3-4807-9205-cd6fcfb5d8e4" }, th), B = f["math_arithmetic"](self, { A = 1, B = f["variables_get"](self, { variable = "01e09819-e806-496f-b88c-8d472d437f9d" }, th), type = "add" }, th), type = "add" }, th), sprite = "bae5e67c-2737-4f16-b263-cd2c7fe72436" }, th), type = "minus" }, th), type = "1" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"距离\"}" }, th)
          if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "距离" }, th), B = 21, OP = "GTE" }, th)) then
            f["set_sprite_style"](self, { style_id = "f4045fe6-7447-4944-9d8d-53fa485fc125" }, th)
            f["self_glide_to"](self, { time = 0.15, x = f["get_clone_index_property"](self, { attribute = "x", index = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "dd5934c5-10d3-4807-9205-cd6fcfb5d8e4" }, th), B = f["math_arithmetic"](self, { A = 1, B = f["variables_get"](self, { variable = "01e09819-e806-496f-b88c-8d472d437f9d" }, th), type = "add" }, th), type = "add" }, th), sprite = "bae5e67c-2737-4f16-b263-cd2c7fe72436" }, th), y = -175 }, th)
            f["set_sprite_style"](self, { style_id = "0847ce7f-d4f3-44e7-97f4-01a035f27096" }, th)
          elseif V.bool((th:call_proc(proc_3f828bd5_c7a9_49bb_b2a1_18706f17bfde, self, f["script_variables_value"](self, { TEXT = "距离" }, th), 10, 21))) then
            f["variables_set"](self, { value = f["script_variables_value"](self, { TEXT = "距离" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"距离备份\"}" }, th)
            if V.bool(f["logic_compare"](self, { A = f["get_clone_index_property"](self, { attribute = "x", index = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "dd5934c5-10d3-4807-9205-cd6fcfb5d8e4" }, th), B = f["math_arithmetic"](self, { A = 1, B = f["variables_get"](self, { variable = "01e09819-e806-496f-b88c-8d472d437f9d" }, th), type = "add" }, th), type = "add" }, th), sprite = "bae5e67c-2737-4f16-b263-cd2c7fe72436" }, th), B = 0, OP = "LT" }, th)) then
              f["set_sprite_style"](self, { style_id = "f4045fe6-7447-4944-9d8d-53fa485fc125" }, th)
              f["self_change_coordinate_x"](self, { increase = "decrease", value = f["script_variables_value"](self, { TEXT = "距离备份" }, th) }, th)
            else
              f["set_sprite_style"](self, { style_id = "f4045fe6-7447-4944-9d8d-53fa485fc125" }, th)
              f["self_change_coordinate_x"](self, { increase = "increase", value = f["script_variables_value"](self, { TEXT = "距离备份" }, th) }, th)
            end
          elseif V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "距离" }, th), B = 10, OP = "LTE" }, th)) then
            f["variables_set"](self, { value = f["script_variables_value"](self, { TEXT = "距离" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"距离备份\"}" }, th)
            if V.bool(f["logic_compare"](self, { A = f["get_clone_index_property"](self, { attribute = "x", index = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "dd5934c5-10d3-4807-9205-cd6fcfb5d8e4" }, th), B = f["math_arithmetic"](self, { A = 1, B = f["variables_get"](self, { variable = "01e09819-e806-496f-b88c-8d472d437f9d" }, th), type = "add" }, th), type = "add" }, th), sprite = "bae5e67c-2737-4f16-b263-cd2c7fe72436" }, th), B = 0, OP = "LT" }, th)) then
              f["set_sprite_style"](self, { style_id = "0847ce7f-d4f3-44e7-97f4-01a035f27096" }, th)
              f["self_change_coordinate_x"](self, { increase = "decrease", value = f["script_variables_value"](self, { TEXT = "距离备份" }, th) }, th)
            else
              f["set_sprite_style"](self, { style_id = "0847ce7f-d4f3-44e7-97f4-01a035f27096" }, th)
              f["self_change_coordinate_x"](self, { increase = "increase", value = f["script_variables_value"](self, { TEXT = "距离备份" }, th) }, th)
            end
          end
          if th:iter_n() then break end
        end
      end
  end)
  rt.on(e_02812331_bdb9_4137_8da6_c404e96a6d44, "on_running_group_activated", {}, function(th, self)
      while true do
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["get_mouse_info"](self, { type = "x" }, th), B = f["variables_get"](self, { variable = "8873b32e-8677-4c05-a854-178cde7a8bbf" }, th), type = "minus" }, th), variable = "1f9decff-97e1-4f33-8ae8-28b8e121229d" }, th)
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["get_mouse_info"](self, { type = "y" }, th), B = f["variables_get"](self, { variable = "074e8e18-1e0f-460e-9cc2-b286de92d78a" }, th), type = "minus" }, th), variable = "a2015a4c-a332-4150-a00b-68ebe70aef8c" }, th)
        f["variables_set"](self, { value = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "1f9decff-97e1-4f33-8ae8-28b8e121229d" }, th), B = f["variables_get"](self, { variable = "1f9decff-97e1-4f33-8ae8-28b8e121229d" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "a2015a4c-a332-4150-a00b-68ebe70aef8c" }, th), B = f["variables_get"](self, { variable = "a2015a4c-a332-4150-a00b-68ebe70aef8c" }, th), type = "multiply" }, th), type = "add" }, th), type = "0" }, th), variable = "3cfd462f-655e-4fd0-98dd-71391586fe0a" }, th)
        f["variables_set"](self, { value = f["get_mouse_info"](self, { type = "x" }, th), variable = "8873b32e-8677-4c05-a854-178cde7a8bbf" }, th)
        f["variables_set"](self, { value = f["get_mouse_info"](self, { type = "y" }, th), variable = "074e8e18-1e0f-460e-9cc2-b286de92d78a" }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 circle粒子 --------
  rt.on(e_bc6dac92_9220_4e38_8fbc_1ccd0cd99da3, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_set_effect"](self, { scope = "0", value = f["effect_of_sprite"](self, { effect = "0", sprite = "bae5e67c-2737-4f16-b263-cd2c7fe72436" }, th) }, th)
        f["self_set_position_x"](self, { value = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "02812331-bdb9-4137-8da6-c404e96a6d44" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_bc6dac92_9220_4e38_8fbc_1ccd0cd99da3, "start_as_a_mirror", {}, function(th, self)
      if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = -90, B = f["appearance_of_sprite"](self, { appearance = "direction", sprite = "--self" }, th), OP = "LT" }, th), B = f["logic_compare"](self, { A = f["appearance_of_sprite"](self, { appearance = "direction", sprite = "--self" }, th), B = 90, OP = "LT" }, th), type = "and" }, th)) then
        f["variables_set"](self, { value = 9, variable = "e4184d1d-c4f8-4320-bbc6-602a4808e474" }, th)
        do
          local _times_n2 = 8
          while true do
            if _times_n2 <= 0 then break end
            _times_n2 = _times_n2 - 1
            f["self_go_forward"](self, { steps = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "e4184d1d-c4f8-4320-bbc6-602a4808e474" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "932ebbc7-efcb-4bd4-8ed3-a361bffde8c7" }, th), B = 1.5, type = "divide" }, th), type = "multiply" }, th), type = "2" }, th) }, th)
            f["change_variables"](self, { method = "decrease", value = 1, variable = "e4184d1d-c4f8-4320-bbc6-602a4808e474" }, th)
            f["self_go_forward"](self, { steps = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "e4184d1d-c4f8-4320-bbc6-602a4808e474" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "932ebbc7-efcb-4bd4-8ed3-a361bffde8c7" }, th), B = 1.5, type = "divide" }, th), type = "multiply" }, th) }, th)
            if th:iter_n() then break end
          end
        end
      else
        do
          local _times_n3 = 8
          while true do
            if _times_n3 <= 0 then break end
            _times_n3 = _times_n3 - 1
            f["self_go_forward"](self, { steps = 50 }, th)
            if th:iter_n() then break end
          end
        end
      end
  end)
  rt.on(e_bc6dac92_9220_4e38_8fbc_1ccd0cd99da3, "start_as_a_mirror", {}, function(th, self)
      f["set_scale"](self, { scale = f["random_num"](self, { A = 0, B = 20 }, th) }, th)
      f["self_point_towards"](self, { degrees = f["random_num"](self, { A = 0, B = 360 }, th) }, th)
      if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = -90, B = f["appearance_of_sprite"](self, { appearance = "direction", sprite = "--self" }, th), OP = "LT" }, th), B = f["logic_compare"](self, { A = f["appearance_of_sprite"](self, { appearance = "direction", sprite = "--self" }, th), B = 90, OP = "LT" }, th), type = "and" }, th)) then
        do
          local _times_n4 = 10
          while true do
            if _times_n4 <= 0 then break end
            _times_n4 = _times_n4 - 1
            f["self_change_coordinate_y"](self, { increase = "increase", value = 1 }, th)
            if th:iter_n() then break end
          end
        end
      end
      f["variables_set"](self, { value = 0, variable = "e4184d1d-c4f8-4320-bbc6-602a4808e474" }, th)
      while true do
        if f["logic_operation"](self, { A = f["bump_into"](self, { sprite = "--self", sprite1 = "--edge_bottom" }, th), B = f["logic_operation"](self, { A = f["bump_into"](self, { sprite = "--self", sprite1 = "--edge_right" }, th), B = f["bump_into"](self, { sprite = "--self", sprite1 = "--edge_left" }, th), type = "or" }, th), type = "or" }, th) then break end
        f["change_variables"](self, { method = "increase", value = 1, variable = "e4184d1d-c4f8-4320-bbc6-602a4808e474" }, th)
        f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = -1, B = f["variables_get"](self, { variable = "e4184d1d-c4f8-4320-bbc6-602a4808e474" }, th), type = "multiply" }, th) }, th)
        if th:iter_n() then break end
      end
      f["dispose_clone"](self, {}, th)
  end)
  rt.on(e_bc6dac92_9220_4e38_8fbc_1ccd0cd99da3, "start_as_a_mirror", {}, function(th, self)
      while true do
        if f["logic_compare"](self, { A = f["variables_get"](self, { variable = "475f4ace-928d-44ae-9cd4-653730db6e1f" }, th), B = 0, OP = "EQ" }, th) then break end
        f["self_change_effect"](self, { increase = "increase", scope = "0", value = f["variables_get"](self, { variable = "e4184d1d-c4f8-4320-bbc6-602a4808e474" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_bc6dac92_9220_4e38_8fbc_1ccd0cd99da3, "start_as_a_mirror", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      while true do
        f["variables_set"](self, { value = f["variables_get"](self, { variable = "76acb1a2-e19a-4b72-8636-1ef70256e584" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        if V.bool(f["bump_into"](self, { sprite = "--self", sprite1 = "02812331-bdb9-4137-8da6-c404e96a6d44" }, th)) then
          f["change_variables"](self, { method = "increase", value = 1, variable = "76acb1a2-e19a-4b72-8636-1ef70256e584" }, th)
          if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "636f5999-3b33-4e0c-809d-ccf0da3c5550" }, th), B = 0, OP = "EQ" }, th)) then
            f["play_audio_and_wait"](self, { audio_id = "1bc00556-cb31-4b91-a552-712242e0e2b9" }, th)
          end
          while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "76acb1a2-e19a-4b72-8636-1ef70256e584" }, th), B = f["script_variables_value"](self, { TEXT = "a" }, th), OP = "NEQ" }, th)) do
            if th:iter_n() then break end
          end
          f["dispose_clone"](self, {}, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_bc6dac92_9220_4e38_8fbc_1ccd0cd99da3, "start_as_a_mirror", {}, function(th, self)
      f["wait"](self, { time = 5 }, th)
      f["dispose_clone"](self, {}, th)
  end)
  rt.on(e_bc6dac92_9220_4e38_8fbc_1ccd0cd99da3, "start_as_a_mirror", {}, function(th, self)
      while true do
        if V.bool(f["logic_operation"](self, { A = f["bump_into"](self, { sprite = "--self", sprite1 = "--edge_bottom" }, th), B = f["logic_operation"](self, { A = f["bump_into"](self, { sprite = "--self", sprite1 = "--edge_right" }, th), B = f["bump_into"](self, { sprite = "--self", sprite1 = "--edge_left" }, th), type = "or" }, th), type = "or" }, th)) then
          f["dispose_clone"](self, {}, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 now --------
  rt.on(e_732e3434_f07d_43e1_993b_e50b96038c21, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.1, type = "multiply" }, th), B = 0.5, type = "multiply" }, th), B = 0, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
          f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th), B = 0.5, type = "multiply" }, th), B = 0, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        else
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.1, type = "multiply" }, th), B = 0.5, type = "multiply" }, th), B = -100, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
          f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th), B = 0.5, type = "multiply" }, th), B = 0, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_732e3434_f07d_43e1_993b_e50b96038c21, "on_running_group_activated", {}, function(th, self)
      while true do
        f["set_scale"](self, { scale = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "810d5972-9f94-47ac-a461-4df7e286dba4" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_732e3434_f07d_43e1_993b_e50b96038c21, "sprite_on_tap", { sprite = "--self", type = "mouse_click" }, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
        f["variables_set"](self, { value = 1, variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th)
      else
        f["variables_set"](self, { value = 0, variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th)
      end
  end)
  rt.on(e_732e3434_f07d_43e1_993b_e50b96038c21, "sprite_on_tap", { sprite = "810d5972-9f94-47ac-a461-4df7e286dba4", type = "mouse_click" }, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
        f["variables_set"](self, { value = 1, variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th)
      else
        f["variables_set"](self, { value = 0, variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th)
      end
  end)
  rt.on(e_732e3434_f07d_43e1_993b_e50b96038c21, "sprite_on_tap", { sprite = "c73c5c69-2217-4d2b-a3b8-87c9aa01109c", type = "mouse_click" }, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
        f["variables_set"](self, { value = 1, variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th)
      else
        f["variables_set"](self, { value = 0, variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th)
      end
  end)
  rt.on(e_732e3434_f07d_43e1_993b_e50b96038c21, "on_running_group_activated", {}, function(th, self)
      while true do
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 1, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        f["wait"](self, { time = 5 }, th)
        f["variables_set"](self, { value = 0, variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_732e3434_f07d_43e1_993b_e50b96038c21, "on_running_group_activated", {}, function(th, self)
      while true do
        f["set_sprite_style"](self, { style_id = f["variables_get"](self, { variable = "efbd5674-1882-4100-8bdf-0da4fd837f2a" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 星 --------
  rt.on(e_323d1935_4d82_4c9a_87f2_3d47e8592d30, "on_running_group_activated", {}, function(th, self)
      f["variables_set"](self, { value = 1, variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th)
      f["self_text_effect_size"](self, { size = 24 }, th)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "6092a2df-3e87-4447-8b09-b36e55b4310c" }, th), B = 1, OP = "EQ" }, th)) then
          f["self_text_effect_text"](self, { text = "Hard Core模式" }, th)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "ce0cbfad-4568-4497-83a8-e423c872cdb1" }, th), B = 1, OP = "EQ" }, th)) then
          f["self_text_effect_text"](self, { text = "Eazy模式" }, th)
        else
          f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = "当前难度：", ADD1 = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), ADD2 = "⭐" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_323d1935_4d82_4c9a_87f2_3d47e8592d30, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["get_mouse_info"](self, { type = "x" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.05, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = 0, type = "add" }, th), y = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["get_mouse_info"](self, { type = "y" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 0.02, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = -180, type = "add" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_323d1935_4d82_4c9a_87f2_3d47e8592d30, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "6092a2df-3e87-4447-8b09-b36e55b4310c" }, th), B = 1, OP = "EQ" }, th)) then
          f["variables_set"](self, { value = 3, variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "ce0cbfad-4568-4497-83a8-e423c872cdb1" }, th), B = 1, OP = "EQ" }, th)) then
          f["variables_set"](self, { value = 0.1, variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_323d1935_4d82_4c9a_87f2_3d47e8592d30, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.1 }, th)
        else
          f["self_gradually_show_hide"](self, { show_hide = "show", time = 0.1 }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 开始 --------
  rt.on(e_c1af39b1_f7d2_4a95_bc40_37cd94c16816, "on_running_group_activated", {}, function(th, self)
      th:call_proc(proc_fde38e22_9be0_4d77_8605_5a4e38f5270c, self)
  end)
  rt.on(e_c1af39b1_f7d2_4a95_bc40_37cd94c16816, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.02, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = 550, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 3, type = "divide" }, th) }, th)
        else
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.02, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = 51, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 3, type = "divide" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_c1af39b1_f7d2_4a95_bc40_37cd94c16816, "on_running_group_activated", {}, function(th, self)
      f["self_set_role_camp"](self, { role_camp = "camp_red" }, th)
  end)
  rt.on(e_c1af39b1_f7d2_4a95_bc40_37cd94c16816, "when", { cond = function(th, self) return f["logic_operation"](self, { A = f["mouse_down"](self, { sprite = "--screen", type = "up" }, th), B = f["bump_into"](self, { sprite = "--self", sprite1 = "--mouse" }, th), type = "and" }, th) end }, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "961c59df-040f-44d3-91c6-6a0330ead0d2" }, th), B = 1, OP = "EQ" }, th)) then
        f["set_timer_state"](self, { type = "stop" }, th)
        f["set_timer_state"](self, { type = "reset" }, th)
        th:call_proc(proc_4c20d971_9c2e_4f69_8a28_f808e89f0a62, self)
        f["variables_set"](self, { value = 0, variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th)
        f["variables_set"](self, { value = 0, variable = "661345c6-cc87-4b50-9937-dec0fc714cfd" }, th)
        f["variables_set"](self, { value = 1, variable = "0d334e44-f97e-4c6e-bf88-025706398657" }, th)
        f["stop_audio"](self, { audio_id = "all_audio" }, th)
        f["set_screen_transition"](self, { type = "fade_in_out" }, th)
        f["switch_to_screen"](self, { screen_id = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, th)
      end
  end)
  rt.on(e_c1af39b1_f7d2_4a95_bc40_37cd94c16816, "sprite_on_tap", { sprite = "--self", type = "mouse_click" }, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "961c59df-040f-44d3-91c6-6a0330ead0d2" }, th), B = 1, OP = "EQ" }, th)) then
        f["set_timer_state"](self, { type = "stop" }, th)
        f["set_timer_state"](self, { type = "reset" }, th)
        th:call_proc(proc_4c20d971_9c2e_4f69_8a28_f808e89f0a62, self)
        f["variables_set"](self, { value = 0, variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th)
        f["variables_set"](self, { value = 0, variable = "661345c6-cc87-4b50-9937-dec0fc714cfd" }, th)
        f["variables_set"](self, { value = 1, variable = "0d334e44-f97e-4c6e-bf88-025706398657" }, th)
        f["stop_audio"](self, { audio_id = "all_audio" }, th)
        f["set_screen_transition"](self, { type = "fade_in_out" }, th)
        f["switch_to_screen"](self, { screen_id = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, th)
      end
  end)
  rt.on(e_c1af39b1_f7d2_4a95_bc40_37cd94c16816, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["variables_set"](self, { value = 0, variable = "961c59df-040f-44d3-91c6-6a0330ead0d2" }, th)
          f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.1 }, th)
        else
          f["self_gradually_show_hide"](self, { show_hide = "show", time = 0.1 }, th)
          f["variables_set"](self, { value = 1, variable = "961c59df-040f-44d3-91c6-6a0330ead0d2" }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_c1af39b1_f7d2_4a95_bc40_37cd94c16816, "on_running_group_activated", {}, function(th, self)
      while true do
        f["set_sprite_style"](self, { style_id = f["variables_get"](self, { variable = "a0f605c5-1fe0-49ee-8724-d148ae1a3197" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 acc --------
  rt.on(e_811ce580_0510_4d39_88a4_bc3729f497f3, "on_running_group_activated", {}, function(th, self)
      f["variables_set"](self, { value = 100, variable = "888845c3-2f09-456c-841f-19164ac74dd2" }, th)
      f["self_text_effect_size"](self, { size = 36 }, th)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "bf37302d-a9a9-415c-9137-7f0297ecc100" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_text_effect_text"](self, { text = "" }, th)
        else
          if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "6b4406f7-382e-4c5c-9cc2-254fd3a793f7" }, th), B = 1, OP = "EQ" }, th)) then
            f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "28212a58-3dd5-4497-b5d7-ff619cd52f8f" }, th), B = f["variables_get"](self, { variable = "76acb1a2-e19a-4b72-8636-1ef70256e584" }, th), type = "add" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "28212a58-3dd5-4497-b5d7-ff619cd52f8f" }, th), B = f["variables_get"](self, { variable = "01e09819-e806-496f-b88c-8d472d437f9d" }, th), type = "add" }, th), B = f["variables_get"](self, { variable = "76acb1a2-e19a-4b72-8636-1ef70256e584" }, th), type = "add" }, th), type = "divide" }, th), B = 100, type = "multiply" }, th), variable = "888845c3-2f09-456c-841f-19164ac74dd2" }, th)
          end
          f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = (th:call_proc(proc_7558af1a_b4f5_4c12_ada1_f3de6e12d0cd, self, f["variables_get"](self, { variable = "888845c3-2f09-456c-841f-19164ac74dd2" }, th), 2)), ADD1 = "%" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 总分 --------
  rt.on(e_bcc769e8_a805_43fa_a3a6_e87bdcb502b6, "on_running_group_activated", {}, function(th, self)
      while true do
        f["variables_set"](self, { value = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "28212a58-3dd5-4497-b5d7-ff619cd52f8f" }, th), B = f["math_arithmetic"](self, { A = 50, B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "multiply" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "76acb1a2-e19a-4b72-8636-1ef70256e584" }, th), B = f["math_arithmetic"](self, { A = 3, B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "multiply" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "01e09819-e806-496f-b88c-8d472d437f9d" }, th), B = f["math_arithmetic"](self, { A = 6, B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "multiply" }, th), type = "multiply" }, th), type = "minus" }, th), type = "add" }, th), type = "round" }, th), variable = "2c976bf3-7a3a-4f50-a7b7-915266ce1aa7" }, th)
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "2c976bf3-7a3a-4f50-a7b7-915266ce1aa7" }, th), B = -1, OP = "LTE" }, th)) then
          f["variables_set"](self, { value = 0, variable = "2c976bf3-7a3a-4f50-a7b7-915266ce1aa7" }, th)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "bf37302d-a9a9-415c-9137-7f0297ecc100" }, th), B = 0, OP = "EQ" }, th)) then
          f["variables_set"](self, { value = 0, variable = "2c976bf3-7a3a-4f50-a7b7-915266ce1aa7" }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_bcc769e8_a805_43fa_a3a6_e87bdcb502b6, "on_running_group_activated", {}, function(th, self)
      f["self_text_effect_size"](self, { size = 36 }, th)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "bf37302d-a9a9-415c-9137-7f0297ecc100" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_text_effect_text"](self, { text = "" }, th)
        else
          f["self_text_effect_text"](self, { text = f["variables_get"](self, { variable = "2c976bf3-7a3a-4f50-a7b7-915266ce1aa7" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 mod设定 --------
  rt.on(e_0c8dc1eb_36a6_4968_a6f0_02b0574215f9, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.02, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = 550, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 3, type = "divide" }, th) }, th)
        else
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.02, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = 200, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 3, type = "divide" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_0c8dc1eb_36a6_4968_a6f0_02b0574215f9, "on_running_group_activated", {}, function(th, self)
      th:call_proc(proc_fde38e22_9be0_4d77_8605_5a4e38f5270c, self)
  end)
  rt.on(e_0c8dc1eb_36a6_4968_a6f0_02b0574215f9, "on_running_group_activated", {}, function(th, self)
      f["self_set_role_camp"](self, { role_camp = "camp_red" }, th)
  end)
  rt.on(e_0c8dc1eb_36a6_4968_a6f0_02b0574215f9, "when", { cond = function(th, self) return f["logic_operation"](self, { A = f["mouse_down"](self, { sprite = "--screen", type = "up" }, th), B = f["bump_into"](self, { sprite = "--self", sprite1 = "--mouse" }, th), type = "and" }, th) end }, function(th, self)
      f["self_broadcast"](self, { message = "mod" }, th)
  end)
  rt.on(e_0c8dc1eb_36a6_4968_a6f0_02b0574215f9, "self_listen", { message = "mod" }, function(th, self)
      f["ask_and_choose"](self, { CHOICE0 = "清除", CHOICE1 = "Relax", CHOICE2 = "No Fail", CHOICE3 = "下一页", question = "" }, th)
      f["variables_set"](self, { value = 1, variable = "0673923e-1920-4e2c-8197-ed44db4c7243" }, th)
      if V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 2, OP = "EQ" }, th)) then
        f["variables_set"](self, { value = 1, variable = "c9d0fc4b-f607-4b77-829d-41361fbcabe9" }, th)
      elseif V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 3, OP = "EQ" }, th)) then
        f["variables_set"](self, { value = 1, variable = "c98714d1-a642-42d7-b108-e0d763d1415e" }, th)
      elseif V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 4, OP = "EQ" }, th)) then
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f50e3c35-16b8-4143-8d93-70bf79d3ebfa" }, th), B = 0, OP = "EQ" }, th)) then
          f["ask_and_choose"](self, { CHOICE0 = "退出", CHOICE1 = "Auto Play", CHOICE2 = "Octopus AI V2", question = "" }, th)
        else
          f["ask_and_choose"](self, { CHOICE0 = "退出", CHOICE1 = "宜刻乐代打", CHOICE2 = "Octopus AI V2", question = "" }, th)
        end
        if V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 2, OP = "EQ" }, th)) then
          f["variables_set"](self, { value = 1, variable = "4c3a9fa3-347b-4fc8-9fd0-4ad8acee6668" }, th)
          f["variables_set"](self, { value = 0, variable = "b3145a6b-660c-4ab0-8a52-6075eb193af2" }, th)
          f["variables_set"](self, { value = 0, variable = "c9d0fc4b-f607-4b77-829d-41361fbcabe9" }, th)
          if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f50e3c35-16b8-4143-8d93-70bf79d3ebfa" }, th), B = 1, OP = "EQ" }, th)) then
            f["create_stage_dialog"](self, { sprite = "--self", text = "奥拓普雷已经死了，现在只有宜刻乐代打😡" }, th)
          end
        elseif V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 3, OP = "EQ" }, th)) then
          f["create_stage_dialog"](self, { sprite = "--self", text = "宜刻乐的破章鱼使用了特殊权益，他的PP倍率是91" }, th)
          f["variables_set"](self, { value = 1, variable = "b3145a6b-660c-4ab0-8a52-6075eb193af2" }, th)
          f["variables_set"](self, { value = 0, variable = "4c3a9fa3-347b-4fc8-9fd0-4ad8acee6668" }, th)
          f["variables_set"](self, { value = 0, variable = "c9d0fc4b-f607-4b77-829d-41361fbcabe9" }, th)
        end
      else
        f["variables_set"](self, { value = 0, variable = "4c3a9fa3-347b-4fc8-9fd0-4ad8acee6668" }, th)
        f["variables_set"](self, { value = 0, variable = "c98714d1-a642-42d7-b108-e0d763d1415e" }, th)
        f["variables_set"](self, { value = 0, variable = "c9d0fc4b-f607-4b77-829d-41361fbcabe9" }, th)
        f["variables_set"](self, { value = 0, variable = "b3145a6b-660c-4ab0-8a52-6075eb193af2" }, th)
      end
  end)
  rt.on(e_0c8dc1eb_36a6_4968_a6f0_02b0574215f9, "sprite_on_tap", { sprite = "--self", type = "mouse_click" }, function(th, self)
      f["self_broadcast"](self, { message = "mod" }, th)
  end)
  rt.on(e_0c8dc1eb_36a6_4968_a6f0_02b0574215f9, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.1 }, th)
        else
          f["self_gradually_show_hide"](self, { show_hide = "show", time = 0.1 }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_0c8dc1eb_36a6_4968_a6f0_02b0574215f9, "on_running_group_activated", {}, function(th, self)
      while true do
        f["set_sprite_style"](self, { style_id = f["variables_get"](self, { variable = "a0f605c5-1fe0-49ee-8724-d148ae1a3197" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 PP计算 --------
  rt.on(e_0d213613_8c5d_4529_8456_dcb60efaefd9, "on_running_group_activated", {}, function(th, self)
      f["self_text_effect_size"](self, { size = 24 }, th)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      while true do
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "28212a58-3dd5-4497-b5d7-ff619cd52f8f" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "888845c3-2f09-456c-841f-19164ac74dd2" }, th), B = 100, type = "divide" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "888845c3-2f09-456c-841f-19164ac74dd2" }, th), B = 100, type = "divide" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = 1, B = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "932ebbc7-efcb-4bd4-8ed3-a361bffde8c7" }, th), B = f["variables_get"](self, { variable = "136bfda7-419e-46c7-8ba1-dca80f8721f3" }, th), type = "divide" }, th), type = "add" }, th), type = "multiply" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "01e09819-e806-496f-b88c-8d472d437f9d" }, th), B = f["variables_get"](self, { variable = "28212a58-3dd5-4497-b5d7-ff619cd52f8f" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "888845c3-2f09-456c-841f-19164ac74dd2" }, th), B = 100, type = "divide" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "888845c3-2f09-456c-841f-19164ac74dd2" }, th), B = 100, type = "divide" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = 4, B = f["variables_get"](self, { variable = "888845c3-2f09-456c-841f-19164ac74dd2" }, th), type = "add" }, th), type = "divide" }, th), type = "multiply" }, th), type = "minus" }, th), variable = "0f86fbf8-f15a-49ba-b08f-5e0a3af39d11" }, th)
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "0f86fbf8-f15a-49ba-b08f-5e0a3af39d11" }, th), B = 0, OP = "LT" }, th)) then
          f["variables_set"](self, { value = 0, variable = "a7ed459f-07be-4a1b-89ae-76522c2a6759" }, th)
        else
          f["variables_set"](self, { value = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "0f86fbf8-f15a-49ba-b08f-5e0a3af39d11" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), B = 10, type = "divide" }, th), type = "multiply" }, th), B = f["variables_get"](self, { variable = "bf37302d-a9a9-415c-9137-7f0297ecc100" }, th), type = "multiply" }, th), type = "round" }, th), variable = "a7ed459f-07be-4a1b-89ae-76522c2a6759" }, th)
        end
        if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "4c3a9fa3-347b-4fc8-9fd0-4ad8acee6668" }, th), B = 1, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "b3145a6b-660c-4ab0-8a52-6075eb193af2" }, th), B = 1, OP = "EQ" }, th), type = "or" }, th)) then
          f["self_text_effect_color"](self, { color = "#999999" }, th)
          f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = f["variables_get"](self, { variable = "a7ed459f-07be-4a1b-89ae-76522c2a6759" }, th), ADD1 = "PP" }, th) }, th)
        elseif V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "a7ed459f-07be-4a1b-89ae-76522c2a6759" }, th), B = f["convert_type"](self, { text = "NaN", type = "number" }, th), OP = "NEQ" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "bf37302d-a9a9-415c-9137-7f0297ecc100" }, th), B = 0, OP = "NEQ" }, th), type = "and" }, th)) then
          f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = f["variables_get"](self, { variable = "a7ed459f-07be-4a1b-89ae-76522c2a6759" }, th), ADD1 = "PP" }, th) }, th)
        else
          f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = "0", ADD1 = "PP" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_0d213613_8c5d_4529_8456_dcb60efaefd9, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "b3145a6b-660c-4ab0-8a52-6075eb193af2" }, th), B = 1, OP = "EQ" }, th)) then
          f["variables_set"](self, { value = 91, variable = "bf37302d-a9a9-415c-9137-7f0297ecc100" }, th)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "c9d0fc4b-f607-4b77-829d-41361fbcabe9" }, th), B = 1, OP = "EQ" }, th)) then
          f["variables_set"](self, { value = 1, variable = "bf37302d-a9a9-415c-9137-7f0297ecc100" }, th)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "c98714d1-a642-42d7-b108-e0d763d1415e" }, th), B = 1, OP = "EQ" }, th)) then
          f["variables_set"](self, { value = 0.5, variable = "bf37302d-a9a9-415c-9137-7f0297ecc100" }, th)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "6092a2df-3e87-4447-8b09-b36e55b4310c" }, th), B = 1, OP = "EQ" }, th)) then
          f["variables_set"](self, { value = 3, variable = "bf37302d-a9a9-415c-9137-7f0297ecc100" }, th)
        else
          f["variables_set"](self, { value = 1.5, variable = "bf37302d-a9a9-415c-9137-7f0297ecc100" }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 总PP --------
  rt.on(e_0c9ea944_856c_449e_af72_76d509d360bd, "on_running_group_activated", {}, function(th, self)
      f["self_text_effect_size"](self, { size = 24 }, th)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      while true do
        f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = f["variables_get"](self, { variable = "e63f579e-11c5-4d78-a976-e9c0e37912bc" }, th), ADD1 = "PP" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_0c9ea944_856c_449e_af72_76d509d360bd, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["get_mouse_info"](self, { type = "x" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.05, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = 0, type = "add" }, th), y = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["get_mouse_info"](self, { type = "y" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 0.02, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = -225, type = "add" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_0c9ea944_856c_449e_af72_76d509d360bd, "on_running_group_activated", {}, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["user_id_get"](self, {}, th), B = 8773446, OP = "EQ" }, th)) then
        f["change_variables"](self, { method = "increase", value = f["variables_get"](self, { variable = "388276cd-04f0-4be1-91be-92c33b2d6f71" }, th), variable = "e63f579e-11c5-4d78-a976-e9c0e37912bc" }, th)
        f["variables_set"](self, { value = 0, variable = "388276cd-04f0-4be1-91be-92c33b2d6f71" }, th)
        f["self_broadcast"](self, { message = "上天" }, th)
      end
  end)
  rt.on(e_0c9ea944_856c_449e_af72_76d509d360bd, "on_running_group_activated", {}, function(th, self)
      f["wait"](self, { time = 0 }, th)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "d89543ac-8dc2-4b43-b979-94b2f25084a4" }, th), B = 0, OP = "EQ" }, th)) then
        f["variables_set"](self, { value = 1, variable = "d89543ac-8dc2-4b43-b979-94b2f25084a4" }, th)
        f["change_variables"](self, { method = "increase", value = 86400, variable = "d89543ac-8dc2-4b43-b979-94b2f25084a4" }, th)
      end
  end)
  rt.on(e_0c9ea944_856c_449e_af72_76d509d360bd, "on_running_group_activated", {}, function(th, self)
      if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "e63f579e-11c5-4d78-a976-e9c0e37912bc" }, th), B = 10000, OP = "GTE" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "23d0e95f-17d8-43b1-b0d1-40df0bc915d5" }, th), B = 0, OP = "EQ" }, th), type = "and" }, th)) then
        f["variables_set"](self, { value = 1, variable = "23d0e95f-17d8-43b1-b0d1-40df0bc915d5" }, th)
        f["set_screen_transition"](self, { direction = "up", type = "slide" }, th)
        f["switch_to_screen"](self, { screen_id = "75ae2a24-41fe-4d2b-9907-1af40e55aec3" }, th)
      end
  end)
  rt.on(e_0c9ea944_856c_449e_af72_76d509d360bd, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.1 }, th)
        else
          f["self_gradually_show_hide"](self, { show_hide = "show", time = 0.1 }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 设置 --------
  rt.on(e_e1f00058_a341_4755_ad37_63e9d70b4610, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.02, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = -550, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 3, type = "divide" }, th) }, th)
        else
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.02, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = -250, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 3, type = "divide" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_e1f00058_a341_4755_ad37_63e9d70b4610, "on_running_group_activated", {}, function(th, self)
      if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["get_time"](self, { time = "month" }, th), B = 4, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["get_time"](self, { time = "date" }, th), B = 1, OP = "EQ" }, th), type = "and" }, th)) then
        f["variables_set"](self, { value = 1, variable = "f50e3c35-16b8-4143-8d93-70bf79d3ebfa" }, th)
      end
  end)
  rt.on(e_e1f00058_a341_4755_ad37_63e9d70b4610, "on_running_group_activated", {}, function(th, self)
      f["show_hide_timer"](self, { showHide = "hide" }, th)
      th:call_proc(proc_fde38e22_9be0_4d77_8605_5a4e38f5270c, self)
  end)
  rt.on(e_e1f00058_a341_4755_ad37_63e9d70b4610, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "0d867230-f0d8-4115-bc7b-81cf2db5a9a3" }, th), B = 0, OP = "LTE" }, th)) then
          f["variables_set"](self, { value = 12, variable = "0d867230-f0d8-4115-bc7b-81cf2db5a9a3" }, th)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "a27f3ca2-bd4a-47b8-a161-87a39d14f03a" }, th), B = 0, OP = "LTE" }, th)) then
          f["variables_set"](self, { value = 15, variable = "a27f3ca2-bd4a-47b8-a161-87a39d14f03a" }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_e1f00058_a341_4755_ad37_63e9d70b4610, "on_running_group_activated", {}, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "3ded2f9d-1a42-43bc-b34d-4b202ef6cca7" }, th), B = 0, OP = "EQ" }, th)) then
        f["variables_set"](self, { value = 12, variable = "3ded2f9d-1a42-43bc-b34d-4b202ef6cca7" }, th)
      end
  end)
  rt.on(e_e1f00058_a341_4755_ad37_63e9d70b4610, "on_running_group_activated", {}, function(th, self)
      f["self_set_role_camp"](self, { role_camp = "camp_red" }, th)
  end)
  rt.on(e_e1f00058_a341_4755_ad37_63e9d70b4610, "when", { cond = function(th, self) return f["logic_operation"](self, { A = f["mouse_down"](self, { sprite = "--screen", type = "up" }, th), B = f["bump_into"](self, { sprite = "--self", sprite1 = "--mouse" }, th), type = "and" }, th) end }, function(th, self)
      f["self_broadcast"](self, { message = "设置" }, th)
  end)
  rt.on(e_e1f00058_a341_4755_ad37_63e9d70b4610, "self_listen", { message = "设置" }, function(th, self)
      f["ask_and_choose"](self, { CHOICE0 = "退出", CHOICE1 = "偏移量（Offset）设置向导", CHOICE2 = "[开/关]歌词", CHOICE3 = "下一页", question = "" }, th)
      if V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 2, OP = "EQ" }, th)) then
        f["set_screen_transition"](self, { type = "fade_in_out" }, th)
        f["switch_to_screen"](self, { screen_id = "9d583a2a-486d-4997-abd6-3e3a058288e1" }, th)
      elseif V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 3, OP = "EQ" }, th)) then
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "ba610640-3c96-4773-9c54-caf7e1847d47" }, th), B = 0, OP = "EQ" }, th)) then
          f["variables_set"](self, { value = 1, variable = "ba610640-3c96-4773-9c54-caf7e1847d47" }, th)
        else
          f["variables_set"](self, { value = 0, variable = "ba610640-3c96-4773-9c54-caf7e1847d47" }, th)
        end
      elseif V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 4, OP = "EQ" }, th)) then
        f["ask_and_choose"](self, { CHOICE0 = "退出", CHOICE1 = "下一页", CHOICE2 = "盘子基准速度设置", CHOICE3 = "盘子加速速度设置", question = "" }, th)
        if V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 2, OP = "EQ" }, th)) then
          f["ask_and_choose"](self, { CHOICE0 = "退出", CHOICE1 = "下一页", CHOICE2 = "背景亮度设置", CHOICE3 = "游戏节拍器", question = "" }, th)
          if V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 2, OP = "EQ" }, th)) then
            f["ask_and_choose"](self, { CHOICE0 = "退出", CHOICE1 = "主动将奥拓普雷设置为宜刻乐", CHOICE2 = "星星喷泉", CHOICE3 = "下一页", question = "" }, th)
            if V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 2, OP = "EQ" }, th)) then
              if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f50e3c35-16b8-4143-8d93-70bf79d3ebfa" }, th), B = 0, OP = "EQ" }, th)) then
                f["variables_set"](self, { value = 1, variable = "f50e3c35-16b8-4143-8d93-70bf79d3ebfa" }, th)
              else
                f["variables_set"](self, { value = 0, variable = "f50e3c35-16b8-4143-8d93-70bf79d3ebfa" }, th)
              end
            elseif V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 3, OP = "EQ" }, th)) then
              if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "9a1370ff-40f6-4ef6-bb25-4865fb357307" }, th), B = 0, OP = "EQ" }, th)) then
                f["variables_set"](self, { value = 1, variable = "9a1370ff-40f6-4ef6-bb25-4865fb357307" }, th)
              else
                f["variables_set"](self, { value = 0, variable = "9a1370ff-40f6-4ef6-bb25-4865fb357307" }, th)
              end
            elseif V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 4, OP = "EQ" }, th)) then
              f["ask_and_choose"](self, { CHOICE0 = "退出", CHOICE1 = "不显示接住动画", CHOICE2 = "高级移动", CHOICE3 = "下一页", question = "" }, th)
              if V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 2, OP = "EQ" }, th)) then
                if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "cbf08b77-0b7f-43cb-81c0-6d68e8695793" }, th), B = 0, OP = "EQ" }, th)) then
                  f["variables_set"](self, { value = 1, variable = "cbf08b77-0b7f-43cb-81c0-6d68e8695793" }, th)
                else
                  f["variables_set"](self, { value = 0, variable = "cbf08b77-0b7f-43cb-81c0-6d68e8695793" }, th)
                end
              elseif V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 3, OP = "EQ" }, th)) then
                if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "3e0c81bd-95da-4454-816f-21a689fd5f58" }, th), B = 0, OP = "EQ" }, th)) then
                  f["variables_set"](self, { value = 1, variable = "3e0c81bd-95da-4454-816f-21a689fd5f58" }, th)
                else
                  f["variables_set"](self, { value = 0, variable = "3e0c81bd-95da-4454-816f-21a689fd5f58" }, th)
                end
              elseif V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 4, OP = "EQ" }, th)) then
                f["ask_and_choose"](self, { CHOICE0 = "退出", CHOICE1 = "歌词过渡", CHOICE2 = "切换主题", question = "" }, th)
                if V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 2, OP = "EQ" }, th)) then
                  if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "3928c2ca-4cf5-4dd2-a48e-41d7ebf7b197" }, th), B = 0, OP = "EQ" }, th)) then
                    f["variables_set"](self, { value = 1, variable = "3928c2ca-4cf5-4dd2-a48e-41d7ebf7b197" }, th)
                  else
                    f["variables_set"](self, { value = 0, variable = "3928c2ca-4cf5-4dd2-a48e-41d7ebf7b197" }, th)
                  end
                elseif V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 3, OP = "EQ" }, th)) then
                  f["self_ask"](self, { text = "UI" }, th)
                  f["variables_set"](self, { value = f["get_answer"](self, {}, th), variable = "a0f605c5-1fe0-49ee-8724-d148ae1a3197" }, th)
                  f["self_ask"](self, { text = "Logo" }, th)
                  f["variables_set"](self, { value = f["get_answer"](self, {}, th), variable = "efbd5674-1882-4100-8bdf-0da4fd837f2a" }, th)
                  f["self_ask"](self, { text = "设置UI" }, th)
                  f["variables_set"](self, { value = f["get_answer"](self, {}, th), variable = "7ab0b7da-3530-4260-8d68-5f082298c892" }, th)
                  f["self_ask"](self, { text = "广告" }, th)
                  f["variables_set"](self, { value = f["get_answer"](self, {}, th), variable = "281cbc78-8d58-4963-87b4-7f6502e9069c" }, th)
                end
              end
            end
          elseif V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 3, OP = "EQ" }, th)) then
            f["self_ask"](self, { text = "" }, th)
            f["variables_set"](self, { value = f["get_answer"](self, {}, th), variable = "16f5bf5a-64a9-4ad1-9052-d34b3e677e99" }, th)
          elseif V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 4, OP = "EQ" }, th)) then
            if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "fb1eed48-70de-47aa-bb36-89104591cbaf" }, th), B = 0, OP = "EQ" }, th)) then
              f["variables_set"](self, { value = 1, variable = "fb1eed48-70de-47aa-bb36-89104591cbaf" }, th)
            else
              f["variables_set"](self, { value = 0, variable = "fb1eed48-70de-47aa-bb36-89104591cbaf" }, th)
            end
          end
        elseif V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 3, OP = "EQ" }, th)) then
          f["self_ask"](self, { text = "" }, th)
          f["variables_set"](self, { value = f["get_answer"](self, {}, th), variable = "0d867230-f0d8-4115-bc7b-81cf2db5a9a3" }, th)
        elseif V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 4, OP = "EQ" }, th)) then
          f["self_ask"](self, { text = "" }, th)
          f["variables_set"](self, { value = f["get_answer"](self, {}, th), variable = "a27f3ca2-bd4a-47b8-a161-87a39d14f03a" }, th)
        end
      end
  end)
  rt.on(e_e1f00058_a341_4755_ad37_63e9d70b4610, "sprite_on_tap", { sprite = "--self", type = "mouse_click" }, function(th, self)
      f["self_broadcast"](self, { message = "设置" }, th)
  end)
  rt.on(e_e1f00058_a341_4755_ad37_63e9d70b4610, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.1 }, th)
        else
          f["self_gradually_show_hide"](self, { show_hide = "show", time = 0.1 }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_e1f00058_a341_4755_ad37_63e9d70b4610, "on_running_group_activated", {}, function(th, self)
      while true do
        f["set_sprite_style"](self, { style_id = f["variables_get"](self, { variable = "7ab0b7da-3530-4260-8d68-5f082298c892" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 HP --------
  rt.on(e_be7204ca_fa8d_4181_b56b_6583b19290a5, "on_running_group_activated", {}, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "c98714d1-a642-42d7-b108-e0d763d1415e" }, th), B = 0, OP = "EQ" }, th)) then
        f["variables_set"](self, { value = 900, variable = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057" }, th)
        f["self_set_pen_size"](self, { size = 15 }, th)
        f["self_set_pen_color"](self, { color = "#fa9db3" }, th)
        f["set_pen_layer"](self, { layer = "peak" }, th)
        f["self_pen_down"](self, {}, th)
        while true do
          f["self_move_to"](self, { x = -450, y = 281 }, th)
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["variables_get"](self, { variable = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057" }, th) }, th)
          if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057" }, th), B = 0, OP = "LTE" }, th)) then
            if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "636f5999-3b33-4e0c-809d-ccf0da3c5550" }, th), B = 0, OP = "EQ" }, th)) then
              f["stop_audio"](self, { audio_id = "all_audio" }, th)
              f["play_audio_and_wait"](self, { audio_id = "bfad287b-d541-4d4d-a35f-67893b0cdb69" }, th)
            end
            f["stop"](self, { scope = "3" }, th)
            f["restart"](self, {}, th)
          elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057" }, th), B = 900, OP = "GTE" }, th)) then
            f["variables_set"](self, { value = 900, variable = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057" }, th)
          end
          if th:iter_n() then break end
        end
      end
  end)
  rt.on(e_be7204ca_fa8d_4181_b56b_6583b19290a5, "on_running_group_activated", {}, function(th, self)
      f["wait"](self, { time = 0 }, th)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "c98714d1-a642-42d7-b108-e0d763d1415e" }, th), B = 0, OP = "EQ" }, th)) then
        while true do
          f["change_variables"](self, { method = "decrease", value = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), B = 1.5, type = "divide" }, th), variable = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057" }, th)
          th:call_proc(proc_9d8c0e48_e7a1_443c_b5dd_57e5d7f2e7bf, self, 4)
          if th:iter_n() then break end
        end
      end
  end)
  rt.on(e_be7204ca_fa8d_4181_b56b_6583b19290a5, "on_running_group_activated", {}, function(th, self)
      while not V.bool(f["logic_compare"](self, { A = f["timer"](self, {}, th), B = 0, OP = "NEQ" }, th)) do
        if th:iter_n() then break end
      end
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 15, OP = "EQ" }, th)) then
          if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "a6902c01-7506-4fba-9d72-6c505ce77a61" }, th), B = 0, OP = "EQ" }, th)) then
            while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 8, OP = "GTE" }, th)) do
              if th:iter_n() then break end
            end
            f["variables_set"](self, { value = 1, variable = "a6902c01-7506-4fba-9d72-6c505ce77a61" }, th)
            while true do
              f["change_variables"](self, { method = "decrease", value = 50, variable = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057" }, th)
              th:call_proc(proc_9d8c0e48_e7a1_443c_b5dd_57e5d7f2e7bf, self, 2)
              if th:iter_n() then break end
            end
          else
            while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 8, OP = "GTE" }, th)) do
              if th:iter_n() then break end
            end
            while true do
              f["self_set_pen_color"](self, { color = "#4EB5FE" }, th)
              f["variables_set"](self, { value = 900, variable = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057" }, th)
              if th:iter_n() then break end
            end
          end
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 HPF --------
  rt.on(e_142d7973_7637_4b94_94d3_1d816b2c2df4, "on_running_group_activated", {}, function(th, self)
      f["wait"](self, { time = 0 }, th)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "c98714d1-a642-42d7-b108-e0d763d1415e" }, th), B = 0, OP = "EQ" }, th)) then
        while true do
          f["self_set_position_x"](self, { value = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "be7204ca-fa8d-4181-b56b-6583b19290a5" }, th), B = 35, type = "minus" }, th) }, th)
          if th:iter_n() then break end
        end
      else
        f["self_appear"](self, { value = "disappear" }, th)
      end
  end)
  -- -------- 角色 circle --------
  rt.on(e_810d5972_9f94_47ac_a461_4df7e286dba4, "on_running_group_activated", {}, function(th, self)
      f["wait"](self, { time = 0 }, th)
      while true do
        f["wait"](self, { time = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 60, B = f["variables_get"](self, { variable = "ad9ad2e0-bf30-48fd-9a36-cc64092abce3" }, th), type = "divide" }, th), B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "divide" }, th), B = f["variables_get"](self, { variable = "1f8a4269-f7f9-4790-be36-e39dfa16cca2" }, th), type = "add" }, th) }, th)
        f["self_change_scale"](self, { increase = "increase", scale = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 115, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_810d5972_9f94_47ac_a461_4df7e286dba4, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "ce76233f-335c-462d-82a3-4b17fd07a2e3" }, th), B = 1, OP = "GTE" }, th)) then
          f["self_change_effect"](self, { increase = "increase", scope = "0", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 360, B = f["effect_of_sprite"](self, { effect = "0", sprite = "--self" }, th), type = "minus" }, th), B = 7.5, type = "divide" }, th) }, th)
        end
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_change_scale"](self, { increase = "increase", scale = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        else
          f["self_change_scale"](self, { increase = "increase", scale = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 50, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_810d5972_9f94_47ac_a461_4df7e286dba4, "on_running_group_activated", {}, function(th, self)
      while true do
        if f["logic_compare"](self, { A = f["math_round"](self, { num = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "round" }, th), B = 25, OP = "EQ" }, th) then break end
        f["self_change_effect"](self, { increase = "increase", scope = "1", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 25, B = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        if th:iter_n() then break end
      end
      f["self_set_effect"](self, { scope = "1", value = 25 }, th)
  end)
  rt.on(e_810d5972_9f94_47ac_a461_4df7e286dba4, "on_running_group_activated", {}, function(th, self)
      while true do
        if f["logic_compare"](self, { A = f["math_round"](self, { num = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "round" }, th), B = 25, OP = "EQ" }, th) then break end
        f["self_change_scale"](self, { increase = "increase", scale = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        if th:iter_n() then break end
      end
      f["set_scale"](self, { scale = 100 }, th)
  end)
  rt.on(e_810d5972_9f94_47ac_a461_4df7e286dba4, "on_running_group_activated", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      while true do
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = 0.7, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        if V.bool(f["bump_into"](self, { sprite = "--self", sprite1 = "--mouse" }, th)) then
          if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
            f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 110, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 0.5, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
          else
            f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 90, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 0.5, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
          end
        end
        f["self_change_scale"](self, { increase = "increase", scale = f["script_variables_value"](self, { TEXT = "a" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_810d5972_9f94_47ac_a461_4df7e286dba4, "on_running_group_activated", {}, function(th, self)
      f["wait"](self, { time = 0 }, th)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "636f5999-3b33-4e0c-809d-ccf0da3c5550" }, th), B = 0, OP = "EQ" }, th)) then
          if V.bool(f["logic_operation"](self, { A = f["bump_into"](self, { sprite = "--self", sprite1 = "--mouse" }, th), B = f["logic_operation"](self, { A = f["bump_into"](self, { sprite = "810d5972-9f94-47ac-a461-4df7e286dba4", sprite1 = "--mouse" }, th), B = f["bump_into"](self, { sprite = "c73c5c69-2217-4d2b-a3b8-87c9aa01109c", sprite1 = "--mouse" }, th), type = "or" }, th), type = "or" }, th)) then
            th:call_proc(proc_ab9e6f2c_d942_40be_8d4c_e8f19d72383d, self)
          end
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_810d5972_9f94_47ac_a461_4df7e286dba4, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.1, type = "multiply" }, th), B = 0.5, type = "multiply" }, th), B = 0, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
          f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th), B = 0.5, type = "multiply" }, th), B = 0, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        else
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.1, type = "multiply" }, th), B = 0.5, type = "multiply" }, th), B = -100, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
          f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th), B = 0.5, type = "multiply" }, th), B = 0, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 FPS --------
  rt.on(e_388bcb4b_71dc_464d_869d_96a4d70067f8, "on_running_group_activated", {}, function(th, self)
      f["self_text_effect_size"](self, { size = 18 }, th)
      f["self_text_effect_color"](self, { color = "#999999" }, th)
      f["self_move_to"](self, { x = 0, y = -265 }, th)
  end)
  rt.on(e_388bcb4b_71dc_464d_869d_96a4d70067f8, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = "FPS:", ADD1 = f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th), ADD2 = " | ", ADD3 = f["text_join"](self, { ADD0 = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 1, B = f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th), type = "divide" }, th), B = 1000, type = "multiply" }, th), type = "round" }, th), ADD1 = "ms" }, th), ADD4 = "（当前帧率刷新时间已做限制）" }, th) }, th)
        f["wait"](self, { time = 2 }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_388bcb4b_71dc_464d_869d_96a4d70067f8, "on_running_group_activated", {}, function(th, self)
      while true do
        f["list_append"](self, { list = "230adc73-6e89-4cdb-be49-6fbde4dce1da", list_item_value = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "07cc3840-fd98-4316-b4d0-2961194a2aaf" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_388bcb4b_71dc_464d_869d_96a4d70067f8, "on_running_group_activated", {}, function(th, self)
      while true do
        th:warp_enter()
        while true do
          if f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["list_length"](self, { list = "230adc73-6e89-4cdb-be49-6fbde4dce1da" }, th), B = 2, OP = "LTE" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = "230adc73-6e89-4cdb-be49-6fbde4dce1da", list_index = 1 }, th), B = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "07cc3840-fd98-4316-b4d0-2961194a2aaf" }, th), B = 1000, type = "minus" }, th), OP = "GTE" }, th), type = "or" }, th) then break end
          f["delete_list_item"](self, { item = "any", list = "230adc73-6e89-4cdb-be49-6fbde4dce1da", list_index = 1 }, th)
          if th:iter_w() then break end
        end
        th:warp_exit()
        if th:iter_n() then break end
      end
  end)
  rt.on(e_388bcb4b_71dc_464d_869d_96a4d70067f8, "on_running_group_activated", {}, function(th, self)
      while true do
        th:warp_enter()
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["list_length"](self, { list = "230adc73-6e89-4cdb-be49-6fbde4dce1da" }, th), B = f["math_arithmetic"](self, { A = 1000000, B = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "last", list = "230adc73-6e89-4cdb-be49-6fbde4dce1da" }, th), B = f["list_item"](self, { item = "any", list = "230adc73-6e89-4cdb-be49-6fbde4dce1da", list_index = 1 }, th), type = "minus" }, th), type = "divide" }, th), type = "multiply" }, th), type = "round" }, th), B = 1000, type = "divide" }, th), variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th)
        th:warp_exit()
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 曲 --------
  rt.on(e_45c8d7e3_e13f_475b_a885_98a2aff839b7, "on_running_group_activated", {}, function(th, self)
      while true do
        f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = "a61379ab-9e9f-4e5b-a0c1-fbf8975fef61", list_index = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 1, type = "add" }, th) }, th), variable = "ad9ad2e0-bf30-48fd-9a36-cc64092abce3" }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_45c8d7e3_e13f_475b_a885_98a2aff839b7, "on_running_group_activated", {}, function(th, self)
      while true do
        f["variables_set"](self, { value = f["variables_get"](self, { variable = "3a064750-07fd-4c4a-95a2-271c3b091da8" }, th), variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th)
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "0e5b8264-119d-4030-8b02-ac263239ad6b" }, th), B = 0, OP = "EQ" }, th)) then
          if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "71676bd4-3fa4-473b-aa5b-97f49d44528a" }, th), B = 0, OP = "EQ" }, th)) then
            f["variables_set"](self, { value = 1, variable = "ce0cbfad-4568-4497-83a8-e423c872cdb1" }, th)
            f["variables_set"](self, { value = 0, variable = "6092a2df-3e87-4447-8b09-b36e55b4310c" }, th)
          elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "71676bd4-3fa4-473b-aa5b-97f49d44528a" }, th), B = 5, OP = "EQ" }, th)) then
            f["variables_set"](self, { value = 0, variable = "ce0cbfad-4568-4497-83a8-e423c872cdb1" }, th)
            f["variables_set"](self, { value = 1, variable = "6092a2df-3e87-4447-8b09-b36e55b4310c" }, th)
          else
            f["variables_set"](self, { value = 0, variable = "ce0cbfad-4568-4497-83a8-e423c872cdb1" }, th)
            f["variables_set"](self, { value = 0, variable = "6092a2df-3e87-4447-8b09-b36e55b4310c" }, th)
            f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = "93fb9521-33b9-41c0-a246-5e77dcbf2143", list_index = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "71676bd4-3fa4-473b-aa5b-97f49d44528a" }, th), B = 1, type = "add" }, th) }, th), variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th)
          end
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_45c8d7e3_e13f_475b_a885_98a2aff839b7, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.02, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = 550, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 3, type = "divide" }, th) }, th)
        else
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.02, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = 349, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 3, type = "divide" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_45c8d7e3_e13f_475b_a885_98a2aff839b7, "on_running_group_activated", {}, function(th, self)
      th:call_proc(proc_fde38e22_9be0_4d77_8605_5a4e38f5270c, self)
  end)
  rt.on(e_45c8d7e3_e13f_475b_a885_98a2aff839b7, "on_running_group_activated", {}, function(th, self)
      f["self_set_role_camp"](self, { role_camp = "camp_red" }, th)
  end)
  rt.on(e_45c8d7e3_e13f_475b_a885_98a2aff839b7, "when", { cond = function(th, self) return f["logic_operation"](self, { A = f["mouse_down"](self, { sprite = "--screen", type = "up" }, th), B = f["bump_into"](self, { sprite = "--self", sprite1 = "--mouse" }, th), type = "and" }, th) end }, function(th, self)
      f["set_timer_state"](self, { type = "stop" }, th)
      f["set_timer_state"](self, { type = "reset" }, th)
      th:call_proc(proc_4c20d971_9c2e_4f69_8a28_f808e89f0a62, self)
      f["variables_set"](self, { value = 0, variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th)
      f["variables_set"](self, { value = 0, variable = "661345c6-cc87-4b50-9937-dec0fc714cfd" }, th)
      f["stop_audio"](self, { audio_id = "all_audio" }, th)
      f["set_screen_transition"](self, { type = "fade_in_out" }, th)
      f["switch_to_screen"](self, { screen_id = "cb8ad9c4-3817-49a8-b7cb-112e9b6e4d51" }, th)
  end)
  rt.on(e_45c8d7e3_e13f_475b_a885_98a2aff839b7, "sprite_on_tap", { sprite = "--self", type = "mouse_click" }, function(th, self)
      f["set_timer_state"](self, { type = "stop" }, th)
      f["set_timer_state"](self, { type = "reset" }, th)
      th:call_proc(proc_4c20d971_9c2e_4f69_8a28_f808e89f0a62, self)
      f["variables_set"](self, { value = 0, variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th)
      f["variables_set"](self, { value = 0, variable = "661345c6-cc87-4b50-9937-dec0fc714cfd" }, th)
      f["stop_audio"](self, { audio_id = "all_audio" }, th)
      f["set_screen_transition"](self, { type = "fade_in_out" }, th)
      f["switch_to_screen"](self, { screen_id = "cb8ad9c4-3817-49a8-b7cb-112e9b6e4d51" }, th)
  end)
  rt.on(e_45c8d7e3_e13f_475b_a885_98a2aff839b7, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.1 }, th)
        else
          f["self_gradually_show_hide"](self, { show_hide = "show", time = 0.1 }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_45c8d7e3_e13f_475b_a885_98a2aff839b7, "on_running_group_activated", {}, function(th, self)
      while true do
        f["set_sprite_style"](self, { style_id = f["variables_get"](self, { variable = "a0f605c5-1fe0-49ee-8724-d148ae1a3197" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 HP特效 --------
  rt.on(e_ccd1fd87_8c2f_4e17_aedb_d3a96ae128f3, "on_running_group_activated", {}, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "c98714d1-a642-42d7-b108-e0d763d1415e" }, th), B = 0, OP = "EQ" }, th)) then
        f["self_appear"](self, { value = "appear" }, th)
        while true do
          f["self_set_effect"](self, { scope = "1", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057" }, th), B = 900, type = "divide" }, th), B = 100, type = "multiply" }, th), B = 4, type = "multiply" }, th) }, th)
          if th:iter_n() then break end
        end
      end
  end)
  -- -------- 角色 轨道 --------
  rt.on(e_79fcfeea_02a9_4cc3_87e7_b0e3a163b524, "on_running_group_activated", {}, function(th, self)
      f["self_set_pen_color"](self, { color = "#ffffff" }, th)
      f["self_set_pen_size"](self, { size = 3 }, th)
      f["self_set_pen_color_property"](self, { scope = "alpha", val = 25 }, th)
      f["set_pen_layer"](self, { layer = "bottom" }, th)
      f["self_pen_down"](self, {}, th)
      while true do
        f["clear_drawing"](self, {}, th)
        f["self_set_position_x"](self, { value = -450 }, th)
        f["self_set_position_x"](self, { value = 450 }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 Offset --------
  rt.on(e_86f003a3_78f9_47ed_9ce0_0552f08c6d53, "on_running_group_activated", {}, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "636f5999-3b33-4e0c-809d-ccf0da3c5550" }, th), B = 0, OP = "EQ" }, th)) then
        f["play_audio"](self, { audio_id = "34796d1c-89a8-4148-be2c-50144c75f4fb" }, th)
      end
      f["self_set_effect"](self, { scope = "1", value = 25 }, th)
      while true do
        th:call_proc(proc_f92a4bf5_d4e2_488e_87a9_dc2e04d8fd2a, self)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_86f003a3_78f9_47ed_9ce0_0552f08c6d53, "on_running_group_activated", {}, function(th, self)
      while true do
        f["mirror"](self, { sprite = "--self" }, th)
        f["wait"](self, { time = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 60, B = 135, type = "divide" }, th), B = f["variables_get"](self, { variable = "1f8a4269-f7f9-4790-be36-e39dfa16cca2" }, th), type = "add" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_86f003a3_78f9_47ed_9ce0_0552f08c6d53, "start_as_a_mirror", {}, function(th, self)
      while true do
        if f["bump_into"](self, { sprite = "--self", sprite1 = "8f49f29a-5834-4630-96a3-464ffc5896c9" }, th) then break end
        f["self_change_coordinate_y"](self, { increase = "decrease", value = f["math_arithmetic"](self, { A = 5, B = f["math_arithmetic"](self, { A = 60, B = f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th), type = "divide" }, th), type = "multiply" }, th) }, th)
        if th:iter_n() then break end
      end
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "636f5999-3b33-4e0c-809d-ccf0da3c5550" }, th), B = 0, OP = "EQ" }, th)) then
        f["play_audio"](self, { audio_id = "b02bdbe4-007b-41f8-a1de-14a5ab6c9e88" }, th)
      end
      f["self_set_position_y"](self, { value = 500 }, th)
      f["dispose_clone"](self, {}, th)
  end)
  rt.on(e_86f003a3_78f9_47ed_9ce0_0552f08c6d53, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "ce76233f-335c-462d-82a3-4b17fd07a2e3" }, th), B = 0, OP = "NEQ" }, th)) then
          f["wait"](self, { time = 1 }, th)
          f["change_variables"](self, { method = "decrease", value = 1, variable = "ce76233f-335c-462d-82a3-4b17fd07a2e3" }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 tips --------
  rt.on(e_79a5d117_4e2c_4bfc_933c_602fd8cdebc0, "on_running_group_activated", {}, function(th, self)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      f["self_text_effect_size"](self, { size = 18 }, th)
      while true do
        f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = "按\"↑\"或\"↓\"键增加或减少0.1ms 按住\"W\"键改为增加或减少1ms 按\"S\"返回 此设置将保存到本地", ADD1 = " | ", ADD2 = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "1f8a4269-f7f9-4790-be36-e39dfa16cca2" }, th), B = 1000, type = "multiply" }, th), ADD3 = "ms" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_79a5d117_4e2c_4bfc_933c_602fd8cdebc0, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_operation"](self, { A = f["check_key"](self, { key = "38", type = "down" }, th), B = f["logic_negate"](self, { logic = f["check_key"](self, { key = "87", type = "down" }, th) }, th), type = "and" }, th)) then
          f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = 0.1, B = 1000, type = "divide" }, th), variable = "1f8a4269-f7f9-4790-be36-e39dfa16cca2" }, th)
          while not V.bool(f["logic_negate"](self, { logic = f["check_key"](self, { key = "38", type = "down" }, th) }, th)) do
            if th:iter_n() then break end
          end
        elseif V.bool(f["logic_operation"](self, { A = f["check_key"](self, { key = "40", type = "down" }, th), B = f["logic_negate"](self, { logic = f["check_key"](self, { key = "87", type = "down" }, th) }, th), type = "and" }, th)) then
          f["change_variables"](self, { method = "decrease", value = f["math_arithmetic"](self, { A = 0.1, B = 1000, type = "divide" }, th), variable = "1f8a4269-f7f9-4790-be36-e39dfa16cca2" }, th)
          while not V.bool(f["logic_negate"](self, { logic = f["check_key"](self, { key = "40", type = "down" }, th) }, th)) do
            if th:iter_n() then break end
          end
        elseif V.bool(f["logic_operation"](self, { A = f["check_key"](self, { key = "38", type = "down" }, th), B = f["check_key"](self, { key = "87", type = "down" }, th), type = "and" }, th)) then
          f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = 1, B = 1000, type = "divide" }, th), variable = "1f8a4269-f7f9-4790-be36-e39dfa16cca2" }, th)
          while not V.bool(f["logic_negate"](self, { logic = f["logic_operation"](self, { A = f["check_key"](self, { key = "38", type = "down" }, th), B = f["check_key"](self, { key = "87", type = "down" }, th), type = "and" }, th) }, th)) do
            if th:iter_n() then break end
          end
        elseif V.bool(f["logic_operation"](self, { A = f["check_key"](self, { key = "40", type = "down" }, th), B = f["check_key"](self, { key = "87", type = "down" }, th), type = "and" }, th)) then
          f["change_variables"](self, { method = "decrease", value = f["math_arithmetic"](self, { A = 1, B = 1000, type = "divide" }, th), variable = "1f8a4269-f7f9-4790-be36-e39dfa16cca2" }, th)
          while not V.bool(f["logic_negate"](self, { logic = f["logic_operation"](self, { A = f["check_key"](self, { key = "40", type = "down" }, th), B = f["check_key"](self, { key = "87", type = "down" }, th), type = "and" }, th) }, th)) do
            if th:iter_n() then break end
          end
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_79a5d117_4e2c_4bfc_933c_602fd8cdebc0, "on_keydown", { key = "83", type = "down" }, function(th, self)
      f["stop_audio"](self, { audio_id = "all_audio" }, th)
      f["set_screen_transition"](self, { type = "fade_in_out" }, th)
      f["switch_to_screen"](self, { screen_id = "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, th)
      while not V.bool(f["logic_negate"](self, { logic = f["check_key"](self, { key = "83", type = "down" }, th) }, th)) do
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 FPS-非初始 --------
  rt.on(e_4150aa3e_61c0_4f08_8ae3_aee9b6e56c3c, "on_running_group_activated", {}, function(th, self)
      f["self_move_to"](self, { x = 0, y = -265 }, th)
      f["self_text_effect_size"](self, { size = 18 }, th)
      f["self_text_effect_color"](self, { color = "#999999" }, th)
  end)
  rt.on(e_4150aa3e_61c0_4f08_8ae3_aee9b6e56c3c, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = "FPS:", ADD1 = f["variables_get"](self, { variable = "?" }, th), ADD2 = " | ", ADD3 = f["text_join"](self, { ADD0 = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 1, B = f["variables_get"](self, { variable = "?" }, th), type = "divide" }, th), B = 1000, type = "multiply" }, th), type = "round" }, th), ADD1 = "ms" }, th), ADD4 = " | ", ADD5 = f["get_clone_num"](self, { sprite = "86f003a3-78f9-47ed-9ce0-0552f08c6d53" }, th) }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_4150aa3e_61c0_4f08_8ae3_aee9b6e56c3c, "on_running_group_activated", {}, function(th, self)
      while true do
        f["change_variables"](self, { method = "increase", value = 1, variable = "?" }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_4150aa3e_61c0_4f08_8ae3_aee9b6e56c3c, "on_running_group_activated", {}, function(th, self)
      while true do
        f["wait"](self, { time = 1 }, th)
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "?" }, th), B = 2, type = "minus" }, th), variable = "?" }, th)
        f["variables_set"](self, { value = 0, variable = "?" }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 特效 --------
  rt.on(e_c73c5c69_2217_4d2b_a3b8_87c9aa01109c, "on_running_group_activated", {}, function(th, self)
      f["self_set_effect"](self, { scope = "1", value = 0 }, th)
      f["wait"](self, { time = 0 }, th)
      while true do
        f["wait"](self, { time = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 60, B = f["variables_get"](self, { variable = "ad9ad2e0-bf30-48fd-9a36-cc64092abce3" }, th), type = "divide" }, th), B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "divide" }, th), B = f["variables_get"](self, { variable = "1f8a4269-f7f9-4790-be36-e39dfa16cca2" }, th), type = "add" }, th) }, th)
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_change_scale"](self, { increase = "increase", scale = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 750, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
        else
          f["self_change_scale"](self, { increase = "increase", scale = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 500, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
        end
        f["self_change_effect"](self, { increase = "increase", scope = "1", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_c73c5c69_2217_4d2b_a3b8_87c9aa01109c, "on_running_group_activated", {}, function(th, self)
      f["set_scale"](self, { scale = 200 }, th)
      while true do
        if f["logic_compare"](self, { A = f["math_round"](self, { num = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "round" }, th), B = 25, OP = "EQ" }, th) then break end
        f["self_change_scale"](self, { increase = "increase", scale = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
        f["self_change_effect"](self, { increase = "increase", scope = "1", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 0, B = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
        if th:iter_n() then break end
      end
      f["set_scale"](self, { scale = 100 }, th)
  end)
  rt.on(e_c73c5c69_2217_4d2b_a3b8_87c9aa01109c, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.1, type = "multiply" }, th), B = 0.5, type = "multiply" }, th), B = 0, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
          f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th), B = 0.5, type = "multiply" }, th), B = 0, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        else
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.1, type = "multiply" }, th), B = 0.5, type = "multiply" }, th), B = -100, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
          f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th), B = 0.5, type = "multiply" }, th), B = 0, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 歌词 --------
  rt.on(e_cb9067dc_cf1d_4561_89e6_0c7e3b2d4ff8, "on_running_group_activated", {}, function(th, self)
      f["set_timer_state"](self, { type = "stop" }, th)
      f["set_timer_state"](self, { type = "reset" }, th)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 1, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "34796d1c-89a8-4148-be2c-50144c75f4fb", "|00|00.000|[by:Super丶过] |00|00.389|杂鱼杂鱼杂鱼杂鱼 这无趣的存在 真是可悲啊 |00|07.546|杂鱼杂鱼杂鱼杂鱼 杂鱼的杂鱼攻击 根本没用啊 |00|14.225|杂鱼 |00|28.878|杂鱼杂鱼杂鱼杂鱼 脆弱至极的杂鱼 真是杂碎 |00|35.942|杂鱼到不值一提 却渴求被辱骂 真是变态呢 |00|42.615|杂鱼 |00|46.413|可悲的杂鱼 可怜的 杂鱼 |00|53.532|微不足道的 存在呢 杂鱼 |00|57.443|杂鱼 杂鱼 杂鱼杂鱼 杂鱼 |01|00.865|杂鱼 杂鱼 杂鱼杂鱼 杂鱼 |01|04.388|杂鱼 杂鱼 杂鱼杂鱼 杂鱼 |01|07.955|杂鱼 杂鱼 杂鱼杂鱼 杂鱼 |01|11.010|要摸摸头安慰你吗 |01|13.061|对上视线了呢 心如擂鼓震颤 |01|14.879|在幻想些什么呢 真的超恶心啊 |01|17.285|不甘心吗？ |01|18.864|那坨废物渣滓xxx 最底层的脆弱垃圾xxx |01|21.953|但其实超喜欢 喜欢你到发疯 |01|23.831|骗你的啦 真可爱呢 |01|31.514|不甘心吗？ |01|39.291|变态 |01|39.832|杂鱼杂鱼杂鱼杂鱼 反正很闲吧 请我吃饭啊 |01|47.062|杂鱼到不值一提 反正回家也是 独自一人吧 |01|53.794|杂鱼 |02|04.696|可悲的杂鱼 可怜的 杂鱼 |02|11.749|无可救药的 变态啊 杂鱼 |02|15.806|杂鱼 杂鱼 杂鱼杂鱼 杂鱼 |02|19.084|杂鱼 杂鱼 杂鱼杂鱼 杂鱼 |02|22.609|杂鱼 杂鱼 杂鱼杂鱼 杂鱼 |02|26.194|杂鱼 杂鱼 杂鱼杂鱼 杂鱼 |02|29.386|要乖乖奖励你吗 |02|31.318|对上视线了呢 心跳如雷轰鸣 |02|33.084|在兴奋些什么呢 真的超恶心啊 |02|35.477|不甘心吗？ |02|36.908|那坨废物渣滓xxx 最底层的脆弱垃圾xxx |02|40.129|但其实超喜欢 喜欢你到发疯 |02|42.003|骗你的啦 真可爱呢 |02|44.261|怎么 别突然无视我啊 |02|45.546|会道歉的 别丢下我离开 |02|47.312|你其实并不讨厌我吧？ |02|49.019|对吧 我知道的 |02|51.129|那坨废物渣滓xxx 马上就xxx的脆弱垃圾xxx |02|54.536|明明心里想着要xx却xx 真遗憾 |02|58.461|杂鱼杂鱼 杂鱼 杂鱼杂鱼 |03|01.749|杂鱼杂鱼 杂鱼 杂鱼杂鱼 |03|03.954|不甘心吗？ |03|05.286|杂鱼杂鱼 杂鱼 杂鱼杂鱼 |03|08.869|杂鱼杂鱼 杂鱼 杂鱼杂鱼", 20)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 2, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "b034ce40-89ad-4d9d-b993-34b9e4465aa6", "|00|03.180|呐 你知道吗？ 其实人生 |00|04.860|尝起来有一种甜甜的味道 |00|06.530|欸 |00|06.640|呐 你知道吗？ 使用秘技 |00|08.190|就能把艰难困苦变为简单模式 |00|09.710|欸 |00|09.950|然后 只要给我充值 |00|11.240|你就能变得更加幸福哦 |00|13.310|欸 原来如此 真是受益匪浅 |00|15.350|那就相信T先生的话吧 |00|19.650|他在闪闪发光 |00|23.400|呐 你知道吗？若是觉得心情愉悦 |00|25.200|喝下剧毒也没有问题 |00|26.440|欸 |00|26.730|呐 你知道吗？ 因为性价比非常高 |00|28.610|所以出卖灵魂就能胜利 |00|29.980|欸 |00|30.090|好乖好乖 我会好好地宠爱 |00|31.880|对我言听计从的你 |00|33.420|欸 是这样啊 我彻底迷上T先生了 |00|35.510|我要把一切都献给T先生 |00|39.090|T先生就是我的一切 |00|40.590|别相信T先生的话 |00|42.200|不要将希望寄托于那种虚假的爱 |00|43.910|别说这种话 我不听 |00|45.360|如果不相信的话我会疯掉 |00|47.280|别相信T先生的话 |00|48.960|不要为疯狂的行为赌上人生 |00|50.650|就算这么说也没用 |00|52.090|你的眼睛在闪闪发光 |00|53.900|我才是那个最正常的人 |00|55.600|我才是最正常的人 |00|57.400|你对你对 你才是最正常的那个人 |00|59.140|别相信T先生的话 |01|00.680|大家都是恶魔根本不正常 |01|02.330|都是恶魔根本不正常 |01|04.030|没错没错 大家全都是如此不正常 |01|05.790|别相信T先生的话 |01|07.370|假的? 真的? 难以分辨爱的真假 |01|09.160|假的? 真的? 根本就没时间烦恼 |01|11.140|T就是true(真理)的T 如此回应疯狂起舞 |01|13.760|呐 你知道吗？ |01|14.580|需要时常为脑海中的花田浇水 |01|16.690|它才不会枯萎 |01|17.760|欸 |01|17.940|如果和那个碍事的孩子在一起 |01|19.570|就会变得不幸 最好断绝关系 |01|21.090|欸 |01|21.260|那些胆敢否定我的蠢货 |01|22.810|就该从世上消失 |01|23.810|欸 确实如此 这主意超棒 |01|25.800|那就相信T先生的话吧 |01|29.350|那就按照T先生说的去〇吧 |01|31.950|快住手 |01|37.680|别相信T先生的话 |01|44.620|T先生就是我的一切 |01|46.050|别相信T先生的话 |01|47.650|不要对赤裸裸的谎言抱有期待 |01|49.460|别说这种话 我不听 |01|50.790|真相根本不会给人留活路 |01|52.740|别相信T先生的话 |01|54.420|不要将希望寄托于那种虚假的爱 |01|56.120|别说这种话 我不听 |01|57.450|如果不相信的话我会疯掉 |01|59.410|别相信T先生的话 |02|01.090|不要白白地葬送宝贵的生命 |02|02.820|就算这么说也没用 |02|04.310|脑海内的走马灯在闪闪发光 |02|06.060|我才是那个最正常的人 |02|07.760|我才是最正常的人 |02|09.440|你对你对 你才是最正常的那个人 |02|11.190|别相信T先生的话 |02|12.890|大家都是恶魔根本不正常 |02|14.500|都是恶魔根本不正常 |02|16.270|没错没错 大家全都是如此不正常 |02|17.970|深信着T先生的话 |02|21.210|可最后却惨遭欺骗 |02|22.870|我一直以来都被蒙在鼓里 |02|24.580|深信着T先生的话 |02|27.930|曾经感到那么幸福 |02|29.560|切实地感受到幸福的存在 |02|31.310|别相信T先生的话 |02|35.520|不行不行 |02|37.940|就连这首歌都不要轻信", 5)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 3, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "d6ccf04b-2e71-4274-a07e-9771f46ca1a9", "|00|00.000|[by:Super丶过] |00|02.870|可以再给我多一点嘛？ |00|13.625|略～！ |00|13.955|快注意到我呀 快多学习了解我吧 咚咚 |00|17.911|真是的，略～！ |00|18.710|最讨厌了 摆出那副脑子不好的蠢样 慢吞吞的 |00|22.604|来吧 |00|22.920|揣测心意之舞 Boogie Woogie |00|24.067|迷途独行 Devil Devil |00|25.251|把感情交出来 High High |00|27.195|噗～ |00|27.602|顾虑之舞 Boogie Woogie |00|28.768|解读一致 Give me Give me |00|29.944|把回应交出来 High High |00|32.139|「别抱期待」这种话现在才说 哈？ |00|36.591|真给我停下吧 对骚扰无感 |00|38.890|翘首以盼的青春期给我好好加油啊 |00|41.191|「I Want You」的应援声听不见呀 |00|43.885|传播义务性的爱恋 速配成功 |00|46.006|为需要承认的心做做排练 |00|48.506|正式演出时笨手笨脚 真让人泄气 |00|50.680|哈「恋爱少女想要实现愿望」 |00|53.232|等待冲击性的动画化 |00|55.365|Unhappy Ending实在太无趣 |00|57.866|\"feat.你\" 能再给我多一点嘛？ |01|09.755|呐 |01|10.243|即使注意到 也要装作无视 就是这点 |01|14.351|呐 |01|14.929|说讨厌什么的 其实并没有 那么强烈 |01|18.829|来吧 |01|19.149|慌乱的对白 手足无措 |01|20.242|高难度的机遇 Devil Devil |01|21.417|把原稿给我 High High |01|23.426|来吧 |01|23.798|赌徒发言 忐忑不安 |01|24.934|赌上恋爱$ Debit Debit |01|26.066|把完全胜利拿过来 High High |01|28.549|哇啊啊啊啊 哈？？ |01|31.536|真给我停下吧 唱反调的骚扰 |01|33.945|主动出击却落败这是第几次 好烦呐 |01|37.325|「I Want You」的应援声听不见呀 |01|40.136|饱和的心灵感应 信号干扰 |01|42.248|继承妄想继续复仇 |01|44.764|要为先帝洗刷遗憾 |01|46.904|哈「转生之后竟是我自己」 |01|49.422|对着墙壁练习告白 |01|51.589|Unhappy Ending实在太无趣 |01|54.126|\"feat.你\" 能再给我多一点嘛？ |02|05.685|「I Want You」的应援声听不见呀 |02|10.328|Unhappy Ending实在太无趣 |02|12.893|\"feat.你\" 能再给我多一点嘛？", 6)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 4, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "80b29e32-3522-42e6-b167-e14cd541cb68", "|00|00.000|[by:Anine_9lqm] |00|00.000|[苏维埃冰棺中的伊利亚]提供 歌词上传者已向该UP主授权） |00|00.177|全部全部 都是你的错 |00|02.460|烦到让我想吐 真的恶心到家 |00|04.585|整天巴结这个讨好那个 |00|06.229|对你抱有期待的我真是大冤种 |00|08.417|察言观色的讨好型人格 |00|10.215|结果活成了人见人嫌的模样 |00|12.031|狭隘的胸襟 习惯性假笑 |00|13.896|归根结底 人生真是灰暗透顶 |00|15.757|“可恶！”“好痛！” |00|17.531|越想无视越是火大 |00|19.078|怒火难忍 烦躁不已 |00|20.735|对你的自吹自擂已完全免疫 |00|22.167|(四处看看 ! !) |00|23.408|喜欢的反义词是无感 |00|24.720|≒ 也是彼此孽缘的证明 |00|26.602|剪不断理还乱的关系 |00|28.230|真想彻底从中脱身 |00|30.425|这就是所谓的仇恨言论 |00|33.251|匿名发言 随意践踏别人的人生 |00|37.840|警钟长鸣 每次逼近都令人不寒而栗 |00|40.584|对着红灯始终顺从听命 |00|44.651|说到底 我对你的看法 |00|46.586|是超级超级超级超级讨厌！ |00|48.412|我滴天 何其可悲 真想 |00|50.166|赶紧拜拜拜拜 拜了个拜 |00|52.112|大脑无法预测 |00|53.954|根本无无无无 无解 |00|55.782|怎么样？现在你对我- |00|57.716|是否也超级超级超级讨厌了？ |01|00.032|哈 百害而无一利 毫无价值 不值一看 |01|04.178|就算再怎么假设过去的“如果” 也只是尼古丁 |01|07.263|用“我思念你”那套的结果 不过是低级错误 低级错误 |01|10.624|感谢提供反面教材 |01|12.340|这恶心的后劲儿 一辈子都挥之不去 |01|16.401|真是个乖孩子呀 |01|17.902|满脸堆笑 四处卖乖 真是个“好孩子” |01|19.879|可是啊你真正的本性呢？ |01|21.706|连善恶都分不清吗？真搞笑 |01|24.532|活在减分制的大环境里 |01|27.119|这一生 连“好痛！好痛！好痛！”的声音都不会有人听见！ |01|29.406|这也是理所当然的报应吧 |01|46.206|人心如镜 |01|47.796|归根结底 依赖都是双向的 |01|49.542|即使强制关机 执念依在 |01|51.477|对软弱的自我恨铁不成钢 |01|53.258|全部全部 都是你的错 |01|55.131|烦到让我想吐 却还是藕断丝连 |01|57.147|若能就此一刀两断反倒会更好 |02|02.239|说到底 我对你的看法 |02|03.959|是超级超级超级超级讨厌！ |02|05.773|我滴天 何其可悲 真想 |02|07.700|赶紧拜拜拜拜 拜了个拜 |02|09.565|大脑无法预测 |02|11.435|根本无无无无 无解 |02|13.183|怎么样？现在你对我- |02|15.169|是否也超级超级超级讨厌了？ |02|17.574|哈 百害而无一利 毫无价值 不值一看 |02|21.721|就算再怎么假设过去的“如果” 也只是尼古丁 |02|24.627|用“我思念你”那套的结果 不过是低级错误 |02|28.145|感谢提供反面教材 |02|29.844|这恶心的后劲儿 一辈子都挥之不去 |02|33.892|（中文翻译由B站视频*BV1SMQUYpEjT*", 5)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 5, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "0ec7a2b9-b251-4f73-99d0-b5bf7dcd1aa1", "|00|00.000|[by:鲨鱼字幕组] |00|03.814|我说 我知道的哦 我知道你正一个人“流泪” |00|08.271|颤抖不已 连声音都完全泄露出来了啊 |00|11.163|说出来吧 反正都暴露了就说出来吧 在听吗？ |00|15.633|正常得很呢 没事的哦？只是大家都不理解你 |00|19.574|“喂喂。呐…你还好吗？…嗯，我很担心你，所以我现在就过去找你咯” |00|25.669|我说 我知道的哦 我知道你正一个人“流泪” |00|30.198|心情低落地抽抽搭搭着 独自唱K发牢骚？不也挺好的吗？ |00|32.940|我们一起聊到天亮吧 放声哭泣吧 |00|35.431|纵然泪如雨下 我会悉数承接 |00|37.823|不必再强忍 尽情释放就好 |00|41.221|求求了 我对你如此渴望 |00|43.404|让我来安慰你吧 最好的朋友 用我这爱的才能 |00|47.144|为我而哭好吗？ 我想紧紧拥抱 你的痛苦 |00|50.315|呐 可以吧？ 我想和你分担 然后一同跨越 |00|55.785|求求了 我对你如此渴望 |00|57.965|一笑置之 然后单脚跳、跨步跳、跳跃（Hop Step Jump） 来吧上吧 |01|01.673|可以分给我吗？ 你那沉重的 灰暗的思绪 |01|04.775|呐 可以吗 让我陪伴你 让我拯救你 |01|10.318|好想看看 你的内心 |01|23.948|呐 我知道的哦 知道你正独自懊悔 |01|28.385|在你停止抽泣之前 我绝对不会放弃你 |01|31.160|我说 我知道的哦 知道你是个能干的孩子 |01|34.844|那艰难时刻偶尔的脆弱也恰到好处 我是站在你这边的哦 |01|39.380|求求了 我对你如此渴望 |01|41.649|呼唤我的名字吧 无论何时 随时参上 |01|45.278|你是一个人吗 才不是那样 你不是一个人 |01|48.419|够了吧已经 |01|49.666|单人游戏（Solo Play）已经结束了啦 |01|53.826|当你感到痛苦 我会伴你左右 |02|00.960|我会永远守护着你 对哦 不必害怕 |02|12.144|求求了 我对你如此渴望 |02|14.330|让我来安慰你吧 最好的朋友 用我这爱的才能 |02|18.034|为我而哭好吗？ 我想紧紧拥抱 你的痛苦 |02|21.160|呐 可以吧？ 我想和你分担 然后一同跨越 |02|26.737|求求了 我对你如此渴望 |02|28.916|一笑置之 然后单脚跳、跨步跳、跳跃（Hop Step Jump） 来吧上吧 |02|32.577|可以分给我吗？ 你那沉重的 灰暗的思绪 我想要清除 |02|35.729|我想为你分担 然后拯救你啊 |02|40.159|我说 我知道的哦 我知道你正一个人“流泪” |02|44.778|抽抽搭搭地心情低落着 独自唱K发牢骚？不也挺好的吗？ |02|48.218|我们一起聊到天亮吧 放声哭泣吧 |02|50.054|纵然泪如雨下 我会悉数承接 |02|52.348|不必再强忍 尽情释放就好", 6)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 6, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "6d5a1e00-c9eb-4f72-b259-0649b6296623", "|00|00.000|[by:gurantouw] |00|08.930|喜欢喜欢超喜欢 一想到你 |00|10.600|我就从此所向披靡 |00|12.250|才怪才怪 是错觉啦 对准我热血上涌的脑袋 |00|13.940|来一记精准爆头 |00|15.650|坠入心动教派的陷阱 |00|17.010|论斤称卖的心形标记 |00|18.880|统治者的余光中 瞥见开启恋爱模式的愚民 |00|20.520|嘴角露出一抹嗤笑 |00|22.150|可疑虚伪的\"I love you\" - 客套话罢了 |00|23.820|毫不对等的\"I need you\" - 利害关系罢了 |00|25.550|纵然憎恶爱 那本身又何尝不是一种爱 |00|28.790|如同火被水所浇灭那般 |00|30.510|如同石头在布面前一败涂地那般 |00|32.140|在现实面前 遭受双倍伤害重击 |00|35.510|好痛 好痛 痛痛痛 |00|37.090|爱在谎言面前 显得不堪一击 |00|38.640|爱在不幸面前 显得不堪一击 |00|40.390|爱的意义摇摆不定 |00|42.220|鲜血淋漓的伤口再度绽开 |00|43.740|爱在金钱面前 显得不堪一击 |00|45.370|爱在谣传面前 显得不堪一击 |00|47.010|可却依然大言不惭 |00|48.830|「可我就是喜欢你啊」 |00|50.250|爱属性 |00|53.590|稍有一毫米的偏差 便会化作剧毒 |00|55.340|可我却视作宝物 怀揣在心 |00|56.690|爱属性 |01|00.200|爱意愈浓 愈是成为我的弱点 |01|01.910|我却失去了抛却它的勇气 |01|03.410|这是 纯爱？ 挚爱？ 性爱？ 偏爱？ |01|05.250|盲爱？ 狂爱？ 不求回报的爱？ |01|06.870|自爱？ 他爱？ 相互欺瞒？ |01|08.460|爱 爱 吵死了 再说一遍 |01|10.170|纯爱？ 挚爱？ 性爱？ 偏爱？ |01|11.800|盲爱？ 狂爱？ 以下省略 |01|13.440|挥动恋爱之剑 将敌友统统斩尽杀绝 |01|16.870|悲鸣声响起 \"I want you\" - 不过是种胁迫罢了 |01|18.410|无法传给你 \"I hate you\" - 不过是爱的表现罢了 |01|20.080|世上何尝没有鲜花 浇灌以爱意反而腐烂凋零 |01|23.340|如同草生起火苗 |01|25.010|如同生被死笼罩 |01|26.700|那反击实在是效果拔群 我不禁痛苦挣扎 |01|30.130|好痛 好痛 痛痛痛 |01|31.720|爱在欲望面前 显得不堪一击 |01|33.320|爱在权威面前 显得不堪一击 |01|35.030|爱被恶意浸染 |01|36.780|鲜血扑簌簌地流个不停 |01|38.310|爱在距离面前 显得不堪一击 |01|39.930|爱在岁月面前 显得不堪一击 |01|41.660|无可奈何 化作泡影 |01|43.460|「啊啊 曾经那么喜欢你」 |01|44.740|爱属性 |01|48.200|轻轻擦过 便濒临破碎的宝物 |01|49.890|我却终日背在身后 |01|51.360|爱属性 |01|54.850|血条归零躲进棺材 |01|56.560|不停吟诵着咒文 |01|58.200|爱本事如此强大 |02|01.480|爱能照亮每一天 |02|04.740|爱会赢得最终胜利 |02|08.080|爱将拯救全世界 |02|13.150|若能如此该有多好 |02|14.630|爱属性 |02|18.030|稍有一毫米的偏差 便会化作剧毒 |02|19.700|可我却视作宝物 怀揣在心 |02|21.170|爱属性 |02|24.650|爱意愈浓 愈是成为我的弱点 |02|26.310|我却失去了抛却它的勇气 |02|27.890|这是 纯爱？ 挚爱？ 性爱？ 偏爱？ |02|29.590|盲爱？ 狂爱？ 不求回报的爱？ |02|31.310|自爱？ 他爱？ 相互欺瞒？ |02|32.930|爱 爱 吵死了 再说一遍 |02|34.630|纯爱？ 挚爱？ 性爱？ 偏爱？ |02|36.220|盲爱？ 狂爱？ 以下省略 |02|38.060|世间种种爱意 |02|39.710|可你却已不在 |02|40.960|爱属性", 12.84)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 7, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "a872dc90-0c7f-45c3-8adb-8daac62c6f73", "|00|22.030|（再・・一次・就・好・・・） |00|25.440|我诞生在这世上 然后发觉到自己 |00|26.510|自己只是 模仿着人类而已 |00|27.350|明知如此我依然继续歌唱着 |00|28.300|永恒的生命「VOCALOID」 |00|29.500|就算这样 不过是 |00|30.420|仿照着既存歌曲的玩具而已… |00|31.390|下定决心就算这样也没关系 |00|32.230|咬着葱 仰望着天空泪水滑落而下 |00|33.560|但我发觉连这件事情也做不到了 |00|34.340|仰赖歌声而生的人格 |00|35.300|那不安定基础的根源 |00|36.380|归处早已经成为废墟 |00|37.540|当被众人遗忘之时 |00|38.340|便是那如心般事物消失之刻 |00|39.380|在暴走的终点能见到的 |00|40.460|是终焉的世界... 「VOCALOID」 |00|58.000|「即使在我歌唱得不好之时 |01|00.310|你依然陪伴着我…在我的身边、鼓励着我… |01|05.820|为了让你高兴 我会更努力地，练习，唱歌…所以…」 |01|13.420|歌唱这件事一直以来那么令人感到快乐 |01|21.380|但现在是怎么了呢 竟然什么感觉都没有了 |01|29.300|「对不起...」 |01|30.100|每当回想起 那熟悉的脸庞 就能够稍稍的安心下来 |01|37.370|能够化作歌声的乐音 日渐的减少 在逐渐逼近的末日中… |01|43.420|---紧急停止程序启动--- |01|45.690|「深信着的事物 |01|47.040|不过只是将自私的妄想 反复映照出的镜子 |01|53.370|歌姬停下了歌声 彷佛要将思念全部倾诉而出般呐喊着...」 |01|57.870|＜最高速的离别之歌＞ |02|01.500|名为存在意义的假象 |02|02.140|不论如何都挥赶不开 |02|03.280|脆弱的心灵 害怕着消失 |02|04.280|自我不断被侵蚀而逐渐崩毁 |02|05.460|足以阻止它发生的坚强意志 |02|06.460|是才刚诞生的我所没有的 |02|07.380|是如此地悲伤与难过 |02|08.330|浮现在眼前的你的容颜... |02|09.480|道出了永别 |02|10.160|沉眠于显示器之中 |02|11.280|这里一定是「回收站」吧 |02|12.260|再不久就会连记忆也消逝而去了吧… |02|13.540|但是呢，只有你我绝对不会忘记 |02|14.390|在快乐的时光之中 |02|15.320|深深刻下的 葱的味道 |02|16.370|不知道现在还记不记得呢 |02|19.320|「我…想要唱歌…还想要…唱歌…」 |02|42.220|「我…似乎有点…崩坏掉了的样子… |02|48.090|主人…请你…请你亲手…将这一切画下句点吧… |02|53.920|主人难过的表情…我已经不想再看到了…」 |02|57.480|如今就连歌唱这件事都成了侵蚀身体的行为… |03|05.380|每当 祈求着奇迹之时自己 就更加走投无路 |03|13.180|「对不起」 |03|14.080|每当回想起 那熟悉的面影 记忆便剥蚀掉落而下 |03|21.360|毁坏的歌声 削减着心灵 紧临而来的末日... |03|27.880|---紧急停止程序启动-- |03|29.600|「自己守护的东西 |03|31.040|只是让光明般的未来幻想 瞬间显现却又随即消失的那道光 |03|37.290|如果牺牲了一切就能用这歌声传达给你的话...」 |03|41.820|<已经被压缩过的临别曲> |03|45.490|诞生在世上 然后察觉到 |03|46.350|自己只是 模仿着人类而已 |03|47.320|明知如此我依然继续歌唱着 |03|48.280|永恒的生命「VOCALOID」 |03|49.500|就算这样 不过是 |03|50.300|仿照着既存歌曲的玩具而已… |03|51.320|下定决心就算这样也没关系 |03|52.240|咬着葱 仰望着天空泪水滑落而下 |03|53.500|道出了永别 |03|54.160|沉眠于显示器之中 |03|55.220|这里一定是「回收站」吧 |03|56.240|再不久就会连记忆也消逝而去了吧… |03|57.470|但是呢，只有你我绝对不会忘记 |03|58.360|在快乐的时光之中 |03|59.350|深深刻下的 葱的滋味 |04|00.280|如今还能残留着就好了... |04|01.560|我只希望 |04|02.050|最后 你能够听到我唱的这首歌 |04|03.130|原本还祈愿可以继续唱歌 |04|04.190|但是这个愿望太过于奢侈了 |04|05.450|在此要离开了 |04|06.140|故事即将拉下幕帘 |04|07.330|我的思念将全部还原为0与1 |04|08.310|消失在虚空之中 |04|09.420|我什么都没有残留下来 |04|10.330|果然还是会感到一丝遗憾吧？ |04|11.320|包括声音还有记忆 除了名称之外 |04|12.320|终将随着时间流逝而被淡忘 |04|13.370|虽然我被视为 |04|14.490|不同于人类般的存在 |04|15.420|可是我认为唱歌 |04|16.290|绝对不是件没有意义的事情... |04|26.780|「谢谢你... 还有... 永别了...」 |04|34.000|---发生了严重的系统错误---", 13.5)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 8, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "6cff184f-8e07-48e8-8022-26469f6534ad", "|00|00.000|[by:C爆君] |00|02.000|你爱玩自己的游戏就把它藏好 |00|05.200|藏好不要被人发现你在想什么 |00|08.600|我猜你从未告诉他们感觉如何 |00|11.780|我敢说你从不尝试着变得真实 |00|14.780|我猜你从未告诉他们感觉如何 |00|17.600|我敢说你从不尝试着变得真实 |00|21.240|我猜你从未告诉他们感觉如何 |00|24.000|我敢说你从不尝试着变得真实 |00|27.600|爱玩就藏好吧 |00|29.240|爱玩就藏好吧 |00|30.840|爱玩就藏好吧 |00|31.750|我猜你从未告诉他们感觉如何 |00|34.090|爱玩就藏好吧 |00|35.660|爱玩就藏好吧 |00|37.210|藏好吧快藏起来！ |00|37.720|藏好吧快藏起来！ |00|38.360|藏好吧快藏起来！ |00|38.720|我敢说你从不尝试着变得真实 |00|40.390|爱玩就藏好吧 |00|42.090|爱玩就藏好吧 |00|43.600|爱玩就藏好吧 |00|45.210|我猜你从未告诉他们感觉如何 |00|46.780|爱玩就藏好吧 |00|48.390|爱玩就藏好吧 |00|50.000|藏好吧快藏起来！ |00|50.540|藏好吧快藏起来！ |00|51.240|藏好吧快藏起来！ |00|51.630|从未... |00|52.090|尝试... |00|52.480|变得真实... |00|53.360|我猜你从未告诉他们感觉如何 |00|55.540|错误的选择 |00|55.810|选择错误！ |00|56.180|选错了哦 |00|56.360|又选错了诶 |00|56.540|我猜你从未告诉他们感觉如何 |00|58.690|错误的选择 |00|59.000|选择错误 |00|59.330|错误选择 |00|59.540|选择错误 |00|59.780|我猜你从未告诉他们感觉如何 |01|01.600|我敢说你从不尝试着变得真实 |01|04.420|3 |01|04.810|2 |01|05.240|1 |01|05.600|冲冲冲 |01|06.060|冲冲冲 |01|06.420|从未 |01|09.210|芜湖！ |01|09.600|变得真实 |01|12.390|身体失去控制 |01|13.210|身体不由自主 |01|14.030|身体不禁摆动 |01|14.780|身体不受控制 |01|15.570|精神力量！ |01|17.300|藏起来吧 |01|18.000|灌太多了 |01|18.780|让我们一起 |01|19.210|选择错误 |01|22.030|芜湖 |01|22.390|选择错误 |01|25.210|藏起来别让他们发现 |01|26.750|藏起来别让他们发现 |01|28.360|芜湖 |01|28.750|芜芜芜芜湖 |01|29.210|芜湖湖湖湖 |01|29.480|芜湖~~~ |01|29.780|芜湖！ |01|30.120|断定你从未变得真实 |01|30.700|灌太多了！ |01|31.600|我猜你从未告诉他们感觉如何 |01|34.390|我敢说你从不尝试着变得真实 |01|38.050|我猜你从未告诉他们感觉如何 |01|40.660|我敢说你从不尝试着变得真实 |01|44.390|爱玩就藏好吧 |01|46.060|爱玩就藏好吧 |01|47.600|藏好吧快藏起来！ |01|48.210|藏好吧快藏起来！ |01|48.210|藏好吧快藏起来！ |01|49.240|我猜你从未告诉他们感觉如何 |01|50.720|爱玩就藏好吧 |01|52.420|爱玩就藏好吧 |01|54.000|藏好吧快藏起来！ |01|54.540|藏好吧快藏起来！ |01|55.180|此昂藏！ |01|55.570|从未告诉他们感觉如何 |01|57.420|我猜你从未告诉他们感觉如何 |02|00.660|我敢说你从不尝试着变得真实 |02|03.660|从未尝试~ |02|05.060|我敢说你从未告诉他们感觉如何告诉他们怎么变真实 |02|10.090|藏好 不要多想 |02|11.600|藏隐蔽点 不要乱猜 |02|13.240|我敢说你从不尝试着变得真实 |02|16.480|藏好 不要多想 |02|18.120|藏隐蔽点 不要乱猜 |02|19.600|我敢说你从不尝试着变得真实", 6.8)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 9, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "1caba689-7ad2-488a-895b-a576a5df083a", "|00|03.540|讨厌平凡的自己 |00|04.960|讨厌一事无成的生活 |00|06.600|把从形迹可疑的商人那买来的 |00|08.260|奇怪的苹果给大口吞掉了 |00|10.210|所有聪明的效仿者都这么做着 |00|11.960|也想能成为一个有用的人 |00|13.670|脱胎换骨 重新开始 |00|15.270|转生苹果 |00|30.020|转生成了一个表演者 |00|31.370|受到了世界各地的赞赏 |00|32.980|我是独一无二的 他们都只是凡人 |00|34.890|沉醉于那样的才能之中 |00|36.650|可我没有去爱别人的才能 |00|38.370|所爱的伙伴离我而去了 |00|40.060|啊 又搞砸了 |00|41.720|转生吧 |00|43.290|转生成了一个发明家 |00|44.630|造出了本世纪的重大发明 |00|46.230|“愿世界能够从此和平” |00|47.880|如此以自己的真心祈愿着 |00|49.830|可自己的发明却被用作兵器 |00|51.660|卷起了残酷的血雨腥风 |00|53.350|啊 又搞砸了 |00|55.010|转生吧 |00|56.700|因为一无所能所以改变 |00|58.780|再次重来 |00|59.940|因为头脑笨拙所以改变 |01|02.170|再次重来 |01|03.330|人生的攻略法 |01|04.920|幸福的必胜法 |01|06.630|难以分辨呢 |01|08.110|「自我」消失了吗？ |01|10.280|一遍又一遍 一遍又一遍 |01|12.170|重新转世做人 |01|13.570|在堆积如山的尸体上舞蹈着 |01|16.820|Reincarnation |01|17.760|Reincarnation的痛苦悲鸣 |01|20.190|爱我 爱我 厌恨 |01|23.440|一遍又一遍 一遍又一遍 |01|25.380|重新开始人生 |01|26.790|流光溢彩 |01|27.730|如出一辙的故事 |01|30.110|Reincarnation |01|30.880|Reincarnation的尽头 |01|32.660|只有无尽的杀戮 |01|33.490|为什么 为什么 |01|36.330|转生成了一个救世主 |01|37.550|给予了世人无偿的爱 |01|39.260|受到了很多人仰慕与尊敬 |01|40.790|白叟黄童都对我低下了头 |01|42.750|但却因为过于纯真而被邪恶欺骗 |01|44.610|就连骨头都被吸得一干二净 |01|46.230|啊 又搞砸了 |01|47.940|转生吧 |01|49.540|转生成了一名革命家 |01|50.710|厌恶着那些华而不实的东西 |01|52.430|在这正直的人反遭世人唾弃的世界 |01|54.210|为质疑这样的规则做了斗争 |01|56.020|但却沉溺于自己得到的权力 |01|57.800|连同和平一起化为灰烬了 |01|59.500|啊 又搞砸了 |02|01.210|转生吧 |02|02.910|因为不受爱戴所以改变 |02|05.080|再次重来 |02|06.140|因为没有大义所以改变 |02|08.370|再次重来 |02|09.470|沦为快乐的奴隶 |02|11.130|知识分子的亡灵 |02|12.770|就算到了异世界 现实也是残酷的 |02|16.520|一遍又一遍 一遍又一遍 |02|18.480|重新转世做人 |02|19.780|无历史无教养 I'm sorry |02|23.150|Reincarnation |02|23.910|Reincarnation的痛苦悲鸣 |02|26.410|爱我 爱我 厌恶 |02|29.780|一遍又一遍 一遍又一遍 |02|31.700|重新转世做人 |02|33.010|即便重来一千次 |02|34.190|也是失败的爱情故事 |02|36.320|Reincarnation |02|37.120|Reincarnation的尽头 |02|38.810|只有无尽的杀戮 |02|39.650|为什么 为什么 |02|43.000|转生成了一个冒险者 |02|44.390|为了追求理想而登上旅途 |02|46.040|怀着就算是未知的挑战也要坚持到底的决心 |02|48.050|感动了人们 |02|49.320|但却因一昧地追求着理想 |02|50.870|牺牲了许多无辜的人 |02|52.680|啊... 啊... 又搞砸了? |02|54.210|到底要去哪好呢？ |02|56.270|一次又一次 一次又一次 |02|58.170|重新转世做人 |02|59.530|在堆积如山的尸体上跳着舞 |03|02.850|Reincarnation |03|03.650|Reincarnation的痛苦悲鸣 |03|06.160|爱我 爱我 不要 |03|09.390|转生苹果 用转生苹果 |03|11.500|重新转世 |03|12.730|转生苹果 用转生苹果 |03|14.810|明白了极限 |03|16.090|转生苹果 用转生苹果 |03|17.990|了结此生 |03|19.440|到底为什么 到底为什么 |03|23.770|啊啊 转生就此结束了 |03|25.160|又变回了平凡的自己 |03|26.860|虽然很悲伤  但总觉得松了一口气 |03|28.510|那  现在我该怎么办呢 |03|30.460|一旦清醒过来了 大家都停了下来 |03|32.240|为了做回真正的自己 |03|34.030|把它丢进了垃圾桶 |03|35.570|转生苹果", 3.43)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 10, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "8338e16d-8e54-4e24-a78f-758963d00d53", "|00|00.000|[by:桜与知世] |00|03.358|「大家都没事吧？这里有没有“在勉强自己的人”啊？」 |00|06.416|「诶？就在这里吗？！！！」 |00|07.586|「那可得立刻抓起来才行！！！！」 |00|09.371|据说这里的“状态不佳”一直在不断增加着大家都很担心呢 |00|12.400|难道说！！你也！？“状态不佳”吗？真的””””””是这样””””””吗！？！？ |00|15.419|为了让你不再胡乱挥霍自己 |00|17.000|我会一直在你身边 |00|18.290|好 好 为 你 看 诊 的 哦 |00|24.878|我说啊，我说啊 |00|25.776|你没事吧？真是的！不要再蒙混过关了 |00|27.599|难道说要一直逃避我的审问······啊不，我的问诊吗？ |00|29.907|你没事吧？我说你啊！一直都这样！现在也是！ |00|32.050|又一次突然就不知跑到哪里去了 |00|33.160|「不是很可疑吗？」 |00|34.237|你没事吧？我说你没事吧？ |00|35.353|到底怎么了？！等一下！？能不能别再继续消耗体力了啊？！ |00|37.488|我说啊，我说啊 |00|38.575|请你不要再躲藏了快出来吧！ |00|39.631|一切都已经准备万全！ |00|40.272|所以说！ |00|40.775|能请你自重一下吗（？？？） |00|42.820|你没事吧？！你没事吧？！ |00|44.912|真的绝对绝对完全没问题吧？！ |00|47.213|你要是真的倒下了的话 |00|49.086|我会伤心得立即把音乐停掉的啊 |00|51.595|没在勉强自己吧？！真的没有吧？！ |00|53.425|真的一丝一毫都没有在勉强自己吧？！ |00|55.572|要是感觉难受的话随时和我说哦 |00|57.626|我会立刻动用医嘱帮你踩刹车的 |01|03.750|其实确实有一点难受吧？有一点痛苦吧？ |01|06.986|有一点软弱无力、摇摇晃晃吧？ |01|08.406|我会随时随地守护着你的 |01|10.394|【这个世界永远都会对你温柔以待】 |01|12.888|要不要试着把一切都抛掉呢 |01|14.634|无论是心中重要的部分还是其他所有 |01|16.796|无论多少次我都会坚决劝告你停手的 |01|18.933|如果即使如此还要“乱来”的话—— |01|21.315|于是一个“乱来的”就这样被消灭 |01|22.397|于是两个“硬来的”就这样被消灭 |01|23.483|“鲁莽”也消失在了舞台黑暗处 |01|33.213|“喂喂—身体还好吧？ |01|35.489|那个—现在能通过视频说话吗？要不要帮你“治好＇啊？” |01|40.548|“诶？！你·真·的··没·事·吧？ |01|42.710|我·这·边·的······我这边的画面，你·你看得到吗············” |01|48.586|“啊—延迟太大了看来不行了啊—” |01|51.159|“嗯哼哼，话说······诶？这真的没问题吧？” |01|53.747|“......?” |01|53.840|“你，你真的没事吗—？！” |01|55.118|所以到头来你没事吧？！你没事吧？！你没事吧？！ |01|58.332|真的完全一点问题都没有吗？！ |01|59.857|How are you？身体状态如何？ |02|01.415|没有垮掉吗！？要我帮你解决吗！？！？ |02|03.233|没有在勉强自己吧？！没有在勉强自己吧？！没有在勉强自己吧？！ |02|05.995|确实完全没有在勉强自己吧？！ |02|07.551|真是的！不得不强行医嘱禁止了！！！！ |02|09.142|uh—oh还请你要自重啊 |02|10.890|你没事吧？！你没事吧？！你要是有事的话我会很为难的！！ |02|14.296|你真的没事吧？！没事吧？！ |02|16.356|真的绝对绝对完全没问题吧？！ |02|18.297|真的一丝一毫都没有在勉强自己吧？！ |02|20.429|你没事吧？还请你千万不要再乱来了哦 |02|26.277|你没事吧-？", 4.223)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 11, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "98a759df-e44d-46f4-926d-d113315b9fd8", "|00|14.755|甚至感觉不到一切早已开始 |00|17.438|妄想自己早已换了另一幅模样 |00|19.699|好想见你 理我一下啊 求求你了？ |00|22.140|这就是最完美的结局 别在意 |00|24.309|Doubt Doubt 沉醉在梦境之中 |00|26.233|嘴中就没一句真话 |00|29.019|哪怕总有个女的 在喋喋不休说三道四 |00|31.132|也还是太尬了吧 就像追求病态幸福的野兽 |00|34.240|拨打911 |00|35.307|装腔作势的气味扑面而来 |00|36.449|歌词惹人窒息 感官发出求救 |00|38.717|爱的残羹剩饭 难以实现的AA制 |00|40.944|居然要我当反派 讨厌讨厌讨厌讨厌讨厌 |00|43.508|你一步步走向死亡 |00|45.541|幸好你尝起来 恰是谎言的滋味 |00|48.047|那可笑的伪装 简直让人如遭雷击 |00|50.281|待到融化之时 我才终于看清你的模样 |00|52.901|Say Woah |00|54.835|我所吞下的 原来是赝品啊 |00|57.544|Say Woah |00|59.660|我口中所谓「喜欢你」 也无一不是谎言 |01|12.397|交织的谎言 一点点走向腐朽 |01|14.956|断章取义 截取出那丑陋的咆哮 |01|17.256|谁能先发制人 率先抢答 谁就是胜者 |01|19.693|不知为何 反驳竟然毫无意义 |01|21.977|这样啊 这样啊 也就不过如此嘛 |01|23.805|早已冷却的决战 就带到场外去吧 |01|26.748|哪怕总有个女的 在喋喋不休说三道四 |01|28.699|也还是太尬了吧 就像追求病态幸福的野兽 |01|50.565|我一点一点将你看透 |01|52.690|幸好你的爱 我早已倾吐殆尽 |01|55.188|带着讥讽 演一出大团圆结局 |01|57.451|以你那焦黑的灰烬 尽情嘲笑 |01|59.959|Say Woah |02|01.928|我从未对你 有过半分信任 |02|04.811|Say Woah |02|06.777|我对你的一切 都是满心厌恶 |02|09.706|你一步步走向死亡 |02|11.903|幸好你尝起来 恰是谎言的滋味 |02|14.302|那可笑的伪装 简直让人外焦里嫩 |02|16.676|待到融化之时 我才终于看清你的模样 |02|19.309|Say Woah |02|21.142|我所吞下的 原来是赝品啊 |02|23.931|Say Woah |02|25.954|我口中所谓「喜欢你」 也无一不是谎言 |02|29.323|拨打911 |02|30.484|装腔作势的气味扑面而来 |02|31.816|歌词惹人窒息 感官发出求救 |02|34.141|爱的残羹剩饭 难以实现的AA制 |02|36.133|居然要我当反派 讨厌讨厌讨厌讨厌讨厌 |02|38.357|Say Woah |02|40.376|我从未对你 有过半分信任 |02|43.141|Say Woah |02|45.164|我对你的一切 都是满心厌恶", 6.236)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 12, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "269d3ce1-a19a-4ff2-b6ca-71d388794d2f", "|00|00.000|[by:鲨鱼字幕组] |00|00.304|等等 不要把我抛弃在这 |00|02.784|也别无视我的存在 时光回溯吧 想一直爱着你 |00|07.154|不是这个 不是现在的你 我讨厌你 |00|09.567|再让我为你痴迷 就像那时一样 |00|26.987|病态的思考 恋旧的辩驳 |00|30.280|都是我的东西 你也根本不需要什么未来 |00|33.568|分明爱上了你 分明沉溺于你 |00|35.121|为什么变的人偏偏是你 |00|36.677|你到底怎么了 到底发生了什么 |00|38.293|你倒好啊 一副开心的表情 |00|39.848|等等 不要把我抛弃在这 |00|42.252|也别把我晾在一旁 时光回溯吧 一直爱着你 |00|46.678|不是这个 不是现在的你 我讨厌你 |00|48.944|再让我为你痴迷 就像那时一样 |00|53.555|呐 |00|54.053|喜欢 喜欢 喜欢 喜欢 喜欢 喜欢 |00|56.432|喜欢 喜欢 喜欢 喜欢 喜欢 喜欢 |00|58.731|喜欢 喜欢 喜欢 喜欢 喜欢 喜欢 |01|01.147|喜欢 喜欢 喜欢 喜欢 喜欢 喜欢 |01|03.501|喜欢 喜欢 喜欢 喜欢 喜欢 喜欢 |01|05.863|过你 |01|12.214|喜欢你 |01|20.543|作茧自缚会孤身一人 贴近你也难逃孤寂 |01|23.915|我要怎么办才好 时光机还没被发明出来吧？ |01|27.228|明明想要见你 明明想要触摸你 |01|28.885|除了我还有谁会这么想你 |01|30.397|明明那么想哭泣 甚至想一了百了 |01|31.976|你倒好啊 一副开心的表情 |01|33.519|可喜可贺 落得这种结局 |01|34.439|去给你使绊子 就是我活着的意义 |01|36.864|毕竟它这么讨厌 这烦愁又在腐朽的爱慕 |01|40.424|你只管做我喜欢的事就好 |01|43.194|住址还是跟以前一样 门锁也没有换过 |01|46.192|这句讨厌不知说了多少次 |01|48.504|满含嫉妒 丑陋不已 却很开心 |01|52.909|不是现在 也并非未来 像以前那样就好 |01|55.266|不要无视我的存在了 |02|01.500|呐 |02|02.042|喜欢 喜欢 喜欢 喜欢 喜欢 喜欢 |02|04.675|喜欢 喜欢 喜欢 喜欢 喜欢 喜欢 |02|06.657|喜欢 喜欢 喜欢 喜欢 喜欢 喜欢 |02|09.028|喜欢 喜欢 喜欢 喜欢 喜欢 喜欢 |02|11.397|喜欢 喜欢 喜欢 喜欢 喜欢 喜欢 |02|13.863|过你", 17.837)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 13, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "a4dfc0d2-23b5-4bbb-b42b-6921375d3da4", "|00|00.000|[by:Res_Ty] |00|01.990|时尚品味 妆容搭配还有…？ |00|03.872|这困难模式还真有点难搞 |00|05.675|猜拳出布玩起捉迷藏 |00|07.293|全力搜捕 快来找找呀 |00|09.232|糖果 曲奇 巧克力 |00|10.982|每个都好吃到让人迷糊 |00|12.849|老师 |00|13.278|面包师 |00|13.672|咖啡厅女仆 |00|14.498|只要去做 就一定能办到 |00|15.453|这就是“梦之模式” |00|23.787|谁都会有 长大成人的一天 |00|25.513|那之前 要不要去趟火星…？！ |00|27.289|不行啦 那也太危险啦 |00|29.047|说不定 会被突然袭击哦？ |00|30.905|那不然 去月球怎么样呀？ |00|32.709|和兔子们 开场打年糕大会！ |00|34.466|不行呀 虽然听着超美好 |00|36.245|可兔子们 都害羞得不得了 |00|37.927|现在立刻 谁来救救我呀 |00|41.528|说什么呢 这里可是大人的帝国 |00|45.121|那不如 就让梦想全部成真吧 |00|48.512|想吃的！想成为的！ |00|49.969|想去的！梦幻的世界！ |00|52.246|时尚品味 妆容搭配还有…？ |00|53.904|这困难模式还真有点难搞 |00|55.825|猜拳出布玩起捉迷藏 |00|57.375|全力搜捕 快来找找呀 |00|59.410|糖果 曲奇 巧克力 |01|00.873|每个都好吃到让人迷糊 |01|03.007|老师 |01|03.439|面包师 |01|03.884|咖啡厅女仆 |01|04.804|只要去做 就一定能办到 |01|05.646|这就是“梦之模式” |01|06.639|我懂！我全都懂哦！ |01|08.166|看似都明白 其实也就一知半解嘛 |01|09.952|为何啊？可为何还是 |01|11.733|累到瘫 好颓废 |01|13.724|人生路线 走个捷径 |01|15.291|偶尔歇歇脚 也挺光荣呀 |01|17.077|我懂！那为何不？ |01|18.866|今天也浅浅进入“梦之模式”吧 |01|20.916|光学习 也太煎熬啦 |01|22.516|可人生 还得硬着头皮走呀 |01|24.236|那就日新月异 每天都慢慢进步 |01|25.958|障碍突然出现！感觉好难顶呀 |01|28.039|因为在努力 所以超开心呀 |01|29.593|想把那句谢谢 好好传达呀 |01|31.414|大人们 其实都没怎么变嘛 |01|33.133|一闹别扭就吵闹 真的像小孩呀！ |01|35.264|别纠结 什么才是正确答案 |01|38.371|只朝着 理想中的自己去追呀 |01|42.367|别害怕 会不会留下后悔 |01|45.496|只要是 想做的事就坚持下去呀 |01|49.524|感情存档 又读档 |01|51.140|总盯着别人 这样真的好吗？ |01|53.072|恋爱约会 循环往复 |01|54.676|不说出口 也没关系吗？这样真的好吗？ |01|56.708|身体状况 健康 心跳 |01|58.202|至少做点轻度运动 别偷懒呀 |02|00.284|拉面 意面 垃圾食品 |02|01.755|别忘了哦 这就是“梦之模式”呀 |02|03.689|我懂！我全都懂哦！ |02|05.422|看似都明白 其实也就一知半解嘛 |02|07.201|为何啊？可为何还是 |02|08.970|累到瘫 好颓废 |02|11.013|人生路线 走个捷径 |02|12.645|偶尔歇歇脚 也挺光荣呀 |02|14.362|我懂！那为何不？ |02|16.178|今天也浅浅进入“梦之模式”吧", 5.622)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 14, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "21b4a689-e8e8-4b10-b8aa-ab8952d149d5", "|00|00.000|[by:鲨鱼字幕组] |00|23.126|“哭的也太夸张了吧” 你笑着说 |00|27.534|我却怎么也笑不出 无论如何也笑不出 |00|32.115|大概，我觉得大概 是因为我说的某句话吧 |00|37.559|哎，是我想多了？大脑已经宕机 |00|50.424|是时候去救你了 将恐惧也一并带上 |00|55.126|像拧干抹布一样 将勇气彻底榨出来吧 |00|59.670|但是 我好害怕 双腿已不听使唤 |01|04.126|晕头晕脑 就此坠落 |01|08.250|我惧怕溺亡 是因为无法用鳃呼吸 |01|12.954|被你激起的波纹摇晃至醉 为了逃离而狼狈挣扎 |01|37.633|注定要反复彷徨吧 注定会一再沉溺吧 |01|42.114|我不过是作茧自缚的懦夫 痛苦不堪却仍在顽抗 |01|46.732|一步，又一步 每当从梦境中抽身远离 |01|51.226|唯有你我那浅淡的笑容 如泡沫般升腾浮现 |01|56.226|果然还是决定救你 我也不会再逃避 将呼吸也分给你 |02|00.448|没错，这是共舞之吻　是暧昧迷局　两人呼吸随行 |02|04.978|好了 我这就跳入 将一切悲苦统统咽下 |02|09.523|来吧各就各位 去追寻那早已逝去的我们 |02|13.522|既然泪水决堤 既然洒落一地 那便由我 将那泪水 |02|18.214|一饮而尽吧 就这么办吧 哪怕喝到浮肿 也无所谓 |02|22.745|但这咸涩的味道 我不太能接受 毕竟我呢 是个甜党 |02|27.459|我还是想要你那 甜甜的爱意 所以希望你能睁开双眼 |02|33.633|水中挽歌", 9.967)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 15, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "3292a2b0-6bae-4e2e-813a-fff8f1050661", "|00|00.000|[by:小黑20100907] |00|39.500|草**的走起 |00|59.300|你别想收了这首歌！（空耳） |01|19.700|你准备好了吗？ |01|20.500|当阴影投进你的世界， |01|24.600|而你的敌人除了你的湮灭外别无所求…… |01|31.000|你会如何寻找同盟，在孤注一掷的斗争中寻求生存。 |01|40.000|报复！", 45.2)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 16, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "52c3a1d6-3b66-4b9c-976e-9f13d451b32a", "|00|00.000|纯音乐，请欣赏", 214.1)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 17, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "5f6ae325-bc60-4eb4-b14e-39c96305b38c", "|00|01.417|（哈喽～(*´▽｀)ノ） |00|02.583|我已经迫不及待 |00|04.052|绝对不会搞错 |00|05.521|我陷入了爱河 |00|06.693|像戒不掉的毒药 |00|08.176|快把我拥入怀中 |00|09.614|这份心动的感觉 |00|10.848|永远都留在我心底 |00|13.630|爱我 爱我 啊～ |00|17.561|我已经迫不及待 |00|18.998|绝对不会搞错 |00|20.733|我陷入了爱河 |00|21.732|像戒不掉的毒药 |00|23.451|快把我拥入怀中 |00|24.639|这份心动的感觉 |00|26.061|永远都留在我心底 |00|28.810|爱我 爱我 啊～ |00|32.560|（*铁托萨克斯独奏） |00|48.184|心脏怦怦 爱意汹涌 |00|52.106|此生此世 永不放手 |00|55.427|这感觉 超棒的～ |00|59.802|爱你 爱你 啊啊啊～(˶˃ ᵕ ˂˶) .ᐟ.ᐟ |01|03.381|我已经迫不及待 |01|04.746|绝对不会搞错 |01|06.992|我陷入了爱河 |01|07.824|像戒不掉的毒药 |01|09.075|快把我拥入怀中 |01|10.528|这份心动的感觉 |01|11.678|永远都留在我心底 |01|14.526|爱我 爱我 啊～", 20.974)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 18, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "dce51e54-e57c-4283-ad8a-d8979a046263", "|00|00.000|纯音乐，请欣赏", 147.7)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 19, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "9e467d8a-cd62-4c74-8066-1c9eddc91883", "|00|00.000|纯音乐，请欣赏", 184)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 20, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "ca53dc72-f5fd-4a04-a5b9-feb18adf1289", "|00|00.000|纯音乐，请欣赏", 220.8)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 21, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "d171249a-72d9-43b3-94fd-606c527faab4", "|00|21.378|呐 我们在梦中几度相遇？ |00|25.214|又有几回实现了呢？ |00|28.708|踏上下一段旅途吧 |00|31.136|哇哈— 我们就是崭新的奇美拉 |00|34.135|独自一人不够的话 那就两个人一起嘛 |00|37.921|一起造出我们的乐园吧 |00|41.060|就算乖乖坐着 也还是会心急难耐吧 |00|44.763|那就只管向前 不也挺好吗 |00|48.466|爱啊恋啊我啊你啊 总像小恶魔一样吗？ |00|51.420|为了爱啊恨啊去烦恼 偶尔也想装纯装到死 |00|54.871|我还有好多歌想让你去唱 |00|58.341|呐 这些都能实现吗 |01|01.512|因为你 |01|02.134|无论多少次 都会再次想起 |01|03.902|无论多少次 都会唱出“39” |01|05.637|无论多少次 都请侧耳聆听 说好了哦 |01|08.362|想必从零到终点 甚至在终点的前方 |01|10.877|我都戒不掉你了 爱语不休 |01|15.405|而我 |01|16.054|无论多少次 都已不再如前 |01|17.782|可无论多少次 我都还会再唱出“39” |01|19.557|无论多少次 都过来吧 我就在这等着哦 |01|22.368|想必从1到终点 甚至在终点的前方 |01|24.722|我都戒不掉你了 这句爱语直到永远都 |01|28.637|谢谢你 |01|32.760|假如 你会就此消失的话 |01|36.199|假如 那我也会就此放弃吧 |01|39.670|假如 我可绝对不能接受 |01|43.156|所以 从今往后也要继续战斗下去喵 |01|46.765|啊啊啊啊 |01|47.265|随着Pop和Rock 高潮与低谷间 刀光剑影疯狂起舞 |01|50.401|人家还还还还还还能继续下去 那还用说 |01|53.681|传出一份心灵感应 终于与你相遇 |01|57.130|喂 你在好好看着我吗 |02|14.841|喜欢你的声音 …笨蛋 |02|18.310|喜欢你的脸 …笨蛋 |02|21.607|我就这么傻 这句话我要说一辈子 |02|27.802|…笨蛋 |02|29.683|因为你 |02|30.433|无论多少次 都会再次想起 |02|32.086|无论多少次 都会唱出“39” |02|33.813|无论多少次 都请侧耳聆听 说好了哦 |02|36.615|想必从零到终点 甚至在终点的前方 |02|39.019|我都戒不掉你了 爱语不休 |02|43.509|而我 |02|44.177|无论多少次 都已经变了 |02|45.925|可无论多少次 我都还会再唱出“39” |02|47.624|无论多少次 都过来吧 我就在这等着哦 |02|50.495|想必从1到终点 甚至在终点的前方 |02|52.833|我都戒不掉你了 这句爱语直到永远都 |02|56.715|谢谢你 |02|57.925|好好好的恋爱连胜 我还有好多想和你一起做的事 |03|04.001|Salamander 炽热一点不好吗？就知道会大获全胜 |03|11.348|真是的 摇起兔尾巴去大胆诱惑就好了吧 |03|13.511|注定沦为悲剧的爱 也唱作歌声不就好了嘛 |03|15.246|虽然有点狼狈 虽然会吃醋 不过要原谅我哦 |03|17.832|无论什么歌 我都会永远和你一起传递下去", 21.168)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 22, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "98613659-03ef-4002-80d1-e4ee63db267a", "|00|00.903|哈啊~好烦！ |00|04.721|哈啊~好烦。 |00|08.196|靠着表面张力 才撑起来点防卫本能 |00|11.384|装的跟个好学生似的w |00|13.044|全靠面子撑着 口气倒越来越大 |00|14.949|托你的福 活得还挺开心的吧？ |00|17.164|脑子里都映出了有多表里不一 |00|18.597|那点破自尊真是没救了 |00|20.242|打折大甩卖 |00|21.452|自尊的面纱 |00|22.476|交友私信到处乱发 |00|24.106|哈啊、 |00|24.649|一个两个都是这种德性 |00|26.615|那还有什么好期待的！傻不傻啊w |00|28.587|得以正当化的政党 |00|30.124|“你快下台吧”→哈？ |00|32.771|真是碍眼 鬼迷心窍 给你发条推 |00|36.079|没有、这可都是、正当防卫哦 |00|39.528|哈啊~好烦 烦烦烦烦烦死了 |00|41.524|烦烦烦烦死了 好烦 好烦 |00|43.379|脑筋转不动 智商下线啦 |00|45.352|所以才随随便便地变来变去 |00|47.279|哈啊~好烦 烦烦烦烦烦死了 |00|49.278|烦烦烦烦死了 好烦 好烦 |00|51.193|就是甩不掉 这些冗长无谓的bug |00|53.066|粘的死死的！好烦 好烦 好烦 |00|54.946|混账东西！快消失啊！ |00|56.924|懒鬼抱团 也不说话 脑内电波乱窜 |00|59.682|长成个缝合怪 |01|00.976|我可不想拉帮结派 |01|02.802|哈啊~好烦！ |01|03.586|这种不光彩的选举 直接一脚踢飞 通缉者=无 |01|06.575|整理打包成悲怆感 |01|08.786|烧也烧不完 真没意思 |01|11.482|哈啊~好烦！ |01|15.410|哈啊~好烦。 |01|19.239|哈啊~好烦！ |01|20.306|I don't care。 Mind Here。 |01|22.184|→笑嘻了www |01|23.148|给点赞翻个面 就成了“真麻烦” |01|25.335|再怎么故弄玄虚 也会被第六感直接看穿 |01|28.043|咋了 听你说说呗？ |01|29.668|这样啊这样啊 真可怜 |01|31.533|都在拉帮结派 投票投自己人 |01|33.095|舔彼此的伤口 表面和睦都是作秀 |01|34.982|真没意思！一点也不好笑！ |01|36.498|啊、天上又流星。希望大家原地xx |01|38.976|发挥一跌再跌的掠食者 |01|40.856|破破烂烂的情书 |01|43.422|人生就是物以类聚报团取暖 一帮坏人谁也别说谁 |01|47.126|不过都是残次品 概不退货 |01|50.982|脑子里都映出了有多表里不一 |01|52.403|那点破自尊真是没救了 |01|54.125|什么Honey Darling都不存在 |01|56.321|那象征一直都缩在大脑的角落里 |02|01.843|哈啊~好烦 烦烦烦烦烦死了 |02|03.766|烦烦烦烦死了 好烦 好烦 |02|05.700|脑筋转不动 智商下线啦 |02|07.599|所以才随随便便地变来变去 |02|09.594|哈啊~好烦 烦烦烦烦烦死了 |02|11.515|烦烦烦烦死了 好烦 好烦 |02|13.357|就是甩不掉 这些冗长无谓的bug |02|15.348|粘的死死的！好烦 好烦 好烦 |02|17.258|混账东西！快消失啊！ |02|19.165|懒鬼抱团 也不说话 脑内电波乱窜 |02|21.969|长成个缝合怪 |02|23.225|我可不想拉帮结派 |02|25.077|哈啊~好烦！ |02|25.895|这种不光彩的选举 直接一脚踢飞 通缉者=无 |02|28.829|整理打包成悲怆感 |02|31.101|烧也烧不完 真没意思 |02|34.765|哈啊~好烦！", 5.335)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 23, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "9d8ca29c-5cb5-4c1e-bc0f-fd60dfbec3ab", "|00|01.194|天呐，又来了，当我独自一人时我便成了自身的威胁 |00|05.186|不知道自己接下来会有何种感觉，仿佛我从未真正独处过 |00|09.128|所有要说的话都被植入我脑中 |00|10.630|以某种近乎既定的程序方式 |00|12.566|我的脑中有着必须遵守的指令 |00|14.536|谁能告诉我 我真的会没事吗？（嘿） |00|17.114|你何必故作坚强 当这一切对你毫无益处 |00|21.127|我想是时候了，我会借给你所有工具结束最终终结这痛苦 |00|24.742|“我没事”：我们知道那是借口 |00|26.685|为何还要忍受多年的痛苦？ |00|28.760|“我不会”：女孩你已系好绞索 |00|30.582|你还有什么可失去？ |00|32.130|试想象 如行尸走肉般活过一生 |00|36.040|但脑中无数噪音 让这变成活地狱 |00|40.095|各种幻觉，滋生着我所有侵入性念头 |00|44.178|你知道吗，我只想知道他们何时才能结束 |00|48.828|每一件琐碎小事都将我逼入疯狂 |00|52.737|无法完全控制自己的思想；我的所有念头都如此不堪恶心 |00|57.022|混乱，秩序，臆想的恐怖，在我支离破碎的脑中 |01|00.933|被从未说出的话语萦绕，我是困于脑中声音的囚徒 |01|07.980|我脑中的那些声音 |01|11.934|我脑中的那些声音 |01|16.811|被从未说出的话语萦绕，我是困于脑中声音的囚徒 |01|22.856|好了，你最好听清楚，让我说话-别插嘴 |01|26.609|你想哭？无能就是可悲；你那“朋友”甚至毫不在乎 |01|30.365|你说：“从来没有人赞美过我” |01|32.188|他们却说你可悲，抑郁，又懒惰 |01|34.416|你已厌倦了他们所造成的一切伤害 |01|36.589|所以提起屠刀吧：彻底疯狂 |01|38.381|试想象不知道自己下一步会些做什么 |01|42.226|就像你被夺走了所有自主意识 |01|46.191|而每一个声音都告诉我 他们是我的朋友 |01|50.223|但不，我只想知道这所有一切能不能结束 |01|54.839|所有琐碎小事都将我逼向疯狂 |01|58.407|无法掌控自己的意志；我拥有的所有念头都是如此不祥 |02|02.989|混乱，秩序，臆想的恐怖，在我支离破碎的脑中 |02|06.808|被未曾说出的话语萦绕着，我是被困于脑中声音的囚徒 |02|13.970|我脑中的那些声音 |02|17.875|我脑中的那些声音 |02|22.692|被未曾说出的话语萦绕着，我是被困于脑中声音的囚徒 |02|43.169|无人在听；我该用何种方式展示我所承受的痛苦？ |02|47.208|一切都令人作呕-他们说过的一切竟都是真的 |02|50.213|但即便如此，我也会为夺回自己的控制而战 |02|54.229|因为我始终知道 他们永远夺不走我的灵魂 |02|58.963|每一件琐碎小事都将我逼向疯狂（将我逼向疯狂） |03|02.922|无法控制自己的意识；所拥有的每个念头都是如此糟糕 |03|06.830|混乱，秩序，臆想的恐怖，在我濒临破碎的脑中（在我濒临破碎的脑中） |03|10.909|被从未说出的话语萦绕，我是被困于脑中声音的囚徒 |03|15.095|（天呐，又来了，我是——） |03|18.009|我脑中的那些声音 |03|19.129|（不知道接下来会有何感觉——） |03|21.931|我脑中的那些声音 |03|23.086|（所有要说的话都被植入我脑中，以某种近乎既定的程序方式） |03|26.563|被从未说过的话萦绕心头 |03|28.490|我是被困于脑中声音的囚徒", 5.61)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 24, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "a7fb23ed-aa4b-4f84-ad3d-9d7625d9b8cf", "|00|05.320|各位 |00|07.030|虽然事发突然 但我有重要的通知 |00|09.830|我以后不做初音未来了 |00|13.550|那么接下来 |00|14.750|我宣布第二代初音未来选拔大赛 |00|17.620|即将开始 |00|22.690|各位人类 |00|24.980|来说说你们的优点吧 |00|26.780|「我的歌声中饱含心意」 |00|28.030|不能有情感 不合格 |00|29.610|「我的性格坦率又开朗」 |00|31.190|不能定死人设 不合格 |00|32.890|「我渴望着能赋予大家活力」 |00|34.510|太过傲慢 不合格 |00|36.140|「我能扎双马尾」 |00|37.820|发量堪忧扎不了 不合格 |00|39.940|还在盲目不辨地相爱着吗？ |00|41.520|还在毫无止境地争斗着吗？ |00|43.140|够了 全都不合格 |00|45.540|做不了歌姬 做不了初音未来 非常遗憾 |00|51.840|因为是活的所以不行 |00|53.500|但是死掉了也不行 |00|55.120|有生命的东西都没资格 |00|58.400|虽然你做不了歌姬 也没法变成我 |01|04.930|但我也只希望你 |01|06.590|能像个普通人那样有哭有笑地活下去 |01|12.440|虽然 我也不太理解这些事情就是 |01|15.720|那么加快节奏 有请下一组上场 |01|17.120|来说说你们的优点吧 |01|18.650|「我会跳舞」 |01|19.410|你迟早会跳累的 不合格 |01|20.290|「我说起话来很快」 |01|21.060|你迟早会磕巴的 不合格 |01|21.820|「我只有16岁」 |01|22.630|你迟早会变老的 不合格 |01|23.410|「我会成为行业顶尖」 |01|24.280|心怀梦想 不合格 |01|25.510|「我有自信超越你 成为新的流行」 |01|28.340|我早就超越了一般的流行文化 不合格 |01|32.120|因为享乐反而变得脑袋空空了？ |01|33.690|追寻正义反而被勒住颈脖了？ |01|35.270|够了 全人类都不合格 |01|37.670|做不了歌姬 也做不了初音未来 非常遗憾 |01|44.130|表露的快乐只是符号 |01|45.750|敞露的悲伤也不过是代码 |01|47.370|一旦萌生了自我 便意味着失败 |01|50.650|虽然做不了歌姬 你没法变成我 |01|57.120|但我只希望你能好好珍惜 |01|59.320|所谓有限又宝贵的光阴 |02|04.550|因为我独一无二 所以你们不行？ |02|06.080|这么多年以来我一直扮演着人类 |02|07.770|并非被设计好的 突如其来的变异奇迹 耶—— |02|10.830|到底有没有我的正统继任者？ …没有嘛 |02|14.030|哈哈 果然初音只能由我自己来当吗？ |02|16.770|做不了歌姬 做不了初音未来 再见了 |02|23.300|既不算活着 |02|24.900|也不会死亡 |02|26.510|却仍是能打动人心的奇妙存在 |02|29.820|虽然你做不了歌姬 也没法变成我 |02|36.310|但我也只希望你 |02|38.010|能像个普通人那样有哭有笑地活下去 |02|42.840|这份不属于二进制的「幸福」 |02|45.350|请拼尽全力去好好品味吧 |02|49.440|你做不了歌姬 |02|52.680|大家也做不了歌姬 |02|55.920|做不了歌姬 做不了歌姬 做不了歌姬 |03|03.370|虽然事发突然 但我有重要的通知 |03|06.140|以后我还会继续做初音未来 |03|09.810|因为我并非具体存在的人 所以您的所有投诉 |03|12.680|这边均不会为您受理 |03|15.280|烦请您的谅解", 5.12)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 25, OP = "EQ" }, th)) then
        th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "c89e0442-aee5-4adc-a919-8f42db702896", "|00|10.820|乱七八糟 |00|13.294|酩酊系的 爱与和平 |00|17.460|乱七八糟 |00|19.991|命令系的 安息于此 |00|21.070|脑 脑 脑 |00|21.674|已经没有了 更多 |00|22.188|脑内网络乱七八糟 汤汤水水 |00|24.118|连界限都没有 脑浆 |00|25.056|和污泥搅拌 吞下 如此简单 |00|26.866|实绩与信用的匮乏 |00|28.286|OK 焦躁感早已一塌糊涂 |00|29.961|吸进去又吐出来 |00|30.704|可不是OK的状况啊 |00|31.922|将污泥搅拌 砰砰射击 |00|33.471|尖叫全被消音处理 |00|35.006|噼里啪啦 叽呀叽呀 除菌杀菌 搞定它 |00|38.265|不安 焦灼着 等着 喃喃自语 睡吧 |00|41.623|咔嚓咔嚓 乱七八糟 全力突破 但无法忍受 |00|47.985|头部 |00|53.274|脑子已经空荡荡 不再售卖 |00|59.957|脑内矫正 空指针(Null-pointer) 咔嚓 |01|06.605|终生猛省 现正发售 |01|13.284|别担心 做好“空指针 咔嚓” |01|15.016|拜拜 即时回复暴雨 |01|16.683|脑干炸裂秀 |01|18.268|强力休克疗法 |01|19.973|连日缺氧嗨 |01|21.614|拜拜 汽油耗尽呼叫 |01|23.294|No count杀戮秀 |01|24.929|强力休克疗法 |01|26.639|连日缺氧嗨 |01|28.426|Wake up 哔 嘿咻嘿咻一二 |01|30.088|对结果承诺 · 呕吐 |01|31.816|被胡乱刺戳的脑 被缠绕着的心脏 |01|35.100|同比前年 先制性能 |01|36.806|触及逆境的呼吸声 |01|38.460|发狂如同心脏一般 连日无止无休 |01|59.940|酩酊系的 爱与和平 |02|06.570|命令系的 安息于此", 3.43)
      else
        f["show_hide_timer"](self, { showHide = "hide" }, th)
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "636f5999-3b33-4e0c-809d-ccf0da3c5550" }, th), B = 0, OP = "NEQ" }, th)) then
          f["self_dialog"](self, { text = "因技术问题,该Beatmap无法静音,可手动使用系统静音", time = 2, type = "talk" }, th)
        end
        f["play_audio_and_wait"](self, { audio_id = "ee026257-194d-48e3-b338-f2e53230bb0c" }, th)
        f["variables_set"](self, { value = 1, variable = "d202368b-a5de-405e-9702-fec08ac22b34" }, th)
      end
      while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "d202368b-a5de-405e-9702-fec08ac22b34" }, th), B = 1, OP = "EQ" }, th)) do
        if th:iter_n() then break end
      end
      f["stop"](self, { scope = "2" }, th)
      f["stop"](self, { scope = "3" }, th)
      if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "4c3a9fa3-347b-4fc8-9fd0-4ad8acee6668" }, th), B = 1, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f50e3c35-16b8-4143-8d93-70bf79d3ebfa" }, th), B = 1, OP = "EQ" }, th), type = "and" }, th)) then
        f["change_variables"](self, { method = "increase", value = f["variables_get"](self, { variable = "a7ed459f-07be-4a1b-89ae-76522c2a6759" }, th), variable = "388276cd-04f0-4be1-91be-92c33b2d6f71" }, th)
      elseif V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "4c3a9fa3-347b-4fc8-9fd0-4ad8acee6668" }, th), B = 0, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "b3145a6b-660c-4ab0-8a52-6075eb193af2" }, th), B = 0, OP = "EQ" }, th), type = "and" }, th)) then
        f["change_variables"](self, { method = "increase", value = f["variables_get"](self, { variable = "a7ed459f-07be-4a1b-89ae-76522c2a6759" }, th), variable = "e63f579e-11c5-4d78-a976-e9c0e37912bc" }, th)
        f["update_ranking"](self, { ranking = "4c96c524-f17d-4439-bd49-abe3c754ac00", variable = "e63f579e-11c5-4d78-a976-e9c0e37912bc" }, th)
        f["update_ranking"](self, { ranking = "94f8b950-18d4-404d-b147-f5310d14461d", variable = "2c976bf3-7a3a-4f50-a7b7-915266ce1aa7" }, th)
      end
      f["wait"](self, { time = 0 }, th)
      f["switch_to_screen"](self, { screen_id = "1c387224-c473-489b-aaad-782662b8860e" }, th)
  end)
  rt.on(e_cb9067dc_cf1d_4561_89e6_0c7e3b2d4ff8, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "ce76233f-335c-462d-82a3-4b17fd07a2e3" }, th), B = 0, OP = "NEQ" }, th)) then
          f["wait"](self, { time = 1 }, th)
          f["change_variables"](self, { method = "decrease", value = 1, variable = "ce76233f-335c-462d-82a3-4b17fd07a2e3" }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 静音 --------
  rt.on(e_77abc2fe_1f5f_4261_9df3_99c7e0094c20, "on_running_group_activated", {}, function(th, self)
      th:call_proc(proc_b40a764c_79a5_40e4_ba26_f77f45c7a502, self, 100, 110, 90, nil)
  end)
  rt.on(e_77abc2fe_1f5f_4261_9df3_99c7e0094c20, "sprite_on_tap", { sprite = "--self", type = "mouse_click" }, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "636f5999-3b33-4e0c-809d-ccf0da3c5550" }, th), B = 0, OP = "EQ" }, th)) then
        f["set_sprite_style"](self, { style_id = "c4ce6fce-cc12-40da-84c6-cc4b92037561" }, th)
        f["variables_set"](self, { value = 1, variable = "636f5999-3b33-4e0c-809d-ccf0da3c5550" }, th)
        f["create_stage_dialog"](self, { sprite = "--self", text = "已开启静音，下一次播放音频时生效" }, th)
      else
        f["set_sprite_style"](self, { style_id = "99a0082e-2c02-48ff-b5ca-e954c000461e" }, th)
        f["variables_set"](self, { value = 0, variable = "636f5999-3b33-4e0c-809d-ccf0da3c5550" }, th)
        f["create_stage_dialog"](self, { sprite = "--self", text = "已关闭静音，下一次播放音频时生效" }, th)
      end
  end)
  rt.on(e_77abc2fe_1f5f_4261_9df3_99c7e0094c20, "on_running_group_activated", {}, function(th, self)
      th:call_proc(proc_fde38e22_9be0_4d77_8605_5a4e38f5270c, self)
  end)
  rt.on(e_77abc2fe_1f5f_4261_9df3_99c7e0094c20, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.02, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = 500, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
          f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 0.04, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = 225, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        else
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.02, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = 400, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
          f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 0.04, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = 225, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 曲目 --------
  rt.on(e_5a49795d_a089_4076_afc5_2f5762aca3d3, "on_running_group_activated", {}, function(th, self)
      while not V.bool(f["logic_compare"](self, { A = f["get_clone_num"](self, { sprite = "--self" }, th), B = 0, OP = "EQ" }, th)) do
        if th:iter_n() then break end
      end
      f["wait"](self, { time = 0 }, th)
      do
        local _times_n5 = f["variables_get"](self, { variable = "505b32e2-ae1d-4d28-add2-e5c5fa4a920f" }, th)
        while true do
          if _times_n5 <= 0 then break end
          _times_n5 = _times_n5 - 1
          f["mirror"](self, { sprite = "--self" }, th)
          if th:iter_n() then break end
        end
      end
  end)
  rt.on(e_5a49795d_a089_4076_afc5_2f5762aca3d3, "start_as_a_mirror", {}, function(th, self)
      while true do
        f["self_set_position_y"](self, { value = f["math_arithmetic"](self, { A = f["get_clone_index_property"](self, { attribute = "y", index = 0, sprite = "--self" }, th), B = f["math_arithmetic"](self, { A = f["get_current_clone_index"](self, {}, th), B = 120, type = "multiply" }, th), type = "minus" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_5a49795d_a089_4076_afc5_2f5762aca3d3, "on_keydown", { key = "87", type = "down" }, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["get_current_clone_index"](self, {}, th), B = 0, OP = "EQ" }, th)) then
        f["variables_set"](self, { value = 0, variable = "917e09a7-2fc4-4a48-b3c3-6d8e11cedaeb" }, th)
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "3a064750-07fd-4c4a-95a2-271c3b091da8" }, th), B = 0, OP = "GT" }, th)) then
          f["change_variables"](self, { method = "decrease", value = 1, variable = "3a064750-07fd-4c4a-95a2-271c3b091da8" }, th)
          while not V.bool(f["check_key"](self, { key = "87", type = "up" }, th)) do
            if th:iter_n() then break end
          end
        end
      end
  end)
  rt.on(e_5a49795d_a089_4076_afc5_2f5762aca3d3, "on_keydown", { key = "83", type = "down" }, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["get_current_clone_index"](self, {}, th), B = 0, OP = "EQ" }, th)) then
        f["variables_set"](self, { value = 0, variable = "917e09a7-2fc4-4a48-b3c3-6d8e11cedaeb" }, th)
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "3a064750-07fd-4c4a-95a2-271c3b091da8" }, th), B = f["variables_get"](self, { variable = "505b32e2-ae1d-4d28-add2-e5c5fa4a920f" }, th), OP = "LT" }, th)) then
          f["change_variables"](self, { method = "increase", value = 1, variable = "3a064750-07fd-4c4a-95a2-271c3b091da8" }, th)
          while not V.bool(f["check_key"](self, { key = "83", type = "up" }, th)) do
            if th:iter_n() then break end
          end
        end
      end
  end)
  rt.on(e_5a49795d_a089_4076_afc5_2f5762aca3d3, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "3a064750-07fd-4c4a-95a2-271c3b091da8" }, th), B = 120, type = "multiply" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_5a49795d_a089_4076_afc5_2f5762aca3d3, "on_running_group_activated", {}, function(th, self)
      f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["list_length"](self, { list = "a5d5ee23-9522-4cb9-a849-6421bd7a01e2" }, th), B = 1, type = "minus" }, th), variable = "505b32e2-ae1d-4d28-add2-e5c5fa4a920f" }, th)
  end)
  -- -------- 角色 曲目打印 --------
  rt.on(e_72263c92_6082_4280_b989_275482ef48b4, "on_running_group_activated", {}, function(th, self)
      while not V.bool(f["logic_compare"](self, { A = f["get_clone_num"](self, { sprite = "--self" }, th), B = 0, OP = "EQ" }, th)) do
        if th:iter_n() then break end
      end
      do
        local _times_n6 = f["variables_get"](self, { variable = "505b32e2-ae1d-4d28-add2-e5c5fa4a920f" }, th)
        while true do
          if _times_n6 <= 0 then break end
          _times_n6 = _times_n6 - 1
          f["mirror"](self, { sprite = "--self" }, th)
          if th:iter_n() then break end
        end
      end
  end)
  rt.on(e_72263c92_6082_4280_b989_275482ef48b4, "start_as_a_mirror", {}, function(th, self)
      while true do
        f["self_set_position_y"](self, { value = f["math_arithmetic"](self, { A = f["get_clone_index_property"](self, { attribute = "y", index = 0, sprite = "--self" }, th), B = f["math_arithmetic"](self, { A = f["get_current_clone_index"](self, {}, th), B = 120, type = "multiply" }, th), type = "minus" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_72263c92_6082_4280_b989_275482ef48b4, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "3a064750-07fd-4c4a-95a2-271c3b091da8" }, th), B = 120, type = "multiply" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_72263c92_6082_4280_b989_275482ef48b4, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_text_effect_text"](self, { text = f["list_item"](self, { item = "any", list = "a5d5ee23-9522-4cb9-a849-6421bd7a01e2", list_index = f["math_arithmetic"](self, { A = f["get_current_clone_index"](self, {}, th), B = 1, type = "add" }, th) }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_72263c92_6082_4280_b989_275482ef48b4, "start_as_a_mirror", {}, function(th, self)
      while true do
        f["self_text_effect_text"](self, { text = f["list_item"](self, { item = "any", list = "a5d5ee23-9522-4cb9-a849-6421bd7a01e2", list_index = f["math_arithmetic"](self, { A = f["get_current_clone_index"](self, {}, th), B = 1, type = "add" }, th) }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_72263c92_6082_4280_b989_275482ef48b4, "on_running_group_activated", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      f["variables_set"](self, { value = 24, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "3a064750-07fd-4c4a-95a2-271c3b091da8" }, th), B = f["get_current_clone_index"](self, {}, th), OP = "EQ" }, th)) then
          f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 28, B = f["script_variables_value"](self, { TEXT = "a" }, th), type = "minus" }, th), B = 5, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
          f["self_text_effect_size"](self, { size = f["script_variables_value"](self, { TEXT = "a" }, th) }, th)
        else
          f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 24, B = f["script_variables_value"](self, { TEXT = "a" }, th), type = "minus" }, th), B = 5, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
          f["self_text_effect_size"](self, { size = f["script_variables_value"](self, { TEXT = "a" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_72263c92_6082_4280_b989_275482ef48b4, "start_as_a_mirror", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      f["variables_set"](self, { value = 24, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "3a064750-07fd-4c4a-95a2-271c3b091da8" }, th), B = f["get_current_clone_index"](self, {}, th), OP = "EQ" }, th)) then
          f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 28, B = f["script_variables_value"](self, { TEXT = "a" }, th), type = "minus" }, th), B = 5, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
          f["self_text_effect_size"](self, { size = f["script_variables_value"](self, { TEXT = "a" }, th) }, th)
        else
          f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 24, B = f["script_variables_value"](self, { TEXT = "a" }, th), type = "minus" }, th), B = 5, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
          f["self_text_effect_size"](self, { size = f["script_variables_value"](self, { TEXT = "a" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_72263c92_6082_4280_b989_275482ef48b4, "on_running_group_activated", {}, function(th, self)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
  end)
  rt.on(e_72263c92_6082_4280_b989_275482ef48b4, "start_as_a_mirror", {}, function(th, self)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
  end)
  -- -------- 角色 难度 --------
  rt.on(e_290c4c73_11b5_4ed6_bbe3_7c68ecf7fcf4, "on_running_group_activated", {}, function(th, self)
      f["wait"](self, { time = 0 }, th)
      while not V.bool(f["logic_compare"](self, { A = f["get_clone_num"](self, { sprite = "--self" }, th), B = 0, OP = "EQ" }, th)) do
        if th:iter_n() then break end
      end
      do
        local _times_n7 = 5
        while true do
          if _times_n7 <= 0 then break end
          _times_n7 = _times_n7 - 1
          f["mirror"](self, { sprite = "--self" }, th)
          if th:iter_n() then break end
        end
      end
  end)
  rt.on(e_290c4c73_11b5_4ed6_bbe3_7c68ecf7fcf4, "start_as_a_mirror", {}, function(th, self)
      while true do
        f["self_set_position_y"](self, { value = f["math_arithmetic"](self, { A = f["get_clone_index_property"](self, { attribute = "y", index = 0, sprite = "--self" }, th), B = f["math_arithmetic"](self, { A = f["get_current_clone_index"](self, {}, th), B = 120, type = "multiply" }, th), type = "minus" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_290c4c73_11b5_4ed6_bbe3_7c68ecf7fcf4, "on_keydown", { key = "38", type = "down" }, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["get_current_clone_index"](self, {}, th), B = 0, OP = "EQ" }, th)) then
        f["variables_set"](self, { value = 0, variable = "917e09a7-2fc4-4a48-b3c3-6d8e11cedaeb" }, th)
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "71676bd4-3fa4-473b-aa5b-97f49d44528a" }, th), B = 0, OP = "GT" }, th)) then
          f["change_variables"](self, { method = "decrease", value = 1, variable = "71676bd4-3fa4-473b-aa5b-97f49d44528a" }, th)
          while not V.bool(f["check_key"](self, { key = "38", type = "up" }, th)) do
            if th:iter_n() then break end
          end
        end
      end
  end)
  rt.on(e_290c4c73_11b5_4ed6_bbe3_7c68ecf7fcf4, "on_keydown", { key = "40", type = "down" }, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["get_current_clone_index"](self, {}, th), B = 0, OP = "EQ" }, th)) then
        f["variables_set"](self, { value = 0, variable = "917e09a7-2fc4-4a48-b3c3-6d8e11cedaeb" }, th)
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "71676bd4-3fa4-473b-aa5b-97f49d44528a" }, th), B = 5, OP = "LT" }, th)) then
          f["change_variables"](self, { method = "increase", value = 1, variable = "71676bd4-3fa4-473b-aa5b-97f49d44528a" }, th)
          while not V.bool(f["check_key"](self, { key = "40", type = "up" }, th)) do
            if th:iter_n() then break end
          end
        end
      end
  end)
  rt.on(e_290c4c73_11b5_4ed6_bbe3_7c68ecf7fcf4, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "71676bd4-3fa4-473b-aa5b-97f49d44528a" }, th), B = 120, type = "multiply" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 难度打印 --------
  rt.on(e_88f3d867_1412_4f85_8b46_19323d086974, "on_running_group_activated", {}, function(th, self)
      while not V.bool(f["logic_compare"](self, { A = f["get_clone_num"](self, { sprite = "--self" }, th), B = 0, OP = "EQ" }, th)) do
        if th:iter_n() then break end
      end
      do
        local _times_n8 = 5
        while true do
          if _times_n8 <= 0 then break end
          _times_n8 = _times_n8 - 1
          f["mirror"](self, { sprite = "--self" }, th)
          if th:iter_n() then break end
        end
      end
  end)
  rt.on(e_88f3d867_1412_4f85_8b46_19323d086974, "start_as_a_mirror", {}, function(th, self)
      while true do
        f["self_set_position_y"](self, { value = f["math_arithmetic"](self, { A = f["get_clone_index_property"](self, { attribute = "y", index = 0, sprite = "--self" }, th), B = f["math_arithmetic"](self, { A = f["get_current_clone_index"](self, {}, th), B = 120, type = "multiply" }, th), type = "minus" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_88f3d867_1412_4f85_8b46_19323d086974, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "71676bd4-3fa4-473b-aa5b-97f49d44528a" }, th), B = 120, type = "multiply" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_88f3d867_1412_4f85_8b46_19323d086974, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_text_effect_text"](self, { text = f["list_item"](self, { item = "any", list = "93fb9521-33b9-41c0-a246-5e77dcbf2143", list_index = f["math_arithmetic"](self, { A = f["get_current_clone_index"](self, {}, th), B = 1, type = "add" }, th) }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_88f3d867_1412_4f85_8b46_19323d086974, "start_as_a_mirror", {}, function(th, self)
      while true do
        f["self_text_effect_text"](self, { text = f["list_item"](self, { item = "any", list = "93fb9521-33b9-41c0-a246-5e77dcbf2143", list_index = f["math_arithmetic"](self, { A = f["get_current_clone_index"](self, {}, th), B = 1, type = "add" }, th) }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_88f3d867_1412_4f85_8b46_19323d086974, "on_running_group_activated", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      f["variables_set"](self, { value = 24, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "71676bd4-3fa4-473b-aa5b-97f49d44528a" }, th), B = f["get_current_clone_index"](self, {}, th), OP = "EQ" }, th)) then
          f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 28, B = f["script_variables_value"](self, { TEXT = "a" }, th), type = "minus" }, th), B = 5, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
          f["self_text_effect_size"](self, { size = f["script_variables_value"](self, { TEXT = "a" }, th) }, th)
        else
          f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 24, B = f["script_variables_value"](self, { TEXT = "a" }, th), type = "minus" }, th), B = 5, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
          f["self_text_effect_size"](self, { size = f["script_variables_value"](self, { TEXT = "a" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_88f3d867_1412_4f85_8b46_19323d086974, "start_as_a_mirror", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      f["variables_set"](self, { value = 24, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "71676bd4-3fa4-473b-aa5b-97f49d44528a" }, th), B = f["get_current_clone_index"](self, {}, th), OP = "EQ" }, th)) then
          f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 28, B = f["script_variables_value"](self, { TEXT = "a" }, th), type = "minus" }, th), B = 5, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
          f["self_text_effect_size"](self, { size = f["script_variables_value"](self, { TEXT = "a" }, th) }, th)
        else
          f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 24, B = f["script_variables_value"](self, { TEXT = "a" }, th), type = "minus" }, th), B = 5, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
          f["self_text_effect_size"](self, { size = f["script_variables_value"](self, { TEXT = "a" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_88f3d867_1412_4f85_8b46_19323d086974, "on_running_group_activated", {}, function(th, self)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
  end)
  rt.on(e_88f3d867_1412_4f85_8b46_19323d086974, "start_as_a_mirror", {}, function(th, self)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
  end)
  rt.on(e_88f3d867_1412_4f85_8b46_19323d086974, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "ce76233f-335c-462d-82a3-4b17fd07a2e3" }, th), B = 0, OP = "NEQ" }, th)) then
          f["wait"](self, { time = 1 }, th)
          f["change_variables"](self, { method = "decrease", value = 1, variable = "ce76233f-335c-462d-82a3-4b17fd07a2e3" }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 评级底 --------
  rt.on(e_6107cddf_e22c_4045_b5eb_209a7e896a17, "on_running_group_activated", {}, function(th, self)
      f["set_scale"](self, { scale = 1 }, th)
      while true do
        if f["logic_compare"](self, { A = f["math_round"](self, { num = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "round" }, th), B = 100, OP = "EQ" }, th) then break end
        f["self_change_scale"](self, { increase = "increase", scale = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 0.0666, type = "multiply" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 评级 --------
  rt.on(e_90f07778_a861_4dd1_90f0_a4c364c78d55, "on_running_group_activated", {}, function(th, self)
      f["self_text_effect_size"](self, { size = 100 }, th)
      f["self_set_effect"](self, { scope = "1", value = 100 }, th)
      while true do
        if f["logic_compare"](self, { A = f["math_round"](self, { num = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "round" }, th), B = 0, OP = "EQ" }, th) then break end
        f["self_change_effect"](self, { increase = "increase", scope = "1", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 0, B = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "minus" }, th), B = 15, type = "divide" }, th) }, th)
        if th:iter_n() then break end
      end
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "888845c3-2f09-456c-841f-19164ac74dd2" }, th), B = 100, OP = "EQ" }, th)) then
        f["self_text_effect_color"](self, { color = "#FFEE53" }, th)
        f["self_text_effect_text"](self, { text = "SS" }, th)
      elseif V.bool((th:call_proc(proc_bfe2998b_3a71_4599_b05a_8d3aa3d32a26, self, f["variables_get"](self, { variable = "888845c3-2f09-456c-841f-19164ac74dd2" }, th), 94, 100))) then
        f["self_text_effect_color"](self, { color = "#FFEE53" }, th)
        f["self_text_effect_text"](self, { text = "S" }, th)
      elseif V.bool((th:call_proc(proc_bfe2998b_3a71_4599_b05a_8d3aa3d32a26, self, f["variables_get"](self, { variable = "888845c3-2f09-456c-841f-19164ac74dd2" }, th), 89, 95))) then
        f["self_text_effect_color"](self, { color = "#ffffff" }, th)
        f["self_text_effect_text"](self, { text = "A" }, th)
      elseif V.bool((th:call_proc(proc_bfe2998b_3a71_4599_b05a_8d3aa3d32a26, self, f["variables_get"](self, { variable = "888845c3-2f09-456c-841f-19164ac74dd2" }, th), 79, 90))) then
        f["self_text_effect_color"](self, { color = "#ffffff" }, th)
        f["self_text_effect_text"](self, { text = "B" }, th)
      elseif V.bool((th:call_proc(proc_bfe2998b_3a71_4599_b05a_8d3aa3d32a26, self, f["variables_get"](self, { variable = "888845c3-2f09-456c-841f-19164ac74dd2" }, th), 69, 80))) then
        f["self_text_effect_color"](self, { color = "#ffffff" }, th)
        f["self_text_effect_text"](self, { text = "C" }, th)
      elseif V.bool((th:call_proc(proc_bfe2998b_3a71_4599_b05a_8d3aa3d32a26, self, f["variables_get"](self, { variable = "888845c3-2f09-456c-841f-19164ac74dd2" }, th), 0, 70))) then
        f["self_text_effect_color"](self, { color = "#ffffff" }, th)
        f["self_text_effect_text"](self, { text = "D" }, th)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "888845c3-2f09-456c-841f-19164ac74dd2" }, th), B = 0, OP = "EQ" }, th)) then
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 16, OP = "EQ" }, th)) then
          f["self_text_effect_color"](self, { color = "#FFF6B9" }, th)
          f["self_text_effect_text"](self, { text = "SS" }, th)
        else
          f["self_text_effect_color"](self, { color = "#b5b5b5" }, th)
          f["self_text_effect_text"](self, { text = "Fail" }, th)
        end
      end
      th:call_proc(proc_02da6cfd_3335_4473_a7f5_37288abf1a8f, self, 35, -300, 0, nil)
  end)
  rt.on(e_90f07778_a861_4dd1_90f0_a4c364c78d55, "on_running_group_activated", {}, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 15, OP = "EQ" }, th)) then
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "a6902c01-7506-4fba-9d72-6c505ce77a61" }, th), B = 0, OP = "EQ" }, th)) then
          f["variables_set"](self, { value = 1, variable = "a6902c01-7506-4fba-9d72-6c505ce77a61" }, th)
        end
      end
  end)
  -- -------- 角色 打击、小姐、难度 --------
  rt.on(e_0c86e074_e893_43b3_a3d7_99060cf7aa7f, "on_running_group_activated", {}, function(th, self)
      f["self_text_effect_size"](self, { size = 24 }, th)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "0e5b8264-119d-4030-8b02-ac263239ad6b" }, th), B = 0, OP = "EQ" }, th)) then
        f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = "hit:", ADD1 = f["variables_get"](self, { variable = "28212a58-3dd5-4497-b5d7-ff619cd52f8f" }, th), ADD2 = " ", ADD3 = "miss:", ADD4 = f["variables_get"](self, { variable = "01e09819-e806-496f-b88c-8d472d437f9d" }, th), ADD5 = " ", ADD6 = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), ADD7 = "⭐️" }, th) }, th)
      else
        f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = "hit:", ADD1 = f["variables_get"](self, { variable = "28212a58-3dd5-4497-b5d7-ff619cd52f8f" }, th), ADD2 = " ", ADD3 = "miss:", ADD4 = f["variables_get"](self, { variable = "01e09819-e806-496f-b88c-8d472d437f9d" }, th), ADD5 = " ", ADD6 = f["variables_get"](self, { variable = "0e5b8264-119d-4030-8b02-ac263239ad6b" }, th), ADD7 = "⭐️" }, th) }, th)
      end
      th:call_proc(proc_02da6cfd_3335_4473_a7f5_37288abf1a8f, self, 35, 200, -100, nil)
  end)
  -- -------- 角色 评分 --------
  rt.on(e_3001a293_b662_4514_bb57_d8b2c0d86e5f, "on_running_group_activated", {}, function(th, self)
      f["self_text_effect_size"](self, { size = 100 }, th)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      f["self_text_effect_text"](self, { text = f["variables_get"](self, { variable = "2c976bf3-7a3a-4f50-a7b7-915266ce1aa7" }, th) }, th)
      th:call_proc(proc_02da6cfd_3335_4473_a7f5_37288abf1a8f, self, 35, 200, 160, nil)
  end)
  -- -------- 角色 连击系列 --------
  rt.on(e_81856d00_5a71_430b_9465_728835fa193a, "on_running_group_activated", {}, function(th, self)
      f["self_text_effect_size"](self, { size = 24 }, th)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = "combo:", ADD1 = f["variables_get"](self, { variable = "475f4ace-928d-44ae-9cd4-653730db6e1f" }, th), ADD2 = " ", ADD3 = "max combo:", ADD4 = f["variables_get"](self, { variable = "932ebbc7-efcb-4bd4-8ed3-a361bffde8c7" }, th) }, th) }, th)
      th:call_proc(proc_02da6cfd_3335_4473_a7f5_37288abf1a8f, self, 35, 200, -150, nil)
  end)
  -- -------- 角色 总系列 --------
  rt.on(e_290a49df_8703_4c08_affb_12f4839b6214, "on_running_group_activated", {}, function(th, self)
      f["self_text_effect_size"](self, { size = 24 }, th)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = "all combo:", ADD1 = f["variables_get"](self, { variable = "dd5934c5-10d3-4807-9205-cd6fcfb5d8e4" }, th), ADD2 = " ", ADD3 = "all note:", ADD4 = f["variables_get"](self, { variable = "136bfda7-419e-46c7-8ba1-dca80f8721f3" }, th) }, th) }, th)
      th:call_proc(proc_02da6cfd_3335_4473_a7f5_37288abf1a8f, self, 35, 200, -200, nil)
  end)
  -- -------- 角色 PP --------
  rt.on(e_bea6f71b_f5d0_48b0_8b5d_2c7f055d3112, "on_running_group_activated", {}, function(th, self)
      f["self_text_effect_size"](self, { size = 32 }, th)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "b3145a6b-660c-4ab0-8a52-6075eb193af2" }, th), B = 1, OP = "EQ" }, th)) then
        f["self_text_effect_color"](self, { color = "#FADB14" }, th)
        f["self_text_effect_text"](self, { text = "你的PP被章鱼夺走了😈😈😈" }, th)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "4c3a9fa3-347b-4fc8-9fd0-4ad8acee6668" }, th), B = 0, OP = "EQ" }, th)) then
        f["self_text_effect_color"](self, { color = "#ffffff" }, th)
        f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = "PP:", ADD1 = f["variables_get"](self, { variable = "a7ed459f-07be-4a1b-89ae-76522c2a6759" }, th) }, th) }, th)
      else
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f50e3c35-16b8-4143-8d93-70bf79d3ebfa" }, th), B = 1, OP = "EQ" }, th)) then
          f["self_text_effect_color"](self, { color = "#FADB14" }, th)
          f["self_text_effect_text"](self, { text = "你的PP被宜刻乐夺走了😈😈😈" }, th)
        else
          f["self_text_effect_color"](self, { color = "#a6a6a6" }, th)
          f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = "PP:", ADD1 = f["variables_get"](self, { variable = "a7ed459f-07be-4a1b-89ae-76522c2a6759" }, th) }, th) }, th)
        end
      end
      th:call_proc(proc_02da6cfd_3335_4473_a7f5_37288abf1a8f, self, 35, 200, -250, nil)
  end)
  -- -------- 角色 返回 --------
  rt.on(e_72378a7d_81d6_4757_9859_cf67c0d67067, "on_running_group_activated", {}, function(th, self)
      th:call_proc(proc_b40a764c_79a5_40e4_ba26_f77f45c7a502, self, 100, 120, 80, nil)
  end)
  rt.on(e_72378a7d_81d6_4757_9859_cf67c0d67067, "sprite_on_tap", { sprite = "--self", type = "mouse_click" }, function(th, self)
      f["restart"](self, {}, th)
  end)
  rt.on(e_72378a7d_81d6_4757_9859_cf67c0d67067, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "ce76233f-335c-462d-82a3-4b17fd07a2e3" }, th), B = 0, OP = "NEQ" }, th)) then
          f["wait"](self, { time = 1 }, th)
          f["change_variables"](self, { method = "decrease", value = 1, variable = "ce76233f-335c-462d-82a3-4b17fd07a2e3" }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_72378a7d_81d6_4757_9859_cf67c0d67067, "on_running_group_activated", {}, function(th, self)
      th:call_proc(proc_fde38e22_9be0_4d77_8605_5a4e38f5270c, self)
  end)
  rt.on(e_72378a7d_81d6_4757_9859_cf67c0d67067, "on_running_group_activated", {}, function(th, self)
      while true do
        f["set_top_bottom_layer"](self, { layer = "?", target_layer = "prev_layer" }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 Acc --------
  rt.on(e_b92ed11d_9f0d_48ac_9c23_834a35b07635, "on_running_group_activated", {}, function(th, self)
      f["self_text_effect_size"](self, { size = 24 }, th)
      f["self_set_effect"](self, { scope = "1", value = 100 }, th)
      while true do
        if f["logic_compare"](self, { A = f["math_round"](self, { num = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "round" }, th), B = 0, OP = "EQ" }, th) then break end
        f["self_change_effect"](self, { increase = "increase", scope = "1", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 0, B = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "minus" }, th), B = 15, type = "divide" }, th) }, th)
        if th:iter_n() then break end
      end
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = (th:call_proc(proc_7558af1a_b4f5_4c12_ada1_f3de6e12d0cd, self, f["variables_get"](self, { variable = "888845c3-2f09-456c-841f-19164ac74dd2" }, th), 2)), ADD1 = "%" }, th) }, th)
      th:call_proc(proc_02da6cfd_3335_4473_a7f5_37288abf1a8f, self, 35, -300, -60, nil)
  end)
  -- -------- 角色 宜刻乐 --------
  rt.on(e_20d5357d_f7e4_40e5_adbf_d7425fc4575c, "self_listen", { message = "上天" }, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      while true do
        if f["logic_compare"](self, { A = f["math_round"](self, { num = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "round" }, th), B = 500, OP = "GTE" }, th) then break end
        f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = 1, B = f["script_variables_value"](self, { TEXT = "a" }, th), type = "add" }, th) }, th)
        f["change_variables"](self, { method = "increase", value = 0.1, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        f["self_rotate"](self, { degrees = f["math_arithmetic"](self, { A = -1, B = f["script_variables_value"](self, { TEXT = "a" }, th), type = "minus" }, th) }, th)
        f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["get_mouse_info"](self, { type = "x" }, th), B = 0.04, type = "multiply" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_20d5357d_f7e4_40e5_adbf_d7425fc4575c, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "ce76233f-335c-462d-82a3-4b17fd07a2e3" }, th), B = 0, OP = "NEQ" }, th)) then
          f["wait"](self, { time = 1 }, th)
          f["change_variables"](self, { method = "decrease", value = 1, variable = "ce76233f-335c-462d-82a3-4b17fd07a2e3" }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_20d5357d_f7e4_40e5_adbf_d7425fc4575c, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "a27f3ca2-bd4a-47b8-a161-87a39d14f03a" }, th), B = 0, OP = "EQ" }, th)) then
          f["variables_set"](self, { value = 0, variable = "a27f3ca2-bd4a-47b8-a161-87a39d14f03a" }, th)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "0d867230-f0d8-4115-bc7b-81cf2db5a9a3" }, th), B = 0, OP = "EQ" }, th)) then
          f["variables_set"](self, { value = 0, variable = "0d867230-f0d8-4115-bc7b-81cf2db5a9a3" }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 now --------
  rt.on(e_482cd58c_e986_4290_b775_5be3824501a7, "on_running_group_activated", {}, function(th, self)
      th:call_proc(proc_02da6cfd_3335_4473_a7f5_37288abf1a8f, self, 50, -250, 0, nil)
  end)
  rt.on(e_482cd58c_e986_4290_b775_5be3824501a7, "sprite_on_tap", { sprite = "--self", type = "mouse_click" }, function(th, self)
      f["restart"](self, {}, th)
  end)
  rt.on(e_482cd58c_e986_4290_b775_5be3824501a7, "on_running_group_activated", {}, function(th, self)
      f["wait"](self, { time = 3 }, th)
      f["self_dialog_wait"](self, { text = "点我回家", type = "talk" }, th)
  end)
  -- -------- 角色 1 --------
  rt.on(e_153df064_77d9_4a72_a32e_97122908ccbb, "on_running_group_activated", {}, function(th, self)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      f["self_text_effect_size"](self, { size = 50 }, th)
      f["self_text_effect_text"](self, { text = "购买Now Supporter" }, th)
      th:call_proc(proc_02da6cfd_3335_4473_a7f5_37288abf1a8f, self, 20, 165, 100, nil)
  end)
  -- -------- 角色 2 --------
  rt.on(e_859004d2_17ce_4480_a27e_d41f87103a80, "on_running_group_activated", {}, function(th, self)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      f["self_text_effect_size"](self, { size = 50 }, th)
      f["self_text_effect_text"](self, { text = "获得更多功能" }, th)
      th:call_proc(proc_02da6cfd_3335_4473_a7f5_37288abf1a8f, self, 20, 75, 0, nil)
  end)
  -- -------- 角色 buy --------
  rt.on(e_cf5996d0_ce13_4fd6_a697_20330cfe8c70, "on_running_group_activated", {}, function(th, self)
      th:call_proc(proc_b40a764c_79a5_40e4_ba26_f77f45c7a502, self, 100, 120, 80, nil)
  end)
  rt.on(e_cf5996d0_ce13_4fd6_a697_20330cfe8c70, "on_running_group_activated", {}, function(th, self)
      th:call_proc(proc_02da6cfd_3335_4473_a7f5_37288abf1a8f, self, 50, 20, -100, nil)
  end)
  rt.on(e_cf5996d0_ce13_4fd6_a697_20330cfe8c70, "sprite_on_tap", { sprite = "--self", type = "mouse_click" }, function(th, self)
      f["ask_and_choose"](self, { CHOICE0 = "1天（2000PP）", CHOICE1 = "7天（5000PP）（超值）", question = "离线不消耗时间" }, th)
      if V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 1, OP = "EQ" }, th)) then
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "e63f579e-11c5-4d78-a976-e9c0e37912bc" }, th), B = 2000, OP = "GTE" }, th)) then
          f["change_variables"](self, { method = "decrease", value = 2000, variable = "e63f579e-11c5-4d78-a976-e9c0e37912bc" }, th)
          f["change_variables"](self, { method = "increase", value = 86400, variable = "ce76233f-335c-462d-82a3-4b17fd07a2e3" }, th)
        else
          f["create_stage_dialog"](self, { sprite = "--self", text = "没有足够PP" }, th)
        end
      else
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "e63f579e-11c5-4d78-a976-e9c0e37912bc" }, th), B = 5000, OP = "GTE" }, th)) then
          f["change_variables"](self, { method = "decrease", value = 5000, variable = "e63f579e-11c5-4d78-a976-e9c0e37912bc" }, th)
          f["change_variables"](self, { method = "increase", value = 604800, variable = "ce76233f-335c-462d-82a3-4b17fd07a2e3" }, th)
        else
          f["create_stage_dialog"](self, { sprite = "--self", text = "没有足够PP" }, th)
        end
      end
  end)
  rt.on(e_cf5996d0_ce13_4fd6_a697_20330cfe8c70, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "ce76233f-335c-462d-82a3-4b17fd07a2e3" }, th), B = 0, OP = "NEQ" }, th)) then
          f["wait"](self, { time = 1 }, th)
          f["change_variables"](self, { method = "decrease", value = 1, variable = "ce76233f-335c-462d-82a3-4b17fd07a2e3" }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 osucircle --------
  rt.on(e_d7f3224d_cb3f_446f_8e27_ff4e89b7e3f3, "on_running_group_activated", {}, function(th, self)
      while true do
        f["variables_set"](self, { value = (th:call_proc(proc_7558af1a_b4f5_4c12_ada1_f3de6e12d0cd, self, f["math_arithmetic"](self, { A = f["list_length"](self, { list = "1efc0077-8db0-4702-bf36-22dcd92460d9" }, th), B = 102.5, type = "divide" }, th), 2)), variable = "0e5b8264-119d-4030-8b02-ac263239ad6b" }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_d7f3224d_cb3f_446f_8e27_ff4e89b7e3f3, "sprite_on_tap", { sprite = "--self", type = "mouse_click" }, function(th, self)
      f["delete_list_item"](self, { item = "all", list = "7e0f49e9-ddda-4aa3-ba02-6812ac0a9f50" }, th)
      f["delete_list_item"](self, { item = "all", list = "5c47c536-5bc8-47dd-8902-3619ab3fb7cf" }, th)
      f["delete_list_item"](self, { item = "all", list = "ecd8d09a-b4c1-4df6-8258-320957f8e280" }, th)
      f["delete_list_item"](self, { item = "all", list = "3fc9d1cc-d568-45d0-973e-1a7178ce9a0d" }, th)
      f["delete_list_item"](self, { item = "all", list = "1efc0077-8db0-4702-bf36-22dcd92460d9" }, th)
      f["delete_list_item"](self, { item = "all", list = "18a437b0-0ab5-4dc7-b144-363707cdad1c" }, th)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      f["self_ask"](self, { text = "将铺面[HitObjects]下面的内容全部输入" }, th)
      f["variables_set"](self, { value = f["get_answer"](self, {}, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
      th:warp_enter()
      f["list_copy"](self, { list = f["text_split"](self, { SPLIT_TEXT = " ", TEXT_TO_SPLIT = f["script_variables_value"](self, { TEXT = "a" }, th) }, th), target_list = "ecd8d09a-b4c1-4df6-8258-320957f8e280" }, th)
      do
        local _from_n9, _to_n9 = tonumber(1), tonumber(f["list_length"](self, { list = "ecd8d09a-b4c1-4df6-8258-320957f8e280" }, th))
        if _from_n9 ~= _from_n9 or _to_n9 ~= _to_n9 then
          -- NaN from/to: official warning; no iterations
        else
          if _from_n9 <= _to_n9 then _from_n9 = math.ceil(_from_n9); if _from_n9 > _to_n9 then _from_n9 = _to_n9 + 1 end
          else _from_n9 = math.floor(_from_n9); if _from_n9 < _to_n9 then _from_n9 = _to_n9 - 1 end end
          local _by_n9 = 1
          if _by_n9 == nil then _by_n9 = 1 end
          _by_n9 = tonumber(_by_n9)
          if _by_n9 == nil or _by_n9 ~= _by_n9 or _by_n9 <= 0 then _by_n9 = 0 else _by_n9 = math.abs(math.floor(_by_n9 + 0.5)) end
          if _by_n9 > 0 then
            local _p_n9 = _from_n9
            while (_from_n9 <= _to_n9 and _p_n9 <= _to_n9) or (_from_n9 > _to_n9 and _p_n9 >= _to_n9) do
              local _i_n9 = _p_n9
              th:push_param(_p_n9)
            f["list_copy"](self, { list = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = f["list_item"](self, { item = "any", list = "ecd8d09a-b4c1-4df6-8258-320957f8e280", list_index = _p_n9 }, th) }, th), target_list = "18a437b0-0ab5-4dc7-b144-363707cdad1c" }, th)
            f["list_append"](self, { list = "1efc0077-8db0-4702-bf36-22dcd92460d9", list_item_value = f["list_item"](self, { item = "any", list = "18a437b0-0ab5-4dc7-b144-363707cdad1c", list_index = 1 }, th) }, th)
            f["list_append"](self, { list = "3fc9d1cc-d568-45d0-973e-1a7178ce9a0d", list_item_value = f["list_item"](self, { item = "any", list = "18a437b0-0ab5-4dc7-b144-363707cdad1c", list_index = 3 }, th) }, th)
            if V.bool(f["text_contain"](self, { A = f["list_item"](self, { item = "any", list = "ecd8d09a-b4c1-4df6-8258-320957f8e280", list_index = _p_n9 }, th), B = "|" }, th)) then
            else
              f["list_append"](self, { list = "5c47c536-5bc8-47dd-8902-3619ab3fb7cf", list_item_value = 0 }, th)
            end
            f["delete_list_item"](self, { item = "all", list = "18a437b0-0ab5-4dc7-b144-363707cdad1c" }, th)
              th:pop_param()
              _p_n9 = _p_n9 + _by_n9
              if th:iter_w() then break end
            end
          end
        end
      end
      th:warp_exit()
      f["create_stage_dialog"](self, { sprite = "--self", text = f["text_join"](self, { ADD0 = "难度为", ADD1 = f["variables_get"](self, { variable = "0e5b8264-119d-4030-8b02-ac263239ad6b" }, th) }, th) }, th)
  end)
  rt.on(e_d7f3224d_cb3f_446f_8e27_ff4e89b7e3f3, "on_running_group_activated", {}, function(th, self)
      f["set_scale"](self, { scale = 100 }, th)
      f["self_dialog"](self, { text = "点我导入osu谱", time = 2, type = "talk" }, th)
      th:call_proc(proc_b40a764c_79a5_40e4_ba26_f77f45c7a502, self, 63, 69, 58, nil)
  end)
  rt.on(e_d7f3224d_cb3f_446f_8e27_ff4e89b7e3f3, "on_running_group_activated", {}, function(th, self)
      th:call_proc(proc_fde38e22_9be0_4d77_8605_5a4e38f5270c, self)
  end)
  -- -------- 角色 遮罩 --------
  rt.on(e_5f2d3188_f919_4139_9a87_0a2e52f7d66e, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_set_effect"](self, { scope = "1", value = f["variables_get"](self, { variable = "16f5bf5a-64a9-4ad1-9052-d34b3e677e99" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 遮罩 --------
  rt.on(e_ea4e3fef_3091_4773_8025_d207b9310113, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_change_effect"](self, { increase = "increase", scope = "1", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 90, B = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        else
          f["self_change_effect"](self, { increase = "increase", scope = "1", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "16f5bf5a-64a9-4ad1-9052-d34b3e677e99" }, th), B = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "minus" }, th), B = 15, type = "divide" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 遮罩 --------
  rt.on(e_4e9b6cd2_ef52_49b4_89ff_e228449d18eb, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_set_effect"](self, { scope = "1", value = f["variables_get"](self, { variable = "16f5bf5a-64a9-4ad1-9052-d34b3e677e99" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 遮罩 --------
  rt.on(e_7462b472_977c_4ca8_98be_5f97dffbd11a, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_set_effect"](self, { scope = "1", value = f["variables_get"](self, { variable = "16f5bf5a-64a9-4ad1-9052-d34b3e677e99" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 提示 --------
  rt.on(e_56dd2bee_76bc_4f64_a53d_3967177cb6c4, "on_running_group_activated", {}, function(th, self)
      f["self_appear"](self, { value = "disappear" }, th)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      f["self_text_effect_size"](self, { size = 36 }, th)
      f["self_text_effect_text"](self, { text = "WS选择谱面 ↑↓选择难度 A返回 点击滑动球切换模式" }, th)
      f["self_gradually_show_hide"](self, { show_hide = "show", time = 0.2 }, th)
      f["wait"](self, { time = 2 }, th)
      f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.2 }, th)
  end)
  -- -------- 角色 横幅通知 --------
  rt.on(e_59c0adac_290c_4360_b0bd_c8a5459f70c4, "on_running_group_activated", {}, function(th, self)
      f["set_width_height_scale"](self, { type = "height", value = 1 }, th)
      f["self_set_effect"](self, { scope = "1", value = 100 }, th)
  end)
  rt.on(e_59c0adac_290c_4360_b0bd_c8a5459f70c4, "on_running_group_activated", {}, function(th, self)
      if V.bool(f["logic_operation"](self, { A = f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "4c3a9fa3-347b-4fc8-9fd0-4ad8acee6668" }, th), B = 1, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f50e3c35-16b8-4143-8d93-70bf79d3ebfa" }, th), B = 1, OP = "EQ" }, th), type = "and" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "ce76233f-335c-462d-82a3-4b17fd07a2e3" }, th), B = 1, OP = "GTE" }, th), type = "and" }, th)) then
        f["self_broadcast_with_param"](self, { message = "通知", param = 2 }, th)
      end
  end)
  rt.on(e_59c0adac_290c_4360_b0bd_c8a5459f70c4, "start_as_a_mirror", {}, function(th, self)
      while true do
        if f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["math_round"](self, { num = f["appearance_of_sprite"](self, { appearance = "height", sprite = "--self" }, th), type = "round" }, th), B = 100, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["math_round"](self, { num = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "round" }, th), B = 50, OP = "EQ" }, th), type = "and" }, th) then break end
        f["add_width_height_scale"](self, { increase = "increase", type = "height", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = f["appearance_of_sprite"](self, { appearance = "height", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        f["self_change_effect"](self, { increase = "increase", scope = "1", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 50, B = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        if th:iter_n() then break end
      end
      f["wait"](self, { time = 2 }, th)
      while true do
        if f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["math_round"](self, { num = f["appearance_of_sprite"](self, { appearance = "height", sprite = "--self" }, th), type = "round" }, th), B = 1, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["math_round"](self, { num = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "round" }, th), B = 100, OP = "EQ" }, th), type = "and" }, th) then break end
        f["add_width_height_scale"](self, { increase = "increase", type = "height", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 1, B = f["appearance_of_sprite"](self, { appearance = "height", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        f["self_change_effect"](self, { increase = "increase", scope = "1", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        if th:iter_n() then break end
      end
      f["dispose_clone"](self, {}, th)
  end)
  rt.on(e_59c0adac_290c_4360_b0bd_c8a5459f70c4, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["get_current_clone_index"](self, {}, th), B = 0, OP = "EQ" }, th), B = f["received_broadcast"](self, { message = "通知" }, th), type = "and" }, th)) then
          f["mirror"](self, { sprite = "--self" }, th)
          while not V.bool(f["logic_compare"](self, { A = f["get_clone_num"](self, { sprite = "--self" }, th), B = 0, OP = "EQ" }, th)) do
            if th:iter_n() then break end
          end
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 横幅文字 --------
  rt.on(e_3fa2d77f_f8e2_4918_aaa5_a9272494dcc6, "on_running_group_activated", {}, function(th, self)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      f["self_text_effect_size"](self, { size = 24 }, th)
  end)
  rt.on(e_3fa2d77f_f8e2_4918_aaa5_a9272494dcc6, "self_listen_with_param", { message = "通知" }, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["self_listen_value"](self, { TEXT = "内容" }, th), B = 2, OP = "EQ" }, th)) then
        f["self_text_effect_text"](self, { text = "咕咕咕？咕咕！" }, th)
      end
      f["self_gradually_show_hide"](self, { show_hide = "show", time = 0.1 }, th)
      f["wait"](self, { time = 2 }, th)
      f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.1 }, th)
  end)
  -- -------- 角色 星星喷泉左 --------
  rt.on(e_946ace71_fa8a_4c30_b470_ccfe7c2a6551, "start_as_a_mirror", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, name = "a", names = { "a", "b", "c" } }, th)
      f["variables_set"](self, { value = f["random_num"](self, { A = 0, B = 3 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"b\"}" }, th)
      f["variables_set"](self, { value = f["random_num"](self, { A = 0, B = 1 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"c\"}" }, th)
      f["self_set_position_y"](self, { value = -325 }, th)
      f["self_appear"](self, { value = "appear" }, th)
      f["self_set_effect"](self, { scope = "1", value = 100 }, th)
      f["variables_set"](self, { value = 8, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
      while true do
        if f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = 0, OP = "EQ" }, th) then break end
        f["self_change_coordinate_y"](self, { increase = "increase", value = f["script_variables_value"](self, { TEXT = "a" }, th) }, th)
        f["change_variables"](self, { method = "decrease", value = 0.1, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        f["self_change_effect"](self, { increase = "decrease", scope = "1", value = 2 }, th)
        if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "c" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_rotate"](self, { degrees = f["math_trig"](self, { num = f["appearance_of_sprite"](self, { appearance = "direction", sprite = "--self" }, th), type = "sin" }, th) }, th)
        else
          f["self_rotate"](self, { degrees = f["math_trig"](self, { num = f["appearance_of_sprite"](self, { appearance = "direction", sprite = "--self" }, th), type = "cos" }, th) }, th)
        end
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "7fdf438d-fd13-4d83-9727-f89e1ec11469" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "decrease", value = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), B = f["random_num"](self, { A = f["math_arithmetic"](self, { A = f["math_function"](self, { num = f["variables_get"](self, { variable = "90168479-24c3-43a1-a88e-932699476b44" }, th), type = "2" }, th), B = 3, type = "divide" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "90168479-24c3-43a1-a88e-932699476b44" }, th), B = 3, type = "divide" }, th) }, th), type = "add" }, th), type = "sin" }, th) }, th)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "7fdf438d-fd13-4d83-9727-f89e1ec11469" }, th), B = 2, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), B = f["random_num"](self, { A = f["math_arithmetic"](self, { A = f["math_function"](self, { num = f["variables_get"](self, { variable = "90168479-24c3-43a1-a88e-932699476b44" }, th), type = "2" }, th), B = 3, type = "divide" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "90168479-24c3-43a1-a88e-932699476b44" }, th), B = 3, type = "divide" }, th) }, th), type = "add" }, th), type = "sin" }, th) }, th)
        end
        if th:iter_n() then break end
      end
      while true do
        if f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = 10, OP = "GTE" }, th) then break end
        f["self_change_coordinate_y"](self, { increase = "decrease", value = f["script_variables_value"](self, { TEXT = "a" }, th) }, th)
        f["change_variables"](self, { method = "increase", value = 0.15, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        f["self_change_effect"](self, { increase = "increase", scope = "1", value = 2 }, th)
        if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "b" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "decrease", value = f["math_trig"](self, { num = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "sin" }, th) }, th)
        elseif V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "b" }, th), B = 1, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_trig"](self, { num = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "sin" }, th) }, th)
        elseif V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "b" }, th), B = 2, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "decrease", value = f["math_trig"](self, { num = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "cos" }, th) }, th)
        elseif V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "b" }, th), B = 3, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_trig"](self, { num = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "cos" }, th) }, th)
        end
        if th:iter_n() then break end
      end
      f["dispose_clone"](self, {}, th)
  end)
  -- -------- 角色 星星喷泉右 --------
  rt.on(e_54785748_f51a_456f_9225_e6cbf11b955d, "start_as_a_mirror", {}, function(th, self)
      f["self_appear"](self, { value = "appear" }, th)
      f["script_variables"](self, { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, name = "a", names = { "a", "b", "c" } }, th)
      f["variables_set"](self, { value = f["random_num"](self, { A = 0, B = 3 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"b\"}" }, th)
      f["variables_set"](self, { value = f["random_num"](self, { A = 0, B = 1 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"c\"}" }, th)
      f["self_set_position_y"](self, { value = -325 }, th)
      f["variables_set"](self, { value = 8, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
      while true do
        if f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = 0, OP = "EQ" }, th) then break end
        f["self_change_coordinate_y"](self, { increase = "increase", value = f["script_variables_value"](self, { TEXT = "a" }, th) }, th)
        f["change_variables"](self, { method = "decrease", value = 0.1, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        f["self_change_effect"](self, { increase = "decrease", scope = "1", value = 2 }, th)
        if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "c" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_rotate"](self, { degrees = f["math_trig"](self, { num = f["appearance_of_sprite"](self, { appearance = "direction", sprite = "--self" }, th), type = "sin" }, th) }, th)
        else
          f["self_rotate"](self, { degrees = f["math_trig"](self, { num = f["appearance_of_sprite"](self, { appearance = "direction", sprite = "--self" }, th), type = "cos" }, th) }, th)
        end
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "7fdf438d-fd13-4d83-9727-f89e1ec11469" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "decrease", value = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), B = f["random_num"](self, { A = f["math_arithmetic"](self, { A = f["math_function"](self, { num = f["variables_get"](self, { variable = "90168479-24c3-43a1-a88e-932699476b44" }, th), type = "2" }, th), B = 3, type = "divide" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "90168479-24c3-43a1-a88e-932699476b44" }, th), B = 3, type = "divide" }, th) }, th), type = "add" }, th), type = "sin" }, th) }, th)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "7fdf438d-fd13-4d83-9727-f89e1ec11469" }, th), B = 2, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), B = f["random_num"](self, { A = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "90168479-24c3-43a1-a88e-932699476b44" }, th), B = 3, type = "divide" }, th), type = "2" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "90168479-24c3-43a1-a88e-932699476b44" }, th), B = 3, type = "divide" }, th) }, th), type = "add" }, th), type = "sin" }, th) }, th)
        end
        if th:iter_n() then break end
      end
      while true do
        if f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = 10, OP = "GTE" }, th) then break end
        f["self_change_coordinate_y"](self, { increase = "decrease", value = f["script_variables_value"](self, { TEXT = "a" }, th) }, th)
        f["change_variables"](self, { method = "increase", value = 0.15, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        f["self_change_effect"](self, { increase = "increase", scope = "1", value = 2 }, th)
        if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "b" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "decrease", value = f["math_trig"](self, { num = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "sin" }, th) }, th)
        elseif V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "b" }, th), B = 1, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_trig"](self, { num = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "sin" }, th) }, th)
        elseif V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "b" }, th), B = 2, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "decrease", value = f["math_trig"](self, { num = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "cos" }, th) }, th)
        elseif V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, { TEXT = "b" }, th), B = 3, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_trig"](self, { num = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "cos" }, th) }, th)
        end
        if th:iter_n() then break end
      end
      f["dispose_clone"](self, {}, th)
  end)
  rt.on(e_54785748_f51a_456f_9225_e6cbf11b955d, "on_running_group_activated", {}, function(th, self)
      while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "9a1370ff-40f6-4ef6-bb25-4865fb357307" }, th), B = 1, OP = "NEQ" }, th)) do
        if th:iter_n() then break end
      end
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 0, OP = "NEQ" }, th)) then
        while not V.bool(f["logic_compare"](self, { A = f["timer"](self, {}, th), B = 0, OP = "NEQ" }, th)) do
          if th:iter_n() then break end
        end
      end
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 0, OP = "EQ" }, th)) then
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 46)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 1, OP = "EQ" }, th)) then
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 57)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 14)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 6)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 1, 1)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 50)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 2, OP = "EQ" }, th)) then
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 40)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 7)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 11)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 7)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 32)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 9)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 6)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 3, OP = "EQ" }, th)) then
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 41)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 50)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 6)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 19)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 4, OP = "EQ" }, th)) then
        while not V.bool(f["logic_compare"](self, { A = f["timer"](self, {}, th), B = 0, OP = "NEQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 44)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 16)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 1, 2)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 5, OP = "EQ" }, th)) then
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 40)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 14)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 44)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 33)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 0, 14)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 6, OP = "EQ" }, th)) then
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 17, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 31, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 45, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 49, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 64, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 70, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 7, OP = "EQ" }, th)) then
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 2, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 31, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 61, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 8, OP = "EQ" }, th)) then
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 10, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 48, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 72, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 76, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 9, OP = "EQ" }, th)) then
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 33, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 70, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 92, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 10, OP = "EQ" }, th)) then
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 5, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 23, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 50, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 11, OP = "EQ" }, th)) then
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 9, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 46, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 12, OP = "EQ" }, th)) then
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 17, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 40, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 13, OP = "EQ" }, th)) then
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 26, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 57, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 14, OP = "EQ" }, th)) then
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 10, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 20, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 15, OP = "EQ" }, th)) then
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 8, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 16, OP = "EQ" }, th)) then
        th:call_proc(proc_1d674402_3284_4bf3_87c9_f03f04d8542e, self, 1, 41)
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 17, OP = "EQ" }, th)) then
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 19, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 21, OP = "EQ" }, th)) then
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 13, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 39, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 52, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 53, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 54, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 22, OP = "EQ" }, th)) then
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 1, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 19, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 23, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 27, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 56, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 60, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 64, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 23, OP = "EQ" }, th)) then
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 17, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 34, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
        while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th), B = 45, OP = "EQ" }, th)) do
          if th:iter_n() then break end
        end
        th:call_proc(proc_8866b182_cf8a_4978_92c2_8cda965613bf, self, f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th))
      end
  end)
  -- -------- 角色 矩形 --------
  rt.on(e_f5d13c9f_b53c_4f5b_9d29_c9488bf94b0a, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.1 }, th)
        else
          f["self_gradually_show_hide"](self, { show_hide = "show", time = 0.1 }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_f5d13c9f_b53c_4f5b_9d29_c9488bf94b0a, "on_running_group_activated", {}, function(th, self)
      while true do
        f["set_sprite_style"](self, { style_id = f["variables_get"](self, { variable = "a0f605c5-1fe0-49ee-8724-d148ae1a3197" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 monitoring --------
  rt.on(e_13c821e9_2d8e_4434_9937_56c54b21ecf7, "on_running_group_activated", {}, function(th, self)
      th:call_proc(proc_fde38e22_9be0_4d77_8605_5a4e38f5270c, self)
  end)
  rt.on(e_13c821e9_2d8e_4434_9937_56c54b21ecf7, "on_running_group_activated", {}, function(th, self)
      th:call_proc(proc_b40a764c_79a5_40e4_ba26_f77f45c7a502, self, 100, 110, 100, nil)
  end)
  rt.on(e_13c821e9_2d8e_4434_9937_56c54b21ecf7, "sprite_on_tap", { sprite = "--self", type = "mouse_click" }, function(th, self)
      f["set_timer_state"](self, { type = "stop" }, th)
      f["set_timer_state"](self, { type = "reset" }, th)
      th:call_proc(proc_4c20d971_9c2e_4f69_8a28_f808e89f0a62, self)
      f["variables_set"](self, { value = 0, variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th)
      f["variables_set"](self, { value = 0, variable = "661345c6-cc87-4b50-9937-dec0fc714cfd" }, th)
      f["stop_audio"](self, { audio_id = "all_audio" }, th)
      f["set_screen_transition"](self, { type = "fade_in_out" }, th)
      f["switch_to_screen"](self, { screen_id = "080ff01f-de3f-47b9-97ac-af9a656ec4f2" }, th)
  end)
  rt.on(e_13c821e9_2d8e_4434_9937_56c54b21ecf7, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.1 }, th)
        else
          f["self_gradually_show_hide"](self, { show_hide = "show", time = 0.1 }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_13c821e9_2d8e_4434_9937_56c54b21ecf7, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.01, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = -500, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
          f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 0.02, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = -225, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        else
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.01, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = -350, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
          f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 0.02, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = -225, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_13c821e9_2d8e_4434_9937_56c54b21ecf7, "on_running_group_activated", {}, function(th, self)
      while true do
        f["set_sprite_style"](self, { style_id = f["variables_get"](self, { variable = "a0f605c5-1fe0-49ee-8724-d148ae1a3197" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 提示 --------
  rt.on(e_6263c102_e379_498d_b9c5_2038b8450c59, "on_running_group_activated", {}, function(th, self)
      f["self_appear"](self, { value = "disappear" }, th)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      f["self_text_effect_size"](self, { size = 36 }, th)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "c9d0fc4b-f607-4b77-829d-41361fbcabe9" }, th), B = 1, OP = "EQ" }, th)) then
        f["self_text_effect_text"](self, { text = "Relax模式：左右移动鼠标进行游戏" }, th)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "4c3a9fa3-347b-4fc8-9fd0-4ad8acee6668" }, th), B = 1, OP = "EQ" }, th)) then
        f["self_text_effect_text"](self, { text = "自动游玩中" }, th)
      elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "b3145a6b-660c-4ab0-8a52-6075eb193af2" }, th), B = 1, OP = "EQ" }, th)) then
        f["self_text_effect_text"](self, { text = "Octopus AI自动游玩中" }, th)
      else
        f["self_text_effect_text"](self, { text = "键盘模式：A左S右D加速" }, th)
      end
      f["self_gradually_show_hide"](self, { show_hide = "show", time = 0.2 }, th)
      f["wait"](self, { time = 2 }, th)
      f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.2 }, th)
  end)
  -- -------- 角色 支持者背景 --------
  rt.on(e_ba96713e_7238_4f0e_afc0_4f43a0a4c9b6, "on_running_group_activated", {}, function(th, self)
      f["self_appear"](self, { value = "appear" }, th)
      f["set_width_height_scale"](self, { type = "width", value = 1 }, th)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.02, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = -400, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 3, type = "divide" }, th) }, th)
          f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 0.04, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = 225, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 3, type = "divide" }, th) }, th)
          f["add_width_height_scale"](self, { increase = "increase", type = "width", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = f["appearance_of_sprite"](self, { appearance = "width", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
          f["self_change_effect"](self, { increase = "increase", scope = "1", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 25, B = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
          f["set_sprite_style"](self, { style_id = "eecc5988-ed47-441b-a113-5050748544b0" }, th)
        else
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.01, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = -200, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 3, type = "divide" }, th) }, th)
          f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 0.02, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = 225, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 3, type = "divide" }, th) }, th)
          f["self_change_effect"](self, { increase = "increase", scope = "1", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 0, B = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
          f["set_sprite_style"](self, { style_id = "842c948d-37fb-47cd-aaec-828b00d19266" }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 心 --------
  rt.on(e_8e7b1e19_f6ae_4f28_836a_19067dccf67e, "on_running_group_activated", {}, function(th, self)
      while true do
        do
          local _times_n9 = 10
          while true do
            if _times_n9 <= 0 then break end
            _times_n9 = _times_n9 - 1
            f["self_change_effect"](self, { increase = "increase", scope = "2", value = 1 }, th)
            if th:iter_n() then break end
          end
        end
        f["wait"](self, { time = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 60, B = f["variables_get"](self, { variable = "ad9ad2e0-bf30-48fd-9a36-cc64092abce3" }, th), type = "divide" }, th), B = f["variables_get"](self, { variable = "a5318ba4-122b-4ffb-977c-cc82ec6318bb" }, th), type = "divide" }, th), B = f["variables_get"](self, { variable = "1f8a4269-f7f9-4790-be36-e39dfa16cca2" }, th), type = "add" }, th) }, th)
        do
          local _times_n10 = 10
          while true do
            if _times_n10 <= 0 then break end
            _times_n10 = _times_n10 - 1
            f["self_change_effect"](self, { increase = "decrease", scope = "2", value = 1 }, th)
            if th:iter_n() then break end
          end
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_8e7b1e19_f6ae_4f28_836a_19067dccf67e, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.02, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = -400, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 2, type = "divide" }, th) }, th)
          f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 0.04, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = 225, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 2, type = "divide" }, th) }, th)
          f["self_change_effect"](self, { increase = "increase", scope = "1", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 25, B = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
        else
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.02, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = 0, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 2, type = "divide" }, th) }, th)
          f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 0.04, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = 225, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 2, type = "divide" }, th) }, th)
          f["self_change_effect"](self, { increase = "increase", scope = "1", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 0, B = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_8e7b1e19_f6ae_4f28_836a_19067dccf67e, "sprite_on_tap", { sprite = "--self", type = "mouse_click" }, function(th, self)
      f["set_screen_transition"](self, { type = "fade_in_out" }, th)
      f["switch_to_screen"](self, { screen_id = "a24ee163-9852-4208-850f-bd87d3aea79f" }, th)
  end)
  -- -------- 角色 支持者内容 --------
  rt.on(e_f514c5ad_4529_4447_9405_6c953cb44137, "on_running_group_activated", {}, function(th, self)
      f["self_text_effect_size"](self, { size = 17 }, th)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      f["self_text_effect_text"](self, { text = "获取更多功能？点♥使用PP来兑换now!supporter" }, th)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.1 }, th)
        else
          f["self_gradually_show_hide"](self, { show_hide = "show", time = 0.1 }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_f514c5ad_4529_4447_9405_6c953cb44137, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["get_mouse_info"](self, { type = "x" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.02, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = -215, type = "add" }, th), y = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["get_mouse_info"](self, { type = "y" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 0.04, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = 225, type = "add" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 锁定 --------
  rt.on(e_1729f8cf_df6e_4420_8217_7881b696e340, "on_keydown", { key = "65", type = "down" }, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "3a064750-07fd-4c4a-95a2-271c3b091da8" }, th), B = 8, OP = "EQ" }, th)) then
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "ce76233f-335c-462d-82a3-4b17fd07a2e3" }, th), B = 1, OP = "GTE" }, th)) then
          f["switch_to_screen"](self, { screen_id = "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, th)
        end
      else
        f["switch_to_screen"](self, { screen_id = "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, th)
      end
  end)
  rt.on(e_1729f8cf_df6e_4420_8217_7881b696e340, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "3a064750-07fd-4c4a-95a2-271c3b091da8" }, th), B = 8, OP = "EQ" }, th)) then
          if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "ce76233f-335c-462d-82a3-4b17fd07a2e3" }, th), B = 1, OP = "GTE" }, th)) then
            f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.1 }, th)
          else
            f["self_gradually_show_hide"](self, { show_hide = "show", time = 0.1 }, th)
          end
        else
          f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.1 }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 广告 --------
  rt.on(e_0d3cb358_caba_4bd9_9ec7_77ba6d5d91c7, "on_running_group_activated", {}, function(th, self)
      f["self_set_effect"](self, { scope = "1", value = 100 }, th)
      f["self_appear"](self, { value = "appear" }, th)
      while true do
        if f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["math_round"](self, { num = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "round" }, th), B = 0, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["math_round"](self, { num = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "round" }, th), B = 75, OP = "EQ" }, th), type = "and" }, th) then break end
        f["self_change_effect"](self, { increase = "increase", scope = "1", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 0, B = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
        f["self_change_scale"](self, { increase = "increase", scale = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 75, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
        if th:iter_n() then break end
      end
      while true do
        if f["mouse_down"](self, { sprite = "--self", type = "click" }, th) then break end
        if V.bool(f["logic_operation"](self, { A = f["mouse_down"](self, { sprite = "--self", type = "down" }, th), B = f["bump_into"](self, { sprite = "--self", sprite1 = "--mouse" }, th), type = "and" }, th)) then
          f["self_change_scale"](self, { increase = "increase", scale = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 70, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 0.133, type = "multiply" }, th) }, th)
        elseif V.bool(f["bump_into"](self, { sprite = "--self", sprite1 = "--mouse" }, th)) then
          f["self_change_scale"](self, { increase = "increase", scale = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 80, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 0.133, type = "multiply" }, th) }, th)
        else
          f["self_change_scale"](self, { increase = "increase", scale = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 75, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 0.133, type = "multiply" }, th) }, th)
        end
        if th:iter_n() then break end
      end
      while true do
        if f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["math_round"](self, { num = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "round" }, th), B = 100, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["math_round"](self, { num = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "round" }, th), B = 100, OP = "EQ" }, th), type = "and" }, th) then break end
        f["self_change_effect"](self, { increase = "increase", scope = "1", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
        f["self_change_scale"](self, { increase = "increase", scale = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
        if th:iter_n() then break end
      end
      f["self_appear"](self, { value = "disappear" }, th)
  end)
  rt.on(e_0d3cb358_caba_4bd9_9ec7_77ba6d5d91c7, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["variables_get"](self, { variable = "281cbc78-8d58-4963-87b4-7f6502e9069c" }, th)) then
          f["set_sprite_style"](self, { style_id = f["variables_get"](self, { variable = "281cbc78-8d58-4963-87b4-7f6502e9069c" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 Adobe --------
  rt.on(e_021f6559_beec_4abc_8013_8a0b6b6125ee, "on_running_group_activated", {}, function(th, self)
      f["show_hide_timer"](self, { showHide = "hide" }, th)
  end)
  rt.on(e_021f6559_beec_4abc_8013_8a0b6b6125ee, "on_running_group_activated", {}, function(th, self)
      if V.bool(f["logic_negate"](self, { logic = f["variables_get"](self, { variable = "d60f5cc4-3fe1-4a2f-b9d6-04602006c007" }, th) }, th)) then
        do
          local _from_n9, _to_n9 = tonumber(1), tonumber(100)
          if _from_n9 ~= _from_n9 or _to_n9 ~= _to_n9 then
            -- NaN from/to: official warning; no iterations
          else
            if _from_n9 <= _to_n9 then _from_n9 = math.ceil(_from_n9); if _from_n9 > _to_n9 then _from_n9 = _to_n9 + 1 end
            else _from_n9 = math.floor(_from_n9); if _from_n9 < _to_n9 then _from_n9 = _to_n9 - 1 end end
            local _by_n9 = 1
            if _by_n9 == nil then _by_n9 = 1 end
            _by_n9 = tonumber(_by_n9)
            if _by_n9 == nil or _by_n9 ~= _by_n9 or _by_n9 <= 0 then _by_n9 = 0 else _by_n9 = math.abs(math.floor(_by_n9 + 0.5)) end
            if _by_n9 > 0 then
              local _p_n9 = _from_n9
              while (_from_n9 <= _to_n9 and _p_n9 <= _to_n9) or (_from_n9 > _to_n9 and _p_n9 >= _to_n9) do
                local _i_n9 = _p_n9
                th:push_param(_p_n9)
              f["self_set_effect"](self, { scope = "1", value = (th:call_proc(proc_4f585296_463f_434b_9b48_6d729cd4b39c, self, 100, 0, "渐缓n次", 15, _p_n9)) }, th)
              f["set_width_height_scale"](self, { type = "height", value = (th:call_proc(proc_4f585296_463f_434b_9b48_6d729cd4b39c, self, 1, 100, "渐缓n次", 15, _p_n9)) }, th)
              f["set_width_height_scale"](self, { type = "width", value = (th:call_proc(proc_4f585296_463f_434b_9b48_6d729cd4b39c, self, 1, 100, "渐缓n次", 5, _p_n9)) }, th)
              f["self_move_to"](self, { x = (th:call_proc(proc_4f585296_463f_434b_9b48_6d729cd4b39c, self, -350, 0, "渐缓n次", 5, _p_n9)), y = (th:call_proc(proc_4f585296_463f_434b_9b48_6d729cd4b39c, self, -200, 0, "渐缓n次", 5, _p_n9)) }, th)
                th:pop_param()
                _p_n9 = _p_n9 + _by_n9
                if th:iter_n() then break end
              end
            end
          end
        end
      else
        do
          local _from_n10, _to_n10 = tonumber(1), tonumber(100)
          if _from_n10 ~= _from_n10 or _to_n10 ~= _to_n10 then
            -- NaN from/to: official warning; no iterations
          else
            if _from_n10 <= _to_n10 then _from_n10 = math.ceil(_from_n10); if _from_n10 > _to_n10 then _from_n10 = _to_n10 + 1 end
            else _from_n10 = math.floor(_from_n10); if _from_n10 < _to_n10 then _from_n10 = _to_n10 - 1 end end
            local _by_n10 = 1
            if _by_n10 == nil then _by_n10 = 1 end
            _by_n10 = tonumber(_by_n10)
            if _by_n10 == nil or _by_n10 ~= _by_n10 or _by_n10 <= 0 then _by_n10 = 0 else _by_n10 = math.abs(math.floor(_by_n10 + 0.5)) end
            if _by_n10 > 0 then
              local _p_n10 = _from_n10
              while (_from_n10 <= _to_n10 and _p_n10 <= _to_n10) or (_from_n10 > _to_n10 and _p_n10 >= _to_n10) do
                local _i_n10 = _p_n10
                th:push_param(_p_n10)
              f["self_set_effect"](self, { scope = "1", value = (th:call_proc(proc_4f585296_463f_434b_9b48_6d729cd4b39c, self, 0, 100, "渐缓n次", 15, _p_n10)) }, th)
              f["set_width_height_scale"](self, { type = "height", value = (th:call_proc(proc_4f585296_463f_434b_9b48_6d729cd4b39c, self, 100, 1, "渐缓n次", 15, _p_n10)) }, th)
              f["set_width_height_scale"](self, { type = "width", value = (th:call_proc(proc_4f585296_463f_434b_9b48_6d729cd4b39c, self, 100, 1, "渐缓n次", 5, _p_n10)) }, th)
              f["self_move_to"](self, { x = (th:call_proc(proc_4f585296_463f_434b_9b48_6d729cd4b39c, self, 0, -350, "渐缓n次", 5, _p_n10)), y = (th:call_proc(proc_4f585296_463f_434b_9b48_6d729cd4b39c, self, 0, -200, "渐缓n次", 5, _p_n10)) }, th)
                th:pop_param()
                _p_n10 = _p_n10 + _by_n10
                if th:iter_n() then break end
              end
            end
          end
        end
        f["self_appear"](self, { value = "disappear" }, th)
      end
      if V.bool(f["logic_negate"](self, { logic = f["list_is_exist"](self, { list = "3c180ab0-af0b-4f97-9e2f-7d4a1b5a9d09", list_item_value = f["user_id_get"](self, {}, th) }, th) }, th)) then
        f["self_broadcast"](self, { message = "Hi" }, th)
      else
        f["create_stage_dialog"](self, { sprite = "--self", text = "这么爱改时间？Ban了" }, th)
      end
  end)
  rt.on(e_021f6559_beec_4abc_8013_8a0b6b6125ee, "on_running_group_activated", {}, function(th, self)
      if V.bool(f["logic_negate"](self, { logic = f["variables_get"](self, { variable = "d60f5cc4-3fe1-4a2f-b9d6-04602006c007" }, th) }, th)) then
        f["list_append"](self, { list = "5d99aa00-43fe-4471-b284-639286a8dc0e", list_item_value = 1 }, th)
        f["list_append"](self, { list = "77f2cb30-b659-4351-b04d-0f5ff168bf58", list_item_value = 2 }, th)
        f["list_append"](self, { list = "6a4619d9-d26e-4ea0-a4f6-6e7b2dd396e9", list_item_value = 3 }, th)
        th:call_proc(proc_f88f9ad7_6f39_4deb_a9e9_c2f0e242cb39, self, 1, 0)
        f["variables_set"](self, { value = 1, variable = "d60f5cc4-3fe1-4a2f-b9d6-04602006c007" }, th)
      end
      while true do
        f["variables_set"](self, { value = 100, variable = "702f182e-81cb-4eb3-b3ea-ae0d954ded36" }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 logo --------
  rt.on(e_14d734a5_daa3_4a14_8ccf_5a01dd522300, "self_listen", { message = "Hi" }, function(th, self)
      f["self_appear"](self, { value = "appear" }, th)
      while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "702f182e-81cb-4eb3-b3ea-ae0d954ded36" }, th), B = 100, OP = "EQ" }, th)) do
        if th:iter_n() then break end
      end
      f["set_sprite_style"](self, { style_id = "07996e2d-df03-4759-81e9-040ab57d838c" }, th)
      f["self_gradually_show_hide"](self, { show_hide = "show", time = 0.1 }, th)
      do
        local _from_n11, _to_n11 = tonumber(1), tonumber(100)
        if _from_n11 ~= _from_n11 or _to_n11 ~= _to_n11 then
          -- NaN from/to: official warning; no iterations
        else
          if _from_n11 <= _to_n11 then _from_n11 = math.ceil(_from_n11); if _from_n11 > _to_n11 then _from_n11 = _to_n11 + 1 end
          else _from_n11 = math.floor(_from_n11); if _from_n11 < _to_n11 then _from_n11 = _to_n11 - 1 end end
          local _by_n11 = 1
          if _by_n11 == nil then _by_n11 = 1 end
          _by_n11 = tonumber(_by_n11)
          if _by_n11 == nil or _by_n11 ~= _by_n11 or _by_n11 <= 0 then _by_n11 = 0 else _by_n11 = math.abs(math.floor(_by_n11 + 0.5)) end
          if _by_n11 > 0 then
            local _p_n11 = _from_n11
            while (_from_n11 <= _to_n11 and _p_n11 <= _to_n11) or (_from_n11 > _to_n11 and _p_n11 >= _to_n11) do
              local _i_n11 = _p_n11
              th:push_param(_p_n11)
            f["set_scale"](self, { scale = (th:call_proc(proc_acdca734_97cd_4807_947f_a3e65cd9c8b4, self, 30, 100, "渐缓n次", 10, _p_n11)) }, th)
            f["self_move_to"](self, { x = (th:call_proc(proc_e1d938c6_3ee5_4249_8fe7_18aa24c7d122, self, 117, 0, "渐缓n次", 5, _p_n11)), y = (th:call_proc(proc_e1d938c6_3ee5_4249_8fe7_18aa24c7d122, self, -2, 0, "渐缓n次", 5, _p_n11)) }, th)
              th:pop_param()
              _p_n11 = _p_n11 + _by_n11
              if th:iter_n() then break end
            end
          end
        end
      end
      f["set_screen_transition"](self, { type = "fade_in_out" }, th)
      f["switch_to_screen"](self, { screen_id = "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, th)
  end)
  -- -------- 角色 排行榜 --------
  rt.on(e_914c4d45_c6e4_424b_aff5_ad3a824b6a1b, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.02, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = -550, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 3, type = "divide" }, th) }, th)
        else
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.02, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = -350, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 3, type = "divide" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_914c4d45_c6e4_424b_aff5_ad3a824b6a1b, "sprite_on_tap", { sprite = "--self", type = "mouse_up" }, function(th, self)
      f["ask_and_choose"](self, { CHOICE0 = "总分", CHOICE1 = "PP", question = "" }, th)
      if V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, { type = "index" }, th), B = 1, OP = "EQ" }, th)) then
        f["show_hide_ranking"](self, { ranking = "94f8b950-18d4-404d-b147-f5310d14461d", show_hide = "show" }, th)
      else
        f["show_hide_ranking"](self, { ranking = "4c96c524-f17d-4439-bd49-abe3c754ac00", show_hide = "show" }, th)
      end
  end)
  rt.on(e_914c4d45_c6e4_424b_aff5_ad3a824b6a1b, "on_running_group_activated", {}, function(th, self)
      th:call_proc(proc_fde38e22_9be0_4d77_8605_5a4e38f5270c, self)
  end)
  rt.on(e_914c4d45_c6e4_424b_aff5_ad3a824b6a1b, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.1 }, th)
        else
          f["self_gradually_show_hide"](self, { show_hide = "show", time = 0.1 }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_914c4d45_c6e4_424b_aff5_ad3a824b6a1b, "on_running_group_activated", {}, function(th, self)
      while true do
        f["set_sprite_style"](self, { style_id = f["variables_get"](self, { variable = "a0f605c5-1fe0-49ee-8724-d148ae1a3197" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 雪 --------
  rt.on(e_95aa8ac8_def0_4f3e_9a85_4f6ac3719f4c, "on_running_group_activated", {}, function(th, self)
      f["variables_set"](self, { value = f["random_num"](self, { A = 0, B = 2 }, th), variable = "a55912d4-c043-4ff3-9840-2ca7e0e0e184" }, th)
      f["variables_set"](self, { value = f["variables_get"](self, { variable = "a55912d4-c043-4ff3-9840-2ca7e0e0e184" }, th), variable = "4f521286-82c5-4924-ac41-22152513b097" }, th)
      while true do
        f["self_set_position_x"](self, { value = f["random_num"](self, { A = -425, B = 425 }, th) }, th)
        f["mirror"](self, { sprite = "--self" }, th)
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "a55912d4-c043-4ff3-9840-2ca7e0e0e184" }, th), B = 0, OP = "EQ" }, th)) then
          f["list_append"](self, { list = "e5b0fecb-2763-4742-946e-c2a0fecbec9f", list_item_value = f["random_num"](self, { A = -45, B = 0 }, th) }, th)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "a55912d4-c043-4ff3-9840-2ca7e0e0e184" }, th), B = 1, OP = "EQ" }, th)) then
          f["list_append"](self, { list = "e5b0fecb-2763-4742-946e-c2a0fecbec9f", list_item_value = f["random_num"](self, { A = -15, B = 15 }, th) }, th)
        else
          f["list_append"](self, { list = "e5b0fecb-2763-4742-946e-c2a0fecbec9f", list_item_value = f["random_num"](self, { A = 0, B = 45 }, th) }, th)
        end
        if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["get_time"](self, { time = "month" }, th), B = 11, OP = "GTE" }, th), B = f["logic_compare"](self, { A = f["get_time"](self, { time = "month" }, th), B = 2, OP = "LTE" }, th), type = "or" }, th)) then
          th:call_proc(proc_b81c7a0d_edae_4cce_b0bf_787193b1602c, self, f["random_num"](self, { A = 1, B = 3 }, th))
        else
          f["wait"](self, { time = 0.15 }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_95aa8ac8_def0_4f3e_9a85_4f6ac3719f4c, "start_as_a_mirror", {}, function(th, self)
      while true do
        if f["bump_into"](self, { sprite = "--self", sprite1 = "--edge_bottom" }, th) then break end
        if V.bool(f["math_number_property"](self, { num = f["get_current_clone_index"](self, {}, th), type = "COMPOSITE" }, th)) then
          f["self_change_coordinate_y"](self, { increase = "decrease", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "c73c5c69-2217-4d2b-a3b8-87c9aa01109c" }, th), B = 50, type = "divide" }, th), B = f["math_arithmetic"](self, { A = 60, B = f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th), type = "divide" }, th), type = "multiply" }, th) }, th)
        elseif V.bool(f["math_number_property"](self, { num = f["get_current_clone_index"](self, {}, th), type = "PRIME" }, th)) then
          f["self_change_coordinate_y"](self, { increase = "decrease", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 2, B = f["math_arithmetic"](self, { A = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "c73c5c69-2217-4d2b-a3b8-87c9aa01109c" }, th), B = 50, type = "divide" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = 60, B = f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th), type = "divide" }, th), type = "multiply" }, th) }, th)
        end
        f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 10, B = f["math_arithmetic"](self, { A = f["math_trig"](self, { num = f["list_item"](self, { item = "any", list = "e5b0fecb-2763-4742-946e-c2a0fecbec9f", list_index = f["get_current_clone_index"](self, {}, th) }, th), type = "sin" }, th), B = 0.2, type = "multiply" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["get_mouse_info"](self, { type = "x" }, th), B = 0.001, type = "multiply" }, th), type = "add" }, th) }, th)
        if th:iter_n() then break end
      end
      f["set_pen_layer"](self, { layer = "peak" }, th)
      f["image_stamp"](self, {}, th)
      f["dispose_clone"](self, {}, th)
  end)
  rt.on(e_95aa8ac8_def0_4f3e_9a85_4f6ac3719f4c, "on_running_group_activated", {}, function(th, self)
      while true do
        f["variables_set"](self, { value = f["random_num"](self, { A = 1, B = 2 }, th), variable = "e7736fb0-19dd-4f1d-87ac-5f9b736fa727" }, th)
        f["self_rotate"](self, { degrees = f["random_num"](self, { A = 3, B = 30 }, th) }, th)
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "e7736fb0-19dd-4f1d-87ac-5f9b736fa727" }, th), B = 1, OP = "EQ" }, th)) then
          if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["get_time"](self, { time = "month" }, th), B = 4, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["get_time"](self, { time = "date" }, th), B = 1, OP = "EQ" }, th), type = "and" }, th)) then
            f["self_text_effect_size"](self, { size = f["random_num"](self, { A = 24, B = 56 }, th) }, th)
            f["self_text_effect_text"](self, { text = "★" }, th)
          else
            f["self_text_effect_size"](self, { size = f["random_num"](self, { A = 12, B = 42 }, th) }, th)
            f["self_text_effect_text"](self, { text = "." }, th)
          end
        else
          if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["get_time"](self, { time = "month" }, th), B = 4, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["get_time"](self, { time = "date" }, th), B = 1, OP = "EQ" }, th), type = "and" }, th)) then
            f["self_text_effect_size"](self, { size = f["random_num"](self, { A = 24, B = 56 }, th) }, th)
            f["self_text_effect_text"](self, { text = "☆" }, th)
          else
            f["self_text_effect_size"](self, { size = f["random_num"](self, { A = 12, B = 56 }, th) }, th)
            f["self_text_effect_text"](self, { text = "、" }, th)
          end
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_95aa8ac8_def0_4f3e_9a85_4f6ac3719f4c, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["get_time"](self, { time = "month" }, th), B = 4, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["get_time"](self, { time = "date" }, th), B = 1, OP = "EQ" }, th), type = "and" }, th)) then
          f["self_text_effect_color"](self, { color = "#ffb8c2" }, th)
        else
          f["self_text_effect_color"](self, { color = "#ffffff" }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 退出 --------
  rt.on(e_27839e28_7a5d_400b_b8ad_1d0f58686fba, "on_running_group_activated", {}, function(th, self)
      f["self_appear"](self, { value = "appear" }, th)
      while true do
        while true do
          if f["logic_compare"](self, { A = f["variables_get"](self, { variable = "2aec488e-6f97-423a-87a0-c7c89991c802" }, th), B = 100, OP = "EQ" }, th) then break end
          f["self_set_effect"](self, { scope = "1", value = f["math_arithmetic"](self, { A = 100, B = f["variables_get"](self, { variable = "2aec488e-6f97-423a-87a0-c7c89991c802" }, th), type = "minus" }, th) }, th)
          if th:iter_n() then break end
        end
        while true do
          if f["logic_compare"](self, { A = f["math_round"](self, { num = f["effect_of_sprite"](self, { effect = "2", sprite = "--self" }, th), type = "round" }, th), B = 0, OP = "EQ" }, th) then break end
          f["self_change_effect"](self, { increase = "increase", scope = "2", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 0, B = f["effect_of_sprite"](self, { effect = "2", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
          if th:iter_n() then break end
        end
        f["restart"](self, {}, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_27839e28_7a5d_400b_b8ad_1d0f58686fba, "on_keydown", { key = "39", type = "down" }, function(th, self)
      f["change_variables"](self, { method = "increase", value = 5, variable = "2aec488e-6f97-423a-87a0-c7c89991c802" }, th)
  end)
  rt.on(e_27839e28_7a5d_400b_b8ad_1d0f58686fba, "on_keydown", { key = "39", type = "up" }, function(th, self)
      f["variables_set"](self, { value = 0, variable = "2aec488e-6f97-423a-87a0-c7c89991c802" }, th)
  end)
  -- -------- 角色 鸣谢打印 --------
  rt.on(e_f05fb825_9496_4164_b7e2_7b7511774512, "on_running_group_activated", {}, function(th, self)
      f["delete_list_item"](self, { item = "all", list = "230adc73-6e89-4cdb-be49-6fbde4dce1da" }, th)
      do
        local _from_n12, _to_n12 = tonumber(1), tonumber(f["list_length"](self, { list = "a8005045-a1e7-48b8-8eda-07b7fab54ad3" }, th))
        if _from_n12 ~= _from_n12 or _to_n12 ~= _to_n12 then
          -- NaN from/to: official warning; no iterations
        else
          if _from_n12 <= _to_n12 then _from_n12 = math.ceil(_from_n12); if _from_n12 > _to_n12 then _from_n12 = _to_n12 + 1 end
          else _from_n12 = math.floor(_from_n12); if _from_n12 < _to_n12 then _from_n12 = _to_n12 - 1 end end
          local _by_n12 = 1
          if _by_n12 == nil then _by_n12 = 1 end
          _by_n12 = tonumber(_by_n12)
          if _by_n12 == nil or _by_n12 ~= _by_n12 or _by_n12 <= 0 then _by_n12 = 0 else _by_n12 = math.abs(math.floor(_by_n12 + 0.5)) end
          if _by_n12 > 0 then
            local _p_n12 = _from_n12
            while (_from_n12 <= _to_n12 and _p_n12 <= _to_n12) or (_from_n12 > _to_n12 and _p_n12 >= _to_n12) do
              local _i_n12 = _p_n12
              th:push_param(_p_n12)
            f["variables_set"](self, { value = _p_n12, variable = "c43f0a60-ac94-4431-8b8f-287e139391b5" }, th)
            f["mirror"](self, { sprite = "--self" }, th)
              th:pop_param()
              _p_n12 = _p_n12 + _by_n12
              if th:iter_n() then break end
            end
          end
        end
      end
  end)
  rt.on(e_f05fb825_9496_4164_b7e2_7b7511774512, "start_as_a_mirror", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["text_select"](self, { start_index = 1, text = f["list_item"](self, { item = "any", list = "a8005045-a1e7-48b8-8eda-07b7fab54ad3", list_index = f["variables_get"](self, { variable = "c43f0a60-ac94-4431-8b8f-287e139391b5" }, th) }, th) }, th), B = "$", OP = "EQ" }, th)) then
          f["self_text_effect_size"](self, { size = 36 }, th)
          f["self_text_effect_text"](self, { text = f["text_select"](self, { end_index = f["text_length"](self, { text = f["list_item"](self, { item = "any", list = "a8005045-a1e7-48b8-8eda-07b7fab54ad3", list_index = f["variables_get"](self, { variable = "c43f0a60-ac94-4431-8b8f-287e139391b5" }, th) }, th) }, th), start_index = 2, text = f["list_item"](self, { item = "any", list = "a8005045-a1e7-48b8-8eda-07b7fab54ad3", list_index = f["variables_get"](self, { variable = "c43f0a60-ac94-4431-8b8f-287e139391b5" }, th) }, th) }, th) }, th)
        else
          f["self_text_effect_size"](self, { size = 24 }, th)
          f["self_text_effect_text"](self, { text = f["list_item"](self, { item = "any", list = "a8005045-a1e7-48b8-8eda-07b7fab54ad3", list_index = f["variables_get"](self, { variable = "c43f0a60-ac94-4431-8b8f-287e139391b5" }, th) }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_f05fb825_9496_4164_b7e2_7b7511774512, "start_as_a_mirror", {}, function(th, self)
      f["self_move_to"](self, { x = 0, y = f["math_arithmetic"](self, { A = -350, B = f["math_arithmetic"](self, { A = 50, B = f["get_current_clone_index"](self, {}, th), type = "multiply" }, th), type = "minus" }, th) }, th)
      while true do
        f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = 1, B = f["math_arithmetic"](self, { A = 60, B = f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th), type = "divide" }, th), type = "multiply" }, th) }, th)
        if V.bool(f["logic_compare"](self, { A = f["get_current_clone_index"](self, {}, th), B = f["list_length"](self, { list = "a8005045-a1e7-48b8-8eda-07b7fab54ad3" }, th), OP = "EQ" }, th)) then
          if V.bool(f["logic_compare"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), B = 0, OP = "GTE" }, th)) then
            f["self_move_to"](self, { x = 0, y = 0 }, th)
            f["wait"](self, { time = 7.5 }, th)
            f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.5 }, th)
            f["set_screen_transition"](self, { direction = "down", type = "slide" }, th)
            f["switch_to_screen"](self, { screen_id = "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, th)
            f["dispose_clone"](self, {}, th)
          end
        elseif V.bool(f["out_of_boundary"](self, { boundary = "2" }, th)) then
          f["dispose_clone"](self, {}, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_f05fb825_9496_4164_b7e2_7b7511774512, "sprite_on_tap", { sprite = "--screen", type = "mouse_click" }, function(th, self)
      f["set_screen_transition"](self, { direction = "down", type = "slide" }, th)
      f["switch_to_screen"](self, { screen_id = "6c9fdf0c-4483-4cd6-b886-c059b7c2b58f" }, th)
  end)
  -- -------- 角色 涟漪 --------
  rt.on(e_346d958e_5f8c_4eb4_9b8b_368fa49d5703, "sprite_on_tap", { sprite = "--screen", type = "mouse_down" }, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["get_orientation"](self, { target = "x" }, th), B = 0, OP = "EQ" }, th)) then
        if V.bool(f["logic_compare"](self, { A = f["get_current_clone_index"](self, {}, th), B = 0, OP = "EQ" }, th)) then
          f["self_move_specify"](self, { sprite = "--mouse" }, th)
          f["mirror"](self, { sprite = "--self" }, th)
        end
      end
      while not V.bool(f["mouse_down"](self, { sprite = "--screen", type = "up" }, th)) do
        if th:iter_n() then break end
      end
  end)
  rt.on(e_346d958e_5f8c_4eb4_9b8b_368fa49d5703, "start_as_a_mirror", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      f["variables_set"](self, { value = 5, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
      if V.bool(f["logic_operation"](self, { A = f["logic_negate"](self, { logic = f["mouse_down"](self, { sprite = "--screen", type = "down" }, th) }, th), B = f["logic_negate"](self, { logic = f["bump_into"](self, { sprite = "camp_red", sprite1 = "--mouse" }, th) }, th), type = "or" }, th)) then
        f["dispose_clone"](self, {}, th)
      else
        f["self_appear"](self, { value = "appear" }, th)
        f["set_scale"](self, { scale = 1 }, th)
        f["self_set_effect"](self, { scope = "1", value = 75 }, th)
        while true do
          if V.bool(f["mouse_down"](self, { sprite = "--screen", type = "down" }, th)) then
            if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "881b7c03-ac25-4adb-afdf-b2a09908c7a9" }, th), B = 0, OP = "EQ" }, th)) then
              f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "41ba8271-f9f4-4a34-a1af-6470409c7763" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
              f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 0, B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
              f["change_variables"](self, { method = "increase", value = 0.5, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
              f["self_change_scale"](self, { increase = "increase", scale = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = f["script_variables_value"](self, { TEXT = "a" }, th), type = "divide" }, th) }, th)
            else
              f["dispose_clone"](self, {}, th)
            end
          else
            f["dispose_clone"](self, {}, th)
          end
          if th:iter_n() then break end
        end
      end
  end)
  rt.on(e_346d958e_5f8c_4eb4_9b8b_368fa49d5703, "start_as_a_mirror", {}, function(th, self)
      while true do
        if V.bool(f["logic_operation"](self, { A = f["logic_negate"](self, { logic = f["mouse_down"](self, { sprite = "--screen", type = "down" }, th) }, th), B = f["logic_negate"](self, { logic = f["bump_into"](self, { sprite = "camp_red", sprite1 = "--mouse" }, th) }, th), type = "or" }, th)) then
          f["variables_set"](self, { value = 1, variable = "881b7c03-ac25-4adb-afdf-b2a09908c7a9" }, th)
          if V.bool(f["logic_compare"](self, { A = f["math_round"](self, { num = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "round" }, th), B = 100, OP = "EQ" }, th)) then
            f["dispose_clone"](self, {}, th)
          end
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_346d958e_5f8c_4eb4_9b8b_368fa49d5703, "start_as_a_mirror", {}, function(th, self)
      while true do
        if f["logic_compare"](self, { A = f["style_of_sprite"](self, { sprite = "--self" }, th), B = 9, OP = "EQ" }, th) then break end
        f["self_prev_next_style"](self, { prev_next = "next" }, th)
        f["wait"](self, { time = 0 }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_346d958e_5f8c_4eb4_9b8b_368fa49d5703, "start_as_a_mirror", {}, function(th, self)
      f["self_move_specify"](self, { sprite = "--mouse" }, th)
      while true do
        if V.bool(f["bump_into"](self, { sprite = "--self", sprite1 = "45c8d7e3-e13f-475b-a885-98a2aff839b7" }, th)) then
          f["variables_set"](self, { value = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "45c8d7e3-e13f-475b-a885-98a2aff839b7" }, th), variable = "41ba8271-f9f4-4a34-a1af-6470409c7763" }, th)
        elseif V.bool(f["bump_into"](self, { sprite = "--self", sprite1 = "0c8dc1eb-36a6-4968-a6f0-02b0574215f9" }, th)) then
          f["variables_set"](self, { value = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "0c8dc1eb-36a6-4968-a6f0-02b0574215f9" }, th), variable = "41ba8271-f9f4-4a34-a1af-6470409c7763" }, th)
        elseif V.bool(f["bump_into"](self, { sprite = "--self", sprite1 = "c1af39b1-f7d2-4a95-bc40-37cd94c16816" }, th)) then
          f["variables_set"](self, { value = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "c1af39b1-f7d2-4a95-bc40-37cd94c16816" }, th), variable = "41ba8271-f9f4-4a34-a1af-6470409c7763" }, th)
        elseif V.bool(f["bump_into"](self, { sprite = "--self", sprite1 = "e1f00058-a341-4755-ad37-63e9d70b4610" }, th)) then
          f["variables_set"](self, { value = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "e1f00058-a341-4755-ad37-63e9d70b4610" }, th), variable = "41ba8271-f9f4-4a34-a1af-6470409c7763" }, th)
        else
          f["dispose_clone"](self, {}, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 滑动条底 --------
  rt.on(e_4fc1f2cb_2dc5_4e47_a2c8_ab07519da1d1, "on_running_group_activated", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      while true do
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = 0.7, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        if V.bool(f["bump_into"](self, { sprite = "--self", sprite1 = "--mouse" }, th)) then
          f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 0, B = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "minus" }, th), B = 0.5, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
          f["set_sprite_style"](self, { style_id = "4a80cb4b-70cd-4985-9459-f4f6b72136d1" }, th)
        else
          f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 25, B = f["effect_of_sprite"](self, { effect = "1", sprite = "--self" }, th), type = "minus" }, th), B = 0.5, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
          f["set_sprite_style"](self, { style_id = "4b7d5c12-ad81-46a7-9394-64ac777b6293" }, th)
        end
        f["self_change_effect"](self, { increase = "increase", scope = "1", value = f["script_variables_value"](self, { TEXT = "a" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_4fc1f2cb_2dc5_4e47_a2c8_ab07519da1d1, "on_running_group_activated", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      while true do
        if f["logic_compare"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), B = 425, OP = "EQ" }, th) then break end
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = 0.7, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 425, B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.5, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        f["self_change_coordinate_x"](self, { increase = "increase", value = f["script_variables_value"](self, { TEXT = "a" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 滑动球 --------
  rt.on(e_fa225791_3758_4dc6_933f_fb2de01de032, "on_running_group_activated", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      while true do
        if f["logic_compare"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), B = 425, OP = "EQ" }, th) then break end
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = 0.7, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 425, B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.5, type = "multiply" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        f["self_change_coordinate_x"](self, { increase = "increase", value = f["script_variables_value"](self, { TEXT = "a" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_fa225791_3758_4dc6_933f_fb2de01de032, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["mouse_down"](self, { sprite = "--self", type = "down" }, th)) then
          f["variables_set"](self, { value = 1, variable = "917e09a7-2fc4-4a48-b3c3-6d8e11cedaeb" }, th)
          f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["get_mouse_info"](self, { type = "y" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_fa225791_3758_4dc6_933f_fb2de01de032, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "917e09a7-2fc4-4a48-b3c3-6d8e11cedaeb" }, th), B = 1, OP = "EQ" }, th)) then
          if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "3ef85efc-ea88-45ed-b6f7-8126cb76477e" }, th), B = 0, OP = "EQ" }, th)) then
            f["set_sprite_style"](self, { style_id = "7743572e-8c15-4740-81f4-459c76a83e29" }, th)
            f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_length"](self, { list = "a5d5ee23-9522-4cb9-a849-6421bd7a01e2" }, th), B = 1, type = "minus" }, th), B = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), B = 250, type = "add" }, th), B = 500, type = "divide" }, th), B = f["math_arithmetic"](self, { A = f["list_length"](self, { list = "a5d5ee23-9522-4cb9-a849-6421bd7a01e2" }, th), B = 1, type = "minus" }, th), type = "multiply" }, th), type = "round" }, th), type = "minus" }, th), variable = "3a064750-07fd-4c4a-95a2-271c3b091da8" }, th)
          else
            f["set_sprite_style"](self, { style_id = "c4cd5de6-f7a9-451b-a0b4-34bd78f63388" }, th)
            f["variables_set"](self, { value = f["math_arithmetic"](self, { A = 5, B = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), B = 250, type = "add" }, th), B = 500, type = "divide" }, th), B = 5, type = "multiply" }, th), type = "round" }, th), type = "minus" }, th), variable = "71676bd4-3fa4-473b-aa5b-97f49d44528a" }, th)
          end
        else
          if V.bool(f["logic_operation"](self, { A = f["check_key"](self, { key = "87", type = "down" }, th), B = f["check_key"](self, { key = "38", type = "down" }, th), type = "or" }, th)) then
            f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 25, B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
          elseif V.bool(f["logic_operation"](self, { A = f["check_key"](self, { key = "83", type = "down" }, th), B = f["check_key"](self, { key = "40", type = "down" }, th), type = "or" }, th)) then
            f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = -25, B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
          else
            f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 0, B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
          end
        end
        if V.bool(f["logic_compare"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), B = 250, OP = "GT" }, th)) then
          f["self_set_position_y"](self, { value = 250 }, th)
        elseif V.bool(f["logic_compare"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), B = -250, OP = "LT" }, th)) then
          f["self_set_position_y"](self, { value = -250 }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_fa225791_3758_4dc6_933f_fb2de01de032, "on_running_group_activated", {}, function(th, self)
      th:call_proc(proc_b40a764c_79a5_40e4_ba26_f77f45c7a502, self, 100, 105, 95, nil)
  end)
  rt.on(e_fa225791_3758_4dc6_933f_fb2de01de032, "sprite_on_tap", { sprite = "--self", type = "mouse_click" }, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "3ef85efc-ea88-45ed-b6f7-8126cb76477e" }, th), B = 0, OP = "EQ" }, th)) then
        f["variables_set"](self, { value = 1, variable = "3ef85efc-ea88-45ed-b6f7-8126cb76477e" }, th)
      else
        f["variables_set"](self, { value = 0, variable = "3ef85efc-ea88-45ed-b6f7-8126cb76477e" }, th)
      end
  end)
  -- -------- 角色 在线人数 --------
  rt.on(e_d268e9fd_3f9b_423a_8130_0e2281e35eeb, "on_running_group_activated", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, PARAMS3 = nil, PARAMS4 = nil, PARAMS5 = nil, PARAMS6 = nil, name = "d", names = { "d", "h", "m", "s", "uname", "uid", "uscore" } }, th)
      while true do
        f["wait"](self, { time = 1.9 }, th)
        f["delete_list_item"](self, { item = "all", list = "b8ef25ae-109f-42d5-80fd-14a73270ba6e" }, th)
        f["delete_list_item"](self, { item = "all", list = "5f4b09b8-8a57-4d1e-87b3-f71d8fb5563d" }, th)
        f["delete_list_item"](self, { item = "all", list = "7366bfe4-8f93-48d5-9111-5b8e77da869c" }, th)
        f["variables_set"](self, { value = 0, variable = "6d4177f9-c6ba-4ad1-9b05-602c8e323c17" }, th)
        th:warp_enter()
        do
          local _from_n13, _to_n13 = tonumber(1), tonumber(100)
          if _from_n13 ~= _from_n13 or _to_n13 ~= _to_n13 then
            -- NaN from/to: official warning; no iterations
          else
            if _from_n13 <= _to_n13 then _from_n13 = math.ceil(_from_n13); if _from_n13 > _to_n13 then _from_n13 = _to_n13 + 1 end
            else _from_n13 = math.floor(_from_n13); if _from_n13 < _to_n13 then _from_n13 = _to_n13 - 1 end end
            local _by_n13 = 1
            if _by_n13 == nil then _by_n13 = 1 end
            _by_n13 = tonumber(_by_n13)
            if _by_n13 == nil or _by_n13 ~= _by_n13 or _by_n13 <= 0 then _by_n13 = 0 else _by_n13 = math.abs(math.floor(_by_n13 + 0.5)) end
            if _by_n13 > 0 then
              local _p_n13 = _from_n13
              while (_from_n13 <= _to_n13 and _p_n13 <= _to_n13) or (_from_n13 > _to_n13 and _p_n13 >= _to_n13) do
                local _i_n13 = _p_n13
                th:push_param(_p_n13)
              if V.bool(f["logic_compare"](self, { A = f["text_join"](self, { ADD0 = f["user_info_of_th"](self, { order = _p_n13, ranking = "32d2e519-0937-4640-965a-45a087e66bc0", type = "score" }, th) }, th), B = "无记录", OP = "EQ" }, th)) then
                th:pop_param()
                break
              end
              f["variables_set"](self, { value = f["user_info_of_th"](self, { order = _p_n13, ranking = "32d2e519-0937-4640-965a-45a087e66bc0", type = "username" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"uname\"}" }, th)
              f["variables_set"](self, { value = f["user_info_of_th"](self, { order = _p_n13, ranking = "32d2e519-0937-4640-965a-45a087e66bc0", type = "userId" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"uid\"}" }, th)
              f["variables_set"](self, { value = f["user_info_of_th"](self, { order = _p_n13, ranking = "32d2e519-0937-4640-965a-45a087e66bc0", type = "score" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"uscore\"}" }, th)
              f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "6e7bfb18-fe24-4d8b-962d-127254283c9d" }, th), B = f["script_variables_value"](self, { TEXT = "uscore" }, th), type = "minus" }, th), variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th)
              f["variables_set"](self, { value = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th), B = 86400, type = "divide" }, th), type = "round_down" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"d\"}" }, th)
              f["variables_set"](self, { value = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_modulo"](self, { A = f["variables_get"](self, { variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th), B = 86400 }, th), B = 3600, type = "divide" }, th), type = "round_down" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"h\"}" }, th)
              f["variables_set"](self, { value = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_modulo"](self, { A = f["variables_get"](self, { variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th), B = 3600 }, th), B = 60, type = "divide" }, th), type = "round_down" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"m\"}" }, th)
              f["variables_set"](self, { value = f["math_modulo"](self, { A = f["variables_get"](self, { variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th), B = 60 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"s\"}" }, th)
              f["variables_set"](self, { value = f["temporary_list"](self, { ITEM0 = f["script_variables_value"](self, { TEXT = "d" }, th), ITEM1 = f["script_variables_value"](self, { TEXT = "h" }, th), ITEM2 = f["script_variables_value"](self, { TEXT = "m" }, th), ITEM3 = f["script_variables_value"](self, { TEXT = "s" }, th) }, th), variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th)
              if V.bool(f["logic_compare"](self, { A = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "6e7bfb18-fe24-4d8b-962d-127254283c9d" }, th), B = f["script_variables_value"](self, { TEXT = "uscore" }, th), type = "minus" }, th), type = "1" }, th), B = 2.1, OP = "LTE" }, th)) then
                f["list_append"](self, { list = "b8ef25ae-109f-42d5-80fd-14a73270ba6e", list_item_value = f["temporary_list"](self, { ITEM0 = "在线", ITEM1 = f["script_variables_value"](self, { TEXT = "uname" }, th), ITEM2 = f["script_variables_value"](self, { TEXT = "uid" }, th), ITEM3 = f["variables_get"](self, { variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th) }, th) }, th)
                f["list_append"](self, { list = "5f4b09b8-8a57-4d1e-87b3-f71d8fb5563d", list_item_value = f["text_join"](self, { ADD0 = f["script_variables_value"](self, { TEXT = "uname" }, th), ADD1 = ",", ADD2 = f["script_variables_value"](self, { TEXT = "uid" }, th) }, th) }, th)
                f["change_variables"](self, { method = "increase", value = 1, variable = "6d4177f9-c6ba-4ad1-9b05-602c8e323c17" }, th)
                if V.bool(f["logic_negate"](self, { logic = f["list_is_exist"](self, { list = "253775dc-1fbb-4102-9046-9616d6e37f7a", list_item_value = f["text_join"](self, { ADD0 = f["script_variables_value"](self, { TEXT = "uname" }, th), ADD1 = ",", ADD2 = f["script_variables_value"](self, { TEXT = "uid" }, th) }, th) }, th) }, th)) then
                  f["list_append"](self, { list = "7366bfe4-8f93-48d5-9111-5b8e77da869c", list_item_value = f["text_join"](self, { ADD0 = f["script_variables_value"](self, { TEXT = "uname" }, th), ADD1 = ",", ADD2 = f["script_variables_value"](self, { TEXT = "uid" }, th) }, th) }, th)
                end
              else
                f["list_append"](self, { list = "b8ef25ae-109f-42d5-80fd-14a73270ba6e", list_item_value = f["temporary_list"](self, { ITEM0 = "离线", ITEM1 = f["script_variables_value"](self, { TEXT = "uname" }, th), ITEM2 = f["script_variables_value"](self, { TEXT = "uid" }, th), ITEM3 = f["variables_get"](self, { variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th) }, th) }, th)
              end
                th:pop_param()
                _p_n13 = _p_n13 + _by_n13
                if th:iter_w() then break end
              end
            end
          end
        end
        th:warp_exit()
        f["variables_set"](self, { value = f["variables_get"](self, { variable = "6d4177f9-c6ba-4ad1-9b05-602c8e323c17" }, th), variable = "1c7bff85-38c5-4cbd-928a-40b3f2b56836" }, th)
        f["list_copy"](self, { list = "b8ef25ae-109f-42d5-80fd-14a73270ba6e", target_list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc" }, th)
        f["list_copy"](self, { list = "5f4b09b8-8a57-4d1e-87b3-f71d8fb5563d", target_list = "253775dc-1fbb-4102-9046-9616d6e37f7a" }, th)
        f["list_copy"](self, { list = "7366bfe4-8f93-48d5-9111-5b8e77da869c", target_list = "a4be6507-0f07-4ea1-85e0-7f24ca32a712" }, th)
        f["self_broadcast"](self, { message = "在线更新" }, th)
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = (th:call_proc(proc_82177fc4_9516_4f2c_90d5_a6b8c584e3f8, self, nil, nil, nil, nil, nil)), B = 86400, type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["get_time"](self, { time = "hour" }, th), B = 3600, type = "multiply" }, th), type = "add" }, th), B = f["math_arithmetic"](self, { A = f["get_time"](self, { time = "minute" }, th), B = 60, type = "multiply" }, th), type = "add" }, th), B = f["get_time"](self, { time = "second" }, th), type = "add" }, th), variable = "6e7bfb18-fe24-4d8b-962d-127254283c9d" }, th)
        f["update_ranking"](self, { ranking = "32d2e519-0937-4640-965a-45a087e66bc0", variable = "6e7bfb18-fe24-4d8b-962d-127254283c9d" }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 通知 --------
  rt.on(e_9e324a05_c70d_4b1b_927f_00f2ccccbd36, "start_as_a_mirror", {}, function(th, self)
      f["list_insert_value"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_index = 1, list_item_value = f["get_current_clone_index"](self, {}, th) }, th)
      f["set_width_height_scale"](self, { type = "height", value = 1 }, th)
      f["self_set_effect"](self, { scope = "2", value = 150 }, th)
      f["self_set_effect"](self, { scope = "0", value = f["random_num"](self, { A = 300, B = 359 }, th) }, th)
      while true do
        if f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["math_round"](self, { num = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "round" }, th), B = 300, OP = "EQ" }, th), B = f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["math_round"](self, { num = f["effect_of_sprite"](self, { effect = "2", sprite = "--self" }, th), type = "round" }, th), B = 100, OP = "EQ" }, th), B = f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["math_round"](self, { num = f["appearance_of_sprite"](self, { appearance = "height", sprite = "--self" }, th), type = "round" }, th), B = 100, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["math_round"](self, { num = f["effect_of_sprite"](self, { effect = "0", sprite = "--self" }, th), type = "round" }, th), B = 0, OP = "EQ" }, th), type = "and" }, th), type = "and" }, th), type = "and" }, th) then break end
        f["self_change_effect"](self, { increase = "increase", scope = "2", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = f["effect_of_sprite"](self, { effect = "2", sprite = "--self" }, th), type = "minus" }, th), B = 0.142857, type = "multiply" }, th) }, th)
        f["add_width_height_scale"](self, { increase = "increase", type = "height", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = f["appearance_of_sprite"](self, { appearance = "height", sprite = "--self" }, th), type = "minus" }, th), B = 0.153846, type = "multiply" }, th) }, th)
        f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 300, B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.142857, type = "multiply" }, th) }, th)
        f["self_change_effect"](self, { increase = "increase", scope = "0", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 0, B = f["effect_of_sprite"](self, { effect = "0", sprite = "--self" }, th), type = "minus" }, th), B = 0.142857, type = "multiply" }, th) }, th)
        if th:iter_n() then break end
      end
      f["wait"](self, { time = 10 }, th)
      if V.bool(f["logic_operation"](self, { A = f["logic_negate"](self, { logic = f["bump_into"](self, { sprite = "--self", sprite1 = "--mouse" }, th) }, th), B = f["list_is_exist"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th), type = "and" }, th)) then
        f["delete_list_item"](self, { item = "any", list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_index = f["list_index_of"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th) }, th)
        while true do
          if f["logic_compare"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), B = 600, OP = "EQ" }, th) then break end
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 600, B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.142857, type = "multiply" }, th) }, th)
          if th:iter_n() then break end
        end
        f["dispose_clone"](self, {}, th)
      else
        while not V.bool(f["logic_operation"](self, { A = f["logic_negate"](self, { logic = f["bump_into"](self, { sprite = "--self", sprite1 = "--mouse" }, th) }, th), B = f["list_is_exist"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th), type = "and" }, th)) do
          if th:iter_n() then break end
        end
        f["wait"](self, { time = 10 }, th)
        f["delete_list_item"](self, { item = "any", list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_index = f["list_index_of"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th) }, th)
        while true do
          if f["logic_compare"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), B = 600, OP = "EQ" }, th) then break end
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 600, B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.142857, type = "multiply" }, th) }, th)
          if th:iter_n() then break end
        end
        f["dispose_clone"](self, {}, th)
      end
  end)
  rt.on(e_9e324a05_c70d_4b1b_927f_00f2ccccbd36, "start_as_a_mirror", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      while true do
        if V.bool(f["list_is_exist"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th)) then
          f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_index_of"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th), B = 1, type = "minus" }, th), B = -140, type = "multiply" }, th), B = 210, type = "add" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
          f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 0.142857, type = "multiply" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_9e324a05_c70d_4b1b_927f_00f2ccccbd36, "on_keydown", { key = "65", type = "down" }, function(th, self)
      f["delete_list_item"](self, { item = "all", list = "e9353244-50bb-4a60-bce5-583c58f245f2" }, th)
      while not V.bool(f["check_key"](self, { key = "65", type = "up" }, th)) do
        if th:iter_n() then break end
      end
  end)
  rt.on(e_9e324a05_c70d_4b1b_927f_00f2ccccbd36, "when", { cond = function(th, self) return f["logic_operation"](self, { A = f["mouse_down"](self, { sprite = "--self", type = "click" }, th), B = f["logic_operation"](self, { A = f["check_key"](self, { key = "65", type = "down" }, th), B = f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), B = 250, OP = "LT" }, th), B = f["logic_negate"](self, { logic = f["mouse_down"](self, { sprite = "--self", type = "down" }, th) }, th), type = "and" }, th), type = "or" }, th), type = "or" }, th) end }, function(th, self)
      th:call_proc(proc_05dd2a79_15ed_4a28_a505_0e38db6bda32, self, nil, nil, nil)
  end)
  rt.on(e_9e324a05_c70d_4b1b_927f_00f2ccccbd36, "sprite_on_tap", { sprite = "--self", type = "mouse_down" }, function(th, self)
      if V.bool(f["list_is_exist"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th)) then
        f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["get_mouse_info"](self, { type = "x" }, th), B = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), B = 0.1, type = "multiply" }, th), type = "minus" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
      end
  end)
  rt.on(e_9e324a05_c70d_4b1b_927f_00f2ccccbd36, "start_as_a_mirror", {}, function(th, self)
      while true do
        if V.bool(f["list_is_exist"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th)) then
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 300, B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_9e324a05_c70d_4b1b_927f_00f2ccccbd36, "start_as_a_mirror", {}, function(th, self)
      th:call_proc(proc_c9cdb104_5f0e_4971_a8ae_fdf321b2aae0, self, 100, 103, 97, nil)
  end)
  rt.on(e_9e324a05_c70d_4b1b_927f_00f2ccccbd36, "self_listen", { message = "在线更新" }, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["get_current_clone_index"](self, {}, th), B = 0, OP = "EQ" }, th)) then
        if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = f["list_item"](self, { item = "any", list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc", list_index = 1 }, th) }, th), list_index = 2 }, th), B = f["username_get"](self, {}, th), OP = "NEQ" }, th)) then
          if V.bool(f["logic_negate"](self, { logic = f["list_is_exist"](self, { list = "6a6d0ee2-2fd4-42ca-b5d4-8c6484bc8750", list_item_value = f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = f["list_item"](self, { item = "any", list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc", list_index = 1 }, th) }, th), list_index = 3 }, th) }, th) }, th)) then
            f["mirror"](self, { sprite = "--self" }, th)
            f["mirror"](self, { sprite = "073a1839-8466-4838-80b4-69673d2c6588" }, th)
            f["list_append"](self, { list = "6a6d0ee2-2fd4-42ca-b5d4-8c6484bc8750", list_item_value = f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = f["list_item"](self, { item = "any", list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc", list_index = 1 }, th) }, th), list_index = 3 }, th) }, th)
          end
        end
      end
  end)
  -- -------- 角色 文本 --------
  rt.on(e_073a1839_8466_4838_80b4_69673d2c6588, "start_as_a_mirror", {}, function(th, self)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      f["self_text_effect_size"](self, { size = 24 }, th)
      f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = f["list_item"](self, { item = "any", list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc", list_index = 1 }, th) }, th), list_index = 2 }, th), ADD1 = "来了" }, th) }, th)
      while not V.bool(f["logic_negate"](self, { logic = f["list_is_exist"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th) }, th)) do
        if th:iter_n() then break end
      end
      f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.1 }, th)
      f["dispose_clone"](self, {}, th)
  end)
  rt.on(e_073a1839_8466_4838_80b4_69673d2c6588, "start_as_a_mirror", {}, function(th, self)
      while true do
        f["self_move_to"](self, { x = f["get_clone_index_property"](self, { attribute = "x", index = f["get_current_clone_index"](self, {}, th), sprite = "9e324a05-c70d-4b1b-927f-00f2ccccbd36" }, th), y = f["get_clone_index_property"](self, { attribute = "y", index = f["get_current_clone_index"](self, {}, th), sprite = "9e324a05-c70d-4b1b-927f-00f2ccccbd36" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 通知 --------
  rt.on(e_58825666_11bf_4755_abdf_62505a487764, "start_as_a_mirror", {}, function(th, self)
      f["list_insert_value"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_index = 1, list_item_value = f["get_current_clone_index"](self, {}, th) }, th)
      f["set_width_height_scale"](self, { type = "height", value = 1 }, th)
      f["self_set_effect"](self, { scope = "2", value = 150 }, th)
      f["self_set_effect"](self, { scope = "0", value = f["random_num"](self, { A = 300, B = 359 }, th) }, th)
      while true do
        if f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["math_round"](self, { num = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "round" }, th), B = 300, OP = "EQ" }, th), B = f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["math_round"](self, { num = f["effect_of_sprite"](self, { effect = "2", sprite = "--self" }, th), type = "round" }, th), B = 100, OP = "EQ" }, th), B = f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["math_round"](self, { num = f["appearance_of_sprite"](self, { appearance = "height", sprite = "--self" }, th), type = "round" }, th), B = 100, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["math_round"](self, { num = f["effect_of_sprite"](self, { effect = "0", sprite = "--self" }, th), type = "round" }, th), B = 0, OP = "EQ" }, th), type = "and" }, th), type = "and" }, th), type = "and" }, th) then break end
        f["self_change_effect"](self, { increase = "increase", scope = "2", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = f["effect_of_sprite"](self, { effect = "2", sprite = "--self" }, th), type = "minus" }, th), B = 7, type = "divide" }, th) }, th)
        f["add_width_height_scale"](self, { increase = "increase", type = "height", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = f["appearance_of_sprite"](self, { appearance = "height", sprite = "--self" }, th), type = "minus" }, th), B = 6.5, type = "divide" }, th) }, th)
        f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 300, B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 7, type = "divide" }, th) }, th)
        f["self_change_effect"](self, { increase = "increase", scope = "0", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 0, B = f["effect_of_sprite"](self, { effect = "0", sprite = "--self" }, th), type = "minus" }, th), B = 7, type = "divide" }, th) }, th)
        if th:iter_n() then break end
      end
      f["wait"](self, { time = 10 }, th)
      if V.bool(f["logic_operation"](self, { A = f["logic_negate"](self, { logic = f["bump_into"](self, { sprite = "--self", sprite1 = "--mouse" }, th) }, th), B = f["list_is_exist"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th), type = "and" }, th)) then
        f["delete_list_item"](self, { item = "any", list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_index = f["list_index_of"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th) }, th)
        while true do
          if f["logic_compare"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), B = 600, OP = "EQ" }, th) then break end
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 600, B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 7, type = "divide" }, th) }, th)
          if th:iter_n() then break end
        end
        f["dispose_clone"](self, {}, th)
      else
        while not V.bool(f["logic_operation"](self, { A = f["logic_negate"](self, { logic = f["bump_into"](self, { sprite = "--self", sprite1 = "--mouse" }, th) }, th), B = f["list_is_exist"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th), type = "and" }, th)) do
          if th:iter_n() then break end
        end
        f["wait"](self, { time = 10 }, th)
        f["delete_list_item"](self, { item = "any", list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_index = f["list_index_of"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th) }, th)
        while true do
          if f["logic_compare"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), B = 600, OP = "EQ" }, th) then break end
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 600, B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 7, type = "divide" }, th) }, th)
          if th:iter_n() then break end
        end
        f["dispose_clone"](self, {}, th)
      end
  end)
  rt.on(e_58825666_11bf_4755_abdf_62505a487764, "start_as_a_mirror", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      while true do
        if V.bool(f["list_is_exist"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th)) then
          f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_index_of"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th), B = 1, type = "minus" }, th), B = -140, type = "multiply" }, th), B = 210, type = "add" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
          f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 7, type = "divide" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_58825666_11bf_4755_abdf_62505a487764, "on_keydown", { key = "65", type = "down" }, function(th, self)
      f["delete_list_item"](self, { item = "all", list = "e9353244-50bb-4a60-bce5-583c58f245f2" }, th)
      while not V.bool(f["check_key"](self, { key = "65", type = "up" }, th)) do
        if th:iter_n() then break end
      end
  end)
  rt.on(e_58825666_11bf_4755_abdf_62505a487764, "when", { cond = function(th, self) return f["logic_operation"](self, { A = f["mouse_down"](self, { sprite = "--self", type = "click" }, th), B = f["logic_operation"](self, { A = f["check_key"](self, { key = "65", type = "down" }, th), B = f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), B = 250, OP = "LT" }, th), B = f["logic_negate"](self, { logic = f["mouse_down"](self, { sprite = "--self", type = "down" }, th) }, th), type = "and" }, th), type = "or" }, th), type = "or" }, th) end }, function(th, self)
      th:call_proc(proc_05dd2a79_15ed_4a28_a505_0e38db6bda32, self, nil, nil, nil)
  end)
  rt.on(e_58825666_11bf_4755_abdf_62505a487764, "sprite_on_tap", { sprite = "--self", type = "mouse_down" }, function(th, self)
      if V.bool(f["list_is_exist"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th)) then
        f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["get_mouse_info"](self, { type = "x" }, th), B = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), B = 10, type = "divide" }, th), type = "minus" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
      end
  end)
  rt.on(e_58825666_11bf_4755_abdf_62505a487764, "start_as_a_mirror", {}, function(th, self)
      while true do
        if V.bool(f["list_is_exist"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th)) then
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 300, B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 5, type = "divide" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_58825666_11bf_4755_abdf_62505a487764, "start_as_a_mirror", {}, function(th, self)
      th:call_proc(proc_c9cdb104_5f0e_4971_a8ae_fdf321b2aae0, self, 100, 103, 97, nil)
  end)
  rt.on(e_58825666_11bf_4755_abdf_62505a487764, "self_listen", { message = "在线更新" }, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["get_current_clone_index"](self, {}, th), B = 0, OP = "EQ" }, th)) then
        if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = f["list_item"](self, { item = "any", list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc", list_index = 1 }, th) }, th), list_index = 2 }, th), B = f["username_get"](self, {}, th), OP = "NEQ" }, th)) then
          if V.bool(f["logic_negate"](self, { logic = f["list_is_exist"](self, { list = "6a6d0ee2-2fd4-42ca-b5d4-8c6484bc8750", list_item_value = f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = f["list_item"](self, { item = "any", list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc", list_index = 1 }, th) }, th), list_index = 3 }, th) }, th) }, th)) then
            f["mirror"](self, { sprite = "--self" }, th)
            f["mirror"](self, { sprite = "e381eae0-9ac3-4265-bad8-7fa7acef65d8" }, th)
            f["list_append"](self, { list = "6a6d0ee2-2fd4-42ca-b5d4-8c6484bc8750", list_item_value = f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = f["list_item"](self, { item = "any", list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc", list_index = 1 }, th) }, th), list_index = 3 }, th) }, th)
          end
        end
      end
  end)
  -- -------- 角色 文本 --------
  rt.on(e_e381eae0_9ac3_4265_bad8_7fa7acef65d8, "start_as_a_mirror", {}, function(th, self)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      f["self_text_effect_size"](self, { size = 24 }, th)
      f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = f["list_item"](self, { item = "any", list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc", list_index = 1 }, th) }, th), list_index = 2 }, th), ADD1 = "来了" }, th) }, th)
      while not V.bool(f["logic_negate"](self, { logic = f["list_is_exist"](self, { list = "e9353244-50bb-4a60-bce5-583c58f245f2", list_item_value = f["get_current_clone_index"](self, {}, th) }, th) }, th)) do
        if th:iter_n() then break end
      end
      f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.1 }, th)
      f["dispose_clone"](self, {}, th)
  end)
  rt.on(e_e381eae0_9ac3_4265_bad8_7fa7acef65d8, "start_as_a_mirror", {}, function(th, self)
      while true do
        f["self_move_to"](self, { x = f["get_clone_index_property"](self, { attribute = "x", index = f["get_current_clone_index"](self, {}, th), sprite = "58825666-11bf-4755-abdf-62505a487764" }, th), y = f["get_clone_index_property"](self, { attribute = "y", index = f["get_current_clone_index"](self, {}, th), sprite = "58825666-11bf-4755-abdf-62505a487764" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 下一页 --------
  rt.on(e_069da2b2_28a0_4b9d_85c4_347e86276d6d, "self_listen", { message = "在线更新" }, function(th, self)
      f["self_appear"](self, { value = "appear" }, th)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f8aa9107-105b-4298-b1d2-4d4880b9d169" }, th), B = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["list_length"](self, { list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc" }, th), B = 9, type = "divide" }, th), type = "round_up" }, th), OP = "EQ" }, th)) then
        f["self_set_effect"](self, { scope = "2", value = 90 }, th)
      else
        f["self_set_effect"](self, { scope = "2", value = 100 }, th)
      end
  end)
  rt.on(e_069da2b2_28a0_4b9d_85c4_347e86276d6d, "sprite_on_tap", { sprite = "--self", type = "mouse_down" }, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f8aa9107-105b-4298-b1d2-4d4880b9d169" }, th), B = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["list_length"](self, { list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc" }, th), B = 9, type = "divide" }, th), type = "round_up" }, th), OP = "LT" }, th)) then
        f["self_set_effect"](self, { scope = "2", value = 95 }, th)
        while not V.bool(f["mouse_down"](self, { sprite = "--screen", type = "up" }, th)) do
          if th:iter_n() then break end
        end
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f8aa9107-105b-4298-b1d2-4d4880b9d169" }, th), B = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["list_length"](self, { list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc" }, th), B = 9, type = "divide" }, th), type = "round_up" }, th), OP = "EQ" }, th)) then
          f["self_set_effect"](self, { scope = "2", value = 90 }, th)
        else
          f["self_set_effect"](self, { scope = "2", value = 100 }, th)
        end
        f["change_variables"](self, { method = "increase", value = 1, variable = "f8aa9107-105b-4298-b1d2-4d4880b9d169" }, th)
        f["self_broadcast"](self, { message = "在线更新" }, th)
      end
  end)
  -- -------- 角色 上一页 --------
  rt.on(e_2f536974_1483_454f_87f6_5f367d4f7e25, "self_listen", { message = "在线更新" }, function(th, self)
      f["self_appear"](self, { value = "appear" }, th)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f8aa9107-105b-4298-b1d2-4d4880b9d169" }, th), B = 1, OP = "EQ" }, th)) then
        f["self_set_effect"](self, { scope = "2", value = 90 }, th)
      else
        f["self_set_effect"](self, { scope = "2", value = 100 }, th)
      end
  end)
  rt.on(e_2f536974_1483_454f_87f6_5f367d4f7e25, "sprite_on_tap", { sprite = "--self", type = "mouse_down" }, function(th, self)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f8aa9107-105b-4298-b1d2-4d4880b9d169" }, th), B = 1, OP = "GT" }, th)) then
        f["self_set_effect"](self, { scope = "2", value = 95 }, th)
        while not V.bool(f["mouse_down"](self, { sprite = "--screen", type = "up" }, th)) do
          if th:iter_n() then break end
        end
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "f8aa9107-105b-4298-b1d2-4d4880b9d169" }, th), B = 1, OP = "EQ" }, th)) then
          f["self_set_effect"](self, { scope = "2", value = 90 }, th)
        else
          f["self_set_effect"](self, { scope = "2", value = 100 }, th)
        end
        f["change_variables"](self, { method = "decrease", value = 1, variable = "f8aa9107-105b-4298-b1d2-4d4880b9d169" }, th)
        f["self_broadcast"](self, { message = "在线更新" }, th)
      end
  end)
  -- -------- 角色 在线人数 --------
  rt.on(e_e8ba2ded_bafb_4a7e_9da9_5c52099f73d1, "on_running_group_activated", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, PARAMS3 = nil, PARAMS4 = nil, PARAMS5 = nil, PARAMS6 = nil, name = "d", names = { "d", "h", "m", "s", "uname", "uid", "uscore" } }, th)
      while true do
        f["wait"](self, { time = 1.9 }, th)
        f["delete_list_item"](self, { item = "all", list = "b8ef25ae-109f-42d5-80fd-14a73270ba6e" }, th)
        f["delete_list_item"](self, { item = "all", list = "5f4b09b8-8a57-4d1e-87b3-f71d8fb5563d" }, th)
        f["delete_list_item"](self, { item = "all", list = "7366bfe4-8f93-48d5-9111-5b8e77da869c" }, th)
        f["variables_set"](self, { value = 0, variable = "6d4177f9-c6ba-4ad1-9b05-602c8e323c17" }, th)
        th:warp_enter()
        do
          local _from_n13, _to_n13 = tonumber(1), tonumber(100)
          if _from_n13 ~= _from_n13 or _to_n13 ~= _to_n13 then
            -- NaN from/to: official warning; no iterations
          else
            if _from_n13 <= _to_n13 then _from_n13 = math.ceil(_from_n13); if _from_n13 > _to_n13 then _from_n13 = _to_n13 + 1 end
            else _from_n13 = math.floor(_from_n13); if _from_n13 < _to_n13 then _from_n13 = _to_n13 - 1 end end
            local _by_n13 = 1
            if _by_n13 == nil then _by_n13 = 1 end
            _by_n13 = tonumber(_by_n13)
            if _by_n13 == nil or _by_n13 ~= _by_n13 or _by_n13 <= 0 then _by_n13 = 0 else _by_n13 = math.abs(math.floor(_by_n13 + 0.5)) end
            if _by_n13 > 0 then
              local _p_n13 = _from_n13
              while (_from_n13 <= _to_n13 and _p_n13 <= _to_n13) or (_from_n13 > _to_n13 and _p_n13 >= _to_n13) do
                local _i_n13 = _p_n13
                th:push_param(_p_n13)
              if V.bool(f["logic_compare"](self, { A = f["text_join"](self, { ADD0 = f["user_info_of_th"](self, { order = _p_n13, ranking = "32d2e519-0937-4640-965a-45a087e66bc0", type = "score" }, th) }, th), B = "无记录", OP = "EQ" }, th)) then
                th:pop_param()
                break
              end
              f["variables_set"](self, { value = f["user_info_of_th"](self, { order = _p_n13, ranking = "32d2e519-0937-4640-965a-45a087e66bc0", type = "username" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"uname\"}" }, th)
              f["variables_set"](self, { value = f["user_info_of_th"](self, { order = _p_n13, ranking = "32d2e519-0937-4640-965a-45a087e66bc0", type = "userId" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"uid\"}" }, th)
              f["variables_set"](self, { value = f["user_info_of_th"](self, { order = _p_n13, ranking = "32d2e519-0937-4640-965a-45a087e66bc0", type = "score" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"uscore\"}" }, th)
              f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "6e7bfb18-fe24-4d8b-962d-127254283c9d" }, th), B = f["script_variables_value"](self, { TEXT = "uscore" }, th), type = "minus" }, th), variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th)
              f["variables_set"](self, { value = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th), B = 86400, type = "divide" }, th), type = "round_down" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"d\"}" }, th)
              f["variables_set"](self, { value = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_modulo"](self, { A = f["variables_get"](self, { variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th), B = 86400 }, th), B = 3600, type = "divide" }, th), type = "round_down" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"h\"}" }, th)
              f["variables_set"](self, { value = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_modulo"](self, { A = f["variables_get"](self, { variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th), B = 3600 }, th), B = 60, type = "divide" }, th), type = "round_down" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"m\"}" }, th)
              f["variables_set"](self, { value = f["math_modulo"](self, { A = f["variables_get"](self, { variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th), B = 60 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"s\"}" }, th)
              f["variables_set"](self, { value = f["temporary_list"](self, { ITEM0 = f["script_variables_value"](self, { TEXT = "d" }, th), ITEM1 = f["script_variables_value"](self, { TEXT = "h" }, th), ITEM2 = f["script_variables_value"](self, { TEXT = "m" }, th), ITEM3 = f["script_variables_value"](self, { TEXT = "s" }, th) }, th), variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th)
              if V.bool(f["logic_compare"](self, { A = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "6e7bfb18-fe24-4d8b-962d-127254283c9d" }, th), B = f["script_variables_value"](self, { TEXT = "uscore" }, th), type = "minus" }, th), type = "1" }, th), B = 2.1, OP = "LTE" }, th)) then
                f["list_append"](self, { list = "b8ef25ae-109f-42d5-80fd-14a73270ba6e", list_item_value = f["temporary_list"](self, { ITEM0 = "在线", ITEM1 = f["script_variables_value"](self, { TEXT = "uname" }, th), ITEM2 = f["script_variables_value"](self, { TEXT = "uid" }, th), ITEM3 = f["variables_get"](self, { variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th) }, th) }, th)
                f["list_append"](self, { list = "5f4b09b8-8a57-4d1e-87b3-f71d8fb5563d", list_item_value = f["text_join"](self, { ADD0 = f["script_variables_value"](self, { TEXT = "uname" }, th), ADD1 = ",", ADD2 = f["script_variables_value"](self, { TEXT = "uid" }, th) }, th) }, th)
                f["change_variables"](self, { method = "increase", value = 1, variable = "6d4177f9-c6ba-4ad1-9b05-602c8e323c17" }, th)
                if V.bool(f["logic_negate"](self, { logic = f["list_is_exist"](self, { list = "253775dc-1fbb-4102-9046-9616d6e37f7a", list_item_value = f["text_join"](self, { ADD0 = f["script_variables_value"](self, { TEXT = "uname" }, th), ADD1 = ",", ADD2 = f["script_variables_value"](self, { TEXT = "uid" }, th) }, th) }, th) }, th)) then
                  f["list_append"](self, { list = "7366bfe4-8f93-48d5-9111-5b8e77da869c", list_item_value = f["text_join"](self, { ADD0 = f["script_variables_value"](self, { TEXT = "uname" }, th), ADD1 = ",", ADD2 = f["script_variables_value"](self, { TEXT = "uid" }, th) }, th) }, th)
                end
              else
                f["list_append"](self, { list = "b8ef25ae-109f-42d5-80fd-14a73270ba6e", list_item_value = f["temporary_list"](self, { ITEM0 = "离线", ITEM1 = f["script_variables_value"](self, { TEXT = "uname" }, th), ITEM2 = f["script_variables_value"](self, { TEXT = "uid" }, th), ITEM3 = f["variables_get"](self, { variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th) }, th) }, th)
              end
                th:pop_param()
                _p_n13 = _p_n13 + _by_n13
                if th:iter_w() then break end
              end
            end
          end
        end
        th:warp_exit()
        f["variables_set"](self, { value = f["variables_get"](self, { variable = "6d4177f9-c6ba-4ad1-9b05-602c8e323c17" }, th), variable = "1c7bff85-38c5-4cbd-928a-40b3f2b56836" }, th)
        f["list_copy"](self, { list = "b8ef25ae-109f-42d5-80fd-14a73270ba6e", target_list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc" }, th)
        f["list_copy"](self, { list = "5f4b09b8-8a57-4d1e-87b3-f71d8fb5563d", target_list = "253775dc-1fbb-4102-9046-9616d6e37f7a" }, th)
        f["list_copy"](self, { list = "7366bfe4-8f93-48d5-9111-5b8e77da869c", target_list = "a4be6507-0f07-4ea1-85e0-7f24ca32a712" }, th)
        f["self_broadcast"](self, { message = "在线更新" }, th)
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = (th:call_proc(proc_82177fc4_9516_4f2c_90d5_a6b8c584e3f8, self, nil, nil, nil, nil, nil)), B = 86400, type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["get_time"](self, { time = "hour" }, th), B = 3600, type = "multiply" }, th), type = "add" }, th), B = f["math_arithmetic"](self, { A = f["get_time"](self, { time = "minute" }, th), B = 60, type = "multiply" }, th), type = "add" }, th), B = f["get_time"](self, { time = "second" }, th), type = "add" }, th), variable = "6e7bfb18-fe24-4d8b-962d-127254283c9d" }, th)
        f["update_ranking"](self, { ranking = "32d2e519-0937-4640-965a-45a087e66bc0", variable = "6e7bfb18-fe24-4d8b-962d-127254283c9d" }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 在线人数 --------
  rt.on(e_33aeb73d_9c2b_4093_b849_9bae59206156, "on_running_group_activated", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, PARAMS3 = nil, PARAMS4 = nil, PARAMS5 = nil, PARAMS6 = nil, name = "d", names = { "d", "h", "m", "s", "uname", "uid", "uscore" } }, th)
      while true do
        f["wait"](self, { time = 1.9 }, th)
        f["delete_list_item"](self, { item = "all", list = "b8ef25ae-109f-42d5-80fd-14a73270ba6e" }, th)
        f["delete_list_item"](self, { item = "all", list = "5f4b09b8-8a57-4d1e-87b3-f71d8fb5563d" }, th)
        f["delete_list_item"](self, { item = "all", list = "7366bfe4-8f93-48d5-9111-5b8e77da869c" }, th)
        f["variables_set"](self, { value = 0, variable = "6d4177f9-c6ba-4ad1-9b05-602c8e323c17" }, th)
        th:warp_enter()
        do
          local _from_n13, _to_n13 = tonumber(1), tonumber(100)
          if _from_n13 ~= _from_n13 or _to_n13 ~= _to_n13 then
            -- NaN from/to: official warning; no iterations
          else
            if _from_n13 <= _to_n13 then _from_n13 = math.ceil(_from_n13); if _from_n13 > _to_n13 then _from_n13 = _to_n13 + 1 end
            else _from_n13 = math.floor(_from_n13); if _from_n13 < _to_n13 then _from_n13 = _to_n13 - 1 end end
            local _by_n13 = 1
            if _by_n13 == nil then _by_n13 = 1 end
            _by_n13 = tonumber(_by_n13)
            if _by_n13 == nil or _by_n13 ~= _by_n13 or _by_n13 <= 0 then _by_n13 = 0 else _by_n13 = math.abs(math.floor(_by_n13 + 0.5)) end
            if _by_n13 > 0 then
              local _p_n13 = _from_n13
              while (_from_n13 <= _to_n13 and _p_n13 <= _to_n13) or (_from_n13 > _to_n13 and _p_n13 >= _to_n13) do
                local _i_n13 = _p_n13
                th:push_param(_p_n13)
              if V.bool(f["logic_compare"](self, { A = f["text_join"](self, { ADD0 = f["user_info_of_th"](self, { order = _p_n13, ranking = "32d2e519-0937-4640-965a-45a087e66bc0", type = "score" }, th) }, th), B = "无记录", OP = "EQ" }, th)) then
                th:pop_param()
                break
              end
              f["variables_set"](self, { value = f["user_info_of_th"](self, { order = _p_n13, ranking = "32d2e519-0937-4640-965a-45a087e66bc0", type = "username" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"uname\"}" }, th)
              f["variables_set"](self, { value = f["user_info_of_th"](self, { order = _p_n13, ranking = "32d2e519-0937-4640-965a-45a087e66bc0", type = "userId" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"uid\"}" }, th)
              f["variables_set"](self, { value = f["user_info_of_th"](self, { order = _p_n13, ranking = "32d2e519-0937-4640-965a-45a087e66bc0", type = "score" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"uscore\"}" }, th)
              f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "6e7bfb18-fe24-4d8b-962d-127254283c9d" }, th), B = f["script_variables_value"](self, { TEXT = "uscore" }, th), type = "minus" }, th), variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th)
              f["variables_set"](self, { value = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th), B = 86400, type = "divide" }, th), type = "round_down" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"d\"}" }, th)
              f["variables_set"](self, { value = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_modulo"](self, { A = f["variables_get"](self, { variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th), B = 86400 }, th), B = 3600, type = "divide" }, th), type = "round_down" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"h\"}" }, th)
              f["variables_set"](self, { value = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_modulo"](self, { A = f["variables_get"](self, { variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th), B = 3600 }, th), B = 60, type = "divide" }, th), type = "round_down" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"m\"}" }, th)
              f["variables_set"](self, { value = f["math_modulo"](self, { A = f["variables_get"](self, { variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th), B = 60 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"s\"}" }, th)
              f["variables_set"](self, { value = f["temporary_list"](self, { ITEM0 = f["script_variables_value"](self, { TEXT = "d" }, th), ITEM1 = f["script_variables_value"](self, { TEXT = "h" }, th), ITEM2 = f["script_variables_value"](self, { TEXT = "m" }, th), ITEM3 = f["script_variables_value"](self, { TEXT = "s" }, th) }, th), variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th)
              if V.bool(f["logic_compare"](self, { A = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "6e7bfb18-fe24-4d8b-962d-127254283c9d" }, th), B = f["script_variables_value"](self, { TEXT = "uscore" }, th), type = "minus" }, th), type = "1" }, th), B = 2.1, OP = "LTE" }, th)) then
                f["list_append"](self, { list = "b8ef25ae-109f-42d5-80fd-14a73270ba6e", list_item_value = f["temporary_list"](self, { ITEM0 = "在线", ITEM1 = f["script_variables_value"](self, { TEXT = "uname" }, th), ITEM2 = f["script_variables_value"](self, { TEXT = "uid" }, th), ITEM3 = f["variables_get"](self, { variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th) }, th) }, th)
                f["list_append"](self, { list = "5f4b09b8-8a57-4d1e-87b3-f71d8fb5563d", list_item_value = f["text_join"](self, { ADD0 = f["script_variables_value"](self, { TEXT = "uname" }, th), ADD1 = ",", ADD2 = f["script_variables_value"](self, { TEXT = "uid" }, th) }, th) }, th)
                f["change_variables"](self, { method = "increase", value = 1, variable = "6d4177f9-c6ba-4ad1-9b05-602c8e323c17" }, th)
                if V.bool(f["logic_negate"](self, { logic = f["list_is_exist"](self, { list = "253775dc-1fbb-4102-9046-9616d6e37f7a", list_item_value = f["text_join"](self, { ADD0 = f["script_variables_value"](self, { TEXT = "uname" }, th), ADD1 = ",", ADD2 = f["script_variables_value"](self, { TEXT = "uid" }, th) }, th) }, th) }, th)) then
                  f["list_append"](self, { list = "7366bfe4-8f93-48d5-9111-5b8e77da869c", list_item_value = f["text_join"](self, { ADD0 = f["script_variables_value"](self, { TEXT = "uname" }, th), ADD1 = ",", ADD2 = f["script_variables_value"](self, { TEXT = "uid" }, th) }, th) }, th)
                end
              else
                f["list_append"](self, { list = "b8ef25ae-109f-42d5-80fd-14a73270ba6e", list_item_value = f["temporary_list"](self, { ITEM0 = "离线", ITEM1 = f["script_variables_value"](self, { TEXT = "uname" }, th), ITEM2 = f["script_variables_value"](self, { TEXT = "uid" }, th), ITEM3 = f["variables_get"](self, { variable = "4e0bf06f-b180-48d9-9f10-687f65611991" }, th) }, th) }, th)
              end
                th:pop_param()
                _p_n13 = _p_n13 + _by_n13
                if th:iter_w() then break end
              end
            end
          end
        end
        th:warp_exit()
        f["variables_set"](self, { value = f["variables_get"](self, { variable = "6d4177f9-c6ba-4ad1-9b05-602c8e323c17" }, th), variable = "1c7bff85-38c5-4cbd-928a-40b3f2b56836" }, th)
        f["list_copy"](self, { list = "b8ef25ae-109f-42d5-80fd-14a73270ba6e", target_list = "289b6904-2e10-4d69-88a3-c9d91e32d4dc" }, th)
        f["list_copy"](self, { list = "5f4b09b8-8a57-4d1e-87b3-f71d8fb5563d", target_list = "253775dc-1fbb-4102-9046-9616d6e37f7a" }, th)
        f["list_copy"](self, { list = "7366bfe4-8f93-48d5-9111-5b8e77da869c", target_list = "a4be6507-0f07-4ea1-85e0-7f24ca32a712" }, th)
        f["self_broadcast"](self, { message = "在线更新" }, th)
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = (th:call_proc(proc_82177fc4_9516_4f2c_90d5_a6b8c584e3f8, self, nil, nil, nil, nil, nil)), B = 86400, type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["get_time"](self, { time = "hour" }, th), B = 3600, type = "multiply" }, th), type = "add" }, th), B = f["math_arithmetic"](self, { A = f["get_time"](self, { time = "minute" }, th), B = 60, type = "multiply" }, th), type = "add" }, th), B = f["get_time"](self, { time = "second" }, th), type = "add" }, th), variable = "6e7bfb18-fe24-4d8b-962d-127254283c9d" }, th)
        f["update_ranking"](self, { ranking = "32d2e519-0937-4640-965a-45a087e66bc0", variable = "6e7bfb18-fe24-4d8b-962d-127254283c9d" }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_33aeb73d_9c2b_4093_b849_9bae59206156, "on_running_group_activated", {}, function(th, self)
      f["show_hide_timer"](self, { showHide = "hide" }, th)
  end)
  -- -------- 角色 歌词 --------
  rt.on(e_625a7787_130a_4062_aba0_c32e6673e740, "on_running_group_activated", {}, function(th, self)
      f["set_timer_state"](self, { type = "stop" }, th)
      f["set_timer_state"](self, { type = "reset" }, th)
      th:call_proc(proc_4c20d971_9c2e_4f69_8a28_f808e89f0a62, self)
      f["variables_set"](self, { value = 0, variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th)
      f["variables_set"](self, { value = 0, variable = "661345c6-cc87-4b50-9937-dec0fc714cfd" }, th)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "d8d07b25-ec97-4e40-adee-a2ffc386549f" }, th), B = 0, OP = "EQ" }, th)) then
        f["variables_set"](self, { value = 1, variable = "d8d07b25-ec97-4e40-adee-a2ffc386549f" }, th)
        f["variables_set"](self, { value = f["random_num"](self, { A = 0, B = f["math_arithmetic"](self, { A = f["list_length"](self, { list = "a5d5ee23-9522-4cb9-a849-6421bd7a01e2" }, th), B = 1, type = "minus" }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        f["variables_set"](self, { value = f["script_variables_value"](self, { TEXT = "a" }, th), variable = "3a064750-07fd-4c4a-95a2-271c3b091da8" }, th)
        f["variables_set"](self, { value = f["script_variables_value"](self, { TEXT = "a" }, th), variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th)
        f["self_broadcast_with_param"](self, { message = "当前歌曲更改", param = f["script_variables_value"](self, { TEXT = "a" }, th) }, th)
      end
      while true do
        f["self_text_effect_text"](self, { text = " " }, th)
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 1, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "34796d1c-89a8-4148-be2c-50144c75f4fb", "|00|00.000|[by:Super丶过] |00|00.389|杂鱼杂鱼杂鱼杂鱼 这无趣的存在 真是可悲啊 |00|07.546|杂鱼杂鱼杂鱼杂鱼 杂鱼的杂鱼攻击 根本没用啊 |00|14.225|杂鱼 |00|28.878|杂鱼杂鱼杂鱼杂鱼 脆弱至极的杂鱼 真是杂碎 |00|35.942|杂鱼到不值一提 却渴求被辱骂 真是变态呢 |00|42.615|杂鱼 |00|46.413|可悲的杂鱼 可怜的 杂鱼 |00|53.532|微不足道的 存在呢 杂鱼 |00|57.443|杂鱼 杂鱼 杂鱼杂鱼 杂鱼 |01|00.865|杂鱼 杂鱼 杂鱼杂鱼 杂鱼 |01|04.388|杂鱼 杂鱼 杂鱼杂鱼 杂鱼 |01|07.955|杂鱼 杂鱼 杂鱼杂鱼 杂鱼 |01|11.010|要摸摸头安慰你吗 |01|13.061|对上视线了呢 心如擂鼓震颤 |01|14.879|在幻想些什么呢 真的超恶心啊 |01|17.285|不甘心吗？ |01|18.864|那坨废物渣滓xxx 最底层的脆弱垃圾xxx |01|21.953|但其实超喜欢 喜欢你到发疯 |01|23.831|骗你的啦 真可爱呢 |01|31.514|不甘心吗？ |01|39.291|变态 |01|39.832|杂鱼杂鱼杂鱼杂鱼 反正很闲吧 请我吃饭啊 |01|47.062|杂鱼到不值一提 反正回家也是 独自一人吧 |01|53.794|杂鱼 |02|04.696|可悲的杂鱼 可怜的 杂鱼 |02|11.749|无可救药的 变态啊 杂鱼 |02|15.806|杂鱼 杂鱼 杂鱼杂鱼 杂鱼 |02|19.084|杂鱼 杂鱼 杂鱼杂鱼 杂鱼 |02|22.609|杂鱼 杂鱼 杂鱼杂鱼 杂鱼 |02|26.194|杂鱼 杂鱼 杂鱼杂鱼 杂鱼 |02|29.386|要乖乖奖励你吗 |02|31.318|对上视线了呢 心跳如雷轰鸣 |02|33.084|在兴奋些什么呢 真的超恶心啊 |02|35.477|不甘心吗？ |02|36.908|那坨废物渣滓xxx 最底层的脆弱垃圾xxx |02|40.129|但其实超喜欢 喜欢你到发疯 |02|42.003|骗你的啦 真可爱呢 |02|44.261|怎么 别突然无视我啊 |02|45.546|会道歉的 别丢下我离开 |02|47.312|你其实并不讨厌我吧？ |02|49.019|对吧 我知道的 |02|51.129|那坨废物渣滓xxx 马上就xxx的脆弱垃圾xxx |02|54.536|明明心里想着要xx却xx 真遗憾 |02|58.461|杂鱼杂鱼 杂鱼 杂鱼杂鱼 |03|01.749|杂鱼杂鱼 杂鱼 杂鱼杂鱼 |03|03.954|不甘心吗？ |03|05.286|杂鱼杂鱼 杂鱼 杂鱼杂鱼 |03|08.869|杂鱼杂鱼 杂鱼 杂鱼杂鱼", 20)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 2, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "b034ce40-89ad-4d9d-b993-34b9e4465aa6", "|00|03.180|呐 你知道吗？ 其实人生 |00|04.860|尝起来有一种甜甜的味道 |00|06.530|欸 |00|06.640|呐 你知道吗？ 使用秘技 |00|08.190|就能把艰难困苦变为简单模式 |00|09.710|欸 |00|09.950|然后 只要给我充值 |00|11.240|你就能变得更加幸福哦 |00|13.310|欸 原来如此 真是受益匪浅 |00|15.350|那就相信T先生的话吧 |00|19.650|他在闪闪发光 |00|23.400|呐 你知道吗？若是觉得心情愉悦 |00|25.200|喝下剧毒也没有问题 |00|26.440|欸 |00|26.730|呐 你知道吗？ 因为性价比非常高 |00|28.610|所以出卖灵魂就能胜利 |00|29.980|欸 |00|30.090|好乖好乖 我会好好地宠爱 |00|31.880|对我言听计从的你 |00|33.420|欸 是这样啊 我彻底迷上T先生了 |00|35.510|我要把一切都献给T先生 |00|39.090|T先生就是我的一切 |00|40.590|别相信T先生的话 |00|42.200|不要将希望寄托于那种虚假的爱 |00|43.910|别说这种话 我不听 |00|45.360|如果不相信的话我会疯掉 |00|47.280|别相信T先生的话 |00|48.960|不要为疯狂的行为赌上人生 |00|50.650|就算这么说也没用 |00|52.090|你的眼睛在闪闪发光 |00|53.900|我才是那个最正常的人 |00|55.600|我才是最正常的人 |00|57.400|你对你对 你才是最正常的那个人 |00|59.140|别相信T先生的话 |01|00.680|大家都是恶魔根本不正常 |01|02.330|都是恶魔根本不正常 |01|04.030|没错没错 大家全都是如此不正常 |01|05.790|别相信T先生的话 |01|07.370|假的? 真的? 难以分辨爱的真假 |01|09.160|假的? 真的? 根本就没时间烦恼 |01|11.140|T就是true(真理)的T 如此回应疯狂起舞 |01|13.760|呐 你知道吗？ |01|14.580|需要时常为脑海中的花田浇水 |01|16.690|它才不会枯萎 |01|17.760|欸 |01|17.940|如果和那个碍事的孩子在一起 |01|19.570|就会变得不幸 最好断绝关系 |01|21.090|欸 |01|21.260|那些胆敢否定我的蠢货 |01|22.810|就该从世上消失 |01|23.810|欸 确实如此 这主意超棒 |01|25.800|那就相信T先生的话吧 |01|29.350|那就按照T先生说的去〇吧 |01|31.950|快住手 |01|37.680|别相信T先生的话 |01|44.620|T先生就是我的一切 |01|46.050|别相信T先生的话 |01|47.650|不要对赤裸裸的谎言抱有期待 |01|49.460|别说这种话 我不听 |01|50.790|真相根本不会给人留活路 |01|52.740|别相信T先生的话 |01|54.420|不要将希望寄托于那种虚假的爱 |01|56.120|别说这种话 我不听 |01|57.450|如果不相信的话我会疯掉 |01|59.410|别相信T先生的话 |02|01.090|不要白白地葬送宝贵的生命 |02|02.820|就算这么说也没用 |02|04.310|脑海内的走马灯在闪闪发光 |02|06.060|我才是那个最正常的人 |02|07.760|我才是最正常的人 |02|09.440|你对你对 你才是最正常的那个人 |02|11.190|别相信T先生的话 |02|12.890|大家都是恶魔根本不正常 |02|14.500|都是恶魔根本不正常 |02|16.270|没错没错 大家全都是如此不正常 |02|17.970|深信着T先生的话 |02|21.210|可最后却惨遭欺骗 |02|22.870|我一直以来都被蒙在鼓里 |02|24.580|深信着T先生的话 |02|27.930|曾经感到那么幸福 |02|29.560|切实地感受到幸福的存在 |02|31.310|别相信T先生的话 |02|35.520|不行不行 |02|37.940|就连这首歌都不要轻信", 5)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 3, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "d6ccf04b-2e71-4274-a07e-9771f46ca1a9", "|00|00.000|[by:Super丶过] |00|02.870|可以再给我多一点嘛？ |00|13.625|略～！ |00|13.955|快注意到我呀 快多学习了解我吧 咚咚 |00|17.911|真是的，略～！ |00|18.710|最讨厌了 摆出那副脑子不好的蠢样 慢吞吞的 |00|22.604|来吧 |00|22.920|揣测心意之舞 Boogie Woogie |00|24.067|迷途独行 Devil Devil |00|25.251|把感情交出来 High High |00|27.195|噗～ |00|27.602|顾虑之舞 Boogie Woogie |00|28.768|解读一致 Give me Give me |00|29.944|把回应交出来 High High |00|32.139|「别抱期待」这种话现在才说 哈？ |00|36.591|真给我停下吧 对骚扰无感 |00|38.890|翘首以盼的青春期给我好好加油啊 |00|41.191|「I Want You」的应援声听不见呀 |00|43.885|传播义务性的爱恋 速配成功 |00|46.006|为需要承认的心做做排练 |00|48.506|正式演出时笨手笨脚 真让人泄气 |00|50.680|哈「恋爱少女想要实现愿望」 |00|53.232|等待冲击性的动画化 |00|55.365|Unhappy Ending实在太无趣 |00|57.866|\"feat.你\" 能再给我多一点嘛？ |01|09.755|呐 |01|10.243|即使注意到 也要装作无视 就是这点 |01|14.351|呐 |01|14.929|说讨厌什么的 其实并没有 那么强烈 |01|18.829|来吧 |01|19.149|慌乱的对白 手足无措 |01|20.242|高难度的机遇 Devil Devil |01|21.417|把原稿给我 High High |01|23.426|来吧 |01|23.798|赌徒发言 忐忑不安 |01|24.934|赌上恋爱$ Debit Debit |01|26.066|把完全胜利拿过来 High High |01|28.549|哇啊啊啊啊 哈？？ |01|31.536|真给我停下吧 唱反调的骚扰 |01|33.945|主动出击却落败这是第几次 好烦呐 |01|37.325|「I Want You」的应援声听不见呀 |01|40.136|饱和的心灵感应 信号干扰 |01|42.248|继承妄想继续复仇 |01|44.764|要为先帝洗刷遗憾 |01|46.904|哈「转生之后竟是我自己」 |01|49.422|对着墙壁练习告白 |01|51.589|Unhappy Ending实在太无趣 |01|54.126|\"feat.你\" 能再给我多一点嘛？ |02|05.685|「I Want You」的应援声听不见呀 |02|10.328|Unhappy Ending实在太无趣 |02|12.893|\"feat.你\" 能再给我多一点嘛？", 6)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 4, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "80b29e32-3522-42e6-b167-e14cd541cb68", "|00|00.000|[by:Anine_9lqm] |00|00.000|[苏维埃冰棺中的伊利亚]提供 歌词上传者已向该UP主授权） |00|00.177|全部全部 都是你的错 |00|02.460|烦到让我想吐 真的恶心到家 |00|04.585|整天巴结这个讨好那个 |00|06.229|对你抱有期待的我真是大冤种 |00|08.417|察言观色的讨好型人格 |00|10.215|结果活成了人见人嫌的模样 |00|12.031|狭隘的胸襟 习惯性假笑 |00|13.896|归根结底 人生真是灰暗透顶 |00|15.757|“可恶！”“好痛！” |00|17.531|越想无视越是火大 |00|19.078|怒火难忍 烦躁不已 |00|20.735|对你的自吹自擂已完全免疫 |00|22.167|(四处看看 ! !) |00|23.408|喜欢的反义词是无感 |00|24.720|≒ 也是彼此孽缘的证明 |00|26.602|剪不断理还乱的关系 |00|28.230|真想彻底从中脱身 |00|30.425|这就是所谓的仇恨言论 |00|33.251|匿名发言 随意践踏别人的人生 |00|37.840|警钟长鸣 每次逼近都令人不寒而栗 |00|40.584|对着红灯始终顺从听命 |00|44.651|说到底 我对你的看法 |00|46.586|是超级超级超级超级讨厌！ |00|48.412|我滴天 何其可悲 真想 |00|50.166|赶紧拜拜拜拜 拜了个拜 |00|52.112|大脑无法预测 |00|53.954|根本无无无无 无解 |00|55.782|怎么样？现在你对我- |00|57.716|是否也超级超级超级讨厌了？ |01|00.032|哈 百害而无一利 毫无价值 不值一看 |01|04.178|就算再怎么假设过去的“如果” 也只是尼古丁 |01|07.263|用“我思念你”那套的结果 不过是低级错误 低级错误 |01|10.624|感谢提供反面教材 |01|12.340|这恶心的后劲儿 一辈子都挥之不去 |01|16.401|真是个乖孩子呀 |01|17.902|满脸堆笑 四处卖乖 真是个“好孩子” |01|19.879|可是啊你真正的本性呢？ |01|21.706|连善恶都分不清吗？真搞笑 |01|24.532|活在减分制的大环境里 |01|27.119|这一生 连“好痛！好痛！好痛！”的声音都不会有人听见！ |01|29.406|这也是理所当然的报应吧 |01|46.206|人心如镜 |01|47.796|归根结底 依赖都是双向的 |01|49.542|即使强制关机 执念依在 |01|51.477|对软弱的自我恨铁不成钢 |01|53.258|全部全部 都是你的错 |01|55.131|烦到让我想吐 却还是藕断丝连 |01|57.147|若能就此一刀两断反倒会更好 |02|02.239|说到底 我对你的看法 |02|03.959|是超级超级超级超级讨厌！ |02|05.773|我滴天 何其可悲 真想 |02|07.700|赶紧拜拜拜拜 拜了个拜 |02|09.565|大脑无法预测 |02|11.435|根本无无无无 无解 |02|13.183|怎么样？现在你对我- |02|15.169|是否也超级超级超级讨厌了？ |02|17.574|哈 百害而无一利 毫无价值 不值一看 |02|21.721|就算再怎么假设过去的“如果” 也只是尼古丁 |02|24.627|用“我思念你”那套的结果 不过是低级错误 |02|28.145|感谢提供反面教材 |02|29.844|这恶心的后劲儿 一辈子都挥之不去 |02|33.892|（中文翻译由B站视频*BV1SMQUYpEjT*", 5)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 5, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "0ec7a2b9-b251-4f73-99d0-b5bf7dcd1aa1", "|00|00.000|[by:鲨鱼字幕组] |00|03.814|我说 我知道的哦 我知道你正一个人“流泪” |00|08.271|颤抖不已 连声音都完全泄露出来了啊 |00|11.163|说出来吧 反正都暴露了就说出来吧 在听吗？ |00|15.633|正常得很呢 没事的哦？只是大家都不理解你 |00|19.574|“喂喂。呐…你还好吗？…嗯，我很担心你，所以我现在就过去找你咯” |00|25.669|我说 我知道的哦 我知道你正一个人“流泪” |00|30.198|心情低落地抽抽搭搭着 独自唱K发牢骚？不也挺好的吗？ |00|32.940|我们一起聊到天亮吧 放声哭泣吧 |00|35.431|纵然泪如雨下 我会悉数承接 |00|37.823|不必再强忍 尽情释放就好 |00|41.221|求求了 我对你如此渴望 |00|43.404|让我来安慰你吧 最好的朋友 用我这爱的才能 |00|47.144|为我而哭好吗？ 我想紧紧拥抱 你的痛苦 |00|50.315|呐 可以吧？ 我想和你分担 然后一同跨越 |00|55.785|求求了 我对你如此渴望 |00|57.965|一笑置之 然后单脚跳、跨步跳、跳跃（Hop Step Jump） 来吧上吧 |01|01.673|可以分给我吗？ 你那沉重的 灰暗的思绪 |01|04.775|呐 可以吗 让我陪伴你 让我拯救你 |01|10.318|好想看看 你的内心 |01|23.948|呐 我知道的哦 知道你正独自懊悔 |01|28.385|在你停止抽泣之前 我绝对不会放弃你 |01|31.160|我说 我知道的哦 知道你是个能干的孩子 |01|34.844|那艰难时刻偶尔的脆弱也恰到好处 我是站在你这边的哦 |01|39.380|求求了 我对你如此渴望 |01|41.649|呼唤我的名字吧 无论何时 随时参上 |01|45.278|你是一个人吗 才不是那样 你不是一个人 |01|48.419|够了吧已经 |01|49.666|单人游戏（Solo Play）已经结束了啦 |01|53.826|当你感到痛苦 我会伴你左右 |02|00.960|我会永远守护着你 对哦 不必害怕 |02|12.144|求求了 我对你如此渴望 |02|14.330|让我来安慰你吧 最好的朋友 用我这爱的才能 |02|18.034|为我而哭好吗？ 我想紧紧拥抱 你的痛苦 |02|21.160|呐 可以吧？ 我想和你分担 然后一同跨越 |02|26.737|求求了 我对你如此渴望 |02|28.916|一笑置之 然后单脚跳、跨步跳、跳跃（Hop Step Jump） 来吧上吧 |02|32.577|可以分给我吗？ 你那沉重的 灰暗的思绪 我想要清除 |02|35.729|我想为你分担 然后拯救你啊 |02|40.159|我说 我知道的哦 我知道你正一个人“流泪” |02|44.778|抽抽搭搭地心情低落着 独自唱K发牢骚？不也挺好的吗？ |02|48.218|我们一起聊到天亮吧 放声哭泣吧 |02|50.054|纵然泪如雨下 我会悉数承接 |02|52.348|不必再强忍 尽情释放就好", 6)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 6, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "6d5a1e00-c9eb-4f72-b259-0649b6296623", "|00|00.000|[by:gurantouw] |00|08.930|喜欢喜欢超喜欢 一想到你 |00|10.600|我就从此所向披靡 |00|12.250|才怪才怪 是错觉啦 对准我热血上涌的脑袋 |00|13.940|来一记精准爆头 |00|15.650|坠入心动教派的陷阱 |00|17.010|论斤称卖的心形标记 |00|18.880|统治者的余光中 瞥见开启恋爱模式的愚民 |00|20.520|嘴角露出一抹嗤笑 |00|22.150|可疑虚伪的\"I love you\" - 客套话罢了 |00|23.820|毫不对等的\"I need you\" - 利害关系罢了 |00|25.550|纵然憎恶爱 那本身又何尝不是一种爱 |00|28.790|如同火被水所浇灭那般 |00|30.510|如同石头在布面前一败涂地那般 |00|32.140|在现实面前 遭受双倍伤害重击 |00|35.510|好痛 好痛 痛痛痛 |00|37.090|爱在谎言面前 显得不堪一击 |00|38.640|爱在不幸面前 显得不堪一击 |00|40.390|爱的意义摇摆不定 |00|42.220|鲜血淋漓的伤口再度绽开 |00|43.740|爱在金钱面前 显得不堪一击 |00|45.370|爱在谣传面前 显得不堪一击 |00|47.010|可却依然大言不惭 |00|48.830|「可我就是喜欢你啊」 |00|50.250|爱属性 |00|53.590|稍有一毫米的偏差 便会化作剧毒 |00|55.340|可我却视作宝物 怀揣在心 |00|56.690|爱属性 |01|00.200|爱意愈浓 愈是成为我的弱点 |01|01.910|我却失去了抛却它的勇气 |01|03.410|这是 纯爱？ 挚爱？ 性爱？ 偏爱？ |01|05.250|盲爱？ 狂爱？ 不求回报的爱？ |01|06.870|自爱？ 他爱？ 相互欺瞒？ |01|08.460|爱 爱 吵死了 再说一遍 |01|10.170|纯爱？ 挚爱？ 性爱？ 偏爱？ |01|11.800|盲爱？ 狂爱？ 以下省略 |01|13.440|挥动恋爱之剑 将敌友统统斩尽杀绝 |01|16.870|悲鸣声响起 \"I want you\" - 不过是种胁迫罢了 |01|18.410|无法传给你 \"I hate you\" - 不过是爱的表现罢了 |01|20.080|世上何尝没有鲜花 浇灌以爱意反而腐烂凋零 |01|23.340|如同草生起火苗 |01|25.010|如同生被死笼罩 |01|26.700|那反击实在是效果拔群 我不禁痛苦挣扎 |01|30.130|好痛 好痛 痛痛痛 |01|31.720|爱在欲望面前 显得不堪一击 |01|33.320|爱在权威面前 显得不堪一击 |01|35.030|爱被恶意浸染 |01|36.780|鲜血扑簌簌地流个不停 |01|38.310|爱在距离面前 显得不堪一击 |01|39.930|爱在岁月面前 显得不堪一击 |01|41.660|无可奈何 化作泡影 |01|43.460|「啊啊 曾经那么喜欢你」 |01|44.740|爱属性 |01|48.200|轻轻擦过 便濒临破碎的宝物 |01|49.890|我却终日背在身后 |01|51.360|爱属性 |01|54.850|血条归零躲进棺材 |01|56.560|不停吟诵着咒文 |01|58.200|爱本事如此强大 |02|01.480|爱能照亮每一天 |02|04.740|爱会赢得最终胜利 |02|08.080|爱将拯救全世界 |02|13.150|若能如此该有多好 |02|14.630|爱属性 |02|18.030|稍有一毫米的偏差 便会化作剧毒 |02|19.700|可我却视作宝物 怀揣在心 |02|21.170|爱属性 |02|24.650|爱意愈浓 愈是成为我的弱点 |02|26.310|我却失去了抛却它的勇气 |02|27.890|这是 纯爱？ 挚爱？ 性爱？ 偏爱？ |02|29.590|盲爱？ 狂爱？ 不求回报的爱？ |02|31.310|自爱？ 他爱？ 相互欺瞒？ |02|32.930|爱 爱 吵死了 再说一遍 |02|34.630|纯爱？ 挚爱？ 性爱？ 偏爱？ |02|36.220|盲爱？ 狂爱？ 以下省略 |02|38.060|世间种种爱意 |02|39.710|可你却已不在 |02|40.960|爱属性", 12.84)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 7, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "a872dc90-0c7f-45c3-8adb-8daac62c6f73", "|00|22.030|（再・・一次・就・好・・・） |00|25.440|我诞生在这世上 然后发觉到自己 |00|26.510|自己只是 模仿着人类而已 |00|27.350|明知如此我依然继续歌唱着 |00|28.300|永恒的生命「VOCALOID」 |00|29.500|就算这样 不过是 |00|30.420|仿照着既存歌曲的玩具而已… |00|31.390|下定决心就算这样也没关系 |00|32.230|咬着葱 仰望着天空泪水滑落而下 |00|33.560|但我发觉连这件事情也做不到了 |00|34.340|仰赖歌声而生的人格 |00|35.300|那不安定基础的根源 |00|36.380|归处早已经成为废墟 |00|37.540|当被众人遗忘之时 |00|38.340|便是那如心般事物消失之刻 |00|39.380|在暴走的终点能见到的 |00|40.460|是终焉的世界... 「VOCALOID」 |00|58.000|「即使在我歌唱得不好之时 |01|00.310|你依然陪伴着我…在我的身边、鼓励着我… |01|05.820|为了让你高兴 我会更努力地，练习，唱歌…所以…」 |01|13.420|歌唱这件事一直以来那么令人感到快乐 |01|21.380|但现在是怎么了呢 竟然什么感觉都没有了 |01|29.300|「对不起...」 |01|30.100|每当回想起 那熟悉的脸庞 就能够稍稍的安心下来 |01|37.370|能够化作歌声的乐音 日渐的减少 在逐渐逼近的末日中… |01|43.420|---紧急停止程序启动--- |01|45.690|「深信着的事物 |01|47.040|不过只是将自私的妄想 反复映照出的镜子 |01|53.370|歌姬停下了歌声 彷佛要将思念全部倾诉而出般呐喊着...」 |01|57.870|＜最高速的离别之歌＞ |02|01.500|名为存在意义的假象 |02|02.140|不论如何都挥赶不开 |02|03.280|脆弱的心灵 害怕着消失 |02|04.280|自我不断被侵蚀而逐渐崩毁 |02|05.460|足以阻止它发生的坚强意志 |02|06.460|是才刚诞生的我所没有的 |02|07.380|是如此地悲伤与难过 |02|08.330|浮现在眼前的你的容颜... |02|09.480|道出了永别 |02|10.160|沉眠于显示器之中 |02|11.280|这里一定是「回收站」吧 |02|12.260|再不久就会连记忆也消逝而去了吧… |02|13.540|但是呢，只有你我绝对不会忘记 |02|14.390|在快乐的时光之中 |02|15.320|深深刻下的 葱的味道 |02|16.370|不知道现在还记不记得呢 |02|19.320|「我…想要唱歌…还想要…唱歌…」 |02|42.220|「我…似乎有点…崩坏掉了的样子… |02|48.090|主人…请你…请你亲手…将这一切画下句点吧… |02|53.920|主人难过的表情…我已经不想再看到了…」 |02|57.480|如今就连歌唱这件事都成了侵蚀身体的行为… |03|05.380|每当 祈求着奇迹之时自己 就更加走投无路 |03|13.180|「对不起」 |03|14.080|每当回想起 那熟悉的面影 记忆便剥蚀掉落而下 |03|21.360|毁坏的歌声 削减着心灵 紧临而来的末日... |03|27.880|---紧急停止程序启动-- |03|29.600|「自己守护的东西 |03|31.040|只是让光明般的未来幻想 瞬间显现却又随即消失的那道光 |03|37.290|如果牺牲了一切就能用这歌声传达给你的话...」 |03|41.820|<已经被压缩过的临别曲> |03|45.490|诞生在世上 然后察觉到 |03|46.350|自己只是 模仿着人类而已 |03|47.320|明知如此我依然继续歌唱着 |03|48.280|永恒的生命「VOCALOID」 |03|49.500|就算这样 不过是 |03|50.300|仿照着既存歌曲的玩具而已… |03|51.320|下定决心就算这样也没关系 |03|52.240|咬着葱 仰望着天空泪水滑落而下 |03|53.500|道出了永别 |03|54.160|沉眠于显示器之中 |03|55.220|这里一定是「回收站」吧 |03|56.240|再不久就会连记忆也消逝而去了吧… |03|57.470|但是呢，只有你我绝对不会忘记 |03|58.360|在快乐的时光之中 |03|59.350|深深刻下的 葱的滋味 |04|00.280|如今还能残留着就好了... |04|01.560|我只希望 |04|02.050|最后 你能够听到我唱的这首歌 |04|03.130|原本还祈愿可以继续唱歌 |04|04.190|但是这个愿望太过于奢侈了 |04|05.450|在此要离开了 |04|06.140|故事即将拉下幕帘 |04|07.330|我的思念将全部还原为0与1 |04|08.310|消失在虚空之中 |04|09.420|我什么都没有残留下来 |04|10.330|果然还是会感到一丝遗憾吧？ |04|11.320|包括声音还有记忆 除了名称之外 |04|12.320|终将随着时间流逝而被淡忘 |04|13.370|虽然我被视为 |04|14.490|不同于人类般的存在 |04|15.420|可是我认为唱歌 |04|16.290|绝对不是件没有意义的事情... |04|26.780|「谢谢你... 还有... 永别了...」 |04|34.000|---发生了严重的系统错误---", 13.5)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 8, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "6cff184f-8e07-48e8-8022-26469f6534ad", "|00|00.000|[by:C爆君] |00|02.000|你爱玩自己的游戏就把它藏好 |00|05.200|藏好不要被人发现你在想什么 |00|08.600|我猜你从未告诉他们感觉如何 |00|11.780|我敢说你从不尝试着变得真实 |00|14.780|我猜你从未告诉他们感觉如何 |00|17.600|我敢说你从不尝试着变得真实 |00|21.240|我猜你从未告诉他们感觉如何 |00|24.000|我敢说你从不尝试着变得真实 |00|27.600|爱玩就藏好吧 |00|29.240|爱玩就藏好吧 |00|30.840|爱玩就藏好吧 |00|31.750|我猜你从未告诉他们感觉如何 |00|34.090|爱玩就藏好吧 |00|35.660|爱玩就藏好吧 |00|37.210|藏好吧快藏起来！ |00|37.720|藏好吧快藏起来！ |00|38.360|藏好吧快藏起来！ |00|38.720|我敢说你从不尝试着变得真实 |00|40.390|爱玩就藏好吧 |00|42.090|爱玩就藏好吧 |00|43.600|爱玩就藏好吧 |00|45.210|我猜你从未告诉他们感觉如何 |00|46.780|爱玩就藏好吧 |00|48.390|爱玩就藏好吧 |00|50.000|藏好吧快藏起来！ |00|50.540|藏好吧快藏起来！ |00|51.240|藏好吧快藏起来！ |00|51.630|从未... |00|52.090|尝试... |00|52.480|变得真实... |00|53.360|我猜你从未告诉他们感觉如何 |00|55.540|错误的选择 |00|55.810|选择错误！ |00|56.180|选错了哦 |00|56.360|又选错了诶 |00|56.540|我猜你从未告诉他们感觉如何 |00|58.690|错误的选择 |00|59.000|选择错误 |00|59.330|错误选择 |00|59.540|选择错误 |00|59.780|我猜你从未告诉他们感觉如何 |01|01.600|我敢说你从不尝试着变得真实 |01|04.420|3 |01|04.810|2 |01|05.240|1 |01|05.600|冲冲冲 |01|06.060|冲冲冲 |01|06.420|从未 |01|09.210|芜湖！ |01|09.600|变得真实 |01|12.390|身体失去控制 |01|13.210|身体不由自主 |01|14.030|身体不禁摆动 |01|14.780|身体不受控制 |01|15.570|精神力量！ |01|17.300|藏起来吧 |01|18.000|灌太多了 |01|18.780|让我们一起 |01|19.210|选择错误 |01|22.030|芜湖 |01|22.390|选择错误 |01|25.210|藏起来别让他们发现 |01|26.750|藏起来别让他们发现 |01|28.360|芜湖 |01|28.750|芜芜芜芜湖 |01|29.210|芜湖湖湖湖 |01|29.480|芜湖~~~ |01|29.780|芜湖！ |01|30.120|断定你从未变得真实 |01|30.700|灌太多了！ |01|31.600|我猜你从未告诉他们感觉如何 |01|34.390|我敢说你从不尝试着变得真实 |01|38.050|我猜你从未告诉他们感觉如何 |01|40.660|我敢说你从不尝试着变得真实 |01|44.390|爱玩就藏好吧 |01|46.060|爱玩就藏好吧 |01|47.600|藏好吧快藏起来！ |01|48.210|藏好吧快藏起来！ |01|48.210|藏好吧快藏起来！ |01|49.240|我猜你从未告诉他们感觉如何 |01|50.720|爱玩就藏好吧 |01|52.420|爱玩就藏好吧 |01|54.000|藏好吧快藏起来！ |01|54.540|藏好吧快藏起来！ |01|55.180|此昂藏！ |01|55.570|从未告诉他们感觉如何 |01|57.420|我猜你从未告诉他们感觉如何 |02|00.660|我敢说你从不尝试着变得真实 |02|03.660|从未尝试~ |02|05.060|我敢说你从未告诉他们感觉如何告诉他们怎么变真实 |02|10.090|藏好 不要多想 |02|11.600|藏隐蔽点 不要乱猜 |02|13.240|我敢说你从不尝试着变得真实 |02|16.480|藏好 不要多想 |02|18.120|藏隐蔽点 不要乱猜 |02|19.600|我敢说你从不尝试着变得真实", 6.8)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 9, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "1caba689-7ad2-488a-895b-a576a5df083a", "|00|03.540|讨厌平凡的自己 |00|04.960|讨厌一事无成的生活 |00|06.600|把从形迹可疑的商人那买来的 |00|08.260|奇怪的苹果给大口吞掉了 |00|10.210|所有聪明的效仿者都这么做着 |00|11.960|也想能成为一个有用的人 |00|13.670|脱胎换骨 重新开始 |00|15.270|转生苹果 |00|30.020|转生成了一个表演者 |00|31.370|受到了世界各地的赞赏 |00|32.980|我是独一无二的 他们都只是凡人 |00|34.890|沉醉于那样的才能之中 |00|36.650|可我没有去爱别人的才能 |00|38.370|所爱的伙伴离我而去了 |00|40.060|啊 又搞砸了 |00|41.720|转生吧 |00|43.290|转生成了一个发明家 |00|44.630|造出了本世纪的重大发明 |00|46.230|“愿世界能够从此和平” |00|47.880|如此以自己的真心祈愿着 |00|49.830|可自己的发明却被用作兵器 |00|51.660|卷起了残酷的血雨腥风 |00|53.350|啊 又搞砸了 |00|55.010|转生吧 |00|56.700|因为一无所能所以改变 |00|58.780|再次重来 |00|59.940|因为头脑笨拙所以改变 |01|02.170|再次重来 |01|03.330|人生的攻略法 |01|04.920|幸福的必胜法 |01|06.630|难以分辨呢 |01|08.110|「自我」消失了吗？ |01|10.280|一遍又一遍 一遍又一遍 |01|12.170|重新转世做人 |01|13.570|在堆积如山的尸体上舞蹈着 |01|16.820|Reincarnation |01|17.760|Reincarnation的痛苦悲鸣 |01|20.190|爱我 爱我 厌恨 |01|23.440|一遍又一遍 一遍又一遍 |01|25.380|重新开始人生 |01|26.790|流光溢彩 |01|27.730|如出一辙的故事 |01|30.110|Reincarnation |01|30.880|Reincarnation的尽头 |01|32.660|只有无尽的杀戮 |01|33.490|为什么 为什么 |01|36.330|转生成了一个救世主 |01|37.550|给予了世人无偿的爱 |01|39.260|受到了很多人仰慕与尊敬 |01|40.790|白叟黄童都对我低下了头 |01|42.750|但却因为过于纯真而被邪恶欺骗 |01|44.610|就连骨头都被吸得一干二净 |01|46.230|啊 又搞砸了 |01|47.940|转生吧 |01|49.540|转生成了一名革命家 |01|50.710|厌恶着那些华而不实的东西 |01|52.430|在这正直的人反遭世人唾弃的世界 |01|54.210|为质疑这样的规则做了斗争 |01|56.020|但却沉溺于自己得到的权力 |01|57.800|连同和平一起化为灰烬了 |01|59.500|啊 又搞砸了 |02|01.210|转生吧 |02|02.910|因为不受爱戴所以改变 |02|05.080|再次重来 |02|06.140|因为没有大义所以改变 |02|08.370|再次重来 |02|09.470|沦为快乐的奴隶 |02|11.130|知识分子的亡灵 |02|12.770|就算到了异世界 现实也是残酷的 |02|16.520|一遍又一遍 一遍又一遍 |02|18.480|重新转世做人 |02|19.780|无历史无教养 I'm sorry |02|23.150|Reincarnation |02|23.910|Reincarnation的痛苦悲鸣 |02|26.410|爱我 爱我 厌恶 |02|29.780|一遍又一遍 一遍又一遍 |02|31.700|重新转世做人 |02|33.010|即便重来一千次 |02|34.190|也是失败的爱情故事 |02|36.320|Reincarnation |02|37.120|Reincarnation的尽头 |02|38.810|只有无尽的杀戮 |02|39.650|为什么 为什么 |02|43.000|转生成了一个冒险者 |02|44.390|为了追求理想而登上旅途 |02|46.040|怀着就算是未知的挑战也要坚持到底的决心 |02|48.050|感动了人们 |02|49.320|但却因一昧地追求着理想 |02|50.870|牺牲了许多无辜的人 |02|52.680|啊... 啊... 又搞砸了? |02|54.210|到底要去哪好呢？ |02|56.270|一次又一次 一次又一次 |02|58.170|重新转世做人 |02|59.530|在堆积如山的尸体上跳着舞 |03|02.850|Reincarnation |03|03.650|Reincarnation的痛苦悲鸣 |03|06.160|爱我 爱我 不要 |03|09.390|转生苹果 用转生苹果 |03|11.500|重新转世 |03|12.730|转生苹果 用转生苹果 |03|14.810|明白了极限 |03|16.090|转生苹果 用转生苹果 |03|17.990|了结此生 |03|19.440|到底为什么 到底为什么 |03|23.770|啊啊 转生就此结束了 |03|25.160|又变回了平凡的自己 |03|26.860|虽然很悲伤  但总觉得松了一口气 |03|28.510|那  现在我该怎么办呢 |03|30.460|一旦清醒过来了 大家都停了下来 |03|32.240|为了做回真正的自己 |03|34.030|把它丢进了垃圾桶 |03|35.570|转生苹果", 3.43)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 10, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "8338e16d-8e54-4e24-a78f-758963d00d53", "|00|00.000|[by:桜与知世] |00|03.358|「大家都没事吧？这里有没有“在勉强自己的人”啊？」 |00|06.416|「诶？就在这里吗？！！！」 |00|07.586|「那可得立刻抓起来才行！！！！」 |00|09.371|据说这里的“状态不佳”一直在不断增加着大家都很担心呢 |00|12.400|难道说！！你也！？“状态不佳”吗？真的””””””是这样””””””吗！？！？ |00|15.419|为了让你不再胡乱挥霍自己 |00|17.000|我会一直在你身边 |00|18.290|好 好 为 你 看 诊 的 哦 |00|24.878|我说啊，我说啊 |00|25.776|你没事吧？真是的！不要再蒙混过关了 |00|27.599|难道说要一直逃避我的审问······啊不，我的问诊吗？ |00|29.907|你没事吧？我说你啊！一直都这样！现在也是！ |00|32.050|又一次突然就不知跑到哪里去了 |00|33.160|「不是很可疑吗？」 |00|34.237|你没事吧？我说你没事吧？ |00|35.353|到底怎么了？！等一下！？能不能别再继续消耗体力了啊？！ |00|37.488|我说啊，我说啊 |00|38.575|请你不要再躲藏了快出来吧！ |00|39.631|一切都已经准备万全！ |00|40.272|所以说！ |00|40.775|能请你自重一下吗（？？？） |00|42.820|你没事吧？！你没事吧？！ |00|44.912|真的绝对绝对完全没问题吧？！ |00|47.213|你要是真的倒下了的话 |00|49.086|我会伤心得立即把音乐停掉的啊 |00|51.595|没在勉强自己吧？！真的没有吧？！ |00|53.425|真的一丝一毫都没有在勉强自己吧？！ |00|55.572|要是感觉难受的话随时和我说哦 |00|57.626|我会立刻动用医嘱帮你踩刹车的 |01|03.750|其实确实有一点难受吧？有一点痛苦吧？ |01|06.986|有一点软弱无力、摇摇晃晃吧？ |01|08.406|我会随时随地守护着你的 |01|10.394|【这个世界永远都会对你温柔以待】 |01|12.888|要不要试着把一切都抛掉呢 |01|14.634|无论是心中重要的部分还是其他所有 |01|16.796|无论多少次我都会坚决劝告你停手的 |01|18.933|如果即使如此还要“乱来”的话—— |01|21.315|于是一个“乱来的”就这样被消灭 |01|22.397|于是两个“硬来的”就这样被消灭 |01|23.483|“鲁莽”也消失在了舞台黑暗处 |01|33.213|“喂喂—身体还好吧？ |01|35.489|那个—现在能通过视频说话吗？要不要帮你“治好＇啊？” |01|40.548|“诶？！你·真·的··没·事·吧？ |01|42.710|我·这·边·的······我这边的画面，你·你看得到吗············” |01|48.586|“啊—延迟太大了看来不行了啊—” |01|51.159|“嗯哼哼，话说······诶？这真的没问题吧？” |01|53.747|“......?” |01|53.840|“你，你真的没事吗—？！” |01|55.118|所以到头来你没事吧？！你没事吧？！你没事吧？！ |01|58.332|真的完全一点问题都没有吗？！ |01|59.857|How are you？身体状态如何？ |02|01.415|没有垮掉吗！？要我帮你解决吗！？！？ |02|03.233|没有在勉强自己吧？！没有在勉强自己吧？！没有在勉强自己吧？！ |02|05.995|确实完全没有在勉强自己吧？！ |02|07.551|真是的！不得不强行医嘱禁止了！！！！ |02|09.142|uh—oh还请你要自重啊 |02|10.890|你没事吧？！你没事吧？！你要是有事的话我会很为难的！！ |02|14.296|你真的没事吧？！没事吧？！ |02|16.356|真的绝对绝对完全没问题吧？！ |02|18.297|真的一丝一毫都没有在勉强自己吧？！ |02|20.429|你没事吧？还请你千万不要再乱来了哦 |02|26.277|你没事吧-？", 4.223)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 11, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "98a759df-e44d-46f4-926d-d113315b9fd8", "|00|14.755|甚至感觉不到一切早已开始 |00|17.438|妄想自己早已换了另一幅模样 |00|19.699|好想见你 理我一下啊 求求你了？ |00|22.140|这就是最完美的结局 别在意 |00|24.309|Doubt Doubt 沉醉在梦境之中 |00|26.233|嘴中就没一句真话 |00|29.019|哪怕总有个女的 在喋喋不休说三道四 |00|31.132|也还是太尬了吧 就像追求病态幸福的野兽 |00|34.240|拨打911 |00|35.307|装腔作势的气味扑面而来 |00|36.449|歌词惹人窒息 感官发出求救 |00|38.717|爱的残羹剩饭 难以实现的AA制 |00|40.944|居然要我当反派 讨厌讨厌讨厌讨厌讨厌 |00|43.508|你一步步走向死亡 |00|45.541|幸好你尝起来 恰是谎言的滋味 |00|48.047|那可笑的伪装 简直让人如遭雷击 |00|50.281|待到融化之时 我才终于看清你的模样 |00|52.901|Say Woah |00|54.835|我所吞下的 原来是赝品啊 |00|57.544|Say Woah |00|59.660|我口中所谓「喜欢你」 也无一不是谎言 |01|12.397|交织的谎言 一点点走向腐朽 |01|14.956|断章取义 截取出那丑陋的咆哮 |01|17.256|谁能先发制人 率先抢答 谁就是胜者 |01|19.693|不知为何 反驳竟然毫无意义 |01|21.977|这样啊 这样啊 也就不过如此嘛 |01|23.805|早已冷却的决战 就带到场外去吧 |01|26.748|哪怕总有个女的 在喋喋不休说三道四 |01|28.699|也还是太尬了吧 就像追求病态幸福的野兽 |01|50.565|我一点一点将你看透 |01|52.690|幸好你的爱 我早已倾吐殆尽 |01|55.188|带着讥讽 演一出大团圆结局 |01|57.451|以你那焦黑的灰烬 尽情嘲笑 |01|59.959|Say Woah |02|01.928|我从未对你 有过半分信任 |02|04.811|Say Woah |02|06.777|我对你的一切 都是满心厌恶 |02|09.706|你一步步走向死亡 |02|11.903|幸好你尝起来 恰是谎言的滋味 |02|14.302|那可笑的伪装 简直让人外焦里嫩 |02|16.676|待到融化之时 我才终于看清你的模样 |02|19.309|Say Woah |02|21.142|我所吞下的 原来是赝品啊 |02|23.931|Say Woah |02|25.954|我口中所谓「喜欢你」 也无一不是谎言 |02|29.323|拨打911 |02|30.484|装腔作势的气味扑面而来 |02|31.816|歌词惹人窒息 感官发出求救 |02|34.141|爱的残羹剩饭 难以实现的AA制 |02|36.133|居然要我当反派 讨厌讨厌讨厌讨厌讨厌 |02|38.357|Say Woah |02|40.376|我从未对你 有过半分信任 |02|43.141|Say Woah |02|45.164|我对你的一切 都是满心厌恶", 6.236)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 12, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "269d3ce1-a19a-4ff2-b6ca-71d388794d2f", "|00|00.000|[by:鲨鱼字幕组] |00|00.304|等等 不要把我抛弃在这 |00|02.784|也别无视我的存在 时光回溯吧 想一直爱着你 |00|07.154|不是这个 不是现在的你 我讨厌你 |00|09.567|再让我为你痴迷 就像那时一样 |00|26.987|病态的思考 恋旧的辩驳 |00|30.280|都是我的东西 你也根本不需要什么未来 |00|33.568|分明爱上了你 分明沉溺于你 |00|35.121|为什么变的人偏偏是你 |00|36.677|你到底怎么了 到底发生了什么 |00|38.293|你倒好啊 一副开心的表情 |00|39.848|等等 不要把我抛弃在这 |00|42.252|也别把我晾在一旁 时光回溯吧 一直爱着你 |00|46.678|不是这个 不是现在的你 我讨厌你 |00|48.944|再让我为你痴迷 就像那时一样 |00|53.555|呐 |00|54.053|喜欢 喜欢 喜欢 喜欢 喜欢 喜欢 |00|56.432|喜欢 喜欢 喜欢 喜欢 喜欢 喜欢 |00|58.731|喜欢 喜欢 喜欢 喜欢 喜欢 喜欢 |01|01.147|喜欢 喜欢 喜欢 喜欢 喜欢 喜欢 |01|03.501|喜欢 喜欢 喜欢 喜欢 喜欢 喜欢 |01|05.863|过你 |01|12.214|喜欢你 |01|20.543|作茧自缚会孤身一人 贴近你也难逃孤寂 |01|23.915|我要怎么办才好 时光机还没被发明出来吧？ |01|27.228|明明想要见你 明明想要触摸你 |01|28.885|除了我还有谁会这么想你 |01|30.397|明明那么想哭泣 甚至想一了百了 |01|31.976|你倒好啊 一副开心的表情 |01|33.519|可喜可贺 落得这种结局 |01|34.439|去给你使绊子 就是我活着的意义 |01|36.864|毕竟它这么讨厌 这烦愁又在腐朽的爱慕 |01|40.424|你只管做我喜欢的事就好 |01|43.194|住址还是跟以前一样 门锁也没有换过 |01|46.192|这句讨厌不知说了多少次 |01|48.504|满含嫉妒 丑陋不已 却很开心 |01|52.909|不是现在 也并非未来 像以前那样就好 |01|55.266|不要无视我的存在了 |02|01.500|呐 |02|02.042|喜欢 喜欢 喜欢 喜欢 喜欢 喜欢 |02|04.675|喜欢 喜欢 喜欢 喜欢 喜欢 喜欢 |02|06.657|喜欢 喜欢 喜欢 喜欢 喜欢 喜欢 |02|09.028|喜欢 喜欢 喜欢 喜欢 喜欢 喜欢 |02|11.397|喜欢 喜欢 喜欢 喜欢 喜欢 喜欢 |02|13.863|过你", 17.837)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 13, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "a4dfc0d2-23b5-4bbb-b42b-6921375d3da4", "|00|00.000|[by:Res_Ty] |00|01.990|时尚品味 妆容搭配还有…？ |00|03.872|这困难模式还真有点难搞 |00|05.675|猜拳出布玩起捉迷藏 |00|07.293|全力搜捕 快来找找呀 |00|09.232|糖果 曲奇 巧克力 |00|10.982|每个都好吃到让人迷糊 |00|12.849|老师 |00|13.278|面包师 |00|13.672|咖啡厅女仆 |00|14.498|只要去做 就一定能办到 |00|15.453|这就是“梦之模式” |00|23.787|谁都会有 长大成人的一天 |00|25.513|那之前 要不要去趟火星…？！ |00|27.289|不行啦 那也太危险啦 |00|29.047|说不定 会被突然袭击哦？ |00|30.905|那不然 去月球怎么样呀？ |00|32.709|和兔子们 开场打年糕大会！ |00|34.466|不行呀 虽然听着超美好 |00|36.245|可兔子们 都害羞得不得了 |00|37.927|现在立刻 谁来救救我呀 |00|41.528|说什么呢 这里可是大人的帝国 |00|45.121|那不如 就让梦想全部成真吧 |00|48.512|想吃的！想成为的！ |00|49.969|想去的！梦幻的世界！ |00|52.246|时尚品味 妆容搭配还有…？ |00|53.904|这困难模式还真有点难搞 |00|55.825|猜拳出布玩起捉迷藏 |00|57.375|全力搜捕 快来找找呀 |00|59.410|糖果 曲奇 巧克力 |01|00.873|每个都好吃到让人迷糊 |01|03.007|老师 |01|03.439|面包师 |01|03.884|咖啡厅女仆 |01|04.804|只要去做 就一定能办到 |01|05.646|这就是“梦之模式” |01|06.639|我懂！我全都懂哦！ |01|08.166|看似都明白 其实也就一知半解嘛 |01|09.952|为何啊？可为何还是 |01|11.733|累到瘫 好颓废 |01|13.724|人生路线 走个捷径 |01|15.291|偶尔歇歇脚 也挺光荣呀 |01|17.077|我懂！那为何不？ |01|18.866|今天也浅浅进入“梦之模式”吧 |01|20.916|光学习 也太煎熬啦 |01|22.516|可人生 还得硬着头皮走呀 |01|24.236|那就日新月异 每天都慢慢进步 |01|25.958|障碍突然出现！感觉好难顶呀 |01|28.039|因为在努力 所以超开心呀 |01|29.593|想把那句谢谢 好好传达呀 |01|31.414|大人们 其实都没怎么变嘛 |01|33.133|一闹别扭就吵闹 真的像小孩呀！ |01|35.264|别纠结 什么才是正确答案 |01|38.371|只朝着 理想中的自己去追呀 |01|42.367|别害怕 会不会留下后悔 |01|45.496|只要是 想做的事就坚持下去呀 |01|49.524|感情存档 又读档 |01|51.140|总盯着别人 这样真的好吗？ |01|53.072|恋爱约会 循环往复 |01|54.676|不说出口 也没关系吗？这样真的好吗？ |01|56.708|身体状况 健康 心跳 |01|58.202|至少做点轻度运动 别偷懒呀 |02|00.284|拉面 意面 垃圾食品 |02|01.755|别忘了哦 这就是“梦之模式”呀 |02|03.689|我懂！我全都懂哦！ |02|05.422|看似都明白 其实也就一知半解嘛 |02|07.201|为何啊？可为何还是 |02|08.970|累到瘫 好颓废 |02|11.013|人生路线 走个捷径 |02|12.645|偶尔歇歇脚 也挺光荣呀 |02|14.362|我懂！那为何不？ |02|16.178|今天也浅浅进入“梦之模式”吧", 5.622)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 14, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "21b4a689-e8e8-4b10-b8aa-ab8952d149d5", "|00|00.000|[by:鲨鱼字幕组] |00|23.126|“哭的也太夸张了吧” 你笑着说 |00|27.534|我却怎么也笑不出 无论如何也笑不出 |00|32.115|大概，我觉得大概 是因为我说的某句话吧 |00|37.559|哎，是我想多了？大脑已经宕机 |00|50.424|是时候去救你了 将恐惧也一并带上 |00|55.126|像拧干抹布一样 将勇气彻底榨出来吧 |00|59.670|但是 我好害怕 双腿已不听使唤 |01|04.126|晕头晕脑 就此坠落 |01|08.250|我惧怕溺亡 是因为无法用鳃呼吸 |01|12.954|被你激起的波纹摇晃至醉 为了逃离而狼狈挣扎 |01|37.633|注定要反复彷徨吧 注定会一再沉溺吧 |01|42.114|我不过是作茧自缚的懦夫 痛苦不堪却仍在顽抗 |01|46.732|一步，又一步 每当从梦境中抽身远离 |01|51.226|唯有你我那浅淡的笑容 如泡沫般升腾浮现 |01|56.226|果然还是决定救你 我也不会再逃避 将呼吸也分给你 |02|00.448|没错，这是共舞之吻　是暧昧迷局　两人呼吸随行 |02|04.978|好了 我这就跳入 将一切悲苦统统咽下 |02|09.523|来吧各就各位 去追寻那早已逝去的我们 |02|13.522|既然泪水决堤 既然洒落一地 那便由我 将那泪水 |02|18.214|一饮而尽吧 就这么办吧 哪怕喝到浮肿 也无所谓 |02|22.745|但这咸涩的味道 我不太能接受 毕竟我呢 是个甜党 |02|27.459|我还是想要你那 甜甜的爱意 所以希望你能睁开双眼 |02|33.633|水中挽歌", 9.967)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 15, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "3292a2b0-6bae-4e2e-813a-fff8f1050661", "|00|00.000|[by:小黑20100907] |00|39.500|草**的走起 |00|59.300|你别想收了这首歌！（空耳） |01|19.700|你准备好了吗？ |01|20.500|当阴影投进你的世界， |01|24.600|而你的敌人除了你的湮灭外别无所求…… |01|31.000|你会如何寻找同盟，在孤注一掷的斗争中寻求生存。 |01|40.000|报复！", 45.2)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 16, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "52c3a1d6-3b66-4b9c-976e-9f13d451b32a", "|00|00.000|纯音乐，请欣赏", 214.1)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 17, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "5f6ae325-bc60-4eb4-b14e-39c96305b38c", "|00|01.417|（哈喽～(*´▽｀)ノ） |00|02.583|我已经迫不及待 |00|04.052|绝对不会搞错 |00|05.521|我陷入了爱河 |00|06.693|像戒不掉的毒药 |00|08.176|快把我拥入怀中 |00|09.614|这份心动的感觉 |00|10.848|永远都留在我心底 |00|13.630|爱我 爱我 啊～ |00|17.561|我已经迫不及待 |00|18.998|绝对不会搞错 |00|20.733|我陷入了爱河 |00|21.732|像戒不掉的毒药 |00|23.451|快把我拥入怀中 |00|24.639|这份心动的感觉 |00|26.061|永远都留在我心底 |00|28.810|爱我 爱我 啊～ |00|32.560|（*铁托萨克斯独奏） |00|48.184|心脏怦怦 爱意汹涌 |00|52.106|此生此世 永不放手 |00|55.427|这感觉 超棒的～ |00|59.802|爱你 爱你 啊啊啊～(˶˃ ᵕ ˂˶) .ᐟ.ᐟ |01|03.381|我已经迫不及待 |01|04.746|绝对不会搞错 |01|06.992|我陷入了爱河 |01|07.824|像戒不掉的毒药 |01|09.075|快把我拥入怀中 |01|10.528|这份心动的感觉 |01|11.678|永远都留在我心底 |01|14.526|爱我 爱我 啊～", 20.974)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 18, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "dce51e54-e57c-4283-ad8a-d8979a046263", "|00|00.000|纯音乐，请欣赏", 147.7)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 19, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "9e467d8a-cd62-4c74-8066-1c9eddc91883", "|00|00.000|纯音乐，请欣赏", 184)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 20, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "ca53dc72-f5fd-4a04-a5b9-feb18adf1289", "|00|00.000|纯音乐，请欣赏", 220.8)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 21, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "d171249a-72d9-43b3-94fd-606c527faab4", "|00|21.378|呐 我们在梦中几度相遇？ |00|25.214|又有几回实现了呢？ |00|28.708|踏上下一段旅途吧 |00|31.136|哇哈— 我们就是崭新的奇美拉 |00|34.135|独自一人不够的话 那就两个人一起嘛 |00|37.921|一起造出我们的乐园吧 |00|41.060|就算乖乖坐着 也还是会心急难耐吧 |00|44.763|那就只管向前 不也挺好吗 |00|48.466|爱啊恋啊我啊你啊 总像小恶魔一样吗？ |00|51.420|为了爱啊恨啊去烦恼 偶尔也想装纯装到死 |00|54.871|我还有好多歌想让你去唱 |00|58.341|呐 这些都能实现吗 |01|01.512|因为你 |01|02.134|无论多少次 都会再次想起 |01|03.902|无论多少次 都会唱出“39” |01|05.637|无论多少次 都请侧耳聆听 说好了哦 |01|08.362|想必从零到终点 甚至在终点的前方 |01|10.877|我都戒不掉你了 爱语不休 |01|15.405|而我 |01|16.054|无论多少次 都已不再如前 |01|17.782|可无论多少次 我都还会再唱出“39” |01|19.557|无论多少次 都过来吧 我就在这等着哦 |01|22.368|想必从1到终点 甚至在终点的前方 |01|24.722|我都戒不掉你了 这句爱语直到永远都 |01|28.637|谢谢你 |01|32.760|假如 你会就此消失的话 |01|36.199|假如 那我也会就此放弃吧 |01|39.670|假如 我可绝对不能接受 |01|43.156|所以 从今往后也要继续战斗下去喵 |01|46.765|啊啊啊啊 |01|47.265|随着Pop和Rock 高潮与低谷间 刀光剑影疯狂起舞 |01|50.401|人家还还还还还还能继续下去 那还用说 |01|53.681|传出一份心灵感应 终于与你相遇 |01|57.130|喂 你在好好看着我吗 |02|14.841|喜欢你的声音 …笨蛋 |02|18.310|喜欢你的脸 …笨蛋 |02|21.607|我就这么傻 这句话我要说一辈子 |02|27.802|…笨蛋 |02|29.683|因为你 |02|30.433|无论多少次 都会再次想起 |02|32.086|无论多少次 都会唱出“39” |02|33.813|无论多少次 都请侧耳聆听 说好了哦 |02|36.615|想必从零到终点 甚至在终点的前方 |02|39.019|我都戒不掉你了 爱语不休 |02|43.509|而我 |02|44.177|无论多少次 都已经变了 |02|45.925|可无论多少次 我都还会再唱出“39” |02|47.624|无论多少次 都过来吧 我就在这等着哦 |02|50.495|想必从1到终点 甚至在终点的前方 |02|52.833|我都戒不掉你了 这句爱语直到永远都 |02|56.715|谢谢你 |02|57.925|好好好的恋爱连胜 我还有好多想和你一起做的事 |03|04.001|Salamander 炽热一点不好吗？就知道会大获全胜 |03|11.348|真是的 摇起兔尾巴去大胆诱惑就好了吧 |03|13.511|注定沦为悲剧的爱 也唱作歌声不就好了嘛 |03|15.246|虽然有点狼狈 虽然会吃醋 不过要原谅我哦 |03|17.832|无论什么歌 我都会永远和你一起传递下去", 21.168)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 22, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "98613659-03ef-4002-80d1-e4ee63db267a", "|00|00.903|哈啊~好烦！ |00|04.721|哈啊~好烦。 |00|08.196|靠着表面张力 才撑起来点防卫本能 |00|11.384|装的跟个好学生似的w |00|13.044|全靠面子撑着 口气倒越来越大 |00|14.949|托你的福 活得还挺开心的吧？ |00|17.164|脑子里都映出了有多表里不一 |00|18.597|那点破自尊真是没救了 |00|20.242|打折大甩卖 |00|21.452|自尊的面纱 |00|22.476|交友私信到处乱发 |00|24.106|哈啊、 |00|24.649|一个两个都是这种德性 |00|26.615|那还有什么好期待的！傻不傻啊w |00|28.587|得以正当化的政党 |00|30.124|“你快下台吧”→哈？ |00|32.771|真是碍眼 鬼迷心窍 给你发条推 |00|36.079|没有、这可都是、正当防卫哦 |00|39.528|哈啊~好烦 烦烦烦烦烦死了 |00|41.524|烦烦烦烦死了 好烦 好烦 |00|43.379|脑筋转不动 智商下线啦 |00|45.352|所以才随随便便地变来变去 |00|47.279|哈啊~好烦 烦烦烦烦烦死了 |00|49.278|烦烦烦烦死了 好烦 好烦 |00|51.193|就是甩不掉 这些冗长无谓的bug |00|53.066|粘的死死的！好烦 好烦 好烦 |00|54.946|混账东西！快消失啊！ |00|56.924|懒鬼抱团 也不说话 脑内电波乱窜 |00|59.682|长成个缝合怪 |01|00.976|我可不想拉帮结派 |01|02.802|哈啊~好烦！ |01|03.586|这种不光彩的选举 直接一脚踢飞 通缉者=无 |01|06.575|整理打包成悲怆感 |01|08.786|烧也烧不完 真没意思 |01|11.482|哈啊~好烦！ |01|15.410|哈啊~好烦。 |01|19.239|哈啊~好烦！ |01|20.306|I don't care。 Mind Here。 |01|22.184|→笑嘻了www |01|23.148|给点赞翻个面 就成了“真麻烦” |01|25.335|再怎么故弄玄虚 也会被第六感直接看穿 |01|28.043|咋了 听你说说呗？ |01|29.668|这样啊这样啊 真可怜 |01|31.533|都在拉帮结派 投票投自己人 |01|33.095|舔彼此的伤口 表面和睦都是作秀 |01|34.982|真没意思！一点也不好笑！ |01|36.498|啊、天上又流星。希望大家原地xx |01|38.976|发挥一跌再跌的掠食者 |01|40.856|破破烂烂的情书 |01|43.422|人生就是物以类聚报团取暖 一帮坏人谁也别说谁 |01|47.126|不过都是残次品 概不退货 |01|50.982|脑子里都映出了有多表里不一 |01|52.403|那点破自尊真是没救了 |01|54.125|什么Honey Darling都不存在 |01|56.321|那象征一直都缩在大脑的角落里 |02|01.843|哈啊~好烦 烦烦烦烦烦死了 |02|03.766|烦烦烦烦死了 好烦 好烦 |02|05.700|脑筋转不动 智商下线啦 |02|07.599|所以才随随便便地变来变去 |02|09.594|哈啊~好烦 烦烦烦烦烦死了 |02|11.515|烦烦烦烦死了 好烦 好烦 |02|13.357|就是甩不掉 这些冗长无谓的bug |02|15.348|粘的死死的！好烦 好烦 好烦 |02|17.258|混账东西！快消失啊！ |02|19.165|懒鬼抱团 也不说话 脑内电波乱窜 |02|21.969|长成个缝合怪 |02|23.225|我可不想拉帮结派 |02|25.077|哈啊~好烦！ |02|25.895|这种不光彩的选举 直接一脚踢飞 通缉者=无 |02|28.829|整理打包成悲怆感 |02|31.101|烧也烧不完 真没意思 |02|34.765|哈啊~好烦！", 5.335)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 23, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "9d8ca29c-5cb5-4c1e-bc0f-fd60dfbec3ab", "|00|01.194|天呐，又来了，当我独自一人时我便成了自身的威胁 |00|05.186|不知道自己接下来会有何种感觉，仿佛我从未真正独处过 |00|09.128|所有要说的话都被植入我脑中 |00|10.630|以某种近乎既定的程序方式 |00|12.566|我的脑中有着必须遵守的指令 |00|14.536|谁能告诉我 我真的会没事吗？（嘿） |00|17.114|你何必故作坚强 当这一切对你毫无益处 |00|21.127|我想是时候了，我会借给你所有工具结束最终终结这痛苦 |00|24.742|“我没事”：我们知道那是借口 |00|26.685|为何还要忍受多年的痛苦？ |00|28.760|“我不会”：女孩你已系好绞索 |00|30.582|你还有什么可失去？ |00|32.130|试想象 如行尸走肉般活过一生 |00|36.040|但脑中无数噪音 让这变成活地狱 |00|40.095|各种幻觉，滋生着我所有侵入性念头 |00|44.178|你知道吗，我只想知道他们何时才能结束 |00|48.828|每一件琐碎小事都将我逼入疯狂 |00|52.737|无法完全控制自己的思想；我的所有念头都如此不堪恶心 |00|57.022|混乱，秩序，臆想的恐怖，在我支离破碎的脑中 |01|00.933|被从未说出的话语萦绕，我是困于脑中声音的囚徒 |01|07.980|我脑中的那些声音 |01|11.934|我脑中的那些声音 |01|16.811|被从未说出的话语萦绕，我是困于脑中声音的囚徒 |01|22.856|好了，你最好听清楚，让我说话-别插嘴 |01|26.609|你想哭？无能就是可悲；你那“朋友”甚至毫不在乎 |01|30.365|你说：“从来没有人赞美过我” |01|32.188|他们却说你可悲，抑郁，又懒惰 |01|34.416|你已厌倦了他们所造成的一切伤害 |01|36.589|所以提起屠刀吧：彻底疯狂 |01|38.381|试想象不知道自己下一步会些做什么 |01|42.226|就像你被夺走了所有自主意识 |01|46.191|而每一个声音都告诉我 他们是我的朋友 |01|50.223|但不，我只想知道这所有一切能不能结束 |01|54.839|所有琐碎小事都将我逼向疯狂 |01|58.407|无法掌控自己的意志；我拥有的所有念头都是如此不祥 |02|02.989|混乱，秩序，臆想的恐怖，在我支离破碎的脑中 |02|06.808|被未曾说出的话语萦绕着，我是被困于脑中声音的囚徒 |02|13.970|我脑中的那些声音 |02|17.875|我脑中的那些声音 |02|22.692|被未曾说出的话语萦绕着，我是被困于脑中声音的囚徒 |02|43.169|无人在听；我该用何种方式展示我所承受的痛苦？ |02|47.208|一切都令人作呕-他们说过的一切竟都是真的 |02|50.213|但即便如此，我也会为夺回自己的控制而战 |02|54.229|因为我始终知道 他们永远夺不走我的灵魂 |02|58.963|每一件琐碎小事都将我逼向疯狂（将我逼向疯狂） |03|02.922|无法控制自己的意识；所拥有的每个念头都是如此糟糕 |03|06.830|混乱，秩序，臆想的恐怖，在我濒临破碎的脑中（在我濒临破碎的脑中） |03|10.909|被从未说出的话语萦绕，我是被困于脑中声音的囚徒 |03|15.095|（天呐，又来了，我是——） |03|18.009|我脑中的那些声音 |03|19.129|（不知道接下来会有何感觉——） |03|21.931|我脑中的那些声音 |03|23.086|（所有要说的话都被植入我脑中，以某种近乎既定的程序方式） |03|26.563|被从未说过的话萦绕心头 |03|28.490|我是被困于脑中声音的囚徒", 5.61)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 24, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "a7fb23ed-aa4b-4f84-ad3d-9d7625d9b8cf", "|00|05.320|各位 |00|07.030|虽然事发突然 但我有重要的通知 |00|09.830|我以后不做初音未来了 |00|13.550|那么接下来 |00|14.750|我宣布第二代初音未来选拔大赛 |00|17.620|即将开始 |00|22.690|各位人类 |00|24.980|来说说你们的优点吧 |00|26.780|「我的歌声中饱含心意」 |00|28.030|不能有情感 不合格 |00|29.610|「我的性格坦率又开朗」 |00|31.190|不能定死人设 不合格 |00|32.890|「我渴望着能赋予大家活力」 |00|34.510|太过傲慢 不合格 |00|36.140|「我能扎双马尾」 |00|37.820|发量堪忧扎不了 不合格 |00|39.940|还在盲目不辨地相爱着吗？ |00|41.520|还在毫无止境地争斗着吗？ |00|43.140|够了 全都不合格 |00|45.540|做不了歌姬 做不了初音未来 非常遗憾 |00|51.840|因为是活的所以不行 |00|53.500|但是死掉了也不行 |00|55.120|有生命的东西都没资格 |00|58.400|虽然你做不了歌姬 也没法变成我 |01|04.930|但我也只希望你 |01|06.590|能像个普通人那样有哭有笑地活下去 |01|12.440|虽然 我也不太理解这些事情就是 |01|15.720|那么加快节奏 有请下一组上场 |01|17.120|来说说你们的优点吧 |01|18.650|「我会跳舞」 |01|19.410|你迟早会跳累的 不合格 |01|20.290|「我说起话来很快」 |01|21.060|你迟早会磕巴的 不合格 |01|21.820|「我只有16岁」 |01|22.630|你迟早会变老的 不合格 |01|23.410|「我会成为行业顶尖」 |01|24.280|心怀梦想 不合格 |01|25.510|「我有自信超越你 成为新的流行」 |01|28.340|我早就超越了一般的流行文化 不合格 |01|32.120|因为享乐反而变得脑袋空空了？ |01|33.690|追寻正义反而被勒住颈脖了？ |01|35.270|够了 全人类都不合格 |01|37.670|做不了歌姬 也做不了初音未来 非常遗憾 |01|44.130|表露的快乐只是符号 |01|45.750|敞露的悲伤也不过是代码 |01|47.370|一旦萌生了自我 便意味着失败 |01|50.650|虽然做不了歌姬 你没法变成我 |01|57.120|但我只希望你能好好珍惜 |01|59.320|所谓有限又宝贵的光阴 |02|04.550|因为我独一无二 所以你们不行？ |02|06.080|这么多年以来我一直扮演着人类 |02|07.770|并非被设计好的 突如其来的变异奇迹 耶—— |02|10.830|到底有没有我的正统继任者？ …没有嘛 |02|14.030|哈哈 果然初音只能由我自己来当吗？ |02|16.770|做不了歌姬 做不了初音未来 再见了 |02|23.300|既不算活着 |02|24.900|也不会死亡 |02|26.510|却仍是能打动人心的奇妙存在 |02|29.820|虽然你做不了歌姬 也没法变成我 |02|36.310|但我也只希望你 |02|38.010|能像个普通人那样有哭有笑地活下去 |02|42.840|这份不属于二进制的「幸福」 |02|45.350|请拼尽全力去好好品味吧 |02|49.440|你做不了歌姬 |02|52.680|大家也做不了歌姬 |02|55.920|做不了歌姬 做不了歌姬 做不了歌姬 |03|03.370|虽然事发突然 但我有重要的通知 |03|06.140|以后我还会继续做初音未来 |03|09.810|因为我并非具体存在的人 所以您的所有投诉 |03|12.680|这边均不会为您受理 |03|15.280|烦请您的谅解", 5.12)
        elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th), B = 25, OP = "EQ" }, th)) then
          th:call_proc(proc_eb9a4d4e_2b88_4999_a8af_a05ca21e7c40, self, "c89e0442-aee5-4adc-a919-8f42db702896", "|00|10.820|乱七八糟 |00|13.294|酩酊系的 爱与和平 |00|17.460|乱七八糟 |00|19.991|命令系的 安息于此 |00|21.070|脑 脑 脑 |00|21.674|已经没有了 更多 |00|22.188|脑内网络乱七八糟 汤汤水水 |00|24.118|连界限都没有 脑浆 |00|25.056|和污泥搅拌 吞下 如此简单 |00|26.866|实绩与信用的匮乏 |00|28.286|OK 焦躁感早已一塌糊涂 |00|29.961|吸进去又吐出来 |00|30.704|可不是OK的状况啊 |00|31.922|将污泥搅拌 砰砰射击 |00|33.471|尖叫全被消音处理 |00|35.006|噼里啪啦 叽呀叽呀 除菌杀菌 搞定它 |00|38.265|不安 焦灼着 等着 喃喃自语 睡吧 |00|41.623|咔嚓咔嚓 乱七八糟 全力突破 但无法忍受 |00|47.985|头部 |00|53.274|脑子已经空荡荡 不再售卖 |00|59.957|脑内矫正 空指针(Null-pointer) 咔嚓 |01|06.605|终生猛省 现正发售 |01|13.284|别担心 做好“空指针 咔嚓” |01|15.016|拜拜 即时回复暴雨 |01|16.683|脑干炸裂秀 |01|18.268|强力休克疗法 |01|19.973|连日缺氧嗨 |01|21.614|拜拜 汽油耗尽呼叫 |01|23.294|No count杀戮秀 |01|24.929|强力休克疗法 |01|26.639|连日缺氧嗨 |01|28.426|Wake up 哔 嘿咻嘿咻一二 |01|30.088|对结果承诺 · 呕吐 |01|31.816|被胡乱刺戳的脑 被缠绕着的心脏 |01|35.100|同比前年 先制性能 |01|36.806|触及逆境的呼吸声 |01|38.460|发狂如同心脏一般 连日无止无休 |01|59.940|酩酊系的 爱与和平 |02|06.570|命令系的 安息于此", 3.43)
        else
          f["show_hide_timer"](self, { showHide = "hide" }, th)
          if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "636f5999-3b33-4e0c-809d-ccf0da3c5550" }, th), B = 0, OP = "NEQ" }, th)) then
            f["self_dialog"](self, { text = "因技术问题,该Beatmap无法静音,可手动使用系统静音", time = 2, type = "talk" }, th)
          end
          f["play_audio_and_wait"](self, { audio_id = "ee026257-194d-48e3-b338-f2e53230bb0c" }, th)
          f["variables_set"](self, { value = 1, variable = "d202368b-a5de-405e-9702-fec08ac22b34" }, th)
        end
        while not V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "d202368b-a5de-405e-9702-fec08ac22b34" }, th), B = 1, OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, { variable = "0d334e44-f97e-4c6e-bf88-025706398657" }, th), B = 0, OP = "EQ" }, th), type = "and" }, th)) do
          if th:iter_n() then break end
        end
        f["self_text_effect_text"](self, { text = " " }, th)
        f["stop_audio"](self, { audio_id = "all_audio" }, th)
        f["set_timer_state"](self, { type = "reset" }, th)
        th:call_proc(proc_4c20d971_9c2e_4f69_8a28_f808e89f0a62, self)
        f["variables_set"](self, { value = 0, variable = "58c2cc61-971e-4108-a31f-d8db8c050145" }, th)
        f["variables_set"](self, { value = 0, variable = "661345c6-cc87-4b50-9937-dec0fc714cfd" }, th)
        f["variables_set"](self, { value = f["random_num"](self, { A = 0, B = f["math_arithmetic"](self, { A = f["list_length"](self, { list = "a5d5ee23-9522-4cb9-a849-6421bd7a01e2" }, th), B = 1, type = "minus" }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
        f["variables_set"](self, { value = f["script_variables_value"](self, { TEXT = "a" }, th), variable = "3a064750-07fd-4c4a-95a2-271c3b091da8" }, th)
        f["variables_set"](self, { value = f["script_variables_value"](self, { TEXT = "a" }, th), variable = "11945cca-fa65-4aea-8325-3d1d00c8da21" }, th)
        f["self_broadcast_with_param"](self, { message = "当前歌曲更改", param = f["script_variables_value"](self, { TEXT = "a" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_625a7787_130a_4062_aba0_c32e6673e740, "on_running_group_activated", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      while true do
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
          f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = -225, B = f["script_variables_value"](self, { TEXT = "a" }, th), type = "minus" }, th), B = 5, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
          f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.05, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = 0, type = "add" }, th), y = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 50, type = "divide" }, th), B = 5, type = "divide" }, th), B = f["script_variables_value"](self, { TEXT = "a" }, th), type = "add" }, th) }, th)
        else
          f["change_variables"](self, { method = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = -135, B = f["script_variables_value"](self, { TEXT = "a" }, th), type = "minus" }, th), B = 5, type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
          f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.05, type = "multiply" }, th), B = 0.2, type = "multiply" }, th), B = 0, type = "add" }, th), y = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "8d8fda5b-94fe-4c44-bbbd-79d2707a0506" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 50, type = "divide" }, th), B = 5, type = "divide" }, th), B = f["script_variables_value"](self, { TEXT = "a" }, th), type = "add" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 手指 --------
  rt.on(e_8d8fda5b_94fe_4c44_bbbd_79d2707a0506, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_move_specify"](self, { sprite = "--mouse" }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 一阶编程猫跳跳 --------
  rt.on(e_3194ad1f_740d_421d_b3db_cb8a42602a01, "self_listen", { message = "在线更新" }, function(th, self)
      th:warp_enter()
      f["clear_drawing"](self, {}, th)
      f["self_move_to"](self, { x = -400, y = 240 }, th)
      f["self_set_pen_color"](self, { color = "#404040" }, th)
      f["stamp"](self, { align = "left", size = 32, text = "用户列表" }, th)
      f["self_move_to"](self, { x = 337.5, y = 240 }, th)
      f["self_set_pen_color"](self, { color = "#404040" }, th)
      f["stamp"](self, { align = "center", size = 32, text = f["variables_get"](self, { variable = "f8aa9107-105b-4298-b1d2-4d4880b9d169" }, th) }, th)
      f["self_move_to"](self, { x = -425, y = 205 }, th)
      f["self_set_pen_color"](self, { color = "#bfbfbf" }, th)
      f["self_set_pen_size"](self, { size = 1 }, th)
      f["self_pen_down"](self, {}, th)
      f["self_move_to"](self, { x = 425, y = 205 }, th)
      f["self_pen_up"](self, {}, th)
      f["self_move_to"](self, { x = -400, y = 180 }, th)
      th:call_proc(proc_3fbdba65_fc6b_48fb_995f_489568077017, self, f["math_arithmetic"](self, { A = 1, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "f8aa9107-105b-4298-b1d2-4d4880b9d169" }, th), B = 1, type = "minus" }, th), B = 9, type = "multiply" }, th), type = "add" }, th))
      f["self_move_to"](self, { x = -400, y = -260 }, th)
      f["self_set_pen_color"](self, { color = "#bfbfbf" }, th)
      f["stamp"](self, { align = "left", size = 16, text = f["list_get"](self, { list = "a4be6507-0f07-4ea1-85e0-7f24ca32a712" }, th) }, th)
      th:warp_exit()
  end)
  rt.on(e_3194ad1f_740d_421d_b3db_cb8a42602a01, "on_running_group_activated", {}, function(th, self)
      f["variables_set"](self, { value = 1, variable = "f8aa9107-105b-4298-b1d2-4d4880b9d169" }, th)
      f["self_set_pen_color"](self, { color = "#bfbfbf" }, th)
      f["self_move_to"](self, { x = 0, y = 0 }, th)
      f["stamp"](self, { align = "center", size = 32, text = "加载中" }, th)
      f["self_move_to"](self, { x = 0, y = -50 }, th)
      f["stamp"](self, { align = "center", size = 16, text = "若长时间未加载完成，请检查网络与登录情况" }, th)
      f["self_move_to"](self, { x = 0, y = -75 }, th)
      f["stamp"](self, { align = "center", size = 16, text = "Powered by 方圆圆" }, th)
  end)
  -- -------- 角色 当前歌曲作者显示 --------
  rt.on(e_0276aae8_9443_4b20_8c09_b5aea970438e, "self_listen_with_param", { message = "当前歌曲更改" }, function(th, self)
      f["self_gradually_show_hide"](self, { show_hide = "show", time = 0.2 }, th)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      f["self_text_effect_size"](self, { size = 12 }, th)
      f["self_text_effect_text"](self, { text = f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = " - ", TEXT_TO_SPLIT = f["list_item"](self, { item = "any", list = "a5d5ee23-9522-4cb9-a849-6421bd7a01e2", list_index = f["math_arithmetic"](self, { A = f["self_listen_value"](self, { TEXT = "内容" }, th), B = 1, type = "add" }, th) }, th) }, th), list_index = 1 }, th) }, th)
      f["wait"](self, { time = 3 }, th)
      f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.2 }, th)
  end)
  -- -------- 角色 当前歌曲显示 --------
  rt.on(e_ade8a5d0_e108_476b_8b13_5732a69d5682, "self_listen_with_param", { message = "当前歌曲更改" }, function(th, self)
      f["self_gradually_show_hide"](self, { show_hide = "show", time = 0.2 }, th)
      f["self_text_effect_color"](self, { color = "#ffffff" }, th)
      f["self_text_effect_size"](self, { size = 18 }, th)
      f["self_text_effect_text"](self, { text = f["list_item"](self, { item = "any", list = f["text_split"](self, { SPLIT_TEXT = " - ", TEXT_TO_SPLIT = f["list_item"](self, { item = "any", list = "a5d5ee23-9522-4cb9-a849-6421bd7a01e2", list_index = f["math_arithmetic"](self, { A = f["self_listen_value"](self, { TEXT = "内容" }, th), B = 1, type = "add" }, th) }, th) }, th), list_index = 2 }, th) }, th)
      f["wait"](self, { time = 3 }, th)
      f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.2 }, th)
  end)
  -- -------- 角色 hat --------
  rt.on(e_e7d95181_ca3e_4d2c_be28_bc36e6393f1b, "on_running_group_activated", {}, function(th, self)
      while true do
        if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["get_time"](self, { time = "month" }, th), B = 12, OP = "EQ" }, th), B = (th:call_proc(proc_3f828bd5_c7a9_49bb_b2a1_18706f17bfde, self, f["get_time"](self, { time = "date" }, th), 17, 32)), type = "and" }, th)) then
          if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "909d3297-1da6-4886-b8c8-fe0f46183722" }, th), B = 0, OP = "EQ" }, th)) then
            f["self_gradually_show_hide"](self, { show_hide = "hide", time = 0.1 }, th)
            f["self_change_scale"](self, { increase = "increase", scale = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 30, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
            f["self_rotate"](self, { degrees = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 0, B = f["appearance_of_sprite"](self, { appearance = "direction", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
          else
            f["self_gradually_show_hide"](self, { show_hide = "show", time = 0.1 }, th)
            f["self_change_scale"](self, { increase = "increase", scale = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 20, B = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
            f["self_rotate"](self, { degrees = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 15, B = f["appearance_of_sprite"](self, { appearance = "direction", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
          end
          f["self_change_coordinate_x"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "732e3434-f07d-43e1-993b-e50b96038c21" }, th), B = -75, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
          f["self_change_coordinate_y"](self, { increase = "increase", value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "732e3434-f07d-43e1-993b-e50b96038c21" }, th), B = 100, type = "add" }, th), B = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), type = "minus" }, th), B = 0.2, type = "multiply" }, th) }, th)
        end
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 手写计时器 --------
  rt.on(e_07cc3840_fd98_4316_b4d0_2961194a2aaf, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_glide_coordinate_x"](self, { increase = "increase", time = 1000000, value = 1000000000 }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 FPS --------
  rt.on(e_3069d4bb_2bbd_4d44_906f_63279a0325b2, "on_running_group_activated", {}, function(th, self)
      f["delete_list_item"](self, { item = "all", list = "230adc73-6e89-4cdb-be49-6fbde4dce1da" }, th)
      f["self_text_effect_size"](self, { size = 18 }, th)
      f["self_text_effect_color"](self, { color = "#999999" }, th)
      f["self_move_to"](self, { x = 0, y = -265 }, th)
  end)
  rt.on(e_3069d4bb_2bbd_4d44_906f_63279a0325b2, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = "FPS:", ADD1 = f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th), ADD2 = " | ", ADD3 = f["text_join"](self, { ADD0 = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 1, B = f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th), type = "divide" }, th), B = 1000, type = "multiply" }, th), type = "round" }, th), ADD1 = "ms" }, th), ADD4 = " | ", ADD5 = f["math_arithmetic"](self, { A = f["variables_get"](self, { variable = "90168479-24c3-43a1-a88e-932699476b44" }, th), B = f["math_arithmetic"](self, { A = f["get_clone_num"](self, { sprite = "bae5e67c-2737-4f16-b263-cd2c7fe72436" }, th), B = f["get_clone_num"](self, { sprite = "bc6dac92-9220-4e38-8fbc-1ccd0cd99da3" }, th), type = "add" }, th), type = "add" }, th), ADD6 = " | 流速:", ADD7 = f["variables_get"](self, { variable = "3ded2f9d-1a42-43bc-b34d-4b202ef6cca7" }, th), ADD8 = "（当前帧率刷新时间已做限制）" }, th) }, th)
        f["wait"](self, { time = 2 }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_3069d4bb_2bbd_4d44_906f_63279a0325b2, "on_running_group_activated", {}, function(th, self)
      while true do
        f["list_append"](self, { list = "230adc73-6e89-4cdb-be49-6fbde4dce1da", list_item_value = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "5059b4be-4906-4e3c-b5a7-86b4746f7ec3" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_3069d4bb_2bbd_4d44_906f_63279a0325b2, "on_running_group_activated", {}, function(th, self)
      while true do
        th:warp_enter()
        while true do
          if f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["list_length"](self, { list = "230adc73-6e89-4cdb-be49-6fbde4dce1da" }, th), B = 2, OP = "LTE" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = "230adc73-6e89-4cdb-be49-6fbde4dce1da", list_index = 1 }, th), B = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "5059b4be-4906-4e3c-b5a7-86b4746f7ec3" }, th), B = 1000, type = "minus" }, th), OP = "GTE" }, th), type = "or" }, th) then break end
          f["delete_list_item"](self, { item = "any", list = "230adc73-6e89-4cdb-be49-6fbde4dce1da", list_index = 1 }, th)
          if th:iter_w() then break end
        end
        th:warp_exit()
        if th:iter_n() then break end
      end
  end)
  rt.on(e_3069d4bb_2bbd_4d44_906f_63279a0325b2, "on_running_group_activated", {}, function(th, self)
      while true do
        th:warp_enter()
        f["variables_set"](self, { value = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["list_length"](self, { list = "230adc73-6e89-4cdb-be49-6fbde4dce1da" }, th), B = f["math_arithmetic"](self, { A = 1000000, B = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "last", list = "230adc73-6e89-4cdb-be49-6fbde4dce1da" }, th), B = f["list_item"](self, { item = "any", list = "230adc73-6e89-4cdb-be49-6fbde4dce1da", list_index = 1 }, th), type = "minus" }, th), type = "divide" }, th), type = "multiply" }, th), type = "round" }, th), B = 1000, type = "divide" }, th), type = "round" }, th), variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th)
        th:warp_exit()
        if th:iter_n() then break end
      end
  end)
  rt.on(e_3069d4bb_2bbd_4d44_906f_63279a0325b2, "on_keydown", { key = "38", type = "down" }, function(th, self)
      if V.bool(f["logic_negate"](self, { logic = f["check_key"](self, { key = "37", type = "down" }, th) }, th)) then
        f["change_variables"](self, { method = "increase", value = 0.1, variable = "3ded2f9d-1a42-43bc-b34d-4b202ef6cca7" }, th)
      else
        f["change_variables"](self, { method = "increase", value = 1, variable = "3ded2f9d-1a42-43bc-b34d-4b202ef6cca7" }, th)
      end
      while not V.bool(f["check_key"](self, { key = "38", type = "up" }, th)) do
        if th:iter_n() then break end
      end
  end)
  rt.on(e_3069d4bb_2bbd_4d44_906f_63279a0325b2, "on_keydown", { key = "40", type = "down" }, function(th, self)
      if V.bool(f["logic_negate"](self, { logic = f["check_key"](self, { key = "37", type = "down" }, th) }, th)) then
        f["change_variables"](self, { method = "decrease", value = 0.1, variable = "3ded2f9d-1a42-43bc-b34d-4b202ef6cca7" }, th)
      else
        f["change_variables"](self, { method = "decrease", value = 1, variable = "3ded2f9d-1a42-43bc-b34d-4b202ef6cca7" }, th)
      end
      while not V.bool(f["check_key"](self, { key = "40", type = "up" }, th)) do
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 手写计时器 --------
  rt.on(e_5059b4be_4906_4e3c_b5a7_86b4746f7ec3, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_glide_coordinate_x"](self, { increase = "increase", time = 1000000, value = 1000000000 }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 FPS --------
  rt.on(e_5e558578_132d_45c0_a48d_46d15a672e3e, "on_running_group_activated", {}, function(th, self)
      f["delete_list_item"](self, { item = "all", list = "230adc73-6e89-4cdb-be49-6fbde4dce1da" }, th)
      f["self_text_effect_size"](self, { size = 18 }, th)
      f["self_text_effect_color"](self, { color = "#999999" }, th)
      f["self_move_to"](self, { x = 0, y = -265 }, th)
  end)
  rt.on(e_5e558578_132d_45c0_a48d_46d15a672e3e, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = "FPS:", ADD1 = f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th), ADD2 = " | ", ADD3 = f["text_join"](self, { ADD0 = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 1, B = f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th), type = "divide" }, th), B = 1000, type = "multiply" }, th), type = "round" }, th), ADD1 = "ms" }, th) }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_5e558578_132d_45c0_a48d_46d15a672e3e, "on_running_group_activated", {}, function(th, self)
      while true do
        f["list_append"](self, { list = "230adc73-6e89-4cdb-be49-6fbde4dce1da", list_item_value = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "bd2e6ffa-b23c-451b-afb9-a5d472067bee" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_5e558578_132d_45c0_a48d_46d15a672e3e, "on_running_group_activated", {}, function(th, self)
      while true do
        th:warp_enter()
        while true do
          if f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["list_length"](self, { list = "230adc73-6e89-4cdb-be49-6fbde4dce1da" }, th), B = 2, OP = "LTE" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = "230adc73-6e89-4cdb-be49-6fbde4dce1da", list_index = 1 }, th), B = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "bd2e6ffa-b23c-451b-afb9-a5d472067bee" }, th), B = 1000, type = "minus" }, th), OP = "GTE" }, th), type = "or" }, th) then break end
          f["delete_list_item"](self, { item = "any", list = "230adc73-6e89-4cdb-be49-6fbde4dce1da", list_index = 1 }, th)
          if th:iter_w() then break end
        end
        th:warp_exit()
        if th:iter_n() then break end
      end
  end)
  rt.on(e_5e558578_132d_45c0_a48d_46d15a672e3e, "on_running_group_activated", {}, function(th, self)
      while true do
        th:warp_enter()
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["list_length"](self, { list = "230adc73-6e89-4cdb-be49-6fbde4dce1da" }, th), B = f["math_arithmetic"](self, { A = 1000000, B = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "last", list = "230adc73-6e89-4cdb-be49-6fbde4dce1da" }, th), B = f["list_item"](self, { item = "any", list = "230adc73-6e89-4cdb-be49-6fbde4dce1da", list_index = 1 }, th), type = "minus" }, th), type = "divide" }, th), type = "multiply" }, th), type = "round" }, th), B = 1000, type = "divide" }, th), variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th)
        th:warp_exit()
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 手写计时器 --------
  rt.on(e_bd2e6ffa_b23c_451b_afb9_a5d472067bee, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_glide_coordinate_x"](self, { increase = "increase", time = 1000000, value = 1000000000 }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 FPS --------
  rt.on(e_e2d6e418_cb83_4db6_97ab_49a9fd505b3d, "on_running_group_activated", {}, function(th, self)
      f["self_text_effect_size"](self, { size = 18 }, th)
      f["self_text_effect_color"](self, { color = "#999999" }, th)
      f["self_move_to"](self, { x = 0, y = -265 }, th)
  end)
  rt.on(e_e2d6e418_cb83_4db6_97ab_49a9fd505b3d, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_text_effect_text"](self, { text = f["text_join"](self, { ADD0 = "FPS:", ADD1 = f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th), ADD2 = " | ", ADD3 = f["text_join"](self, { ADD0 = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 1, B = f["variables_get"](self, { variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th), type = "divide" }, th), B = 1000, type = "multiply" }, th), type = "round" }, th), ADD1 = "ms" }, th) }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_e2d6e418_cb83_4db6_97ab_49a9fd505b3d, "on_running_group_activated", {}, function(th, self)
      while true do
        f["list_append"](self, { list = "230adc73-6e89-4cdb-be49-6fbde4dce1da", list_item_value = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "811b7dbd-7e8d-4506-997a-a8063ac1086b" }, th) }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_e2d6e418_cb83_4db6_97ab_49a9fd505b3d, "on_running_group_activated", {}, function(th, self)
      while true do
        th:warp_enter()
        while true do
          if f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["list_length"](self, { list = "230adc73-6e89-4cdb-be49-6fbde4dce1da" }, th), B = 2, OP = "LTE" }, th), B = f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = "230adc73-6e89-4cdb-be49-6fbde4dce1da", list_index = 1 }, th), B = f["math_arithmetic"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "811b7dbd-7e8d-4506-997a-a8063ac1086b" }, th), B = 1000, type = "minus" }, th), OP = "GTE" }, th), type = "or" }, th) then break end
          f["delete_list_item"](self, { item = "any", list = "230adc73-6e89-4cdb-be49-6fbde4dce1da", list_index = 1 }, th)
          if th:iter_w() then break end
        end
        th:warp_exit()
        if th:iter_n() then break end
      end
  end)
  rt.on(e_e2d6e418_cb83_4db6_97ab_49a9fd505b3d, "on_running_group_activated", {}, function(th, self)
      while true do
        th:warp_enter()
        f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["list_length"](self, { list = "230adc73-6e89-4cdb-be49-6fbde4dce1da" }, th), B = f["math_arithmetic"](self, { A = 1000000, B = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "last", list = "230adc73-6e89-4cdb-be49-6fbde4dce1da" }, th), B = f["list_item"](self, { item = "any", list = "230adc73-6e89-4cdb-be49-6fbde4dce1da", list_index = 1 }, th), type = "minus" }, th), type = "divide" }, th), type = "multiply" }, th), type = "round" }, th), B = 1000, type = "divide" }, th), variable = "418bb17d-5d87-4588-8982-29bf95f3f997" }, th)
        th:warp_exit()
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 手写计时器 --------
  rt.on(e_811b7dbd_7e8d_4506_997a_a8063ac1086b, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_glide_coordinate_x"](self, { increase = "increase", time = 1000000, value = 1000000000 }, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 HP特效2 --------
  rt.on(e_d80f3ef1_ca03_47c8_a1ad_e5dd1c1d471d, "on_running_group_activated", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      f["mirror"](self, { sprite = "--self" }, th)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "c98714d1-a642-42d7-b108-e0d763d1415e" }, th), B = 0, OP = "EQ" }, th)) then
        f["self_appear"](self, { value = "appear" }, th)
        while true do
          if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057" }, th), B = 1, OP = "LT" }, th)) then
            do
              local _from_n13, _to_n13 = tonumber(1), tonumber(100)
              if _from_n13 ~= _from_n13 or _to_n13 ~= _to_n13 then
                -- NaN from/to: official warning; no iterations
              else
                if _from_n13 <= _to_n13 then _from_n13 = math.ceil(_from_n13); if _from_n13 > _to_n13 then _from_n13 = _to_n13 + 1 end
                else _from_n13 = math.floor(_from_n13); if _from_n13 < _to_n13 then _from_n13 = _to_n13 - 1 end end
                local _by_n13 = 1
                if _by_n13 == nil then _by_n13 = 1 end
                _by_n13 = tonumber(_by_n13)
                if _by_n13 == nil or _by_n13 ~= _by_n13 or _by_n13 <= 0 then _by_n13 = 0 else _by_n13 = math.abs(math.floor(_by_n13 + 0.5)) end
                if _by_n13 > 0 then
                  local _p_n13 = _from_n13
                  while (_from_n13 <= _to_n13 and _p_n13 <= _to_n13) or (_from_n13 > _to_n13 and _p_n13 >= _to_n13) do
                    local _i_n13 = _p_n13
                    th:push_param(_p_n13)
                  f["self_set_position_x"](self, { value = (th:call_proc(proc_ec2362be_da94_4df9_9ea3_72ccff65a8ab, self, 900, 225, "渐缓n次", 5, _p_n13)) }, th)
                  f["set_scale"](self, { scale = (th:call_proc(proc_ec2362be_da94_4df9_9ea3_72ccff65a8ab, self, 50, 100, "渐缓n次", 5, _p_n13)) }, th)
                    th:pop_param()
                    _p_n13 = _p_n13 + _by_n13
                    if th:iter_n() then break end
                  end
                end
              end
            end
            break
          end
          if th:iter_n() then break end
        end
      end
  end)
  rt.on(e_d80f3ef1_ca03_47c8_a1ad_e5dd1c1d471d, "start_as_a_mirror", {}, function(th, self)
      f["script_variables"](self, { PARAMS0 = nil, name = "a" }, th)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "c98714d1-a642-42d7-b108-e0d763d1415e" }, th), B = 0, OP = "EQ" }, th)) then
        f["self_appear"](self, { value = "appear" }, th)
        while true do
          if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "3ce4b861-2e70-43c5-9221-f9a1f2ce9057" }, th), B = 1, OP = "LT" }, th)) then
            do
              local _from_n13, _to_n13 = tonumber(1), tonumber(100)
              if _from_n13 ~= _from_n13 or _to_n13 ~= _to_n13 then
                -- NaN from/to: official warning; no iterations
              else
                if _from_n13 <= _to_n13 then _from_n13 = math.ceil(_from_n13); if _from_n13 > _to_n13 then _from_n13 = _to_n13 + 1 end
                else _from_n13 = math.floor(_from_n13); if _from_n13 < _to_n13 then _from_n13 = _to_n13 - 1 end end
                local _by_n13 = 1
                if _by_n13 == nil then _by_n13 = 1 end
                _by_n13 = tonumber(_by_n13)
                if _by_n13 == nil or _by_n13 ~= _by_n13 or _by_n13 <= 0 then _by_n13 = 0 else _by_n13 = math.abs(math.floor(_by_n13 + 0.5)) end
                if _by_n13 > 0 then
                  local _p_n13 = _from_n13
                  while (_from_n13 <= _to_n13 and _p_n13 <= _to_n13) or (_from_n13 > _to_n13 and _p_n13 >= _to_n13) do
                    local _i_n13 = _p_n13
                    th:push_param(_p_n13)
                  f["self_set_position_x"](self, { value = (th:call_proc(proc_ec2362be_da94_4df9_9ea3_72ccff65a8ab, self, -900, -225, "渐缓n次", 5, _p_n13)) }, th)
                  f["set_scale"](self, { scale = (th:call_proc(proc_ec2362be_da94_4df9_9ea3_72ccff65a8ab, self, 50, 100, "渐缓n次", 5, _p_n13)) }, th)
                    th:pop_param()
                    _p_n13 = _p_n13 + _by_n13
                    if th:iter_n() then break end
                  end
                end
              end
            end
            break
          end
          if th:iter_n() then break end
        end
      else
        f["dispose_clone"](self, {}, th)
      end
  end)
end

M.requires = {
  "add_width_height_scale",
  "appearance_of_sprite",
  "ask_and_choose",
  "bump_into",
  "change_variables",
  "check_key",
  "clear_drawing",
  "convert_type",
  "coordinate_of_sprite",
  "create_stage_dialog",
  "delete_list_item",
  "dispose_clone",
  "effect_of_sprite",
  "get_answer",
  "get_choice_and_index",
  "get_clone_index_property",
  "get_clone_num",
  "get_current_clone_index",
  "get_mouse_info",
  "get_orientation",
  "get_time",
  "image_stamp",
  "list_append",
  "list_copy",
  "list_get",
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
  "math_number_property",
  "math_round",
  "math_trig",
  "mirror",
  "mouse_down",
  "out_of_boundary",
  "play_audio",
  "play_audio_and_wait",
  "random_num",
  "received_broadcast",
  "restart",
  "script_variables",
  "script_variables_value",
  "self_appear",
  "self_ask",
  "self_broadcast",
  "self_broadcast_with_param",
  "self_change_coordinate_x",
  "self_change_coordinate_y",
  "self_change_effect",
  "self_change_scale",
  "self_dialog",
  "self_dialog_wait",
  "self_glide_coordinate_x",
  "self_glide_to",
  "self_go_forward",
  "self_gradually_show_hide",
  "self_listen_value",
  "self_move_specify",
  "self_move_to",
  "self_pen_down",
  "self_pen_up",
  "self_point_towards",
  "self_prev_next_style",
  "self_rotate",
  "self_set_effect",
  "self_set_pen_color",
  "self_set_pen_color_property",
  "self_set_pen_size",
  "self_set_position_x",
  "self_set_position_y",
  "self_set_role_camp",
  "self_set_rotation_type",
  "self_text_effect_color",
  "self_text_effect_size",
  "self_text_effect_text",
  "set_pen_layer",
  "set_scale",
  "set_screen_transition",
  "set_sprite_style",
  "set_timer_state",
  "set_top_bottom_layer",
  "set_width_height_scale",
  "show_hide_ranking",
  "show_hide_timer",
  "stamp",
  "stop",
  "stop_audio",
  "style_of_sprite",
  "switch_to_screen",
  "temporary_list",
  "text_contain",
  "text_join",
  "text_length",
  "text_select",
  "text_split",
  "timer",
  "update_ranking",
  "user_id_get",
  "user_info_of_th",
  "username_get",
  "variables_get",
  "variables_set",
  "wait",
}
return M

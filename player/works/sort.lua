-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：KN最快快速排序   version=0.27.4
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用
local __CONST = {
  { variable = "7df168a8-aae6-425c-b65e-dac39347d7a7" },
  { variable = "c4faacfe-3c08-4d1c-a63c-2a506552f75f" },
  { variable = "22e6a4e0-b80a-49df-b70b-a07c70317a4f" },
  { method = "increase", value = 1, variable = "7df168a8-aae6-425c-b65e-dac39347d7a7" },
  { method = "decrease", value = 1, variable = "c4faacfe-3c08-4d1c-a63c-2a506552f75f" },
  { variable = "4945d116-2d86-4a7c-ba16-8efccdf68b68" },
  { PARAMS0 = nil, name = "长度" },
  { CHOICE0 = "100", CHOICE1 = "1000", CHOICE2 = "10000", CHOICE3 = "自定义", question = "列表长度（一般10000）" },
  { type = "index" },
  { type = "content" },
  { text = "" },
  { TEXT = "长度" },
  { A = 0, B = 10000 },
  { list = "cb4d13be-0cd5-4a47-9d12-6a39ccda29d4" },
  { sprite = "--self", text = "点击后开始" },
}

-- ===== 自定义积木（过程）=====
local proc_21728dff_4e45_405d_9ba1_fcbc4c39cb0d, proc_75a94606_8417_4a54_a000_5ad4e192c30c, proc_8d52ef27_4e4d_4e07_a5ac_f105f3292527, proc_93f2e68c_fe2f_4d4c_acb0_d65ac1c4531c

proc_21728dff_4e45_405d_9ba1_fcbc4c39cb0d = function(th, self, p_______)
  -- 过程「d4885158-e342-4112-b0e5-699d5a7d54bd」 id=21728dff-4e45-405d-9ba1-fcbc4c39cb0d
  if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, __CONST[1], th), B = f["variables_get"](self, __CONST[2], th), OP = "LTE" }, th)) then
    proc_8d52ef27_4e4d_4e07_a5ac_f105f3292527(th, self, p_______)
    proc_93f2e68c_fe2f_4d4c_acb0_d65ac1c4531c(th, self, p_______)
    if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, __CONST[1], th), B = f["variables_get"](self, __CONST[2], th), OP = "LTE" }, th)) then
      f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = p_______, list_index = f["variables_get"](self, __CONST[1], th) }, th), variable = "22e6a4e0-b80a-49df-b70b-a07c70317a4f" }, th)
      f["replace_list_item"](self, { item = "any", list = p_______, list_index = f["variables_get"](self, __CONST[1], th), list_item_value = f["list_item"](self, { item = "any", list = p_______, list_index = f["variables_get"](self, __CONST[2], th) }, th) }, th)
      f["replace_list_item"](self, { item = "any", list = p_______, list_index = f["variables_get"](self, __CONST[2], th), list_item_value = f["variables_get"](self, __CONST[3], th) }, th)
      f["change_variables"](self, __CONST[4], th)
      f["change_variables"](self, __CONST[5], th)
    end
    proc_21728dff_4e45_405d_9ba1_fcbc4c39cb0d(th, self, p_______)
  end
end

proc_75a94606_8417_4a54_a000_5ad4e192c30c = function(th, self, p_______, p_left, p_right)
  -- 过程「函数_89」 id=75a94606-8417-4a54-a000-5ad4e192c30c
  th:warp_enter()
  f["variables_set"](self, { value = p_left, variable = "7df168a8-aae6-425c-b65e-dac39347d7a7" }, th)
  f["variables_set"](self, { value = p_right, variable = "c4faacfe-3c08-4d1c-a63c-2a506552f75f" }, th)
  f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = p_______, list_index = f["math_round"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[1], th), B = f["variables_get"](self, __CONST[2], th), type = "add" }, th), B = 0.5, type = "multiply" }, th), type = "round_down" }, th) }, th), variable = "4945d116-2d86-4a7c-ba16-8efccdf68b68" }, th)
  proc_21728dff_4e45_405d_9ba1_fcbc4c39cb0d(th, self, p_______)
  if V.bool(f["logic_compare"](self, { A = p_left, B = f["variables_get"](self, __CONST[2], th), OP = "LT" }, th)) then
    proc_75a94606_8417_4a54_a000_5ad4e192c30c(th, self, p_______, p_left, f["variables_get"](self, __CONST[2], th))
  end
  if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, __CONST[1], th), B = p_right, OP = "LT" }, th)) then
    proc_75a94606_8417_4a54_a000_5ad4e192c30c(th, self, p_______, f["variables_get"](self, __CONST[1], th), p_right)
  end
  th:warp_exit()
end

proc_8d52ef27_4e4d_4e07_a5ac_f105f3292527 = function(th, self, p_______)
  -- 过程「46c031d0-90a5-4ec8-92f6-83d12a2957a8」 id=8d52ef27-4e4d-4e07-a5ac-f105f3292527
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_______, list_index = f["variables_get"](self, __CONST[1], th) }, th), B = f["variables_get"](self, __CONST[6], th), OP = "LT" }, th)) then
    f["change_variables"](self, __CONST[4], th)
    proc_8d52ef27_4e4d_4e07_a5ac_f105f3292527(th, self, p_______)
  end
end

proc_93f2e68c_fe2f_4d4c_acb0_d65ac1c4531c = function(th, self, p_______)
  -- 过程「46c031d0-90a5-4ec8-92f6-83d12a2957a8」 id=93f2e68c-fe2f-4d4c-acb0-d65ac1c4531c
  if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = p_______, list_index = f["variables_get"](self, __CONST[2], th) }, th), B = f["variables_get"](self, __CONST[6], th), OP = "GT" }, th)) then
    f["change_variables"](self, __CONST[5], th)
    proc_93f2e68c_fe2f_4d4c_acb0_d65ac1c4531c(th, self, p_______)
  end
end

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 900, 562
M.timer_pos = { x = 720, y = 12 }
M.proc_trampoline = false
M.uses_timer = true
M.timer_hidden_default = true
M.vars = { { current_entity_id = "", cv_id = "", entity_name = "", id = "22e6a4e0-b80a-49df-b70b-a07c70317a4f", is_global = true, name = "Sort_swap", order = 3, position = { x = 20, y = 221 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "4945d116-2d86-4a7c-ba16-8efccdf68b68", is_global = true, name = "Sort_pivot", order = 2, position = { x = 20, y = 154 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "74c8a33a-f016-4d0f-863a-e7c3de6fbdf7", is_global = true, name = "长度", order = 5, position = { x = 20, y = 356 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "7df168a8-aae6-425c-b65e-dac39347d7a7", is_global = true, name = "Sort_lower", order = 0, position = { x = 20, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "c4faacfe-3c08-4d1c-a63c-2a506552f75f", is_global = true, name = "Sort_upper", order = 1, position = { x = 20, y = 87 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "cb4d13be-0cd5-4a47-9d12-6a39ccda29d4", is_global = true, name = "a", order = 4, position = { x = 20, y = 288 }, scale = 1, style = "default", type = "list", value = {  }, visible = true } }
M.screens = { { id = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a", name = "背景", screenName = "屏幕", style_index = 1, styles = { "6d0d6c61-a1df-4076-8c19-83ddfdbbca1c" }, visible = true } }
M.cur_scene = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a"
M.actors = { { id = "025dd83c-de62-46a3-86bb-2ab6333e16c2", is_global = true, name = "编程猫", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "e9792a0f-ae14-4489-90c8-dd0fd6edd6d9", "5a1f9428-61c8-4ff3-984b-78ff34bdf04d", "106119db-7ea0-4d47-a33c-65f3d2a560e1", "509a0c7c-af8b-460f-b9a5-3c273ea8394e", "70cdaef4-bd83-4797-8aec-e1edddec8765" }, visible = true, x = 0, y = -50 } }
M.assets_dir = "works"
M.assets = { ["106119db-7ea0-4d47-a33c-65f3d2a560e1"] = { adaption = nil, center = nil, file = "assets/106119db-7ea0-4d47-a33c-65f3d2a560e1.png", id = "106119db-7ea0-4d47-a33c-65f3d2a560e1", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/6e4d95aecf7441e6a9885cba405baeaf.png" }, ["509a0c7c-af8b-460f-b9a5-3c273ea8394e"] = { adaption = nil, center = nil, file = "assets/509a0c7c-af8b-460f-b9a5-3c273ea8394e.png", id = "509a0c7c-af8b-460f-b9a5-3c273ea8394e", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/25593adb06d24d988ada59c1d2131de8.png" }, ["5a1f9428-61c8-4ff3-984b-78ff34bdf04d"] = { adaption = nil, center = nil, file = "assets/5a1f9428-61c8-4ff3-984b-78ff34bdf04d.png", id = "5a1f9428-61c8-4ff3-984b-78ff34bdf04d", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/caf8f973dbe240babece35637dcafee8.png" }, ["6d0d6c61-a1df-4076-8c19-83ddfdbbca1c"] = { adaption = nil, center = nil, file = "assets/6d0d6c61-a1df-4076-8c19-83ddfdbbca1c.jpg", id = "6d0d6c61-a1df-4076-8c19-83ddfdbbca1c", name = "沼泽", styleType = 1, url = "https://creation.codemao.cn/396/8bc3a5b92e934d7287e63f1684b61de6.jpg" }, ["70cdaef4-bd83-4797-8aec-e1edddec8765"] = { adaption = nil, center = nil, file = "assets/70cdaef4-bd83-4797-8aec-e1edddec8765.png", id = "70cdaef4-bd83-4797-8aec-e1edddec8765", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/8aa8cbdbe82a442989b0fadb823444d4.png" }, ["e9792a0f-ae14-4489-90c8-dd0fd6edd6d9"] = { adaption = nil, center = nil, file = "assets/e9792a0f-ae14-4489-90c8-dd0fd6edd6d9.png", id = "e9792a0f-ae14-4489-90c8-dd0fd6edd6d9", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/c364f36a8dcf42d1a6acbe26c7eb6aaa.png" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_700824a5_44a8_4d03_a7e8_aa95d87e9b2a = ents["700824a5-44a8-4d03-a7e8-aa95d87e9b2a"]
  local e_025dd83c_de62_46a3_86bb_2ab6333e16c2 = ents["025dd83c-de62-46a3-86bb-2ab6333e16c2"]
  -- -------- 角色 编程猫 --------
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "on_running_group_activated", {}, function(th, self)
      f["script_variables"](self, __CONST[7], th)
      f["ask_and_choose"](self, __CONST[8], th)
      if V.bool(f["logic_compare"](self, { A = f["get_choice_and_index"](self, __CONST[9], th), B = 4, OP = "NEQ" }, th)) then
        f["variables_set"](self, { value = f["get_choice_and_index"](self, __CONST[10], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"长度\"}" }, th)
      else
        f["self_ask"](self, __CONST[11], th)
        f["variables_set"](self, { value = f["get_answer"](self, {}, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"长度\"}" }, th)
      end
      th:warp_enter()
      do
        local _times_n1 = f["convert_type"](self, { text = f["script_variables_value"](self, __CONST[12], th), type = "number" }, th)
        while true do
          if _times_n1 <= 0 then break end
          _times_n1 = _times_n1 - 1
          f["list_append"](self, { list = "cb4d13be-0cd5-4a47-9d12-6a39ccda29d4", list_item_value = f["random_num"](self, __CONST[13], th) }, th)
          f["variables_set"](self, { value = f["list_length"](self, __CONST[14], th), variable = "74c8a33a-f016-4d0f-863a-e7c3de6fbdf7" }, th)
          if th:iter_w() then break end
        end
      end
      th:warp_exit()
      f["create_stage_dialog"](self, __CONST[15], th)
      f["reset_timer"](self, {}, th)
      proc_75a94606_8417_4a54_a000_5ad4e192c30c(th, self, "cb4d13be-0cd5-4a47-9d12-6a39ccda29d4", 1, f["list_length"](self, __CONST[14], th))
      f["create_stage_dialog"](self, { sprite = "--self", text = f["text_join"](self, { ADD0 = "排序", ADD1 = f["list_length"](self, __CONST[14], th), ADD2 = "项花费：", ADD3 = f["get_timer"](self, {}, th), ADD4 = "秒" }, th) }, th)
  end)
end

M.requires = {
  "ask_and_choose",
  "change_variables",
  "convert_type",
  "create_stage_dialog",
  "get_answer",
  "get_choice_and_index",
  "get_timer",
  "list_append",
  "list_item",
  "list_length",
  "logic_compare",
  "math_arithmetic",
  "math_round",
  "random_num",
  "replace_list_item",
  "reset_timer",
  "script_variables",
  "script_variables_value",
  "self_ask",
  "text_join",
  "variables_get",
  "variables_set",
}
return M

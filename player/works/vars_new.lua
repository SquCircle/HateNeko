-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：我的作品   version=0.27.4
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 900, 562
M.timer_pos = { x = 720, y = 12 }
M.uses_timer = false
M.vars = { { current_entity_id = "", cv_id = "", entity_name = "", id = "3b4df9e3-fb41-47cd-9086-0fba97502517", is_global = true, name = "n", order = 2, position = { x = 20, y = 180 }, scale = 1, style = "default", type = "list", value = {  }, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "7b2aadfb-f908-4dcf-8cb8-02c5a92f0d32", is_global = true, name = "m", order = 1, position = { x = 20, y = 100 }, scale = 1, style = "default", type = "list", value = {  }, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "df21474a-e6d7-4890-b493-7d412b856879", is_global = true, name = "a", order = 0, position = { x = 20, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = true } }
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
      f["variables_set"](self, { value = 42, variable = "df21474a-e6d7-4890-b493-7d412b856879" }, th)
      f["wait"](self, { time = 1 }, th)
      f["change_variables"](self, { method = "increase", value = 1, variable = "df21474a-e6d7-4890-b493-7d412b856879" }, th)
      f["wait"](self, { time = 1 }, th)
      f["show_hide_variables"](self, { show_hide = "hide", variable = "df21474a-e6d7-4890-b493-7d412b856879" }, th)
      f["wait"](self, { time = 1 }, th)
      f["show_hide_variables"](self, { show_hide = "show", variable = "df21474a-e6d7-4890-b493-7d412b856879" }, th)
      f["wait"](self, { time = 1 }, th)
      f["script_variables"](self, { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, name = "a", names = { "a", "b", "c" } }, th)
      f["variables_set"](self, { value = f["variables_get"](self, { variable = "df21474a-e6d7-4890-b493-7d412b856879" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
      f["variables_set"](self, { value = 2, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"b\"}" }, th)
      f["variables_set"](self, { value = 3, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"c\"}" }, th)
      f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "a" }, th), B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, { TEXT = "b" }, th), B = f["script_variables_value"](self, { TEXT = "c" }, th), type = "add" }, th), type = "multiply" }, th), variable = "df21474a-e6d7-4890-b493-7d412b856879" }, th)
      f["wait"](self, { time = 1 }, th)
      f["list_append"](self, { list = "7b2aadfb-f908-4dcf-8cb8-02c5a92f0d32", list_item_value = 1 }, th)
      f["list_append"](self, { list = "7b2aadfb-f908-4dcf-8cb8-02c5a92f0d32", list_item_value = 2 }, th)
      f["list_insert_value"](self, { list = "7b2aadfb-f908-4dcf-8cb8-02c5a92f0d32", list_index = 1, list_item_value = 3 }, th)
      f["delete_list_item"](self, { item = "last", list = "7b2aadfb-f908-4dcf-8cb8-02c5a92f0d32" }, th)
      f["replace_list_item"](self, { item = "any", list = "7b2aadfb-f908-4dcf-8cb8-02c5a92f0d32", list_index = 1, list_item_value = 6 }, th)
      f["list_copy"](self, { list = "7b2aadfb-f908-4dcf-8cb8-02c5a92f0d32", target_list = "3b4df9e3-fb41-47cd-9086-0fba97502517" }, th)
      f["delete_list_item"](self, { item = "all", list = "3b4df9e3-fb41-47cd-9086-0fba97502517" }, th)
      f["list_append"](self, { list = "3b4df9e3-fb41-47cd-9086-0fba97502517", list_item_value = f["list_item"](self, { item = "any", list = "7b2aadfb-f908-4dcf-8cb8-02c5a92f0d32", list_index = 1 }, th) }, th)
      f["list_append"](self, { list = "3b4df9e3-fb41-47cd-9086-0fba97502517", list_item_value = f["list_length"](self, { list = "7b2aadfb-f908-4dcf-8cb8-02c5a92f0d32" }, th) }, th)
      f["list_append"](self, { list = "3b4df9e3-fb41-47cd-9086-0fba97502517", list_item_value = f["list_index_of"](self, { list = "7b2aadfb-f908-4dcf-8cb8-02c5a92f0d32", list_item_value = 6 }, th) }, th)
      f["list_append"](self, { list = "3b4df9e3-fb41-47cd-9086-0fba97502517", list_item_value = f["list_is_exist"](self, { list = "7b2aadfb-f908-4dcf-8cb8-02c5a92f0d32", list_item_value = 6 }, th) }, th)
      f["show_hide_list"](self, { list = "7b2aadfb-f908-4dcf-8cb8-02c5a92f0d32", show_hide = "hide" }, th)
      f["list_append"](self, { list = "3b4df9e3-fb41-47cd-9086-0fba97502517", list_item_value = f["temporary_list"](self, { ITEM0 = 0, ITEM1 = 2, ITEM2 = 4 }, th) }, th)
      f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = f["list_get"](self, { list = "3b4df9e3-fb41-47cd-9086-0fba97502517" }, th), list_index = 1 }, th), variable = "df21474a-e6d7-4890-b493-7d412b856879" }, th)
  end)
end

M.requires = {
  "change_variables",
  "delete_list_item",
  "list_append",
  "list_copy",
  "list_get",
  "list_index_of",
  "list_insert_value",
  "list_is_exist",
  "list_item",
  "list_length",
  "math_arithmetic",
  "replace_list_item",
  "script_variables",
  "script_variables_value",
  "show_hide_list",
  "show_hide_variables",
  "temporary_list",
  "variables_get",
  "variables_set",
  "wait",
}
return M

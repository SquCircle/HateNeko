-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：我的作品   version=0.27.4
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 900, 562
M.vars = { { id = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e", is_global = true, name = "l", position = { x = 0, y = 0 }, scale = 1, style = "default", type = "list", value = {  }, visible = true } }
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
      f["list_append"](self, { list = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e", list_item_value = f["math_arithmetic"](self, { A = 0.1, B = 0.2, type = "add" }, th) }, th)
      f["list_append"](self, { list = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e", list_item_value = f["math_arithmetic"](self, { A = 0.1, B = 0.2, type = "divide" }, th) }, th)
      f["list_append"](self, { list = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e", list_item_value = f["math_arithmetic"](self, { A = 0.1, B = 0.2, type = "power" }, th) }, th)
      f["list_append"](self, { list = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e", list_item_value = f["random_num"](self, { A = 0, B = 5 }, th) }, th)
      f["list_append"](self, { list = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e", list_item_value = f["logic_compare"](self, { A = 1, B = 1, OP = "EQ" }, th) }, th)
      f["list_append"](self, { list = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e", list_item_value = f["logic_operation"](self, { A = true, B = false, type = "and" }, th) }, th)
      f["list_append"](self, { list = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e", list_item_value = f["logic_operation"](self, { A = true, B = false, type = "or" }, th) }, th)
      f["list_append"](self, { list = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e", list_item_value = f["logic_negate"](self, { logic = false }, th) }, th)
      f["list_append"](self, { list = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e", list_item_value = f["math_round"](self, { num = 3.1, type = "round" }, th) }, th)
      f["list_append"](self, { list = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e", list_item_value = f["math_modulo"](self, { A = 64, B = 10 }, th) }, th)
      f["list_append"](self, { list = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e", list_item_value = f["divisible_by"](self, { A = 9, B = 3 }, th) }, th)
      f["list_append"](self, { list = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e", list_item_value = f["math_number_property"](self, { num = 2, type = "PRIME" }, th) }, th)
      f["list_append"](self, { list = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e", list_item_value = f["math_trig"](self, { num = 45, type = "sin" }, th) }, th)
      f["list_append"](self, { list = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e", list_item_value = f["math_function"](self, { num = 2, type = "0" }, th) }, th)
      f["list_append"](self, { list = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e", list_item_value = f["text_join"](self, { ADD0 = "ab", ADD1 = "c" }, th) }, th)
      f["list_append"](self, { list = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e", list_item_value = f["text_select"](self, { start_index = 2, text = "abc" }, th) }, th)
      f["list_append"](self, { list = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e", list_item_value = f["text_length"](self, { text = "abc" }, th) }, th)
      f["list_append"](self, { list = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e", list_item_value = f["text_contain"](self, { A = "abc", B = "a" }, th) }, th)
      f["list_append"](self, { list = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e", list_item_value = f["text_split"](self, { SPLIT_TEXT = ",", TEXT_TO_SPLIT = "a,b,c" }, th) }, th)
      f["list_append"](self, { list = "b52b2ad0-0c23-414e-8d8d-deabdf45f68e", list_item_value = f["convert_type"](self, { text = "123", type = "number" }, th) }, th)
  end)
end

M.requires = {
  "convert_type",
  "divisible_by",
  "list_append",
  "logic_compare",
  "logic_negate",
  "logic_operation",
  "math_arithmetic",
  "math_function",
  "math_modulo",
  "math_number_property",
  "math_round",
  "math_trig",
  "random_num",
  "text_contain",
  "text_join",
  "text_length",
  "text_select",
  "text_split",
}
return M

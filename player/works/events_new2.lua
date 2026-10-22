-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：我的作品   version=0.27.4
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 900, 562
M.timer_pos = { x = 720, y = 12 }
M.uses_timer = false
M.timer_hidden_default = false
M.vars = { { current_entity_id = "", cv_id = "", entity_name = "", id = "6144ba1a-52fb-4a30-af79-8e7175cd1896", is_global = true, name = "j", order = 1, position = { x = 20, y = 100 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "68ee73ed-6f45-4b77-a36d-4b76f1693376", is_global = true, name = "i", order = 0, position = { x = 20, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "adb2451c-2ef3-4b6a-a9a7-62905a38e210", is_global = true, name = "b", order = 2, position = { x = 20, y = 180 }, scale = 1, style = "default", type = "any", value = 0, visible = true } }
M.screens = { { id = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a", name = "背景", screenName = "屏幕", style_index = 1, styles = { "6d0d6c61-a1df-4076-8c19-83ddfdbbca1c" }, visible = true }, { id = "4126ec8b-9512-4d9a-bdda-146d25363e69", name = "背景", screenName = "空白场景", style_index = 1, styles = { "0fd928b8-d087-4026-8d19-6b07aa3f08eb" }, visible = true } }
M.cur_scene = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a"
M.actors = { { id = "025dd83c-de62-46a3-86bb-2ab6333e16c2", is_global = false, name = "编程猫", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "e9792a0f-ae14-4489-90c8-dd0fd6edd6d9", "5a1f9428-61c8-4ff3-984b-78ff34bdf04d", "106119db-7ea0-4d47-a33c-65f3d2a560e1", "509a0c7c-af8b-460f-b9a5-3c273ea8394e", "70cdaef4-bd83-4797-8aec-e1edddec8765" }, visible = true, x = 0, y = -50 }, { id = "866a5033-12e6-4da1-8939-dc5ddca694d2", is_global = false, name = "一阶编程猫跳跳", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "4126ec8b-9512-4d9a-bdda-146d25363e69" }, style_index = 1, styles = { "6776d1b8-5e79-4535-9185-98509d0c028c", "1f636d0c-32c0-4b4f-89ce-9e2f342a1a60", "470237ca-ba9c-4c70-9ab1-40ee3f1ef4ea", "270d6138-c927-4507-8745-e71953ecf1d0", "40bd62cd-2941-4006-9574-6d9cebf4de16" }, visible = true, x = 0, y = 0 }, { id = "74942bac-7503-4bff-a1fc-a7347554a8ee", is_global = false, name = "像素编程猫", order = 2, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "bf83c94c-fc25-4d26-b4b8-2360afce0d03" }, visible = true, x = 264.89656645676, y = -6.6206830188673 } }
M.assets_dir = "works"
M.assets = { ["0fd928b8-d087-4026-8d19-6b07aa3f08eb"] = { adaption = nil, center = nil, file = "assets/0fd928b8-d087-4026-8d19-6b07aa3f08eb.png", id = "0fd928b8-d087-4026-8d19-6b07aa3f08eb", name = "背景", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/img_stage_defult_landscape.png" }, ["106119db-7ea0-4d47-a33c-65f3d2a560e1"] = { adaption = nil, center = nil, file = "assets/106119db-7ea0-4d47-a33c-65f3d2a560e1.png", id = "106119db-7ea0-4d47-a33c-65f3d2a560e1", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/6e4d95aecf7441e6a9885cba405baeaf.png" }, ["1f636d0c-32c0-4b4f-89ce-9e2f342a1a60"] = { adaption = nil, center = nil, file = "assets/1f636d0c-32c0-4b4f-89ce-9e2f342a1a60.png", id = "1f636d0c-32c0-4b4f-89ce-9e2f342a1a60", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/caf8f973dbe240babece35637dcafee8.png" }, ["270d6138-c927-4507-8745-e71953ecf1d0"] = { adaption = nil, center = nil, file = "assets/270d6138-c927-4507-8745-e71953ecf1d0.png", id = "270d6138-c927-4507-8745-e71953ecf1d0", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/25593adb06d24d988ada59c1d2131de8.png" }, ["40bd62cd-2941-4006-9574-6d9cebf4de16"] = { adaption = nil, center = nil, file = "assets/40bd62cd-2941-4006-9574-6d9cebf4de16.png", id = "40bd62cd-2941-4006-9574-6d9cebf4de16", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/8aa8cbdbe82a442989b0fadb823444d4.png" }, ["470237ca-ba9c-4c70-9ab1-40ee3f1ef4ea"] = { adaption = nil, center = nil, file = "assets/470237ca-ba9c-4c70-9ab1-40ee3f1ef4ea.png", id = "470237ca-ba9c-4c70-9ab1-40ee3f1ef4ea", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/6e4d95aecf7441e6a9885cba405baeaf.png" }, ["509a0c7c-af8b-460f-b9a5-3c273ea8394e"] = { adaption = nil, center = nil, file = "assets/509a0c7c-af8b-460f-b9a5-3c273ea8394e.png", id = "509a0c7c-af8b-460f-b9a5-3c273ea8394e", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/25593adb06d24d988ada59c1d2131de8.png" }, ["5a1f9428-61c8-4ff3-984b-78ff34bdf04d"] = { adaption = nil, center = nil, file = "assets/5a1f9428-61c8-4ff3-984b-78ff34bdf04d.png", id = "5a1f9428-61c8-4ff3-984b-78ff34bdf04d", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/caf8f973dbe240babece35637dcafee8.png" }, ["6776d1b8-5e79-4535-9185-98509d0c028c"] = { adaption = nil, center = nil, file = "assets/6776d1b8-5e79-4535-9185-98509d0c028c.png", id = "6776d1b8-5e79-4535-9185-98509d0c028c", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/c364f36a8dcf42d1a6acbe26c7eb6aaa.png" }, ["6d0d6c61-a1df-4076-8c19-83ddfdbbca1c"] = { adaption = nil, center = nil, file = "assets/6d0d6c61-a1df-4076-8c19-83ddfdbbca1c.jpg", id = "6d0d6c61-a1df-4076-8c19-83ddfdbbca1c", name = "沼泽", styleType = 1, url = "https://creation.codemao.cn/396/8bc3a5b92e934d7287e63f1684b61de6.jpg" }, ["70cdaef4-bd83-4797-8aec-e1edddec8765"] = { adaption = nil, center = nil, file = "assets/70cdaef4-bd83-4797-8aec-e1edddec8765.png", id = "70cdaef4-bd83-4797-8aec-e1edddec8765", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/8aa8cbdbe82a442989b0fadb823444d4.png" }, ["bf83c94c-fc25-4d26-b4b8-2360afce0d03"] = { adaption = nil, center = nil, file = "assets/bf83c94c-fc25-4d26-b4b8-2360afce0d03.png", id = "bf83c94c-fc25-4d26-b4b8-2360afce0d03", name = "像素编程猫", styleType = nil, url = "https://creation.codemao.cn/396/de5a7ed139bf42419bd0db82d9c85f47.png" }, ["e9792a0f-ae14-4489-90c8-dd0fd6edd6d9"] = { adaption = nil, center = nil, file = "assets/e9792a0f-ae14-4489-90c8-dd0fd6edd6d9.png", id = "e9792a0f-ae14-4489-90c8-dd0fd6edd6d9", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/c364f36a8dcf42d1a6acbe26c7eb6aaa.png" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_700824a5_44a8_4d03_a7e8_aa95d87e9b2a = ents["700824a5-44a8-4d03-a7e8-aa95d87e9b2a"]
  local e_4126ec8b_9512_4d9a_bdda_146d25363e69 = ents["4126ec8b-9512-4d9a-bdda-146d25363e69"]
  local e_025dd83c_de62_46a3_86bb_2ab6333e16c2 = ents["025dd83c-de62-46a3-86bb-2ab6333e16c2"]
  local e_866a5033_12e6_4da1_8939_dc5ddca694d2 = ents["866a5033-12e6-4da1-8939-dc5ddca694d2"]
  local e_74942bac_7503_4bff_a1fc_a7347554a8ee = ents["74942bac-7503-4bff-a1fc-a7347554a8ee"]
  -- -------- 角色 编程猫 --------
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "start_on_click", {}, function(th, self)
      f["set_screen_transition"](self, { direction = "up", type = "slide" }, th)
      f["self_set_draggable"](self, { draggable = "1" }, th)
      f["change_variables"](self, { method = "increase", value = 1, variable = "68ee73ed-6f45-4b77-a36d-4b76f1693376" }, th)
  end)
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "on_running_group_activated", {}, function(th, self)
      f["change_variables"](self, { method = "increase", value = 1, variable = "68ee73ed-6f45-4b77-a36d-4b76f1693376" }, th)
  end)
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "sprite_on_tap", { sprite = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a", type = "mouse_click" }, function(th, self)
      f["switch_to_screen"](self, { screen_id = "next" }, th)
  end)
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "on_swipe", { type = "up" }, function(th, self)
      f["change_variables"](self, { method = "increase", value = 1, variable = "68ee73ed-6f45-4b77-a36d-4b76f1693376" }, th)
  end)
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "on_swipe", { type = "down" }, function(th, self)
      f["change_variables"](self, { method = "decrease", value = 1, variable = "68ee73ed-6f45-4b77-a36d-4b76f1693376" }, th)
  end)
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "on_keydown", { key = "65", type = "down" }, function(th, self)
      f["variables_set"](self, { value = 0, variable = "68ee73ed-6f45-4b77-a36d-4b76f1693376" }, th)
      f["self_broadcast_with_param"](self, { message = "b", param = "a" }, th)
  end)
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "on_bump_actor", { sprite = "74942bac-7503-4bff-a1fc-a7347554a8ee", type = "move" }, function(th, self)
      f["self_dialog_wait"](self, { text = f["on_bump_actor_value"](self, { TEXT = "角色", attribute = "x" }, th), type = "talk" }, th)
  end)
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "when", { cond = function(th, self) return true end, condition = true }, function(th, self)
      f["change_variables"](self, { method = "increase", value = 1, variable = "6144ba1a-52fb-4a30-af79-8e7175cd1896" }, th)
      f["self_broadcast_and_wait"](self, { message = "Hi" }, th)
  end)
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "self_listen", { message = "Hi" }, function(th, self)
      f["change_variables"](self, { method = "decrease", value = 1, variable = "6144ba1a-52fb-4a30-af79-8e7175cd1896" }, th)
  end)
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "sprite_on_tap", { sprite = "--self", type = "mouse_click" }, function(th, self)
      f["mirror"](self, { sprite = "--self" }, th)
  end)
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "start_as_a_mirror", {}, function(th, self)
      f["self_face_to"](self, { sprite = "--random" }, th)
      do
        local _times_n1 = 100
        while true do
          if _times_n1 <= 0 then break end
          _times_n1 = _times_n1 - 1
          f["self_go_forward"](self, { steps = f["get_current_clone_index"](self, {}, th) }, th)
          f["self_bounce_off_edge"](self, {}, th)
          if th:iter_n() then break end
        end
      end
      f["dispose_clone"](self, {}, th)
  end)
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "self_listen_with_param", { message = "b" }, function(th, self)
      f["variables_set"](self, { value = f["self_listen_value"](self, { TEXT = "内容" }, th), variable = "adb2451c-2ef3-4b6a-a9a7-62905a38e210" }, th)
  end)
  -- -------- 角色 一阶编程猫跳跳 --------
  rt.on(e_866a5033_12e6_4da1_8939_dc5ddca694d2, "sprite_on_tap", { sprite = "--screen", type = "mouse_click" }, function(th, self)
      f["switch_to_screen"](self, { screen_id = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, th)
  end)
  -- -------- 角色 像素编程猫 --------
  rt.on(e_74942bac_7503_4bff_a1fc_a7347554a8ee, "sprite_on_tap", { sprite = "--self", type = "mouse_click" }, function(th, self)
      f["stop"](self, { scope = "3" }, th)
      f["wait"](self, { time = 1 }, th)
      f["restart"](self, {}, th)
  end)
end

M.requires = {
  "change_variables",
  "dispose_clone",
  "get_current_clone_index",
  "mirror",
  "on_bump_actor_value",
  "restart",
  "self_bounce_off_edge",
  "self_broadcast_and_wait",
  "self_broadcast_with_param",
  "self_dialog_wait",
  "self_face_to",
  "self_go_forward",
  "self_listen_value",
  "self_set_draggable",
  "set_screen_transition",
  "stop",
  "switch_to_screen",
  "variables_set",
  "wait",
}
return M

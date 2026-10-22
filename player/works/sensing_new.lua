-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：我的作品   version=0.27.4
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 900, 562
M.timer_pos = { x = 720, y = 12 }
M.uses_timer = true
M.vars = { { current_entity_id = "", cv_id = "", entity_name = "", id = "14d4e8b0-2378-407a-af92-6f817e83e99d", is_global = true, name = "f", order = 7, position = { x = 220, y = 100 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "253ef932-040b-4391-9914-f2fbcf04920c", is_global = true, name = "l", order = 13, position = { x = 420, y = 100 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "2be5e7b9-f68b-42ec-8990-3878c0daacb7", is_global = true, name = "x", order = 0, position = { x = 20, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "35b9e259-fc48-4915-a6b1-59e93096fdd7", is_global = true, name = "j", order = 11, position = { x = 220, y = 420 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "4714bce5-2650-4729-a8a9-56d8ef97092d", is_global = true, name = "k", order = 12, position = { x = 420, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "49194a38-63a2-4267-a71e-b5c39216ec4a", is_global = true, name = "d", order = 5, position = { x = 20, y = 420 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "54e0c4a4-0e7e-45d8-90bb-518fb2fa75b7", is_global = true, name = "y", order = 1, position = { x = 20, y = 100 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "55e5f113-491e-4b78-850f-8470b164e143", is_global = true, name = "g", order = 8, position = { x = 220, y = 180 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "5d67f8f1-e247-495f-af10-693acaee388d", is_global = true, name = "a", order = 2, position = { x = 20, y = 180 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "7ca4574c-1e90-481c-b765-47c60cec1c46", is_global = true, name = "i", order = 10, position = { x = 220, y = 340 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "7ca6d11b-ebae-4ea8-b44e-f2d22ec056dc", is_global = true, name = "e", order = 6, position = { x = 220, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "7fa4cf34-e4f5-40f6-b0d7-9b150e1f8045", is_global = true, name = "h", order = 9, position = { x = 220, y = 260 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "9c13bdab-553c-499e-9ad1-dd387146490f", is_global = true, name = "c", order = 4, position = { x = 20, y = 340 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "da55fb2e-d11e-4cb0-844d-35e46ca02052", is_global = true, name = "b", order = 3, position = { x = 20, y = 260 }, scale = 1, style = "default", type = "any", value = 0, visible = true } }
M.screens = { { id = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a", name = "背景", screenName = "屏幕", style_index = 1, styles = { "6d0d6c61-a1df-4076-8c19-83ddfdbbca1c" }, visible = true } }
M.cur_scene = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a"
M.actors = { { id = "025dd83c-de62-46a3-86bb-2ab6333e16c2", is_global = true, name = "编程猫", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "e9792a0f-ae14-4489-90c8-dd0fd6edd6d9", "5a1f9428-61c8-4ff3-984b-78ff34bdf04d", "106119db-7ea0-4d47-a33c-65f3d2a560e1", "509a0c7c-af8b-460f-b9a5-3c273ea8394e", "70cdaef4-bd83-4797-8aec-e1edddec8765" }, visible = true, x = 0, y = -50 }, { id = "ebf31722-3924-48a4-b1d7-2a03b7978221", is_global = true, name = "阿短", order = 2, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "e1da6b3b-83ee-4236-93a1-bc4856228edb", "8af919a0-a396-4c70-8d41-4e67bb261e4f" }, visible = true, x = -239.65540959285, y = -22.076145406941 } }
M.assets_dir = "works"
M.assets = { ["106119db-7ea0-4d47-a33c-65f3d2a560e1"] = { adaption = nil, center = nil, file = "assets/106119db-7ea0-4d47-a33c-65f3d2a560e1.png", id = "106119db-7ea0-4d47-a33c-65f3d2a560e1", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/6e4d95aecf7441e6a9885cba405baeaf.png" }, ["509a0c7c-af8b-460f-b9a5-3c273ea8394e"] = { adaption = nil, center = nil, file = "assets/509a0c7c-af8b-460f-b9a5-3c273ea8394e.png", id = "509a0c7c-af8b-460f-b9a5-3c273ea8394e", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/25593adb06d24d988ada59c1d2131de8.png" }, ["5a1f9428-61c8-4ff3-984b-78ff34bdf04d"] = { adaption = nil, center = nil, file = "assets/5a1f9428-61c8-4ff3-984b-78ff34bdf04d.png", id = "5a1f9428-61c8-4ff3-984b-78ff34bdf04d", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/caf8f973dbe240babece35637dcafee8.png" }, ["6d0d6c61-a1df-4076-8c19-83ddfdbbca1c"] = { adaption = nil, center = nil, file = "assets/6d0d6c61-a1df-4076-8c19-83ddfdbbca1c.jpg", id = "6d0d6c61-a1df-4076-8c19-83ddfdbbca1c", name = "沼泽", styleType = 1, url = "https://creation.codemao.cn/396/8bc3a5b92e934d7287e63f1684b61de6.jpg" }, ["70cdaef4-bd83-4797-8aec-e1edddec8765"] = { adaption = nil, center = nil, file = "assets/70cdaef4-bd83-4797-8aec-e1edddec8765.png", id = "70cdaef4-bd83-4797-8aec-e1edddec8765", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/8aa8cbdbe82a442989b0fadb823444d4.png" }, ["8af919a0-a396-4c70-8d41-4e67bb261e4f"] = { adaption = nil, center = nil, file = "assets/8af919a0-a396-4c70-8d41-4e67bb261e4f.png", id = "8af919a0-a396-4c70-8d41-4e67bb261e4f", name = "阿短", styleType = nil, url = "https://creation.codemao.cn/396/db4696898a28494b80ac0f41f610df75.png" }, ["e1da6b3b-83ee-4236-93a1-bc4856228edb"] = { adaption = nil, center = nil, file = "assets/e1da6b3b-83ee-4236-93a1-bc4856228edb.png", id = "e1da6b3b-83ee-4236-93a1-bc4856228edb", name = "阿短", styleType = nil, url = "https://creation.codemao.cn/396/1cc51141d259423d8cbf706d31d7f8c0.png" }, ["e9792a0f-ae14-4489-90c8-dd0fd6edd6d9"] = { adaption = nil, center = nil, file = "assets/e9792a0f-ae14-4489-90c8-dd0fd6edd6d9.png", id = "e9792a0f-ae14-4489-90c8-dd0fd6edd6d9", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/c364f36a8dcf42d1a6acbe26c7eb6aaa.png" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_700824a5_44a8_4d03_a7e8_aa95d87e9b2a = ents["700824a5-44a8-4d03-a7e8-aa95d87e9b2a"]
  local e_025dd83c_de62_46a3_86bb_2ab6333e16c2 = ents["025dd83c-de62-46a3-86bb-2ab6333e16c2"]
  local e_ebf31722_3924_48a4_b1d7_2a03b7978221 = ents["ebf31722-3924-48a4-b1d7-2a03b7978221"]
  -- -------- 角色 编程猫 --------
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "on_running_group_activated", {}, function(th, self)
      while true do
        f["self_move_specify"](self, { sprite = "--mouse" }, th)
        f["self_dialog_wait"](self, { text = f["text_join"](self, { ADD0 = f["bump_into"](self, { sprite = "--self", sprite1 = "ebf31722-3924-48a4-b1d7-2a03b7978221" }, th), ADD1 = f["bump_into_color"](self, { color = "#a97d50", sprite = "--self" }, th), ADD2 = f["out_of_boundary"](self, { boundary = "0" }, th) }, th), type = "talk" }, th)
        f["variables_set"](self, { value = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), variable = "2be5e7b9-f68b-42ec-8990-3878c0daacb7" }, th)
        f["variables_set"](self, { value = f["coordinate_of_sprite"](self, { coordinate = "y", sprite = "--self" }, th), variable = "54e0c4a4-0e7e-45d8-90bb-518fb2fa75b7" }, th)
        f["variables_set"](self, { value = f["style_of_sprite"](self, { sprite = "--self" }, th), variable = "5d67f8f1-e247-495f-af10-693acaee388d" }, th)
        f["variables_set"](self, { value = f["appearance_of_sprite"](self, { appearance = "scale", sprite = "--self" }, th), variable = "da55fb2e-d11e-4cb0-844d-35e46ca02052" }, th)
        f["variables_set"](self, { value = f["appearance_of_sprite"](self, { appearance = "direction", sprite = "--self" }, th), variable = "9c13bdab-553c-499e-9ad1-dd387146490f" }, th)
        f["variables_set"](self, { value = f["effect_of_sprite"](self, { effect = "0", sprite = "--self" }, th), variable = "49194a38-63a2-4267-a71e-b5c39216ec4a" }, th)
        f["variables_set"](self, { value = f["distance_to"](self, { sprite = "ebf31722-3924-48a4-b1d7-2a03b7978221" }, th), variable = "7ca6d11b-ebae-4ea8-b44e-f2d22ec056dc" }, th)
        f["variables_set"](self, { value = f["mouse_down"](self, { sprite = "--screen", type = "up" }, th), variable = "14d4e8b0-2378-407a-af92-6f817e83e99d" }, th)
        f["variables_set"](self, { value = f["get_mouse_info"](self, { type = "x" }, th), variable = "55e5f113-491e-4b78-850f-8470b164e143" }, th)
        f["variables_set"](self, { value = f["get_orientation"](self, { target = "x" }, th), variable = "7fa4cf34-e4f5-40f6-b0d7-9b150e1f8045" }, th)
        f["variables_set"](self, { value = f["get_voice_volume"](self, {}, th), variable = "7ca4574c-1e90-481c-b765-47c60cec1c46" }, th)
        f["variables_set"](self, { value = f["get_time"](self, { time = "year" }, th), variable = "35b9e259-fc48-4915-a6b1-59e93096fdd7" }, th)
        f["variables_set"](self, { value = f["get_stage_info"](self, { type = "width" }, th), variable = "253ef932-040b-4391-9914-f2fbcf04920c" }, th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "on_running_group_activated", {}, function(th, self)
      f["set_timer_state"](self, { type = "start" }, th)
      f["wait"](self, { time = 3.14 }, th)
      f["set_timer_state"](self, { type = "stop" }, th)
      f["show_hide_timer"](self, { showHide = "hide" }, th)
      f["variables_set"](self, { value = f["timer"](self, {}, th), variable = "4714bce5-2650-4729-a8a9-56d8ef97092d" }, th)
  end)
end

M.requires = {
  "appearance_of_sprite",
  "bump_into",
  "bump_into_color",
  "coordinate_of_sprite",
  "distance_to",
  "effect_of_sprite",
  "get_mouse_info",
  "get_orientation",
  "get_stage_info",
  "get_time",
  "get_voice_volume",
  "mouse_down",
  "out_of_boundary",
  "self_dialog_wait",
  "self_move_specify",
  "set_timer_state",
  "show_hide_timer",
  "style_of_sprite",
  "text_join",
  "timer",
  "variables_set",
  "wait",
}
return M

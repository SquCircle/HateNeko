-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：我的作品   version=0.27.4
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 900, 562
M.vars = {  }
M.screens = { { id = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a", name = "背景", screenName = "屏幕", style_index = 1, styles = { "6d0d6c61-a1df-4076-8c19-83ddfdbbca1c" }, visible = true } }
M.cur_scene = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a"
M.actors = { { id = "025dd83c-de62-46a3-86bb-2ab6333e16c2", is_global = true, name = "编程猫", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "e9792a0f-ae14-4489-90c8-dd0fd6edd6d9", "5a1f9428-61c8-4ff3-984b-78ff34bdf04d", "106119db-7ea0-4d47-a33c-65f3d2a560e1", "509a0c7c-af8b-460f-b9a5-3c273ea8394e", "70cdaef4-bd83-4797-8aec-e1edddec8765" }, visible = true, x = 0, y = 0 }, { id = "0d6fdc5a-fd61-468c-9ff2-8f6158c1c45d", is_global = true, name = "阿短", order = 2, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "50ef16b0-a037-4567-a22a-a3738fb7263d", "8a21029d-7941-45b3-88df-687fa4dd1370" }, visible = false, x = 0, y = 0 } }
M.assets_dir = "works"
M.assets = { ["106119db-7ea0-4d47-a33c-65f3d2a560e1"] = { adaption = nil, center = nil, file = "assets/106119db-7ea0-4d47-a33c-65f3d2a560e1.png", id = "106119db-7ea0-4d47-a33c-65f3d2a560e1", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/6e4d95aecf7441e6a9885cba405baeaf.png" }, ["509a0c7c-af8b-460f-b9a5-3c273ea8394e"] = { adaption = nil, center = nil, file = "assets/509a0c7c-af8b-460f-b9a5-3c273ea8394e.png", id = "509a0c7c-af8b-460f-b9a5-3c273ea8394e", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/25593adb06d24d988ada59c1d2131de8.png" }, ["50ef16b0-a037-4567-a22a-a3738fb7263d"] = { adaption = nil, center = nil, file = "assets/50ef16b0-a037-4567-a22a-a3738fb7263d.png", id = "50ef16b0-a037-4567-a22a-a3738fb7263d", name = "阿短", styleType = nil, url = "https://creation.codemao.cn/396/1cc51141d259423d8cbf706d31d7f8c0.png" }, ["5a1f9428-61c8-4ff3-984b-78ff34bdf04d"] = { adaption = nil, center = nil, file = "assets/5a1f9428-61c8-4ff3-984b-78ff34bdf04d.png", id = "5a1f9428-61c8-4ff3-984b-78ff34bdf04d", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/caf8f973dbe240babece35637dcafee8.png" }, ["6d0d6c61-a1df-4076-8c19-83ddfdbbca1c"] = { adaption = nil, center = nil, file = "assets/6d0d6c61-a1df-4076-8c19-83ddfdbbca1c.jpg", id = "6d0d6c61-a1df-4076-8c19-83ddfdbbca1c", name = "沼泽", styleType = 1, url = "https://creation.codemao.cn/396/8bc3a5b92e934d7287e63f1684b61de6.jpg" }, ["70cdaef4-bd83-4797-8aec-e1edddec8765"] = { adaption = nil, center = nil, file = "assets/70cdaef4-bd83-4797-8aec-e1edddec8765.png", id = "70cdaef4-bd83-4797-8aec-e1edddec8765", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/8aa8cbdbe82a442989b0fadb823444d4.png" }, ["8a21029d-7941-45b3-88df-687fa4dd1370"] = { adaption = nil, center = nil, file = "assets/8a21029d-7941-45b3-88df-687fa4dd1370.png", id = "8a21029d-7941-45b3-88df-687fa4dd1370", name = "阿短", styleType = nil, url = "https://creation.codemao.cn/396/db4696898a28494b80ac0f41f610df75.png" }, ["e9792a0f-ae14-4489-90c8-dd0fd6edd6d9"] = { adaption = nil, center = nil, file = "assets/e9792a0f-ae14-4489-90c8-dd0fd6edd6d9.png", id = "e9792a0f-ae14-4489-90c8-dd0fd6edd6d9", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/c364f36a8dcf42d1a6acbe26c7eb6aaa.png" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_700824a5_44a8_4d03_a7e8_aa95d87e9b2a = ents["700824a5-44a8-4d03-a7e8-aa95d87e9b2a"]
  local e_025dd83c_de62_46a3_86bb_2ab6333e16c2 = ents["025dd83c-de62-46a3-86bb-2ab6333e16c2"]
  local e_0d6fdc5a_fd61_468c_9ff2_8f6158c1c45d = ents["0d6fdc5a-fd61-468c-9ff2-8f6158c1c45d"]
  -- -------- 角色 编程猫 --------
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "on_running_group_activated", {}, function(th, self)
      f["wait"](self, { time = 1 }, th)
      f["self_move_to"](self, { x = 0, y = 0 }, th)
      f["self_point_towards"](self, { degrees = 0 }, th)
      do
        local _n = 20
        while _n > 0 do
          _n = _n - 1
          f["self_go_forward"](self, { steps = 10 }, th)
          if th:iter_n() then break end
        end
      end
      f["wait"](self, { time = 1 }, th)
      f["self_move_to"](self, { x = 0, y = 0 }, th)
      f["self_point_towards"](self, { degrees = 0 }, th)
      do
        local _n = 20
        while _n > 0 do
          _n = _n - 1
          f["self_move_specify"](self, { sprite = "--random" }, th)
          if th:iter_n() then break end
        end
      end
      f["wait"](self, { time = 1 }, th)
      f["self_move_to"](self, { x = 0, y = 0 }, th)
      f["self_point_towards"](self, { degrees = f["random_num"](self, { A = 0, B = 359 }, th) }, th)
      do
        local _n = 200
        while _n > 0 do
          _n = _n - 1
          f["self_go_forward"](self, { steps = 10 }, th)
          f["self_bounce_off_edge"](self, {}, th)
          if th:iter_n() then break end
        end
      end
      f["wait"](self, { time = 1 }, th)
      f["self_move_to"](self, { x = 0, y = 0 }, th)
      f["self_point_towards"](self, { degrees = 0 }, th)
      f["self_set_position_x"](self, { value = 100 }, th)
      f["self_set_position_y"](self, { value = 100 }, th)
      f["wait"](self, { time = 1 }, th)
      f["self_move_to"](self, { x = 0, y = 0 }, th)
      f["self_point_towards"](self, { degrees = 0 }, th)
      f["self_change_coordinate_x"](self, { increase = "decrease", value = 100 }, th)
      f["self_change_coordinate_y"](self, { increase = "increase", value = 100 }, th)
      f["wait"](self, { time = 1 }, th)
      f["self_move_to"](self, { x = 0, y = 0 }, th)
      f["self_point_towards"](self, { degrees = 0 }, th)
      f["self_glide_to"](self, { time = 1, x = 200, y = 100 }, th)
      f["wait"](self, { time = 1 }, th)
      f["self_move_to"](self, { x = 0, y = 0 }, th)
      f["self_point_towards"](self, { degrees = 0 }, th)
      f["self_glide_coordinate_x"](self, { increase = "increase", time = 1, value = 100 }, th)
      f["self_glide_coordinate_y"](self, { increase = "increase", time = 1, value = 100 }, th)
      f["wait"](self, { time = 1 }, th)
      f["self_move_to"](self, { x = 0, y = 0 }, th)
      f["self_point_towards"](self, { degrees = 0 }, th)
      do
        local _n = 360
        while _n > 0 do
          _n = _n - 1
          f["self_rotate"](self, { degrees = 2 }, th)
          if th:iter_n() then break end
        end
      end
      f["wait"](self, { time = 1 }, th)
      f["self_move_to"](self, { x = 100, y = 0 }, th)
      f["self_point_towards"](self, { degrees = 0 }, th)
      do
        local _n = 360
        while _n > 0 do
          _n = _n - 1
          f["self_rotate_around"](self, { degrees = 2, sprite = "0d6fdc5a-fd61-468c-9ff2-8f6158c1c45d" }, th)
          if th:iter_n() then break end
        end
      end
      f["wait"](self, { time = 1 }, th)
      f["self_move_to"](self, { x = 100, y = 0 }, th)
      f["self_point_towards"](self, { degrees = 0 }, th)
      f["self_set_rotation_type"](self, { rotation_type = "1" }, th)
      do
        local _n = 360
        while _n > 0 do
          _n = _n - 1
          f["self_rotate_around"](self, { degrees = 2, sprite = "0d6fdc5a-fd61-468c-9ff2-8f6158c1c45d" }, th)
          if th:iter_n() then break end
        end
      end
      f["self_set_rotation_type"](self, { rotation_type = "0" }, th)
      f["wait"](self, { time = 1 }, th)
      f["self_move_to"](self, { x = 0, y = 0 }, th)
      f["self_point_towards"](self, { degrees = 0 }, th)
      do
        local _n = 20
        while _n > 0 do
          _n = _n - 1
          f["self_face_to"](self, { sprite = "--random" }, th)
          if th:iter_n() then break end
        end
      end
      f["sync_tell"](self, { sprite = "0d6fdc5a-fd61-468c-9ff2-8f6158c1c45d", DO = function(t2, s2)
          f["self_set_role_camp"](s2, { role_camp = "camp_red" }, t2)
          f["self_appear"](s2, { value = "appear" }, t2)
      end }, th)
      f["self_set_draggable"](self, { draggable = "1" }, th)
      f["self_move_to"](self, { x = 200, y = 0 }, th)
      f["self_set_role_camp"](self, { role_camp = "camp_yellow" }, th)
      while true do
        if V.bool(f["bump_into"](self, { sprite = "--self", sprite1 = "camp_red" }, th)) then
          f["self_move_to"](self, { x = 200, y = 0 }, th)
        end
        if th:iter_n() then break end
      end
  end)
end

M.requires = {
  "bump_into",
  "random_num",
  "self_appear",
  "self_bounce_off_edge",
  "self_change_coordinate_x",
  "self_change_coordinate_y",
  "self_face_to",
  "self_glide_coordinate_x",
  "self_glide_coordinate_y",
  "self_glide_to",
  "self_go_forward",
  "self_move_specify",
  "self_move_to",
  "self_point_towards",
  "self_rotate",
  "self_rotate_around",
  "self_set_draggable",
  "self_set_position_x",
  "self_set_position_y",
  "self_set_role_camp",
  "self_set_rotation_type",
  "wait",
}
return M

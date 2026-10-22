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
M.actors = { { id = "025dd83c-de62-46a3-86bb-2ab6333e16c2", is_global = true, name = "编程猫", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "e9792a0f-ae14-4489-90c8-dd0fd6edd6d9", "5a1f9428-61c8-4ff3-984b-78ff34bdf04d", "106119db-7ea0-4d47-a33c-65f3d2a560e1", "509a0c7c-af8b-460f-b9a5-3c273ea8394e", "70cdaef4-bd83-4797-8aec-e1edddec8765" }, visible = false, x = 0, y = 0 }, { id = "7877a1b6-7449-40b1-a7c2-189d6a6514b8", is_global = true, name = "阿短", order = 2, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "c3702cdf-9e66-4ea4-a0a0-69b33f47dd5a", "63ae91e9-6d04-484b-96d6-a9e19c63ee0e" }, visible = true, x = 265.27597361598, y = 0.51723346165204 } }
M.assets_dir = "works"
M.assets = { ["106119db-7ea0-4d47-a33c-65f3d2a560e1"] = { adaption = nil, center = nil, file = "assets/106119db-7ea0-4d47-a33c-65f3d2a560e1.png", id = "106119db-7ea0-4d47-a33c-65f3d2a560e1", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/6e4d95aecf7441e6a9885cba405baeaf.png" }, ["509a0c7c-af8b-460f-b9a5-3c273ea8394e"] = { adaption = nil, center = nil, file = "assets/509a0c7c-af8b-460f-b9a5-3c273ea8394e.png", id = "509a0c7c-af8b-460f-b9a5-3c273ea8394e", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/25593adb06d24d988ada59c1d2131de8.png" }, ["5a1f9428-61c8-4ff3-984b-78ff34bdf04d"] = { adaption = nil, center = nil, file = "assets/5a1f9428-61c8-4ff3-984b-78ff34bdf04d.png", id = "5a1f9428-61c8-4ff3-984b-78ff34bdf04d", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/caf8f973dbe240babece35637dcafee8.png" }, ["63ae91e9-6d04-484b-96d6-a9e19c63ee0e"] = { adaption = nil, center = nil, file = "assets/63ae91e9-6d04-484b-96d6-a9e19c63ee0e.png", id = "63ae91e9-6d04-484b-96d6-a9e19c63ee0e", name = "阿短", styleType = nil, url = "https://creation.codemao.cn/396/db4696898a28494b80ac0f41f610df75.png" }, ["6d0d6c61-a1df-4076-8c19-83ddfdbbca1c"] = { adaption = nil, center = nil, file = "assets/6d0d6c61-a1df-4076-8c19-83ddfdbbca1c.jpg", id = "6d0d6c61-a1df-4076-8c19-83ddfdbbca1c", name = "沼泽", styleType = 1, url = "https://creation.codemao.cn/396/8bc3a5b92e934d7287e63f1684b61de6.jpg" }, ["70cdaef4-bd83-4797-8aec-e1edddec8765"] = { adaption = nil, center = nil, file = "assets/70cdaef4-bd83-4797-8aec-e1edddec8765.png", id = "70cdaef4-bd83-4797-8aec-e1edddec8765", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/8aa8cbdbe82a442989b0fadb823444d4.png" }, ["c3702cdf-9e66-4ea4-a0a0-69b33f47dd5a"] = { adaption = nil, center = nil, file = "assets/c3702cdf-9e66-4ea4-a0a0-69b33f47dd5a.png", id = "c3702cdf-9e66-4ea4-a0a0-69b33f47dd5a", name = "阿短", styleType = nil, url = "https://creation.codemao.cn/396/1cc51141d259423d8cbf706d31d7f8c0.png" }, ["e9792a0f-ae14-4489-90c8-dd0fd6edd6d9"] = { adaption = nil, center = nil, file = "assets/e9792a0f-ae14-4489-90c8-dd0fd6edd6d9.png", id = "e9792a0f-ae14-4489-90c8-dd0fd6edd6d9", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/c364f36a8dcf42d1a6acbe26c7eb6aaa.png" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_700824a5_44a8_4d03_a7e8_aa95d87e9b2a = ents["700824a5-44a8-4d03-a7e8-aa95d87e9b2a"]
  local e_025dd83c_de62_46a3_86bb_2ab6333e16c2 = ents["025dd83c-de62-46a3-86bb-2ab6333e16c2"]
  local e_7877a1b6_7449_40b1_a7c2_189d6a6514b8 = ents["7877a1b6-7449-40b1-a7c2-189d6a6514b8"]
  -- -------- 角色 编程猫 --------
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "on_running_group_activated", {}, function(th, self)
      th:warp_enter()
      do
        local _n = 300
        while _n > 0 do
          _n = _n - 1
          f["mirror"](self, { sprite = "--self" }, th)
          if th:iter_w() then break end
        end
      end
      th:warp_exit()
  end)
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "start_as_a_mirror", {}, function(th, self)
      f["self_appear"](self, { value = "appear" }, th)
      f["self_face_to"](self, { sprite = "--random" }, th)
      while true do
        f["self_go_forward"](self, { steps = 10 }, th)
        f["self_bounce_off_edge"](self, {}, th)
        if V.bool(f["bump_into"](self, { sprite = "--self", sprite1 = "7877a1b6-7449-40b1-a7c2-189d6a6514b8" }, th)) then
          f["self_move_specify"](self, { sprite = "--random" }, th)
        end
        if th:iter_n() then break end
      end
  end)
end

M.requires = {
  "bump_into",
  "mirror",
  "self_appear",
  "self_bounce_off_edge",
  "self_face_to",
  "self_go_forward",
  "self_move_specify",
}
return M

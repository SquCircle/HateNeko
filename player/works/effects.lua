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
M.actors = { { id = "363fa489-4c69-4f94-afd7-441307cd9d9d", is_global = true, name = "新角色", order = 1, rotation = 0, scale_x = 2, scale_y = 2, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "5d85d83b-6320-4c90-a086-0638c1e99a7b" }, visible = true, x = 0, y = 0 } }
M.assets_dir = "works"
M.assets = { ["5d85d83b-6320-4c90-a086-0638c1e99a7b"] = { adaption = nil, center = nil, file = "assets/5d85d83b-6320-4c90-a086-0638c1e99a7b.png", id = "5d85d83b-6320-4c90-a086-0638c1e99a7b", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/Fqnwpl9X6GwhAl2FVPUJ-oRZNbao?imageView2/0/format/png" }, ["6d0d6c61-a1df-4076-8c19-83ddfdbbca1c"] = { adaption = nil, center = nil, file = "assets/6d0d6c61-a1df-4076-8c19-83ddfdbbca1c.jpg", id = "6d0d6c61-a1df-4076-8c19-83ddfdbbca1c", name = "沼泽", styleType = 1, url = "https://creation.codemao.cn/396/8bc3a5b92e934d7287e63f1684b61de6.jpg" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_700824a5_44a8_4d03_a7e8_aa95d87e9b2a = ents["700824a5-44a8-4d03-a7e8-aa95d87e9b2a"]
  local e_363fa489_4c69_4f94_afd7_441307cd9d9d = ents["363fa489-4c69-4f94-afd7-441307cd9d9d"]
  -- -------- 角色 新角色 --------
  rt.on(e_363fa489_4c69_4f94_afd7_441307cd9d9d, "on_running_group_activated", {}, function(th, self)
      f["self_set_effect"](self, { scope = "4", value = 20 }, th)
      f["wait"](self, { time = 2 }, th)
      f["clear_all_effects"](self, {}, th)
      f["self_set_effect"](self, { scope = "5", value = 20 }, th)
      f["wait"](self, { time = 2 }, th)
      f["clear_all_effects"](self, {}, th)
      f["self_set_effect"](self, { scope = "3", value = 8 }, th)
      f["wait"](self, { time = 2 }, th)
      f["clear_all_effects"](self, {}, th)
      f["self_set_effect"](self, { scope = "5", value = 10 }, th)
      f["self_set_effect"](self, { scope = "4", value = 10 }, th)
      f["wait"](self, { time = 2 }, th)
      f["clear_all_effects"](self, {}, th)
      f["self_set_effect"](self, { scope = "5", value = 10 }, th)
      f["self_set_effect"](self, { scope = "3", value = 8 }, th)
      f["wait"](self, { time = 2 }, th)
      f["clear_all_effects"](self, {}, th)
      f["self_set_effect"](self, { scope = "3", value = 8 }, th)
      f["self_set_effect"](self, { scope = "4", value = 10 }, th)
      f["wait"](self, { time = 2 }, th)
      f["clear_all_effects"](self, {}, th)
      f["self_set_effect"](self, { scope = "5", value = 10 }, th)
      f["self_set_effect"](self, { scope = "4", value = 10 }, th)
      f["self_set_effect"](self, { scope = "3", value = 8 }, th)
  end)
end

M.requires = {
  "clear_all_effects",
  "self_set_effect",
  "wait",
}
return M

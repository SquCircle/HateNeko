-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：我的作品   version=0.27.4
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用
local __CONST = {
  { value = 0, variable = "a6aaa21a-cb14-44ce-81aa-6cd5dfd7f7e3" },
  { method = "increase", value = 1, variable = "a6aaa21a-cb14-44ce-81aa-6cd5dfd7f7e3" },
  { variable = "a6aaa21a-cb14-44ce-81aa-6cd5dfd7f7e3" },
}

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 562, 900
M.timer_pos = { x = 720, y = 12 }
M.proc_trampoline = false
M.uses_timer = false
M.timer_hidden_default = false
M.vars = { { current_entity_id = "", cv_id = "", entity_name = "", id = "a6aaa21a-cb14-44ce-81aa-6cd5dfd7f7e3", is_global = true, name = "i", order = 0, position = { x = 20, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = true } }
M.screens = { { id = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a", name = "背景", screenName = "屏幕", style_index = 1, styles = { "5631bae0-8d8d-4c2f-bcda-e1df797e3d73" }, visible = true } }
M.cur_scene = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a"
M.actors = { { id = "75d222f8-49d2-4353-8d8f-f6962722d17d", is_global = true, name = "编程猫", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "5d4c55ed-92c1-4ec0-a713-5d2fa3d24ad4", "31424fec-25a1-443c-a265-70ebe8ffc29b", "d7fd5472-43a8-4044-9e13-4f7db4a5443d", "4af1df64-ea78-424c-b980-01b4e816bb36", "dcffaae3-cbed-4513-bb78-3dcde0e2bcfb" }, visible = true, x = 0, y = 0 } }
M.assets_dir = "works"
M.assets = { ["31424fec-25a1-443c-a265-70ebe8ffc29b"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/31424fec-25a1-443c-a265-70ebe8ffc29b.png", id = "31424fec-25a1-443c-a265-70ebe8ffc29b", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/caf8f973dbe240babece35637dcafee8.png" }, ["4af1df64-ea78-424c-b980-01b4e816bb36"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/4af1df64-ea78-424c-b980-01b4e816bb36.png", id = "4af1df64-ea78-424c-b980-01b4e816bb36", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/25593adb06d24d988ada59c1d2131de8.png" }, ["5631bae0-8d8d-4c2f-bcda-e1df797e3d73"] = { adaption = nil, center = nil, file = "assets/5631bae0-8d8d-4c2f-bcda-e1df797e3d73.jpg", id = "5631bae0-8d8d-4c2f-bcda-e1df797e3d73", name = "沼泽", styleType = 1, url = "https://creation.codemao.cn/396/8bc3a5b92e934d7287e63f1684b61de6.jpg" }, ["5d4c55ed-92c1-4ec0-a713-5d2fa3d24ad4"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/5d4c55ed-92c1-4ec0-a713-5d2fa3d24ad4.png", id = "5d4c55ed-92c1-4ec0-a713-5d2fa3d24ad4", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/c364f36a8dcf42d1a6acbe26c7eb6aaa.png" }, ["d7fd5472-43a8-4044-9e13-4f7db4a5443d"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/d7fd5472-43a8-4044-9e13-4f7db4a5443d.png", id = "d7fd5472-43a8-4044-9e13-4f7db4a5443d", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/6e4d95aecf7441e6a9885cba405baeaf.png" }, ["dcffaae3-cbed-4513-bb78-3dcde0e2bcfb"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/dcffaae3-cbed-4513-bb78-3dcde0e2bcfb.png", id = "dcffaae3-cbed-4513-bb78-3dcde0e2bcfb", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/8aa8cbdbe82a442989b0fadb823444d4.png" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_700824a5_44a8_4d03_a7e8_aa95d87e9b2a = ents["700824a5-44a8-4d03-a7e8-aa95d87e9b2a"]
  local e_75d222f8_49d2_4353_8d8f_f6962722d17d = ents["75d222f8-49d2-4353-8d8f-f6962722d17d"]
  -- -------- 角色 编程猫 --------
  rt.on(e_75d222f8_49d2_4353_8d8f_f6962722d17d, "on_running_group_activated", {}, function(th, self)
      f["variables_set"](self, __CONST[1], th)
      while true do
        f["change_variables"](self, __CONST[2], th)
        f["set_width_height_scale"](self, { type = "width", value = f["math_function"](self, { num = f["math_arithmetic"](self, { A = 200, B = f["math_trig"](self, { num = f["variables_get"](self, __CONST[3], th), type = "cos" }, th), type = "multiply" }, th), type = "1" }, th) }, th)
        f["set_width_height_scale"](self, { type = "height", value = f["math_function"](self, { num = f["math_arithmetic"](self, { A = 200, B = f["math_trig"](self, { num = f["variables_get"](self, __CONST[3], th), type = "sin" }, th), type = "multiply" }, th), type = "1" }, th) }, th)
        f["self_set_effect"](self, { scope = "0", value = f["variables_get"](self, __CONST[3], th) }, th)
        f["self_point_towards"](self, { degrees = f["variables_get"](self, __CONST[3], th) }, th)
        if th:iter_n() then break end
      end
  end)
end

M.requires = {
  "change_variables",
  "math_arithmetic",
  "math_function",
  "math_trig",
  "self_point_towards",
  "self_set_effect",
  "set_width_height_scale",
  "variables_get",
  "variables_set",
}
return M

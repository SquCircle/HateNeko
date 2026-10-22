-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：我的作品   version=0.27.4
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 900, 562
M.vars = { { id = "d5e2984f-0be4-4324-bd68-107d3ab89339", name = "i", value = 0 } }
M.screens = { { id = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a", name = "背景", screenName = "屏幕", style_index = 1, styles = { "6d0d6c61-a1df-4076-8c19-83ddfdbbca1c" }, visible = false } }
M.cur_scene = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a"
M.actors = { { id = "025dd83c-de62-46a3-86bb-2ab6333e16c2", is_global = true, name = "编程猫", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "e9792a0f-ae14-4489-90c8-dd0fd6edd6d9", "5a1f9428-61c8-4ff3-984b-78ff34bdf04d", "106119db-7ea0-4d47-a33c-65f3d2a560e1", "509a0c7c-af8b-460f-b9a5-3c273ea8394e", "70cdaef4-bd83-4797-8aec-e1edddec8765" }, visible = false, x = 0, y = 0 }, { id = "629d16f1-a7e0-47ea-ad83-6e6decc91d48", is_global = true, name = "新角色", order = 2, rotation = 0, scale_x = 0.8, scale_y = 0.8, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "703fdfab-de35-4d81-a4f8-58e6c2291e31" }, visible = true, x = 200, y = -150 } }
M.assets_dir = "works"
M.assets = { ["106119db-7ea0-4d47-a33c-65f3d2a560e1"] = { adaption = nil, center = nil, file = "assets/106119db-7ea0-4d47-a33c-65f3d2a560e1.png", id = "106119db-7ea0-4d47-a33c-65f3d2a560e1", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/6e4d95aecf7441e6a9885cba405baeaf.png" }, ["509a0c7c-af8b-460f-b9a5-3c273ea8394e"] = { adaption = nil, center = nil, file = "assets/509a0c7c-af8b-460f-b9a5-3c273ea8394e.png", id = "509a0c7c-af8b-460f-b9a5-3c273ea8394e", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/25593adb06d24d988ada59c1d2131de8.png" }, ["5a1f9428-61c8-4ff3-984b-78ff34bdf04d"] = { adaption = nil, center = nil, file = "assets/5a1f9428-61c8-4ff3-984b-78ff34bdf04d.png", id = "5a1f9428-61c8-4ff3-984b-78ff34bdf04d", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/caf8f973dbe240babece35637dcafee8.png" }, ["6d0d6c61-a1df-4076-8c19-83ddfdbbca1c"] = { adaption = nil, center = nil, file = "assets/6d0d6c61-a1df-4076-8c19-83ddfdbbca1c.jpg", id = "6d0d6c61-a1df-4076-8c19-83ddfdbbca1c", name = "沼泽", styleType = 1, url = "https://creation.codemao.cn/396/8bc3a5b92e934d7287e63f1684b61de6.jpg" }, ["703fdfab-de35-4d81-a4f8-58e6c2291e31"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/703fdfab-de35-4d81-a4f8-58e6c2291e31.png", id = "703fdfab-de35-4d81-a4f8-58e6c2291e31", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfNzI3MDA5NV8zMzMxMTQwODVfMTc5MjMyMTIwMDAwMF9GaVVPOEdkWUd6Ny0yLXJOaUM5WkRDa1NJLUNF.svg" }, ["70cdaef4-bd83-4797-8aec-e1edddec8765"] = { adaption = nil, center = nil, file = "assets/70cdaef4-bd83-4797-8aec-e1edddec8765.png", id = "70cdaef4-bd83-4797-8aec-e1edddec8765", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/8aa8cbdbe82a442989b0fadb823444d4.png" }, ["e9792a0f-ae14-4489-90c8-dd0fd6edd6d9"] = { adaption = nil, center = nil, file = "assets/e9792a0f-ae14-4489-90c8-dd0fd6edd6d9.png", id = "e9792a0f-ae14-4489-90c8-dd0fd6edd6d9", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/c364f36a8dcf42d1a6acbe26c7eb6aaa.png" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_700824a5_44a8_4d03_a7e8_aa95d87e9b2a = ents["700824a5-44a8-4d03-a7e8-aa95d87e9b2a"]
  local e_025dd83c_de62_46a3_86bb_2ab6333e16c2 = ents["025dd83c-de62-46a3-86bb-2ab6333e16c2"]
  local e_629d16f1_a7e0_47ea_ad83_6e6decc91d48 = ents["629d16f1-a7e0-47ea-ad83-6e6decc91d48"]
  -- -------- 角色 编程猫 --------
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "on_running_group_activated", {}, function(th, self)
      f["variables_set"](self, { value = 0, variable = "d5e2984f-0be4-4324-bd68-107d3ab89339" }, th)
      f["self_set_pen_color"](self, { color = "#ff0000" }, th)
      while true do
        f["change_variables"](self, { method = "increase", value = 1, variable = "d5e2984f-0be4-4324-bd68-107d3ab89339" }, th)
        f["self_change_pen_color_property"](self, { increase = "increase", scope = "hue", steps = 5 }, th)
        f["self_move_to"](self, { x = -200, y = 150 }, th)
        f["self_point_towards"](self, { degrees = f["variables_get"](self, { variable = "d5e2984f-0be4-4324-bd68-107d3ab89339" }, th) }, th)
        f["stamp"](self, { align = "center", size = 50, text = "M" }, th)
        f["stamp"](self, { align = "right", size = 75, text = "L--" }, th)
        f["stamp"](self, { align = "left", size = 25, text = "--R" }, th)
        f["self_move_to"](self, { x = 250, y = 150 }, th)
        f["self_pen_down"](self, {}, th)
        f["self_set_pen_size"](self, { size = 1 }, th)
        do
          local _from, _to, _by = 0, 360, 60
          local _i = _from
          while (_by >= 0 and _i <= _to) or (_by < 0 and _i >= _to) do
            local _p = _i
            th:push_param(_p)
            f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = 200, B = f["math_arithmetic"](self, { A = 50, B = f["math_trig"](self, { num = _p, type = "cos" }, th), type = "multiply" }, th), type = "add" }, th), y = f["math_arithmetic"](self, { A = 150, B = f["math_arithmetic"](self, { A = 50, B = f["math_trig"](self, { num = _p, type = "sin" }, th), type = "multiply" }, th), type = "add" }, th) }, th)
            f["self_change_pen_size"](self, { increase = "increase", steps = 5 }, th)
            th:pop_param()
            _i = _i + _by
            if th:iter_n() then break end
          end
        end
        f["self_pen_up"](self, {}, th)
        f["self_move_to"](self, { x = -200, y = -150 }, th)
        f["image_stamp"](self, {}, th)
        f["self_move_to"](self, { x = 200, y = -150 }, th)
        f["self_point_towards"](self, { degrees = 0 }, th)
        f["stamp"](self, { align = "center", size = 100, text = "█" }, th)
        if V.bool(f["math_number_property"](self, { num = f["variables_get"](self, { variable = "d5e2984f-0be4-4324-bd68-107d3ab89339" }, th), type = "EVEN" }, th)) then
          f["set_pen_layer"](self, { layer = "peak" }, th)
        else
          f["set_pen_layer"](self, { layer = "bottom" }, th)
        end
        if th:iter_n() then break end
      end
  end)
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "sprite_on_tap", { sprite = "--screen", type = "mouse_click" }, function(th, self)
      f["clear_drawing"](self, {}, th)
  end)
end

M.requires = {
  "change_variables",
  "clear_drawing",
  "image_stamp",
  "math_arithmetic",
  "math_number_property",
  "math_trig",
  "self_change_pen_color_property",
  "self_change_pen_size",
  "self_move_to",
  "self_pen_down",
  "self_pen_up",
  "self_point_towards",
  "self_set_pen_color",
  "self_set_pen_size",
  "set_pen_layer",
  "stamp",
  "variables_get",
  "variables_set",
}
return M

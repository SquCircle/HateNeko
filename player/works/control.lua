-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：我的作品   version=0.27.4
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 900, 562
M.vars = { { id = "ba567a4b-6e93-4c8c-93b2-c117583a6f5a", name = "i", value = 0 } }
M.screens = { { id = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a", name = "背景", screenName = "屏幕", style_index = 1, styles = { "6d0d6c61-a1df-4076-8c19-83ddfdbbca1c" }, visible = true } }
M.cur_scene = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a"
M.actors = { { id = "025dd83c-de62-46a3-86bb-2ab6333e16c2", is_global = true, name = "编程猫", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "e9792a0f-ae14-4489-90c8-dd0fd6edd6d9", "5a1f9428-61c8-4ff3-984b-78ff34bdf04d", "106119db-7ea0-4d47-a33c-65f3d2a560e1", "509a0c7c-af8b-460f-b9a5-3c273ea8394e", "70cdaef4-bd83-4797-8aec-e1edddec8765" }, visible = true, x = 0, y = 0 }, { id = "aaac5b19-611a-4956-9829-16a328b2f3be", is_global = true, name = "编程猫1", order = 2, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "e9e1939e-1480-409a-9fed-aba140fa17b9", "ee67fdc5-1e2b-4f36-82bd-9687c03b50d5", "47373fed-3687-4082-8450-74ccbde8888a", "5aeae43a-ecc2-4c5c-bba6-1db72370f0c7", "5cde6ec5-eb8a-45a0-b9e4-3ce3d5da616d" }, visible = true, x = 0, y = 0 } }
M.assets_dir = "works"
M.assets = { ["106119db-7ea0-4d47-a33c-65f3d2a560e1"] = { adaption = nil, center = nil, file = "assets/106119db-7ea0-4d47-a33c-65f3d2a560e1.png", id = "106119db-7ea0-4d47-a33c-65f3d2a560e1", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/6e4d95aecf7441e6a9885cba405baeaf.png" }, ["47373fed-3687-4082-8450-74ccbde8888a"] = { adaption = nil, center = nil, file = "assets/47373fed-3687-4082-8450-74ccbde8888a.png", id = "47373fed-3687-4082-8450-74ccbde8888a", name = "编程猫1", styleType = nil, url = "https://creation.codemao.cn/396/6e4d95aecf7441e6a9885cba405baeaf.png" }, ["509a0c7c-af8b-460f-b9a5-3c273ea8394e"] = { adaption = nil, center = nil, file = "assets/509a0c7c-af8b-460f-b9a5-3c273ea8394e.png", id = "509a0c7c-af8b-460f-b9a5-3c273ea8394e", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/25593adb06d24d988ada59c1d2131de8.png" }, ["5a1f9428-61c8-4ff3-984b-78ff34bdf04d"] = { adaption = nil, center = nil, file = "assets/5a1f9428-61c8-4ff3-984b-78ff34bdf04d.png", id = "5a1f9428-61c8-4ff3-984b-78ff34bdf04d", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/caf8f973dbe240babece35637dcafee8.png" }, ["5aeae43a-ecc2-4c5c-bba6-1db72370f0c7"] = { adaption = nil, center = nil, file = "assets/5aeae43a-ecc2-4c5c-bba6-1db72370f0c7.png", id = "5aeae43a-ecc2-4c5c-bba6-1db72370f0c7", name = "编程猫1", styleType = nil, url = "https://creation.codemao.cn/396/25593adb06d24d988ada59c1d2131de8.png" }, ["5cde6ec5-eb8a-45a0-b9e4-3ce3d5da616d"] = { adaption = nil, center = nil, file = "assets/5cde6ec5-eb8a-45a0-b9e4-3ce3d5da616d.png", id = "5cde6ec5-eb8a-45a0-b9e4-3ce3d5da616d", name = "编程猫1", styleType = nil, url = "https://creation.codemao.cn/396/8aa8cbdbe82a442989b0fadb823444d4.png" }, ["6d0d6c61-a1df-4076-8c19-83ddfdbbca1c"] = { adaption = nil, center = nil, file = "assets/6d0d6c61-a1df-4076-8c19-83ddfdbbca1c.jpg", id = "6d0d6c61-a1df-4076-8c19-83ddfdbbca1c", name = "沼泽", styleType = 1, url = "https://creation.codemao.cn/396/8bc3a5b92e934d7287e63f1684b61de6.jpg" }, ["70cdaef4-bd83-4797-8aec-e1edddec8765"] = { adaption = nil, center = nil, file = "assets/70cdaef4-bd83-4797-8aec-e1edddec8765.png", id = "70cdaef4-bd83-4797-8aec-e1edddec8765", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/8aa8cbdbe82a442989b0fadb823444d4.png" }, ["e9792a0f-ae14-4489-90c8-dd0fd6edd6d9"] = { adaption = nil, center = nil, file = "assets/e9792a0f-ae14-4489-90c8-dd0fd6edd6d9.png", id = "e9792a0f-ae14-4489-90c8-dd0fd6edd6d9", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/c364f36a8dcf42d1a6acbe26c7eb6aaa.png" }, ["e9e1939e-1480-409a-9fed-aba140fa17b9"] = { adaption = nil, center = nil, file = "assets/e9e1939e-1480-409a-9fed-aba140fa17b9.png", id = "e9e1939e-1480-409a-9fed-aba140fa17b9", name = "编程猫1", styleType = nil, url = "https://creation.codemao.cn/396/c364f36a8dcf42d1a6acbe26c7eb6aaa.png" }, ["ee67fdc5-1e2b-4f36-82bd-9687c03b50d5"] = { adaption = nil, center = nil, file = "assets/ee67fdc5-1e2b-4f36-82bd-9687c03b50d5.png", id = "ee67fdc5-1e2b-4f36-82bd-9687c03b50d5", name = "编程猫1", styleType = nil, url = "https://creation.codemao.cn/396/caf8f973dbe240babece35637dcafee8.png" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_700824a5_44a8_4d03_a7e8_aa95d87e9b2a = ents["700824a5-44a8-4d03-a7e8-aa95d87e9b2a"]
  local e_025dd83c_de62_46a3_86bb_2ab6333e16c2 = ents["025dd83c-de62-46a3-86bb-2ab6333e16c2"]
  local e_aaac5b19_611a_4956_9829_16a328b2f3be = ents["aaac5b19-611a-4956-9829-16a328b2f3be"]
  -- -------- 角色 编程猫 --------
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "on_running_group_activated", {}, function(th, self)
      f["self_face_to"](self, { sprite = "--random" }, th)
      while true do
        f["self_go_forward"](self, { steps = 10 }, th)
        f["self_bounce_off_edge"](self, {}, th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 编程猫1 --------
  rt.on(e_aaac5b19_611a_4956_9829_16a328b2f3be, "on_running_group_activated", {}, function(th, self)
      do
        local _times_n1 = 180
        while true do
          if _times_n1 <= 0 then break end
          _times_n1 = _times_n1 - 1
          f["self_rotate"](self, { degrees = 2 }, th)
          if th:iter_n() then break end
        end
      end
      do
        local _from_n2, _to_n2 = tonumber(0), tonumber(360)
        if _from_n2 ~= _from_n2 or _to_n2 ~= _to_n2 then
          -- NaN from/to: official warning; no iterations
        else
          if _from_n2 <= _to_n2 then _from_n2 = math.ceil(_from_n2); if _from_n2 > _to_n2 then _from_n2 = _to_n2 + 1 end
          else _from_n2 = math.floor(_from_n2); if _from_n2 < _to_n2 then _from_n2 = _to_n2 - 1 end end
          local _by_n2 = 2
          if _by_n2 == nil then _by_n2 = 1 end
          _by_n2 = tonumber(_by_n2)
          if _by_n2 == nil or _by_n2 ~= _by_n2 or _by_n2 <= 0 then _by_n2 = 0 else _by_n2 = math.abs(math.floor(_by_n2 + 0.5)) end
          if _by_n2 > 0 then
            local _p_n2 = _from_n2
            while (_from_n2 <= _to_n2 and _p_n2 <= _to_n2) or (_from_n2 > _to_n2 and _p_n2 >= _to_n2) do
              local _i_n2 = _p_n2
              th:push_param(_p_n2)
            f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = 100, B = f["math_trig"](self, { num = _p_n2, type = "cos" }, th), type = "multiply" }, th), y = f["math_arithmetic"](self, { A = 100, B = f["math_trig"](self, { num = _p_n2, type = "sin" }, th), type = "multiply" }, th) }, th)
              th:pop_param()
              _p_n2 = _p_n2 + _by_n2
              if th:iter_n() then break end
            end
          end
        end
      end
      f["self_move_to"](self, { x = -200, y = 0 }, th)
      while true do
        if f["logic_compare"](self, { A = f["coordinate_of_sprite"](self, { coordinate = "x", sprite = "--self" }, th), B = 200, OP = "GTE" }, th) then break end
        f["self_change_coordinate_x"](self, { increase = "increase", value = 2 }, th)
        if th:iter_n() then break end
      end
      f["variables_set"](self, { value = 0, variable = "ba567a4b-6e93-4c8c-93b2-c117583a6f5a" }, th)
      f["self_face_to"](self, { sprite = "--random" }, th)
      while true do
        f["change_variables"](self, { method = "increase", value = 1, variable = "ba567a4b-6e93-4c8c-93b2-c117583a6f5a" }, th)
        if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, { variable = "ba567a4b-6e93-4c8c-93b2-c117583a6f5a" }, th), B = 200, OP = "GT" }, th)) then
          break
        else
          f["self_go_forward"](self, { steps = 10 }, th)
          f["self_bounce_off_edge"](self, {}, th)
        end
        if th:iter_n() then break end
      end
      f["wait"](self, { time = 1 }, th)
      f["self_point_towards"](self, { degrees = 0 }, th)
      f["self_move_to"](self, { x = 0, y = 0 }, th)
      f["self_go_forward"](self, { steps = 100 }, th)
      while not V.bool(f["mouse_down"](self, { sprite = "--screen", type = "click" }, th)) do
        if th:iter_n() then break end
      end
      f["console_log"](self, { console_log = "已执行" }, th)
      th:warp_enter()
      do
        local _from_n3, _to_n3 = tonumber(0), tonumber(360)
        if _from_n3 ~= _from_n3 or _to_n3 ~= _to_n3 then
          -- NaN from/to: official warning; no iterations
        else
          if _from_n3 <= _to_n3 then _from_n3 = math.ceil(_from_n3); if _from_n3 > _to_n3 then _from_n3 = _to_n3 + 1 end
          else _from_n3 = math.floor(_from_n3); if _from_n3 < _to_n3 then _from_n3 = _to_n3 - 1 end end
          local _by_n3 = 1
          if _by_n3 == nil then _by_n3 = 1 end
          _by_n3 = tonumber(_by_n3)
          if _by_n3 == nil or _by_n3 ~= _by_n3 or _by_n3 <= 0 then _by_n3 = 0 else _by_n3 = math.abs(math.floor(_by_n3 + 0.5)) end
          if _by_n3 > 0 then
            local _p_n3 = _from_n3
            while (_from_n3 <= _to_n3 and _p_n3 <= _to_n3) or (_from_n3 > _to_n3 and _p_n3 >= _to_n3) do
              local _i_n3 = _p_n3
              th:push_param(_p_n3)
            f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = 100, B = f["math_trig"](self, { num = _p_n3, type = "cos" }, th), type = "multiply" }, th), y = f["math_arithmetic"](self, { A = 100, B = f["math_trig"](self, { num = _p_n3, type = "sin" }, th), type = "multiply" }, th) }, th)
              th:pop_param()
              _p_n3 = _p_n3 + _by_n3
              if th:iter_w() then break end
            end
          end
        end
      end
      th:warp_exit()
      f["tell"](self, { sprite = "025dd83c-de62-46a3-86bb-2ab6333e16c2", DO = function(t2, s2)
          f["self_move_to"](s2, { x = 0, y = 0 }, t2)
      end }, th)
      f["sync_tell"](self, { sprite = "025dd83c-de62-46a3-86bb-2ab6333e16c2", DO = function(t2, s2)
          do
            local _times_n3 = 180
            while true do
              if _times_n3 <= 0 then break end
              _times_n3 = _times_n3 - 1
              f["self_rotate"](s2, { degrees = 2 }, t2)
              if t2:iter_d() then break end
            end
          end
      end }, th)
      f["self_move_to"](self, { x = 200, y = 200 }, th)
  end)
end

M.requires = {
  "change_variables",
  "console_log",
  "coordinate_of_sprite",
  "logic_compare",
  "math_arithmetic",
  "math_trig",
  "mouse_down",
  "self_bounce_off_edge",
  "self_change_coordinate_x",
  "self_face_to",
  "self_go_forward",
  "self_move_to",
  "self_point_towards",
  "self_rotate",
  "variables_get",
  "variables_set",
  "wait",
}
return M

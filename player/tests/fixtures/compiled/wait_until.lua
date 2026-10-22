-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：wait_until   version=0.27.4
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用
local __CONST = {
  { type = "reset" },
  { value = 1, variable = "v_timer" },
  { time = 0.02 },
  { method = "increase", n = 1, variable = "v_ready" },
  { variable = "v_ready" },
  { value = 1, variable = "v_after" },
  { A = 1, B = 1, OP = "EQ" },
  { value = 1, variable = "v_immediate" },
}

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 562, 900
M.timer_pos = { x = 720, y = 12 }
M.proc_trampoline = false
M.uses_timer = true
M.timer_hidden_default = false
M.vars = { { current_entity_id = "", cv_id = "", entity_name = "", id = "v_after", is_global = false, name = "after", order = 1, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_immediate", is_global = false, name = "immediate", order = 2, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_ready", is_global = false, name = "ready", order = 0, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_timer", is_global = false, name = "timer", order = 3, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true } }
M.screens = { { id = "sc1", name = "背景", screenName = "屏幕", style_index = 1, styles = { "st1" }, visible = true } }
M.cur_scene = "sc1"
M.actors = { { id = "a1", is_global = true, name = "猫", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "sc1" }, style_index = 1, styles = { "st1" }, visible = true, x = 0, y = 0 } }
M.assets_dir = "works"
M.assets = { ["st1"] = { adaption = nil, center = nil, file = "assets/st1.png", id = "st1", name = "s1", styleType = nil, url = "" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_sc1 = ents["sc1"]
  local e_a1 = ents["a1"]
  -- -------- 角色 猫 --------
  rt.on(e_a1, "on_running_group_activated", {}, function(th, self)
      f["set_timer_state"](self, __CONST[1], th)
      while not V.bool(f["logic_compare"](self, { A = f["timer"](self, {}, th), B = 0, OP = "GT" }, th)) do
        if th:iter_n() then break end
      end
      f["variables_set"](self, __CONST[2], th)
  end)
  rt.on(e_a1, "on_running_group_activated", {}, function(th, self)
      do
        local _times_n1 = 3
        while true do
          if _times_n1 <= 0 then break end
          _times_n1 = _times_n1 - 1
          f["wait"](self, __CONST[3], th)
          f["change_variables"](self, __CONST[4], th)
          if th:iter_n() then break end
        end
      end
  end)
  rt.on(e_a1, "on_running_group_activated", {}, function(th, self)
      while not V.bool(f["logic_compare"](self, { A = f["variables_get"](self, __CONST[5], th), B = 3, OP = "GTE" }, th)) do
        if th:iter_n() then break end
      end
      f["variables_set"](self, __CONST[6], th)
  end)
  rt.on(e_a1, "on_running_group_activated", {}, function(th, self)
      while not V.bool(f["logic_compare"](self, __CONST[7], th)) do
        if th:iter_n() then break end
      end
      f["variables_set"](self, __CONST[8], th)
  end)
end

M.requires = {
  "change_variables",
  "logic_compare",
  "set_timer_state",
  "timer",
  "variables_get",
  "variables_set",
  "wait",
}
return M

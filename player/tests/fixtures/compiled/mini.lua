-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：mini   version=0.27.4
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用
local __CONST = {
  { value = 0, variable = "v_count" },
  { method = "increase", n = 1, variable = "v_count" },
  { time = 0.05 },
  { message = "go" },
  { variable = "v_count" },
  { steps = 10 },
  { value = 1, variable = "v_done" },
  { value = 1, variable = "v_flag" },
  { method = "increase", n = 1, variable = "v_total" },
}

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 562, 900
M.timer_pos = { x = 720, y = 12 }
M.proc_trampoline = false
M.uses_timer = false
M.timer_hidden_default = false
M.vars = { { current_entity_id = "", cv_id = "", entity_name = "", id = "v_count", is_global = false, name = "计数", order = 0, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_done", is_global = false, name = "完成", order = 3, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_flag", is_global = false, name = "标志", order = 1, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_total", is_global = false, name = "总计", order = 2, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true } }
M.screens = { { id = "sc1", name = "背景", screenName = "屏幕", style_index = 1, styles = { "st1" }, visible = true } }
M.cur_scene = "sc1"
M.actors = { { id = "a1", is_global = true, name = "猫", order = 2, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "sc1" }, style_index = 1, styles = { "st1" }, visible = true, x = 0, y = 0 }, { id = "a2", is_global = true, name = "狗", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "sc1" }, style_index = 1, styles = { "st1" }, visible = true, x = 100, y = 0 } }
M.assets_dir = "works"
M.assets = { ["st1"] = { adaption = nil, center = nil, file = "assets/st1.png", id = "st1", name = "s1", styleType = nil, url = "" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_sc1 = ents["sc1"]
  local e_a1 = ents["a1"]
  local e_a2 = ents["a2"]
  -- -------- 角色 猫 --------
  rt.on(e_a1, "on_running_group_activated", {}, function(th, self)
      f["variables_set"](self, __CONST[1], th)
      do
        local _times_n1 = 3
        while true do
          if _times_n1 <= 0 then break end
          _times_n1 = _times_n1 - 1
          f["change_variables"](self, __CONST[2], th)
          f["wait"](self, __CONST[3], th)
          if th:iter_n() then break end
        end
      end
      f["self_broadcast"](self, __CONST[4], th)
      if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, __CONST[5], th), B = 3, OP = "GTE" }, th)) then
        f["self_go_forward"](self, __CONST[6], th)
      end
      f["variables_set"](self, __CONST[7], th)
  end)
  rt.on(e_a1, "self_listen", { message = "go" }, function(th, self)
      f["variables_set"](self, __CONST[8], th)
  end)
  -- -------- 角色 狗 --------
  rt.on(e_a2, "self_listen", { message = "go" }, function(th, self)
      f["change_variables"](self, __CONST[9], th)
  end)
end

M.requires = {
  "change_variables",
  "logic_compare",
  "self_broadcast",
  "self_go_forward",
  "variables_get",
  "variables_set",
  "wait",
}
return M

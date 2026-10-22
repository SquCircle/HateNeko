-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：hat_order   version=0.27.4
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用
local __CONST = {
  { value = 1, variable = "v_first" },
  { value = 1, variable = "v_second" },
  { value = 1, variable = "v_b" },
}

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 100, 100
M.timer_pos = { x = 720, y = 12 }
M.proc_trampoline = false
M.uses_timer = false
M.timer_hidden_default = false
M.vars = { { current_entity_id = "", cv_id = "", entity_name = "", id = "v_b", is_global = false, name = "b", order = 2, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_first", is_global = false, name = "first", order = 0, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_second", is_global = false, name = "second", order = 1, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true } }
M.screens = {  }
M.cur_scene = ""
M.actors = { { id = "zzz-actor", is_global = false, name = "A", order = 0, rotation = 0, scale_x = 1, scale_y = 1, scenes = {  }, style_index = 1, styles = {  }, visible = true, x = 0, y = 0 }, { id = "aaa-actor", is_global = false, name = "B", order = 0, rotation = 0, scale_x = 1, scale_y = 1, scenes = {  }, style_index = 1, styles = {  }, visible = true, x = 0, y = 0 } }
M.assets_dir = "works"
M.assets = {  }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_zzz_actor = ents["zzz-actor"]
  local e_aaa_actor = ents["aaa-actor"]
  -- -------- 角色 A --------
  rt.on(e_zzz_actor, "on_running_group_activated", {}, function(th, self)
      f["variables_set"](self, __CONST[1], th)
  end)
  rt.on(e_zzz_actor, "on_running_group_activated", {}, function(th, self)
      f["variables_set"](self, __CONST[2], th)
  end)
  -- -------- 角色 B --------
  rt.on(e_aaa_actor, "on_running_group_activated", {}, function(th, self)
      f["variables_set"](self, __CONST[3], th)
  end)
end

M.requires = {
  "variables_set",
}
return M

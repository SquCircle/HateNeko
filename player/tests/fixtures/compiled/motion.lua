-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：运动测试   version=0.27.4
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用
local __CONST = {
  { x = 100, y = 50 },
  { coordinate = "x" },
  { coordinate = "y" },
  { x = 200 },
  { time = 0.2, x = 0, y = 0 },
  { time = 0.3 },
  { degrees = 90 },
  { steps = 100 },
}

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 562, 900
M.timer_pos = { x = 720, y = 12 }
M.proc_trampoline = false
M.uses_timer = false
M.timer_hidden_default = false
M.vars = { { current_entity_id = "", cv_id = "", entity_name = "", id = "v_dir", is_global = false, name = "朝向", order = 3, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_fx", is_global = false, name = "前进后x", order = 4, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_fy", is_global = false, name = "前进后y", order = 5, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_glide_end", is_global = false, name = "滑行结束x", order = 7, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_glide_mid", is_global = false, name = "滑行中途x", order = 6, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_x1", is_global = false, name = "移到后的x", order = 0, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_x2", is_global = false, name = "设置x后", order = 2, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_y1", is_global = false, name = "移到后的y", order = 1, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true } }
M.screens = { { id = "sc1", name = "背景", screenName = "屏幕", style_index = 1, styles = { "st1" }, visible = true } }
M.cur_scene = "sc1"
M.actors = { { id = "mover", is_global = true, name = "移动者", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "sc1" }, style_index = 1, styles = { "st1" }, visible = true, x = -999, y = -999 } }
M.assets_dir = "works"
M.assets = { ["st1"] = { adaption = nil, center = nil, file = "assets/st1.png", id = "st1", name = "占位", styleType = nil, url = "" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_sc1 = ents["sc1"]
  local e_mover = ents["mover"]
  -- -------- 角色 移动者 --------
  rt.on(e_mover, "on_running_group_activated", {}, function(th, self)
      f["self_move_to"](self, __CONST[1], th)
      f["variables_set"](self, { value = f["coordinate_of_sprite"](self, __CONST[2], th), variable = "v_x1" }, th)
      f["variables_set"](self, { value = f["coordinate_of_sprite"](self, __CONST[3], th), variable = "v_y1" }, th)
      f["self_set_position_x"](self, __CONST[4], th)
      f["variables_set"](self, { value = f["coordinate_of_sprite"](self, __CONST[2], th), variable = "v_x2" }, th)
      f["self_glide_to"](self, __CONST[5], th)
      f["variables_set"](self, { value = f["coordinate_of_sprite"](self, __CONST[2], th), variable = "v_glide_mid" }, th)
      f["wait"](self, __CONST[6], th)
      f["variables_set"](self, { value = f["coordinate_of_sprite"](self, __CONST[2], th), variable = "v_glide_end" }, th)
      f["self_point_towards"](self, __CONST[7], th)
      f["variables_set"](self, { value = f["get_orientation"](self, {}, th), variable = "v_dir" }, th)
      f["self_go_forward"](self, __CONST[8], th)
      f["variables_set"](self, { value = f["coordinate_of_sprite"](self, __CONST[2], th), variable = "v_fx" }, th)
      f["variables_set"](self, { value = f["coordinate_of_sprite"](self, __CONST[3], th), variable = "v_fy" }, th)
  end)
end

M.requires = {
  "coordinate_of_sprite",
  "get_orientation",
  "self_glide_to",
  "self_go_forward",
  "self_move_to",
  "self_point_towards",
  "self_set_position_x",
  "variables_set",
  "wait",
}
return M

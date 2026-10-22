-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：事件测试   version=0.27.4
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用
local __CONST = {
  { message = "go" },
  { value = 1, variable = "v_after" },
  { message = "p", param = "hello" },
  { message = "wait" },
  { value = 1, variable = "v_afterwait" },
  { value = 1, variable = "v_go" },
  { time = 0.05 },
  { value = 1, variable = "v_waited" },
  { value = 1, variable = "v_other" },
  { TEXT = "内容" },
}

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 562, 900
M.timer_pos = { x = 720, y = 12 }
M.proc_trampoline = false
M.uses_timer = false
M.timer_hidden_default = false
M.vars = { { current_entity_id = "", cv_id = "", entity_name = "", id = "v_after", is_global = false, name = "广播后", order = 2, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_afterwait", is_global = false, name = "广播并等待之后", order = 5, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_go", is_global = false, name = "收到go", order = 0, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_got", is_global = false, name = "收到内容", order = 3, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = "", visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_other", is_global = false, name = "收到other", order = 1, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_waited", is_global = false, name = "听者已完成等待", order = 4, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true } }
M.screens = { { id = "sc1", name = "背景", screenName = "屏幕", style_index = 1, styles = { "st1" }, visible = true } }
M.cur_scene = "sc1"
M.actors = { { id = "sender", is_global = true, name = "发送者", order = 4, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "sc1" }, style_index = 1, styles = { "st1" }, visible = true, x = 0, y = 0 }, { id = "l1", is_global = true, name = "听者1", order = 3, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "sc1" }, style_index = 1, styles = { "st1" }, visible = true, x = 0, y = 0 }, { id = "l2", is_global = true, name = "听者2", order = 2, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "sc1" }, style_index = 1, styles = { "st1" }, visible = true, x = 0, y = 0 }, { id = "lp", is_global = true, name = "带内容听者", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "sc1" }, style_index = 1, styles = { "st1" }, visible = true, x = 0, y = 0 } }
M.assets_dir = "works"
M.assets = { ["st1"] = { adaption = nil, center = nil, file = "assets/st1.png", id = "st1", name = "占位", styleType = nil, url = "" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_sc1 = ents["sc1"]
  local e_sender = ents["sender"]
  local e_l1 = ents["l1"]
  local e_l2 = ents["l2"]
  local e_lp = ents["lp"]
  -- -------- 角色 发送者 --------
  rt.on(e_sender, "on_running_group_activated", {}, function(th, self)
      f["self_broadcast"](self, __CONST[1], th)
      f["variables_set"](self, __CONST[2], th)
      f["self_broadcast_with_param"](self, __CONST[3], th)
      f["self_broadcast_and_wait"](self, __CONST[4], th)
      f["variables_set"](self, __CONST[5], th)
  end)
  -- -------- 角色 听者1 --------
  rt.on(e_l1, "received_broadcast", { message = "go" }, function(th, self)
      f["variables_set"](self, __CONST[6], th)
  end)
  rt.on(e_l1, "received_broadcast", { message = "wait" }, function(th, self)
      f["wait"](self, __CONST[7], th)
      f["variables_set"](self, __CONST[8], th)
  end)
  -- -------- 角色 听者2 --------
  rt.on(e_l2, "received_broadcast", { message = "other" }, function(th, self)
      f["variables_set"](self, __CONST[9], th)
  end)
  -- -------- 角色 带内容听者 --------
  rt.on(e_lp, "self_listen_with_param", { message = "p" }, function(th, self)
      f["variables_set"](self, { value = f["self_listen_value"](self, __CONST[10], th), variable = "v_got" }, th)
  end)
end

M.requires = {
  "self_broadcast",
  "self_broadcast_and_wait",
  "self_broadcast_with_param",
  "self_listen_value",
  "variables_set",
  "wait",
}
return M

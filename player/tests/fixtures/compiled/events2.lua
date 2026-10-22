-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：事件测试2   version=0.27.4
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用
local __CONST = {
  { value = 1, variable = "v_tap" },
  { value = 1, variable = "v_key" },
  { key = "65" },
  { value = 1, variable = "v_poll" },
  { variable = "v_x" },
  { value = 1, variable = "v_when" },
  { target = "--self" },
  { value = 1, variable = "v_clone" },
  { value = 1, variable = "v_bump" },
  { value = 1, variable = "v_swipe" },
}

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 562, 900
M.timer_pos = { x = 720, y = 12 }
M.proc_trampoline = false
M.uses_timer = false
M.timer_hidden_default = false
M.vars = { { current_entity_id = "", cv_id = "", entity_name = "", id = "v_bump", is_global = false, name = "碰到触发", order = 6, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_clone", is_global = false, name = "克隆体已启动", order = 5, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_key", is_global = false, name = "按了键(事件)", order = 1, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_poll", is_global = false, name = "轮询到按键", order = 2, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_swipe", is_global = false, name = "滑动触发", order = 7, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_tap", is_global = false, name = "被点击", order = 0, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_when", is_global = false, name = "条件触发", order = 4, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_x", is_global = false, name = "条件变量", order = 3, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true } }
M.screens = { { id = "sc1", name = "背景", screenName = "屏幕", style_index = 1, styles = { "st1" }, visible = true } }
M.cur_scene = "sc1"
M.actors = { { id = "tapper", is_global = true, name = "被点角色", order = 4, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "sc1" }, style_index = 1, styles = { "0554a7fb-795f-47b3-9cdb-e5a99d1085f1" }, visible = true, x = 0, y = 0 }, { id = "keyer", is_global = true, name = "按键角色", order = 3, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "sc1" }, style_index = 1, styles = { "0554a7fb-795f-47b3-9cdb-e5a99d1085f1" }, visible = true, x = 0, y = 0 }, { id = "waiter", is_global = true, name = "条件角色", order = 2, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "sc1" }, style_index = 1, styles = { "0554a7fb-795f-47b3-9cdb-e5a99d1085f1" }, visible = true, x = 0, y = 0 }, { id = "cloner", is_global = true, name = "克隆者", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "sc1" }, style_index = 1, styles = { "0554a7fb-795f-47b3-9cdb-e5a99d1085f1" }, visible = true, x = 0, y = 0 }, { id = "bumper", is_global = false, name = "碰撞者", order = 0, rotation = 0, scale_x = 1, scale_y = 1, scenes = {  }, style_index = 1, styles = { "0554a7fb-795f-47b3-9cdb-e5a99d1085f1" }, visible = true, x = 0, y = 0 }, { id = "bumper2", is_global = false, name = "碰撞目标", order = 0, rotation = 0, scale_x = 1, scale_y = 1, scenes = {  }, style_index = 1, styles = { "0554a7fb-795f-47b3-9cdb-e5a99d1085f1" }, visible = true, x = 0, y = 0 }, { id = "swiper", is_global = false, name = "滑动者", order = 0, rotation = 0, scale_x = 1, scale_y = 1, scenes = {  }, style_index = 1, styles = { "0554a7fb-795f-47b3-9cdb-e5a99d1085f1" }, visible = true, x = 0, y = 0 } }
M.assets_dir = "works"
M.assets = { ["0554a7fb-795f-47b3-9cdb-e5a99d1085f1"] = { adaption = nil, center = nil, file = "assets/0554a7fb-795f-47b3-9cdb-e5a99d1085f1.png", id = "0554a7fb-795f-47b3-9cdb-e5a99d1085f1", name = "真实图片", styleType = nil, url = "" }, ["e9792a0f-ae14-4489-90c8-dd0fd6edd6d9"] = { adaption = nil, center = nil, file = "assets/e9792a0f-ae14-4489-90c8-dd0fd6edd6d9.png", id = "e9792a0f-ae14-4489-90c8-dd0fd6edd6d9", name = "真实造型", styleType = nil, url = "https://x/t.png" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_sc1 = ents["sc1"]
  local e_tapper = ents["tapper"]
  local e_keyer = ents["keyer"]
  local e_waiter = ents["waiter"]
  local e_cloner = ents["cloner"]
  local e_bumper = ents["bumper"]
  local e_bumper2 = ents["bumper2"]
  local e_swiper = ents["swiper"]
  -- -------- 角色 被点角色 --------
  rt.on(e_tapper, "sprite_on_tap", { sprite = "--self" }, function(th, self)
      f["variables_set"](self, __CONST[1], th)
  end)
  -- -------- 角色 按键角色 --------
  rt.on(e_keyer, "on_keydown", { key = "65" }, function(th, self)
      f["variables_set"](self, __CONST[2], th)
  end)
  rt.on(e_keyer, "on_running_group_activated", {}, function(th, self)
      while not V.bool(f["check_key"](self, __CONST[3], th)) do
        if th:iter_n() then break end
      end
      f["variables_set"](self, __CONST[4], th)
  end)
  -- -------- 角色 条件角色 --------
  rt.on(e_waiter, "when", { cond = function(th, self) return f["logic_compare"](self, { A = f["variables_get"](self, __CONST[5], th), B = 0, OP = "GT" }, th) end }, function(th, self)
      f["variables_set"](self, __CONST[6], th)
  end)
  -- -------- 角色 克隆者 --------
  rt.on(e_cloner, "on_running_group_activated", {}, function(th, self)
      f["mirror"](self, __CONST[7], th)
  end)
  rt.on(e_cloner, "start_as_a_mirror", {}, function(th, self)
      f["variables_set"](self, __CONST[8], th)
  end)
  -- -------- 角色 碰撞者 --------
  rt.on(e_bumper, "on_bump_actor", { sprite = "碰撞目标" }, function(th, self)
      f["variables_set"](self, __CONST[9], th)
  end)
  -- -------- 角色 滑动者 --------
  rt.on(e_swiper, "on_swipe", {}, function(th, self)
      f["variables_set"](self, __CONST[10], th)
  end)
end

M.requires = {
  "check_key",
  "logic_compare",
  "mirror",
  "variables_get",
  "variables_set",
}
return M

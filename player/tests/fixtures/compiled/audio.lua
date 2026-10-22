-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：audio测试   version=0.27.4
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用
local __CONST = {
  { audio_id = "snd1", volume = 100 },
  { value = 1, variable = "v_played" },
  { audio_id = "snd1", volume = 50 },
  { value = 1, variable = "v_done" },
  { audio_id = "snd1" },
  { value = 1, variable = "v_stopped" },
}

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 562, 900
M.timer_pos = { x = 720, y = 12 }
M.proc_trampoline = false
M.uses_timer = false
M.timer_hidden_default = false
M.vars = { { current_entity_id = "", cv_id = "", entity_name = "", id = "v_done", is_global = false, name = "等待完成", order = 1, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_played", is_global = false, name = "已播放", order = 0, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "v_stopped", is_global = false, name = "已停止", order = 2, position = { x = 0, y = 0 }, scale = 1, style = "default", type = "variable", value = 0, visible = true } }
M.screens = { { id = "sc1", name = "背景", screenName = "屏幕", style_index = 1, styles = { "st1" }, visible = true } }
M.cur_scene = "sc1"
M.actors = { { id = "a1", is_global = true, name = "猫", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "sc1" }, style_index = 1, styles = { "st1" }, visible = true, x = 0, y = 0 } }
M.assets_dir = "works"
M.assets = { ["st1"] = { adaption = nil, center = nil, file = "assets/st1.png", id = "st1", name = "占位", styleType = nil, url = "" } }
M.audios = { ["snd1"] = { file = "assets/snd1.mp3", id = "snd1", name = "提示音", url = "" } }

function M.register(rt, game, ents)
  f = rt.f
  local e_sc1 = ents["sc1"]
  local e_a1 = ents["a1"]
  -- -------- 角色 猫 --------
  rt.on(e_a1, "on_running_group_activated", {}, function(th, self)
      f["play_audio"](self, __CONST[1], th)
      f["variables_set"](self, __CONST[2], th)
      f["play_audio_and_wait"](self, __CONST[3], th)
      f["variables_set"](self, __CONST[4], th)
      f["stop_audio"](self, __CONST[5], th)
      f["variables_set"](self, __CONST[6], th)
  end)
end

M.requires = {
  "play_audio",
  "play_audio_and_wait",
  "stop_audio",
  "variables_set",
}
return M

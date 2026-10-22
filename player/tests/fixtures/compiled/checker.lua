-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：棋盘格测量   version=0.27.4
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 900, 562
M.timer_pos = { x = 720, y = 12 }
M.proc_trampoline = false
M.uses_timer = false
M.timer_hidden_default = false
M.vars = { { current_entity_id = "", cv_id = "", entity_name = "", id = "75757a8e-156a-4f3e-a34b-17e492ac4ee0", is_global = true, name = "i", order = 0, position = { x = 20, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = true } }
M.screens = { { id = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a", name = "背景", screenName = "屏幕", style_index = 1, styles = { "checker" }, visible = true } }
M.cur_scene = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a"
M.actors = {  }
M.assets_dir = "works"
M.assets = { ["checker"] = { adaption = nil, center = nil, file = "assets/checker.png", id = "checker", name = "棋盘格", styleType = nil, url = "https://x/checker.png" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_700824a5_44a8_4d03_a7e8_aa95d87e9b2a = ents["700824a5-44a8-4d03-a7e8-aa95d87e9b2a"]
end

M.requires = {
}
return M

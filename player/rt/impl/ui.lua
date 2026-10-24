-- 弹窗 / 输入 / 文本印章 等 UI 类原语
-- M2 阶段：不弹真 UI，用「固定字段」代替输入框；文本印章先打到宿主日志（love 的 print）
-- 统一签名：function(self, args, th)
local V = require("rt.values")

local M = {}

local function root_actor(e)
  while e and e.is_clone and e.parent do e = e.parent end
  return e
end

local function game(th) return th.sched.game end

-- 官方数值化规则：按钮/输入里像数字的字符串转 Number，否则保留字符串。
-- 官方数值化规则（self_ask / ask_and_choose 共用）：`/^(-?\d+)(\.\d+)?$/`
-- 只有整数或「整数.小数」才转 Number；"5."、"1e3"、"+5" 都是字符串。
local function norm_value(v)
  if type(v) == "string" and (v:match("^-?%d+$") or v:match("^-?%d+%.%d+$")) then
    return tonumber(v) or v
  end
  return v
end

local function queue_of(g)
  g.dialog_queue = g.dialog_queue or {}
  return g.dialog_queue
end

local function open_log(g, d)
  local what = d.type == "choice" and "选择框" or "输入框"
  g.host:log(("[%s] %s → 等待"):format(what, d.prompt ~= "" and d.prompt or "(无提示)"), "ui")
end

-- 正式 API：当前弹窗（队列第一个）。owner 是调用 ask 的实体（契约字段）。
function M.current_dialog(g)
  g = g or require("rt.init").game
  local q = g and g.dialog_queue
  return q and q[1] or nil
end

-- 正式 API：UI 按钮/提交回调走这里；释放对应线程锁，队列前进到下一个 ask。
function M.submit_choice(value, index, g)
  g = g or require("rt.init").game
  local q = g and g.dialog_queue
  local d = q and q[1]
  if not d or d.type ~= "choice" then return false end

  local idx = tonumber(index)
  if idx == nil then
    local v = norm_value(value)
    for i = 1, 4 do
      local c = d.choices[i]
      if c ~= nil and V.eq(c, v) then idx = i break end
    end
  end
  if idx == nil or idx < 1 or idx > 4 or d.choices[idx] == nil then return false end

  local chosen = d.choices[idx]
  d.th.ask_choice = chosen
  d.th.ask_index = idx
  g.answer = chosen
  g.choice_value = chosen
  g.choice_index = idx
  d.lock.stop()
  table.remove(q, 1)
  g.host:log(("[选择框] → %s (index=%d)"):format(tostring(chosen), idx), "ui")
  if q[1] then open_log(g, q[1]) end
  return true, d
end

-- 正式 API：输入框提交。
function M.submit_answer(value, g)
  g = g or require("rt.init").game
  local q = g and g.dialog_queue
  local d = q and q[1]
  if not d or d.type ~= "ask" then return false end

  local answer = norm_value(value)
  d.th.ask_answer = answer
  g.answer = answer
  d.lock.stop()
  table.remove(q, 1)
  g.host:log(("[输入框] → %s"):format(tostring(answer)), "ui")
  if q[1] then open_log(g, q[1]) end
  return true, d
end

-- 弹出输入框：创建 per-thread 锁 + 入队；线程阻塞到 submit_answer。
function M.self_ask(self, args, th)
  local g = game(th)
  local prompt = V.str(args.text or args.QUESTION)
  local d = {
    type = "ask", owner = root_actor(self), th = th, prompt = prompt,
    lock = th.sched:get_thread_lock(th),
  }
  queue_of(g)[#g.dialog_queue + 1] = d
  g.ask_prompt = prompt
  if g.dialog_queue[1] == d then open_log(g, d) end
  coroutine.yield()   -- 锁住当前线程；submit_answer 释放后从下一帧继续
end

-- 输入框结果（per-thread，避免多个 ask 串值）
function M.get_answer(self, args, th)
  if th.ask_answer ~= nil then return th.ask_answer end
  return game(th).answer or ""
end

-- 弹出选择框：选项保留 0..3 槽位；线程阻塞到 submit_choice。
function M.ask_and_choose(self, args, th)
  local g = game(th)
  local choices = {
    [1] = norm_value(args.CHOICE0),
    [2] = norm_value(args.CHOICE1),
    [3] = norm_value(args.CHOICE2),
    [4] = norm_value(args.CHOICE3),
  }
  local d = {
    type = "choice", owner = self, th = th,
    prompt = V.str(args.question or ""),
    choices = choices,
    lock = th.sched:get_thread_lock(th),
  }
  queue_of(g)[#g.dialog_queue + 1] = d
  if g.dialog_queue[1] == d then open_log(g, d) end
  coroutine.yield()   -- 锁住当前线程；submit_choice 释放后从下一帧继续
end

function M.get_choice_and_index(self, args, th)
  local t = tostring(args.type or "content")
  if t == "index" then
    if th.ask_index ~= nil then return th.ask_index end
    local g = game(th)
    if g.choice_index ~= nil then return g.choice_index end
    return 0 / 0
  end
  if th.ask_choice ~= nil then return th.ask_choice end
  return game(th).choice_value or ""
end

-- 弹窗类：先打日志（M3 再做真 UI）
function M.create_stage_dialog(self, args, th)
  local g = game(th)
  local lock = th and th.sched and th.sched.get_thread_lock and th.sched:get_thread_lock(th) or nil
  g.stage_dialog = {
    text = V.str(args.content or args.CONTENT or args.text or ""),
    title = V.str(args.title or args.TITLE or ""),
    sprite = args.sprite or args.SPRITE or "--self",
    owner = root_actor(self), th = th, lock = lock,
    born = require("rt.core").now_ms and require("rt.core").now_ms() or 0,
    typing_delay = 50,
  }
  -- 舞台对话框是模态：必须等它的确定按钮。
  if th and coroutine.running() then coroutine.yield() end
end

function M.close_self_dialog(self, args, th)
  local g = game(th)
  -- 官方 close_self_dialog -> self_hide_bubble：只关闭当前角色的提示气泡。
  -- 舞台对话框必须由它自己的确认按钮关闭。
  if self then g.bubbles = g.bubbles or {}; g.bubbles[self] = nil end
end

local function bubble(self, args, th, wait)
  local g = game(th)
  g.bubbles = g.bubbles or {}
  local typ = tostring(args.type or args.TYPE or "talk")
  local text = V.str(args.text or args.content or "")
  local sec = tonumber(args.time or args.TIME or 2) or 2
  if sec < 0 then sec = 0 end
  g.bubbles[self] = {
    type = typ, text = text, owner = self,
    duration = wait and 0 or sec * 1000,
    born = require("rt.core").now_ms and require("rt.core").now_ms() or os.clock() * 1000,
  }
end
function M.self_dialog(self, args, th)
  bubble(self, args, th, false)
  -- 指定秒数的气泡：阻塞到它显示结束，避免被下一个气泡立即覆盖。
  local sec = tonumber(args.time or args.TIME or 2) or 2
  if sec > 0 and th and th.block and coroutine.running() then th:block(math.ceil(sec * 1000)) end
end
function M.self_dialog_wait(self, args, th) bubble(self, args, th, true) end
M.self_show_bubble = M.self_dialog
M.self_show_bubble_wait = M.self_dialog_wait

function M.translate(self, args, th)
  local g = game(th)
  local text = V.str(args.text or "")
  local d = {
    type = "translate", text = text, language = V.str(args.language or "en"),
    th = th, lock = th.sched:get_thread_lock(th),
  }
  g.translate_dialog = d
  th.translate_result = text
  -- 与输入框/选择框一样阻塞，确认后继续。
  coroutine.yield()
end

function M.confirm_translation(g)
  g = g or require("rt.init").game
  local d = g and g.translate_dialog
  if not d then return false end
  g.translate_dialog = nil
  if d.lock then d.lock.stop() end
  return true
end

function M.translate_result(self, args, th)
  if th and th.translate_result ~= nil then return th.translate_result end
  return V.str(args.text or "")
end

-- 文本印章（画笔文字）：交给宿主 ——
--   Love2D 宿主：love.graphics.print 真画在舞台上
--   无头宿主：结构化记录下来（便于断言"作品输出了什么"）
function M.stamp(self, args, th)
  local g = game(th)
  local text = V.str(args.text or args.TEXT or "")
  if g.host.stamp_text then
    g.host:stamp_text(self, text, args, g)
  else
    g.host:log("[印章] " .. text, "stamp")
  end
  return nil
end


return M

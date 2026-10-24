-- 时间（计时器/日期）（来自 op_sensing.lua）


local M = {}

local function game(th) return th.sched.game end


function M.timer(self, args, th)
  -- 官方「计时器值」= `u.fM.timer` → `TheatreStore.timerValue`（player.main:2100640）：
  -- 舞台计时器，秒、两位小数，只由「执行计时器」控制（与 get_timer 的 timer_block 是两套）。
  return game(th):stage_timer_value()
end

function M.get_timer(self, args, th)
  -- 旧版「计时器值」（domain 表 get_timer）：`(now - timer_block_date)/1000`。
  return game(th):get_timer_elapsed_s()
end

function M.set_timer_state(self, args, th)
  local g = game(th)
  -- 官方 control_timer（player.main:2100293）：
  --   start → startTimer() / stop → stopTimer() / reset → resetTimer()+startTimer()
  -- 只动舞台计时器；**不**碰 timer_block_date（那是旧版 get_timer/reset_timer 的）。
  -- 作品里传的可能是中文："开始"/"停止"/"重置"。
  local t = tostring(args.type or args.state or "start")
  local tl = t:lower()
  if t == "开始" or tl == "start" then
    g:stage_timer_start()
    g.timer_visible = true
  elseif t == "停止" or tl == "stop" then
    g:stage_timer_stop()
  elseif t == "重置" or tl == "reset" then
    g:stage_timer_reset()
  end
end

function M.reset_timer(self, args, th)
  -- 官方 reset_timer 只重置 timer_block_date（旧版 get_timer 的起点）；
  -- 不启动/停止/清零舞台计时器（官方 reset_timer 里没有 TheatreStore 调用）。
  game(th):reset_timer_block()
end

-- 官方 week.names0..6 是本地化日名（main.15ba0757.js:1 byte 1565722）。
-- 默认中文；KN_LANG/LANG 以 en/fr 开头时切换。

local DAY_NAMES = {
  zh = { "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六" },
  en = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" },
  fr = { "Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi" },
}

local function day_names()
  local lang = tostring(os.getenv("KN_LANG") or os.getenv("LANG") or ""):lower()
  if lang:match("^en") then return DAY_NAMES.en end
  if lang:match("^fr") then return DAY_NAMES.fr end
  return DAY_NAMES.zh
end

function M.show_hide_timer(self, args, th)
  local g = game(th)
  g.timer_visible = (tostring(args.showHide or args.show or args.type or "show") ~= "hide")
  if not g.timer_pos then g.timer_pos = { x = g.stage_w - 180, y = 12 } end
end

function M.get_time(self, args, th)
  -- 官方「当前时间」：字段 time = year/month/date/weekday/weekday_num/hour/minute/second
  local t = tostring(args.time or args.type or "second"):lower()
  if t == "year" then return tonumber(os.date("%Y")) end
  if t == "month" then return tonumber(os.date("%m")) end
  if t == "date" or t == "day" then return tonumber(os.date("%d")) end
  if t == "hour" then return tonumber(os.date("%H")) end
  if t == "minute" then return tonumber(os.date("%M")) end
  if t == "second" or t == "sec" then return tonumber(os.date("%S")) end
  if t == "weekday" or t == "week" or t == "wday" then
    local w = tonumber(os.date("%w")) or 0
    return day_names()[w + 1]
  end
  if t == "weekday_num" then
    local w = tonumber(os.date("%w")) or 0
    return w == 0 and 7 or w
  end
  return tonumber(os.date("%S"))
end

return M

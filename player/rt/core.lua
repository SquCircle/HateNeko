-- KN → Love2D 运行时内核：装配层
--
-- 2026-10-24 模块化：实现已按职责拆到 rt/core/*，本文件只做汇总与兼容导出。
--   state.lua  常量/哨兵/宿主注入/诊断/时间源
--   entity.lua 实体
--   thread.lua 线程（协程）
--   sched.lua  调度器（hat 派发/广播/克隆）
--   game.lua   游戏实例（变量/屏幕/每帧推进）
-- 对外 ABI 不变：core.C / core.SIG / core.Entity / core.Thread / core.Sched / core.Game
-- core.set_host / core.diag / core.warn / core.copy_value / core.now_ms。
local S = require("rt.core.state")

local core = S
core.Entity = require("rt.core.entity").Entity
core.Thread = require("rt.core.thread").Thread
core.Sched = require("rt.core.sched").Sched
core.Game = require("rt.core.game").Game

return core

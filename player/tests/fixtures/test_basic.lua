-- 调度语义专用作品（手写 work 表，不依赖编译器）
-- 供 tests/run.lua 使用：覆盖阻塞 / warp 预算 / 广播 / 克隆 / tell / 作用域 / break / when。
--
-- 注意：这是**测试夹具**，不是业务运行时；所有脚本都通过 rt.on 注册，形状与
-- 编译产物一致（owner, hat, args, function(th, self)）。
local M = {}

M.stage_w, M.stage_h = 562, 900
M.cur_scene = ""
M.screens = {}
M.assets, M.audios = {}, {}
M.assets_dir = "works"

M.vars = {
  { id = "v:loop",         name = "loop",         value = 0 },
  { id = "v:frames",       name = "frames",       value = 0 },
  { id = "v:warpn",        name = "warpn",        value = 0 },
  { id = "v:warp",         name = "warp",         value = 0 },
  { id = "v:wait",         name = "wait",         value = 0 },
  { id = "v:waitdone",     name = "waitdone",     value = 0 },
  { id = "v:bc",           name = "bc",           value = 0 },
  { id = "v:bc2",          name = "bc2",          value = 0 },
  { id = "v:bcafter",      name = "bcafter",      value = 0 },
  { id = "v:clones",       name = "clones",       value = 0 },
  { id = "v:cloneself",    name = "cloneself",    value = 0 },
  { id = "v:told",         name = "told",         value = 0 },
  { id = "v:telltarget",   name = "telltarget",   value = 0 },
  { id = "v:syncdone",     name = "syncdone",     value = 0 },
  { id = "v:g",            name = "g",            value = 0 },
  { id = "v:e",            name = "e",            value = 0 },
  { id = "v:scope_result", name = "scope_result", value = 0 },
  { id = "v:listlen",      name = "listlen",      value = 0 },
  { id = "v:listfirst",    name = "listfirst",    value = 0 },
  { id = "v:brk",          name = "brk",          value = 0 },
  { id = "v:unknown",      name = "unknown",      value = 0 },
  { id = "v:whencount",    name = "whencount",    value = 0 },
}

M.actors = {
  { id = "cat", name = "cat", x = 0,   y = 0, order = 1, styles = {}, style_index = 1, visible = true },
  { id = "dog", name = "dog", x = 100, y = 0, order = 2, styles = {}, style_index = 1, visible = true },
}

function M.register(rt, game, ents)
  local f = rt.f
  local cat, dog = ents["cat"], ents["dog"]

  -- 实体作用域前置：先让 cat.vars 里存在该键，variables_set 才会写进实体作用域
  cat.vars["v:e"] = 0
  -- 列表只作为全局值存在（运行时不区分"列表变量"，见 kntl/emit.py 的说明）
  game.vars["l:list"] = { 42, 7 }

  -- ① 无限循环：v:loop / v:frames 每帧 +1；测试末尾唯一存活线程
  rt.on(cat, "on_running_group_activated", {}, function(th, self)
    while true do
      f.change_variables(self, { variable = "v:frames", value = 1, method = "increase" }, th)
      f.change_variables(self, { variable = "v:loop",   value = 1, method = "increase" }, th)
      if th:iter_n() then break end
    end
  end)

  -- ② warp 循环：每帧 30000 次，第 4 帧到 100000 后 break
  rt.on(cat, "on_running_group_activated", {}, function(th, self)
    th:warp_enter()
    while true do
      f.change_variables(self, { variable = "v:warpn", value = 1, method = "increase" }, th)
      if thr_ge(self, th, "v:warpn", 100000) then
        f.variables_set(self, { variable = "v:warp", value = 100000 }, th)
        th:warp_exit()
        break
      end
      if th:iter_w() then break end
    end
  end)

  -- ③ 阻塞：3 次 20ms 等待（headless 虚拟时钟约 2 帧/次）
  rt.on(cat, "on_running_group_activated", {}, function(th, self)
    for i = 1, 3 do
      f.wait(self, { time = 0.05 }, th)
      f.variables_set(self, { variable = "v:wait", value = i }, th)
    end
    f.variables_set(self, { variable = "v:waitdone", value = 1 }, th)
  end)

  -- ④ 广播 / 广播并等待（两个接收者）
  rt.on(cat, "self_listen", { message = "go" }, function(th, self)
    f.change_variables(self, { variable = "v:bc", value = 1, method = "increase" }, th)
  end)
  rt.on(dog, "self_listen", { message = "go" }, function(th, self)
    f.change_variables(self, { variable = "v:bc2", value = 1, method = "increase" }, th)
  end)
  rt.on(dog, "on_running_group_activated", {}, function(th, self)
    f.self_broadcast_and_wait(self, { message = "go" }, th)
    f.variables_set(self, { variable = "v:bcafter", value = 1 }, th)
  end)

  -- ⑤ 克隆：父体创建 1 个克隆，克隆体自己登记并删除
  rt.on(cat, "start_as_a_mirror", {}, function(th, self)
    f.change_variables(self, { variable = "v:clones", value = 1, method = "increase" }, th)
    if self.is_clone and self.parent == cat then
      f.variables_set(self, { variable = "v:cloneself", value = 1 }, th)
    end
    f.dispose_clone(self, {}, th)
  end)
  rt.on(cat, "on_running_group_activated", {}, function(th, self)
    f.mirror(self, { sprite = "--self" }, th)
  end)

  -- ⑥ 告诉执行并等待
  rt.on(cat, "on_running_group_activated", {}, function(th, self)
    f.sync_tell(self, {
      sprite = "dog",
      DO = function(t2, s2)
        f.variables_set(s2, { variable = "v:told", value = 1 }, t2)
        if s2 == dog then
          f.variables_set(s2, { variable = "v:telltarget", value = 1 }, t2)
        end
      end,
    }, th)
    f.variables_set(self, { variable = "v:syncdone", value = 1 }, th)
  end)

  -- ⑦ 作用域 / 列表
  rt.on(cat, "on_running_group_activated", {}, function(th, self)
    f.variables_set(self, { variable = "v:g", value = 1 }, th)
    f.variables_set(self, { variable = "v:e", value = 5 }, th)       -- cat.vars["v:e"]
    f.script_variables(self, { name = "s", value = 7 }, th)
    f.variables_set(self, {
      variable = "v:scope_result",
      value = f.script_variables_value(self, { TEXT = "s" }, th),
    }, th)
    f.variables_set(self, {
      variable = "v:listlen",
      value = f.list_length(self, { list = "l:list" }, th),
    }, th)
    f.variables_set(self, {
      variable = "v:listfirst",
      value = f.list_item(self, { list = "l:list", item = "any", list_index = 1 }, th),
    }, th)
  end)

  -- ⑧ break：第 3 次跳出
  rt.on(cat, "on_running_group_activated", {}, function(th, self)
    while true do
      f.change_variables(self, { variable = "v:brk", value = 1, method = "increase" }, th)
      if thr_ge(self, th, "v:brk", 3) then break end
      if th:iter_n() then break end
    end
  end)

  -- ⑨ 未知块：降级后脚本继续
  rt.on(cat, "on_running_group_activated", {}, function(th, self)
    f["open_hide_camera"](self, {}, th)
    f.variables_set(self, { variable = "v:unknown", value = 1 }, th)
  end)

  -- ⑩ when：条件恒真，每帧触发一次（线程当帧结束）
  rt.on(cat, "when", {
    cond = function(th, self) return true end,
  }, function(th, self)
    f.change_variables(self, { variable = "v:whencount", value = 1, method = "increase" }, th)
  end)
end

-- 读全局变量并与常量比较（避免在脚本里引入 V.bool / 数字转换分支）
function thr_ge(self, th, key, n)
  return (require("rt.init").game:get_var(key, self, th) or 0) >= n
end

return M

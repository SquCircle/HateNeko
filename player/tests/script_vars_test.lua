package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")
local h = Headless.new()
rt.set_host(h)
local g = rt.load(assert(loadfile("works/now_latest.lua"))(), h)
rt.start()
local th = { script_vars = {}, sched = { game = g } }
local V = '{"type":"NEKO_SCRIPT_VARIABLE_TYPE-test","name":"x"}'
local function ch(n, method)
  rt.f.change_variables(nil, { variable = V, method = method or "increase", value = n }, th)
end
local function eq(name, got, want)
  if got ~= want then error(("%s: got=%s want=%s"):format(name, tostring(got), tostring(want))) end
  print("ok\t" .. name)
end
th.script_vars.x = 5
ch(1, "decrease"); eq("script decrease", th.script_vars.x, 4)
ch(2, "minus"); eq("script minus", th.script_vars.x, 2)
ch(1); eq("script increase", th.script_vars.x, 3)
rt.f.change_variables(nil, { variable = V, method = "decrease", n = 3 }, th)
eq("script args.n", th.script_vars.x, 0)
print("script vars semantics ok")

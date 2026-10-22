package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")
local h = Headless.new()
rt.set_host(h)
local work = assert(loadfile("works/vars_new.lua"))()
local g = rt.load(work, h)
rt.start()
for _ = 1, 420 do rt.step(1/60) end
local function eq(name, got, want)
  if got ~= want then
    error(("%s: got=%s want=%s"):format(name, tostring(got), tostring(want)))
  end
  print("ok\t" .. name)
end
local a = g:get_var("df21474a-e6d7-4890-b493-7d412b856879")
eq("a final", a, 6)
local m = g:get_list("7b2aadfb-f908-4dcf-8cb8-02c5a92f0d32")
eq("m len", #m, 2); eq("m[1]", m[1], 6); eq("m[2]", m[2], 1)
local n = g:get_list("3b4df9e3-fb41-47cd-9086-0fba97502517")
eq("n len", #n, 5); eq("n[1]", n[1], 6); eq("n[2]", n[2], 2)
eq("n[3]", n[3], 1); eq("n[4]", n[4], true)
eq("n[5] list", type(n[5]), "table"); eq("n[5][1]", n[5][1], 0)
local mmeta = g.var_meta["7b2aadfb-f908-4dcf-8cb8-02c5a92f0d32"]
local nmeta = g.var_meta["3b4df9e3-fb41-47cd-9086-0fba97502517"]
eq("m hidden", mmeta.visible, false)
eq("n visible", nmeta.visible, true)
print("vars_new semantics ok")

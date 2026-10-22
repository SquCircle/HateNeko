-- list_copy 源和目标为同一张表时不能被清空
package.path = "./?.lua;" .. package.path
local rt = require("rt.init")
local Headless = require("rt.host.headless")
local h = Headless.new()
rt.set_host(h)
local g = rt.load(assert(loadfile("works/now_latest.lua"))(), h)
rt.start()
local l = { 1, 2, 3 }
rt.f.list_copy(nil, { list = l, target_list = l }, g.sched:system_thread())
assert(#l == 3, "同一列表 list_copy 被清空")
assert(l[1] == 1 and l[3] == 3, "同一列表 list_copy 内容错误")
print("list alias copy ok")

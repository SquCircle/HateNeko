-- 纯 Lua JSON 解码器测试：小样例 + 拿真实作品（3.48MB 的 nodevmwork.json）压测
-- 期望值已用 Python 侧核对过：
--   python3 -c "import json;w=json.load(open('/workspace/nodevmwork.json'));print(len(w['styles']['stylesDict']))"  → 14
package.path = "./?.lua;" .. package.path
local json = require("rt.json")

local fails = 0
local function check(desc, got, want)
  if got ~= want then
    fails = fails + 1
    print(("  FAIL %-40s got=%s want=%s"):format(desc, tostring(got), tostring(want)))
  else
    print(("  ok   %-40s %s"):format(desc, tostring(got)))
  end
end

-- 1) 小样例：转义 / 代理对 / 数字 / 空容器
local small = [[{"a":1,"b":[true,false,null,-2.5e3],"c":"x\ny\t\"z\"","e":"\u4e2d\u6587","f":"\ud83d\ude00","g":{"h":{}}}]]
local t = json.decode(small)
check("整数", t.a, 1)
check("布尔", t.b[1], true)
check("false", t.b[2], false)
check("null", t.b[3], nil)
check("指数", t.b[4], -2500)
check("转义 \\n\\t\\\"", t.c, "x\ny\t\"z\"")
check("\\u 中文", t.e, "中文")
check("代理对 emoji", t.f, "😀")
check("嵌套空表", type(t.g.h), "table")

-- 2) 真实作品压测
-- 真实作品：仓库里的 vm 黄金作品（3.6MB / 53 个过程）；也可用 KNJSON_WORK 指定别的大作品
local path = os.getenv("KNJSON_WORK") or "tests/fixtures/vm.bcmkn.json"
local f = io.open(path, "rb")
if not f then
  print("  -- 跳过真实作品压测（找不到 " .. path .. "）")
else
  local text = f:read("*a")
  f:close()
  local t0 = os.clock()
  local work = json.decode(text)
  local dt = os.clock() - t0
  print(("  -- 解析 %.2f MB 耗时 %.3f s"):format(#text / 1048576, dt))

  check("projectName 解析出来", type(work.projectName), "string")
  check("scenes 存在", type(work.scenes.scenesDict), "table")
  check("actors 存在", type(work.actors.actorsDict), "table")

  local nproc = 0
  for _ in pairs(work.procedures.proceduresDict or {}) do nproc = nproc + 1 end
  check("procedures 数量", nproc, 53)

  local nstyle = 0
  for _ in pairs(work.styles.stylesDict or {}) do nstyle = nstyle + 1 end
  check("styles 数量", nstyle, 14)

  -- 逐块遍历（不依赖 pairs 的顺序）：统计 hat、找 hat.next 里的变量 id
  local hat_count, hat_types, found_var = 0, {}, nil
  for _, a in pairs(work.actors.actorsDict) do
    for _, b in ipairs(a.nekoBlockJsonList or {}) do
      if b.type == "on_running_group_activated" then
        hat_count = hat_count + 1
        hat_types[b.next and b.next.type] = true
        if b.next and b.next.fields and b.next.fields.variable then
          found_var = b.next.fields.variable
        end
      end
    end
  end
  check("绿旗 hat 数量 > 0", hat_count > 0, true)
  check("绿旗下一个块是 variables_set", hat_types["variables_set"], true)
  check("拿到底层变量 id", type(found_var), "string")
  check("变量 id 是 UUID 形态", found_var and #found_var, 36)

  -- 抽样比对中文是否正确解码（与 Python 侧一致）
  local scene_ok = false
  for _, s in pairs(work.scenes.scenesDict) do
    if s.name == "背景" and s.screenName == "屏幕" then scene_ok = true end
  end
  check("场景中文名解码正确", scene_ok, true)
end

print(("结果：%d 项失败"):format(fails))
if fails > 0 then os.exit(1) end

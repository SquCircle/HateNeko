-- VM 作品（Node VM v3 全猫最强解释器）的一致性套件：
-- 喂若干段 JS，断言它自己在 Console 上打出的结果。
-- 用法：lua5.1 tests/vm_conformance.lua [只跑第几个]
--
-- 这些用例是「我们这个运行时是否真的把 JS 语义跑对」的锚点：
-- 每加一条，就多一层防止语义回退的保护。
package.path = "./?.lua;" .. package.path

local rt = require("rt.init")
local Headless = require("rt.host.headless")

local WORK = "works/real_vm.lua"
local FRAMES = 1600

-- expect = 期望在 Console 里出现的文本；nil = 只打印实际输出（不判失败，用于探路）
local CASES = {
  { name = "浮点加法", code = "print(0.1 + 0.2);", expect = "0.30000000000000004" },
  { name = "IIFE", code = "(function(){print(0.1+0.2);})();", expect = "0.30000000000000004" },
  { name = "整数加法", code = "print(1 + 2);", expect = "3" },
  { name = "递归阶乘", code = "function fact(n){if(n<2){return 1;}return n*fact(n-1);} print(fact(5));", expect = "120" },
  { name = "字符串拼接", code = "print('a' + 'b');", expect = "ab" },
  { name = "while 循环累加", code = "var s=0;var i=1;while(i<=10){s=s+i;i=i+1;}print(s);", expect = "55" },
  { name = "三元/比较", code = "print(1<2 ? 'yes' : 'no');", expect = "yes" },
  { name = "数组下标", code = "var a=[1,2,3];print(a[0]+a[2]);", expect = "4" },
  { name = "数组长度", code = "var a=[1,2,3];print(List.length(a));", expect = "3" },
  { name = "内置 Math", code = "print(Math.sqrt(9));", expect = "3" },
  -- 第二批：更接近真实用法（for / 对象 / 闭包 / 字符串 API / 列表 API）
  { name = "for 循环", code = "var s=0;for(var i=0;i<5;i=i+1){s=s+i;}print(s);", expect = "10" },
  -- 手写 AST 形态的函数值（函数节点第 4 项是环境；缺了它会报"不是一个可调用的值"）
  { name = "AST函数调用", expect = "test",
    code = 'var a = ["function", [], [["call", [["string", "test"]], ["getVar", ["identifier", "print"]]]], environ];a();' },
  -- 对象：**键必须带引号**——这是 VM 自己的限制（裸标识符键会被当成表达式求值，
  -- 报「未定义的符号」；VM 序曲里所有对象字面量也都用引号键）。
  { name = "对象属性读", code = 'var o={"a":1};print(o.a);', expect = "1" },
  { name = "对象求和", code = 'var o={"a":1,"b":2};print(o.a+o.b);', expect = "3" },
  -- VM 限制（不作为我们的缺口）：裸键 `{a:1}` 在 VM 里就会报未定义符号
  { name = "对象裸键(VM限制)", code = "var o={a:1};print(o.a);", expect = nil },
  { name = "闭包", code = "function f(x){return function(y){return x+y;};}print(f(1)(2));", expect = "3" },
  { name = "递归+字符串", code = "function rep(s,n){if(n==0){return '';}return s+rep(s,n-1);}print(rep('ab',3));", expect = "ababab" },
  { name = "布尔输出", code = "print(1<2);", expect = "true" },
  { name = "除法", code = "print(1/4);", expect = "0.25" },
  { name = "取模", code = "print(7%3);", expect = "1" },
  { name = "List.push", code = "var a=[];List.push(a,5);print(a[0]);", expect = "5" },
  { name = "String.length", code = "print(String.length('abc'));", expect = "3" },
  { name = "String.format", code = "print(String.format('{}+{}={}',1,2,3));", expect = "1+2=3" },
  { name = "嵌套 while 求和", code = "var s=0;var i=1;while(i<=3){var j=1;while(j<=3){s=s+1;j=j+1;}i=i+1;}print(s);", expect = "9" },
}

local only = tonumber(arg[1])

local src = assert(io.open(WORK, "rb")):read("*a")
local work = assert((loadstring or load)(src, "@" .. WORK))()

local function run_case(code)
  local host = Headless.new()
  host.ask_value = code
  rt.set_host(host)
  local rt2 = require("rt.init") -- 复用同一模块（load 会重置 game）
  local game = rt2.load(work, host)
  local errors = 0
  game.on_error = function() errors = errors + 1 end
  rt2.start()
  local ui = require("rt.impl.ui")
  for _ = 1, FRAMES do
    rt2.step(1 / 60)
    local d = ui.current_dialog(game)
    if d and d.type == "ask" then ui.submit_answer(code, game) end
  end
  local joined = {}
  for _, s in ipairs(host.stamps or {}) do joined[#joined + 1] = s.text end
  return table.concat(joined, "\n"), errors
end

local passed, failed, probe = 0, 0, 0
for i, case in ipairs(CASES) do
  if not only or i == only then
  local out, errors = run_case(case.code)
  local got = out:match("\n([^\n]*)%s*\n程序运行结束") or out:match("程序运行结束")
  -- Console 里第一行是标题，取「程序运行结束」之前的那一行作为输出
  local output = out:gsub("程序运行结束.*", ""):gsub(".*Console\n", ""):gsub("\n+$", "")
  local status
  -- 精确匹配（用子串匹配会误判：`table: 0x7f09…a1` 里也能找到 "1"）
  local ok = case.expect ~= nil and output == case.expect
  if case.expect == nil then
    status = "探路"
    probe = probe + 1
  elseif ok then
    status = "PASS"
    passed = passed + 1
  elseif case.todo then
    status = "TODO"     -- 已知缺口：记录但不判红
    probe = probe + 1
  else
    status = "FAIL"
    failed = failed + 1
  end
  print(("[%s] %-12s 期望=%-6s 实际=%-14s 错误=%d  代码=%s")
    :format(status, case.name, tostring(case.expect), output:gsub("\n", "⏎"):sub(1, 20), errors, case.code:sub(1, 46)))
  end
end

print(("\n总计：PASS %d，FAIL %d，探路 %d"):format(passed, failed, probe))
if failed > 0 then os.exit(1) end

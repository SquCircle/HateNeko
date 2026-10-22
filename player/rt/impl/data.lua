-- 变量 / 脚本变量 / 列表 原语
-- 作用域：脚本(线程) > 实体 > 全局（官方 get_variable(name, entity, interpreter)）
-- 统一签名：function(self, args, th)
local V = require("rt.values")

local M = {}
local STR_CHARS, STR_CHARS_N = {}, 0 -- 字符串→字符表 的小缓存

local function game(th) return th.sched.game end

-- 变量字段可能是 NEKO_SCRIPT_VARIABLE_TYPE JSON；官方脚本变量是解释器/线程级。
-- 快路径：普通变量键是 UUID/名字，不以 "{" 开头，不必做整串 find/match。
local SV_NAME_CACHE = {}
local function script_var_name(args)
  if args.script ~= nil then return tostring(args.script) end
  local v = args.variable
  if type(v) == "string" and v:byte(1) == 123 -- '{'
     and v:find("NEKO_SCRIPT_VARIABLE_TYPE", 1, true) then
    local hit = SV_NAME_CACHE[v]
    if hit ~= nil then return hit or nil end
    local nm = v:match('"name"%s*:%s*"([^"]+)"')
    SV_NAME_CACHE[v] = nm or false
    return nm
  end
  return nil
end

-- 列表变更版本号：list_is_exist 用它做"集合缓存"的失效判断。
-- 缓存挂在列表表自身上（__ver / __set），不占数组下标、不影响 #l。
local function bump(l)
  l.__ver = (l.__ver or 0) + 1
end

---------------------------------------------------------------- variables
-- 调试用：变量键异常时打出协程调用栈（定位到生成代码的具体行）
local function check_key(key, args, th)
  if key == nil or type(key) == "table" then
    print(("[debug] 变量键异常 key=%s args=%s\n%s")
      :format(tostring(key), tostring(args and args.variable), debug.traceback("", 2)))
  end
  return key
end

-- 调试：按写入顺序报告"第一处把 NaN 写进变量"的地方（真正的源头）
local NaN_WRITE = {}
local function nan_check(val, name, self, th)
  if not (require("rt.init").game and require("rt.init").game.debug_nan) then return end
  if type(val) ~= "number" or val == val then return end
  if NaN_WRITE[name] then return end
  NaN_WRITE[name] = true
  local host = require("rt.init").game.host
  if host and host.log then
    host:log(("[NaN写] %s = NaN  ← 由 %s 写入（hat=%s）"):format(
      tostring(name), tostring(self and self.name), tostring(th and th.hat)), "warn")
  end
end

function M.variables_set(self, args, th)
  local sv = script_var_name(args)
  if sv ~= nil then
    nan_check(args.value, sv, self, th)
    if th then th.script_vars[sv] = args.value end
    return
  end
  local key = check_key(args.variable or args.valname, args, th)
  if key == nil then return end
  nan_check(args.value, key, self, th)
  game(th):set_var(key, args.value, self, th)
end
M.set_variable = M.variables_set

function M.variables_get(self, args, th)
  local sv = script_var_name(args)
  if sv ~= nil then
    local v = th and th.script_vars[sv]
    return (v == nil) and 0 or v
  end
  return game(th):get_var(args.variable or args.valname, self, th)
end
M.get_variable = M.variables_get

function M.change_variables(self, args, th)
  local g = game(th)
  local sv = script_var_name(args)
  if sv ~= nil then
    local id = g:resolve_var_key(sv)
    local cur = V.num(th and th.script_vars[id] or 0)
    local n = V.num(args.n or args.value)
    local method = tostring(args.method or "increase")
    if method == "decrease" or method == "minus" then
      th.script_vars[id] = cur - n
    else
      th.script_vars[id] = cur + n
    end
    return
  end
  local key = args.variable or args.valname
  local raw = g:get_var(key, self, th)
  -- 官方：值是对象（列表）时直接不动，避免把列表当数字算
  if type(raw) == "table" then return end
  local cur = V.num(raw)
  local n = V.num(args.n or args.value)
  local method = tostring(args.method or "increase")
  local nextv = (method == "decrease" or method == "minus") and (cur - n) or (cur + n)
  g:set_var(key, nextv, self, th)
end
M.change_variable = M.change_variables

function M.show_hide_variables(self, args, th)
  local g = th and th.sched and th.sched.game
  if not g then return end
  local key = args.variable or args.valname or args.list
  if key == nil then return end
  local meta = g.var_meta and (g.var_meta[key] or g.list_meta[key])
  if not meta and g.var_meta then
    -- 名字兜底
    for id, m in pairs(g.var_meta) do
      if m.name == tostring(key) then meta = m; key = id; break end
    end
  end
  if not meta then return end
  local v = tostring(args.show_hide or args.visible or "hide")
  meta.visible = (v == "show" or v == "true")
  g.var_dirty[key] = (g.var_dirty[key] or 0) + 1
end

function M.show_hide_list(self, args, th)
  -- 不要改调用方的 args 表（编译器常量表会跨调用复用，PERF-3 前置约束）
  if args.list ~= nil then return M.show_hide_variables(self, args, th) end
  local a = {}
  for k, v in pairs(args) do a[k] = v end
  a.list = args.variable
  return M.show_hide_variables(self, a, th)
end

---------------------------------------------------------------- script variables（脚本私有）
local function sv_key(args)
  return args.name or args.variable or args.param_name or args.TEXT
end

-- 脚本变量的 id ↔ 名字：文本代码转出来的作品里，id 形如
--   {"type":"NEKO_SCRIPT_VARIABLE_TYPE-…","name":"a"}
-- 而 script_variables_value 用的是名字。Game.script_var_alias 负责这层映射。
-- 「定义脚本变量」：既是声明也是赋值 —— 每次都写值（重复执行时要能更新，
-- 否则像词法器那种"每读一个字符就重定义 char"的用法会一直读到旧值）
function M.script_variables(self, args, th)
  -- 「定义脚本变量」可能一次声明多个名字：args.names 是列表，全部定义。
  local g = game(th)
  local v = args.value
  if v == nil then v = args.PARAMS0 end
  if v == nil then v = args.TEXT_VALUE end
  local names = args.names
  if type(names) == "table" and #names > 0 then
    for _, nm in ipairs(names) do
      local id = g:resolve_var_key(nm)
      if id ~= nil then
        if v ~= nil then th.script_vars[id] = v
        elseif th.script_vars[id] == nil then th.script_vars[id] = 0 end
      end
    end
    return
  end
  local name = sv_key(args)
  if name == nil then return end
  local id = g:resolve_var_key(name)
  if v ~= nil then
    th.script_vars[id] = v
  elseif th.script_vars[id] == nil then
    th.script_vars[id] = 0
  end
end

function M.script_variables_value(self, args, th)
  local name = sv_key(args)
  if name == nil then return 0 end
  -- 快路径：没有 alias 的脚本变量直接读线程作用域（省 resolve/scope/get_var）
  local g = game(th)
  local alias = g.script_var_alias and g.script_var_alias[name]
  if alias == nil then
    local v = th and th.script_vars[name]
    if v ~= nil then return v end
  end
  return g:get_var(g:resolve_var_key(name), self, th)
end
M.script_variables_get = M.script_variables_value

-- 官方 script_variables_set（编辑器 0.27 的「设置脚本变量」）
-- 变量字段是脚本变量 JSON（{"name":...}）或名字；找不到脚本变量时按普通变量兜底。
function M.script_variables_set(self, args, th)
  local name = sv_key(args)
  if name == nil then return end
  local g = game(th)
  local raw = script_var_name(args) or name
  local is_script = script_var_name(args) ~= nil
  if not is_script and g.script_var_alias and g.script_var_alias[tostring(raw)] then
    is_script = true
  end
  if not is_script then
    return M.variables_set(self, args, th)
  end
  local id = g:resolve_var_key(raw)
  th.script_vars[id] = args.value
end

-- 官方 change_script_variables：method=increase/decrease，value 为数字；
-- 与 change_variables 一样按 JS 数值语义（V.num）相加/相减。
function M.change_script_variables(self, args, th)
  local name = sv_key(args)
  if name == nil then return end
  local g = game(th)
  local raw = script_var_name(args) or name
  local is_script = script_var_name(args) ~= nil
  if not is_script and g.script_var_alias and g.script_var_alias[tostring(raw)] then
    is_script = true
  end
  if not is_script then
    return M.change_variables(self, args, th)
  end
  local id = g:resolve_var_key(raw)
  local cur = V.num(th.script_vars[id] or 0)
  local n = V.num(args.value)
  local method = tostring(args.method or "increase")
  if method == "decrease" or method == "minus" then
    th.script_vars[id] = cur - n
  else
    th.script_vars[id] = cur + n
  end
end


-- 脚本变量在函数参数位出现时（script_variables_param）
function M.script_variables_param(self, args, th)
  return M.script_variables_value(self, args, th)
end

-- 遍历循环的循环变量（编译期通常内联成 Lua 局部变量，这里是运行期兜底）
function M.traverse_number_param(self, args, th)
  return th:param() or 0
end
M.traverse_number_value = M.traverse_number_param

---------------------------------------------------------------- lists
-- 临时列表：可带初始项（ITEM0/ITEM1/… 按编号顺序）
function M.temporary_list(self, args, th)
  local list = {}
  local numbered = {}
  for k in pairs(args or {}) do
    local i = tostring(k):match("^ITEM(%d+)$")
    if i then numbered[#numbered + 1] = { k = k, i = tonumber(i) } end
  end
  if #numbered > 0 then
    table.sort(numbered, function(a, b) return a.i < b.i end)
    for j = 1, #numbered do list[j] = args[numbered[j].k] end
    return list
  end
  if args and args.list then
    local g = game(th)
    local scope = g:scope_of(args.list, self, th)
    scope[args.list] = list
  else
    th.temp_lists = th.temp_lists or {}
    th.temp_lists[#th.temp_lists + 1] = list
  end
  return list
end

local function list_of(args, self, th)
  local key = args.list or args.list_name
  if type(key) == "table" then return key end
  local v = game(th):get_list(key, self, th)
  -- 变量里存的不是列表时不要崩：官方对非列表取值得到 undefined、写入是静默不改。
  -- 字符串按"第 n 个字符"读（作品里常见把字符串当字符表用）。
  -- 非列表值：不崩即可（官方对非列表取到 undefined、写入静默不改）。
  -- 注意**不要**在这里物化整串字符表：那会让"等长度变化"之类的条件永不满足、把作品拖死。
  if type(v) ~= "table" then return {} end
  if type(v) ~= "table" then return {} end
  return v
end

-- 写入类操作：目标确实是"真列表"（存在且是 table）才写，否则静默不动
local function writable_list(args, self, th)
  local key = args.list or args.list_name
  if type(key) == "table" then return key end
  local v = game(th):get_list(key, self, th)
  if type(v) == "table" then return v end
  return nil
end

local function item_arg(args)
  if args.value ~= nil then return args.value end
  if args.list_item_value ~= nil then return args.list_item_value end
  if args.item_value ~= nil then return args.item_value end
  return args.item
end

-- 官方列表索引：f(index) = Math.round(index)，且 **<1 自动取 1**
-- 证据：官方告警 ILLEGAL_LIST_INDEX = "有效值需大于等于1，已自动取最小值1"
local function round_index(v)
  local n = tonumber(v)
  if n == nil then return nil end
  n = V.js_round(n)
  if n ~= n then return nil end
  if n < 1 then n = 1 end
  return n
end

function M.list_append(self, args, th)
  local l = writable_list(args, self, th)
  if not l then return end
  l[#l + 1] = item_arg(args)
  bump(l)
  local g = game(th)
  local key = args.list or args.list_name
  if g and g.diag_lists and g.diag_lists[key] then
    local n = #l
    local prev = (g._diag_list_len or {})[key]
    g._diag_append_n = (g._diag_append_n or 0) + 1
    local do_log = (prev == nil) or (prev == n) or (n % 50 == 0) or (g._diag_append_n % 100 == 0)
    if do_log then
      local ok, core = pcall(require, "rt.core")
      if ok then core.diag("[list] append key=%s len=%d scope=%s", tostring(key), n, tostring(g:scope_of(key, self, th))) end
    end
    g._diag_list_len = g._diag_list_len or {}
    g._diag_list_len[key] = n
  end
end

-- 官方 listInsertValue：idx=round(index)（<1→1）；idx>len → push；否则 splice(idx-1,0,value)
function M.list_insert_value(self, args, th)
  local l = writable_list(args, self, th)
  if not l then return end
  local idx = round_index(args.list_index or args.index)
  local v = item_arg(args)
  if idx == nil then return end
  if idx > #l then
    l[#l + 1] = v
  else
    table.insert(l, idx, v)
  end
  bump(l)
end

-- 官方 deleteListItem：ALL 清空；LAST pop；ANY idx=round(index)（<1→1）；
-- idx>len → 忽略；否则 splice(idx-1,1)
function M.delete_list_item(self, args, th)
  local l = writable_list(args, self, th)
  if not l then return end
  local selector = tostring(args.item or args.type or "any")
  if selector == "all" then
    for i = #l, 1, -1 do l[i] = nil end
    bump(l)
    return
  end
  if selector == "last" then
    if #l > 0 then table.remove(l) end
    bump(l)
    return
  end
  local idx = round_index(args.list_index or args.index)
  if idx == nil then return end
  if idx <= #l then
    table.remove(l, idx)
    bump(l)
  end
end

-- 官方 replaceListItem：ANY idx=round(index)（<1→1）；idx>len → 追加；否则 splice(idx-1,1,value)
function M.replace_list_item(self, args, th)
  local l = writable_list(args, self, th)
  if not l then return end
  local selector = tostring(args.item or args.type or "any")
  local v = item_arg(args)
  if selector == "last" then
    if #l > 0 then l[#l] = v else l[1] = v end
    bump(l)
    return
  end
  local idx = round_index(args.list_index or args.index)
  if idx == nil then return end
  if idx > #l then
    l[#l + 1] = v
  else
    l[idx] = v
  end
  bump(l)
end

local function as_list(v, self, th)
  if type(v) == "table" then return v end
  if v == nil then return {} end
  return game(th):get_list(v, self, th)
end

function M.list_copy(self, args, th)
  local src = as_list(args.list or args.list_name, self, th)
  local dst = as_list(args.target_list or args.target, self, th)
  -- 官方列表变量可能以“同一张表”作为源和目标；先清空会把源一起清掉。
  if src == dst then return end
  for i = #dst, 1, -1 do dst[i] = nil end
  for i = 1, #src do dst[i] = src[i] end
  bump(dst)
end

-- 官方“获取列表”返回列表对象；只有 list_item 才取某一项。
function M.list_get(self, args, th)
  local key = args.list or args.list_name or args.variable
  if type(key) == "table" then return key end
  return game(th):get_list(key, self, th)
end
M.pure_list_get = M.list_get
M.lists_get = M.list_get

-- 列表值 / list_item：LAST = 末尾；ANY 取 round(index)（<1→1）；
-- 取不到（idx>len 或值为 nil）→ NaN（官方 ITEM_NOT_FOUND）
function M.list_item(self, args, th)
  -- 快路径：list 已是表 + integer index + item="any"（k3t V2 模型访问器每帧数万次）
  local key = args.list or args.list_name
  local item = args.item
  if type(key) == "table" and (item == nil or item == "any") then
    local idx = args.list_index or args.index
    if type(idx) == "number" and idx >= 1 and idx == math.floor(idx) then
      local v = key[idx]
      if v == nil then return 0 / 0 end
      return v
    end
  end
  local l = list_of(args, self, th)
  local sel = tostring(args.item or "any")
  local idx
  if sel == "last" then
    idx = #l
  else
    idx = round_index(args.list_index or args.index)
  end
  if idx == nil or idx > #l then return 0 / 0 end
  local v = l[idx]
  if v == nil then return 0 / 0 end
  return v
end

function M.list_length(self, args, th)
  return #list_of(args, self, th)
end
M.data_length = M.list_length

-- 官方 lists_index_of：JS Array.indexOf → 严格相等，1 基返回，找不到返回 0
function M.list_index_of(self, args, th)
  local l = list_of(args, self, th)
  local v = item_arg(args)
  for i = 1, #l do
    if l[i] == v then return i end
  end
  return 0
end

-- 官方 lists_is_exist：`t == VALUE || t == String(VALUE)`。
-- 这是**宽松**相等（不是严格），按源保留；用 rt/values 的 V.eq 做 JS == 近似，
-- 第二项用 V.str 模拟 String(VALUE)。
function M.list_is_exist(self, args, th)
  local l = list_of(args, self, th)
  local raw = item_arg(args)
  -- 官方实际 list.some(e => e === value)：严格相等，不做 String 放宽。
  for i = 1, #l do
    if l[i] == raw then return true end
  end
  return false
end

function M.list_is_exist_slow(self, args, th)
  return M.list_is_exist(self, args, th)
end

-- 列表相关报告块（官方 data_get/data_item…）别名
M.list_value = M.list_item

return M

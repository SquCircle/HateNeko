-- 原语注册表（阶段 4）：显式记录每个原语来自哪个模块，并在启动时硬失败同名覆盖。
--
-- 之前 rt.init 用 merge() 平铺覆盖：同名实现（get_answer、动画桩…）静默后写胜出，
-- 只有读代码才能发现。现在所有模块先登记，构建 f 时若同一名字有多个不同函数，
-- 默认 error；确实需要覆盖时必须在 allow 里写明原因。
local M = {}

-- modules: { { name = "rt.impl.data", mod = <table> }, ... }
-- opts.allow: { [原语名] = "允许的最终模块名" }
function M.build(modules, opts)
  opts = opts or {}
  local allow = opts.allow or {}
  local f, defs, providers, order = {}, {}, {}, {}
  for _, entry in ipairs(modules) do
    local name = entry.name or "?"
    order[#order + 1] = name
    for k, v in pairs(entry.mod) do
      if type(v) == "function" then
        defs[k] = defs[k] or {}
        defs[k][#defs[k] + 1] = { module = name, fn = v }
        f[k] = v
        providers[k] = name
      end
    end
  end
  local conflicts, overrides = {}, {}
  for name, ds in pairs(defs) do
    local distinct = {}
    local n = 0
    for _, d in ipairs(ds) do
      if not distinct[d.fn] then distinct[d.fn] = true; n = n + 1 end
    end
    if n > 1 then
      local allowed = allow[name]
      if allowed and providers[name] == allowed then
        overrides[#overrides + 1] = { name = name, winner = providers[name], count = n,
          modules = (function()
            local ms = {}
            for _, d in ipairs(ds) do ms[#ms + 1] = d.module end
            return ms
          end)() }
      else
        local ms = {}
        for _, d in ipairs(ds) do ms[#ms + 1] = d.module end
        conflicts[#conflicts + 1] = name .. " (" .. table.concat(ms, " / ") .. ")"
      end
    end
  end
  table.sort(conflicts)
  return f, {
    defs = defs,
    providers = providers,
    conflicts = conflicts,
    overrides = overrides,
    modules = order,
  }
end

-- 调试/测试：返回 args 里不在 schema 参数表中的键（schema 为 nil 时不检查）
function M.unknown_args(schema, name, args)
  if not schema or not schema.args or type(args) ~= "table" then return {} end
  local names = schema.args[name]
  if not names then return {} end
  local known = {}
  for _, n in ipairs(names) do known[n] = true end
  local extra = {}
  for k in pairs(args) do
    if type(k) == "string" and not known[k] then extra[#extra + 1] = k end
  end
  table.sort(extra)
  return extra
end

return M

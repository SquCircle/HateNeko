-- 调用 Python 编译器（Lua 侧不再有编译器）
local M = {}
local json = require("rt.json")

local function slurp(path)
  local f = assert(io.open(path, "rb"), "读不到 " .. path)
  local s = f:read("*a"); f:close()
  return s
end

-- 临时目录：os.tmpname() 在 Android（Termux）上会指到不可写的 /tmp，
-- 这里自己挑一个**真能写**的目录（$TMPDIR → ./.tmp → /tmp）。
local _tmpdir = nil
local function tmpdir()
  if _tmpdir then return _tmpdir end
  for _, d in ipairs({ os.getenv("TMPDIR"), ".tmp", "/tmp" }) do
    if d and d ~= "" then
      local probe = d .. "/.kn_write_probe"
      os.execute(('mkdir -p "%s" 2>/dev/null'):format(d))
      local f = io.open(probe, "wb")
      if f then
        f:close()
        os.remove(probe)
        _tmpdir = d
        return d
      end
    end
  end
  _tmpdir = "."
  return _tmpdir
end

local _seq = 0
local function tmppath(tag)
  _seq = _seq + 1
  local ext = "lua"
  if tag == "rep" then ext = "json" elseif tag == "log" then ext = "log" end
  return ("%s/kn_%s_%d_%d.%s"):format(tmpdir(), tag, os.time(), _seq, ext)
end

-- os.execute 的返回值跨 Lua 版本不同：
--   5.1 / LuaJIT：0=成功，非 0=失败
--   5.2+：true, "exit", 0
-- 之前 `ok ~= nil and ok ~= false` 对 5.1 的非 0 码恒为真 → 失败被当成成功，
-- 下一行 slurp 才报"读不到临时文件"，掩盖真实编译错误。
local function exec_ok(ok, why, code)
  if type(ok) == "number" then return ok == 0 end
  if ok == true then
    if why == nil then return true end
    return why == "exit" and code == 0
  end
  return false
end

--- 编译作品文件，返回 (Lua 源码, 报告表)
function M.compile(path)
  local out = tmppath("out")
  local rep = tmppath("rep")
  local log = tmppath("log")
  local ok, why, code = os.execute(
    ('python3 -m kntl.compile "%s" "%s" --no-assets --report-json="%s" >"%s" 2>&1')
      :format(path, out, rep, log))
  if not exec_ok(ok, why, code) then
    local okr, msg = pcall(slurp, log)
    os.remove(out); os.remove(rep); os.remove(log)
    error(("Python 编译失败(%s): %s\n%s"):format(tostring(ok), tostring(path),
      okr and msg or ""), 0)
  end
  local src = slurp(out)
  local report = nil
  local okr, parsed = pcall(function() return json.decode(slurp(rep)) end)
  if okr then report = parsed end
  os.remove(out); os.remove(rep); os.remove(log)
  return src, report
end

return M

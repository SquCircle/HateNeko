local input = {}

local active = false
local text = ""

-- 按 UTF-8 码点切分（中文/emoji 都算一个字符）
local function splitChars(str)
	local chars = {}
	for char in str:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
		chars[#chars + 1] = char
	end
	return chars
end

-- 显式设置激活态，组件式调用更直观
function input.setActive(value)
	value = value and true or false
	if value == active then
		return active
	end
	active = value
	if active then
		text = ""
		love.keyboard.setTextInput(true)
	else
		love.keyboard.setTextInput(false)
	end
	return active
end

-- 切换激活态（旧 API 保留）
function input.input()
	return input.setActive(not active)
end

function input.get()
	return text
end

function input.set(value)
	text = value and tostring(value) or ""
end

function input.clear()
	text = ""
end

function input.join(t)
	if active then
		text = text .. t
	end
end

function input.keypressed(key)
	if not active then
		return
	end
	if key == "backspace" then
		text = input.removeLast(text)
	elseif key == "return" or key == "kpenter" then
		input.input()
	end
end

function input.isActive()
	return active
end

-- 字符数（不是字节数）
function input.length(str)
	return #splitChars(str or "")
end

-- 删掉最后一个 UTF-8 字符
function input.removeLast(str)
	if not str or #str == 0 then
		return str or ""
	end

	local chars = splitChars(str)
	if #chars > 0 then
		table.remove(chars)
	end
	return table.concat(chars)
end

-- 旧全局名保留兼容
removeLastUTF8Char = input.removeLast

-- ---------- UTF-8 光标辅助 ----------

-- 返回第 char_index 个字符之前的字节偏移（char_index 从 0 开始）。
function input.byteOffset(str, char_index)
	str = str or ""
	local idx = 0
	local i = 1
	while i <= #str and idx < char_index do
		local b = str:byte(i)
		local len = (b < 0x80 and 1) or (b < 0xE0 and 2) or (b < 0xF0 and 3) or 4
		i = i + len
		idx = idx + 1
	end
	return math.min(i - 1, #str)
end

-- 字节偏移之前有多少个字符（落在字符中间时向下取整到该字符开头）。
function input.charIndex(str, byte_offset)
	str = str or ""
	byte_offset = math.max(0, math.min(#str, tonumber(byte_offset) or 0))
	local i, n = 1, 0
	while i <= byte_offset do
		local b = str:byte(i)
		local len = (b < 0x80 and 1) or (b < 0xE0 and 2) or (b < 0xF0 and 3) or 4
		local endp = i + len - 1
		if endp > byte_offset then break end
		i = endp + 1
		n = n + 1
	end
	return n
end

function input.prevBoundary(str, pos)
	str = str or ""
	pos = math.max(0, math.min(#str, tonumber(pos) or 0))
	if pos <= 0 then return 0 end
	local i = pos
	while i > 1 and str:byte(i) >= 0x80 and str:byte(i) <= 0xBF do i = i - 1 end
	return i - 1
end

function input.nextBoundary(str, pos)
	str = str or ""
	pos = math.max(0, math.min(#str, tonumber(pos) or 0))
	if pos >= #str then return #str end
	local b = str:byte(pos + 1)
	local len = (b < 0x80 and 1) or (b < 0xE0 and 2) or (b < 0xF0 and 3) or 4
	return math.min(#str, pos + len)
end

function input.insert(str, pos, chunk)
	str = str or ""
	chunk = chunk or ""
	pos = math.max(0, math.min(#str, tonumber(pos) or 0))
	return str:sub(1, pos) .. chunk .. str:sub(pos + 1)
end

function input.removeRange(str, from, to)
	str = str or ""
	from = math.max(0, math.min(#str, tonumber(from) or 0))
	to = math.max(0, math.min(#str, tonumber(to) or 0))
	if to < from then from, to = to, from end
	return str:sub(1, from) .. str:sub(to + 1)
end

return input

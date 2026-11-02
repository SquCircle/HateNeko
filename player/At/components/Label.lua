-- 文字标签：布局里最常用的占位/说明组件。
--
--   At.Label{ x = 20, y = 20, text = "用户名", fontSize = 16 }
--   At.Label{ text = "很长的说明……", wrap = true, w = 240, lineHeight = 1.4 }

-- LÖVE 字体要求合法 UTF-8；列表/变量可含任意字节，先做安全替换。
local function safe_utf8(s)
	s = tostring(s or "")
	local i, n = 1, #s
	local out = {}
	local function byte(j) return s:byte(j) end
	local function cont(j)
		local c = byte(j)
		return c ~= nil and c >= 0x80 and c <= 0xBF
	end
	local function range(j, lo, hi)
		local c = byte(j)
		return c ~= nil and c >= lo and c <= hi
	end
	-- 严格按 RFC 3629 校验（LÖVE 的 UTF-8 解码同样拒绝 overlong / 代理区 / >U+10FFFF）：
	-- 之前只查"首字节 + 后续字节 0x80..0xBF"，ED A0 80（代理）这类仍会漏过去，
	-- 交给 love.graphics.getWrap 时抛 "UTF-8 decoding error: Invalid UTF-8"（DBG 页崩溃）。
	while i <= n do
		local c = byte(i)
		local len = 0
		if c < 0x80 then
			len = 1
		elseif c >= 0xC2 and c <= 0xDF then
			if cont(i + 1) then len = 2 end
		elseif c == 0xE0 then
			if range(i + 1, 0xA0, 0xBF) and cont(i + 2) then len = 3 end
		elseif c >= 0xE1 and c <= 0xEC then
			if cont(i + 1) and cont(i + 2) then len = 3 end
		elseif c == 0xED then
			if range(i + 1, 0x80, 0x9F) and cont(i + 2) then len = 3 end
		elseif c >= 0xEE and c <= 0xEF then
			if cont(i + 1) and cont(i + 2) then len = 3 end
		elseif c == 0xF0 then
			if range(i + 1, 0x90, 0xBF) and cont(i + 2) and cont(i + 3) then len = 4 end
		elseif c >= 0xF1 and c <= 0xF3 then
			if cont(i + 1) and cont(i + 2) and cont(i + 3) then len = 4 end
		elseif c == 0xF4 then
			if range(i + 1, 0x80, 0x8F) and cont(i + 2) and cont(i + 3) then len = 4 end
		end
		if len == 0 then
			out[#out + 1] = "?"
			i = i + 1
		else
			out[#out + 1] = s:sub(i, i + len - 1)
			i = i + len
		end
	end
	return table.concat(out)
end

-- 统一走 utfstr 的严格清洗（非法字节 → "?"，规则与本地 safe_utf8 完全一致）
local ok_utf, U = pcall(require, "utfstr")
local function safe_utf8_u(s)
	if U then return U.sanitize(s) end
	return safe_utf8(s)
end

local Component = require("At.core.component")
local color = require("At.core.color")
local layout = require("At.core.layout")
local pixel = require("At.core.pixel")

local Label = {}
local proto = setmetatable({}, { __index = Component })
proto.__index = proto

local DEFAULTS = {
	w = "auto",
	h = "auto",
	text = "",
	color = "#E8ECF2",
	alpha = 255,
	align = "left", -- 相对自身宽度：left / center / right
	wrap = false, -- true 时需要给定宽度（数字或百分比）
	lineHeight = 1.2,
	interactive = false, -- 纯展示：不消费点击，不挡住容器拖动
}

function Label.new(opts)
	return Component.instantiate(proto, opts, DEFAULTS)
end

function proto:setText(text)
	self.text = text
	self:invalidateSize()
	return self
end

function proto:_safe_text()
	local raw = tostring(self.text or "")
	if self._safe_src ~= raw then
		self._safe_src = raw
		self._safe_text_cache = safe_utf8_u(raw)
	end
	return self._safe_text_cache
end

function proto:measure(availW)
	local f = self:font()
	local text = self:_safe_text()
	local lineH = f:getHeight() * (self.lineHeight or 1.2)

	if self.wrap then
		local limit = layout.pixels(self._specW, availW) or availW
		if limit and limit > 0 and f.getWrap then
			local ok, _, lines = pcall(f.getWrap, f, text, limit)
			if ok and lines then return limit, #lines * lineH end
		end
	end

	return f:getWidth(text), lineH
end

function proto:_draw()
	local text = self:_safe_text()
	if text == "" then
		return
	end

	if self.fontSize then
		love.graphics.setFont(self:font())
	end

	color.setColor(self.color, self.alpha)

	local x, y = pixel.xy(self.x, self.y)

	if self.wrap then
		love.graphics.printf(text, x, y, pixel.round(self.w), self.align or "left")
		return
	end

	local f = love.graphics.getFont()
	local dx = 0
	if self.align == "center" then
		dx = pixel.round((self.w - f:getWidth(text)) / 2)
	elseif self.align == "right" then
		dx = pixel.round(self.w - f:getWidth(text))
	end

	love.graphics.print(text, x + dx, y)
end

setmetatable(Label, {
	__call = function(_, opts)
		Label.safe_utf8 = safe_utf8_u
return Label.new(opts)
	end,
})

Label.safe_utf8 = safe_utf8_u
return Label

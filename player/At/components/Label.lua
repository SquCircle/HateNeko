-- 文字标签：布局里最常用的占位/说明组件。
--
--   At.Label{ x = 20, y = 20, text = "用户名", fontSize = 16 }
--   At.Label{ text = "很长的说明……", wrap = true, w = 240, lineHeight = 1.4 }

-- LÖVE 字体要求合法 UTF-8；列表/变量可含任意字节，先做安全替换。
local function safe_utf8(s)
	s = tostring(s or "")
	local i, n = 1, #s
	local out = {}
	while i <= n do
		local c = s:byte(i)
		local len
		if c < 0x80 then len = 1
		elseif c >= 0xC2 and c <= 0xDF then len = 2
		elseif c >= 0xE0 and c <= 0xEF then len = 3
		elseif c >= 0xF0 and c <= 0xF4 then len = 4
		else len = 0 end
		if len == 0 or i + len - 1 > n then
			out[#out + 1] = "?"; i = i + 1
		else
			local ok = true
			for j = 1, len - 1 do
				local cc = s:byte(i + j)
				if not cc or cc < 0x80 or cc > 0xBF then ok = false; break end
			end
			if ok then out[#out + 1] = s:sub(i, i + len - 1); i = i + len
			else out[#out + 1] = "?"; i = i + 1 end
		end
	end
	return table.concat(out)
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

function proto:measure(availW)
	local f = self:font()
	local text = safe_utf8(self.text)
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
	local text = safe_utf8(self.text)
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
		return Label.new(opts)
	end,
})

return Label

-- 单行文本输入框：点击获取焦点，回车提交，Esc 失焦，光标固定在末尾。
-- 焦点由 At.registry 统一管理，同一时刻只有一个组件接收 textinput。
--
--   local name = At.TextInput{
--       w = "100%", placeholder = "用户名",
--       onChange = function(text) print(text) end,
--       onSubmit = function(text) print("提交", text) end,
--   }
--
--   love.textinput(t)  -> At.textinput(t)
--   love.keypressed(k) -> At.keypressed(k)

local Component = require("At.core.component")
local color = require("At.core.color")
local input = require("At.core.input")
local clip = require("At.core.clip")
local pixel = require("At.core.pixel")
local blur = require("At.effects.blur")
local motion = require("At.core.motion")

local TextInput = {}
local proto = setmetatable({}, { __index = Component })
proto.__index = proto

local DEFAULTS = {
	w = 220,
	h = 44,
	radius = 10,

	text = "",
	placeholder = "",
	fontSize = 16,
	paddingX = 12,
	paddingY = 10,

	color = "#2A2F3A",
	alpha = 255,
	borderColor = "#4A5160",
	focusBorderColor = "#9FB3D3",
	textColor = "#E8ECF2",
	placeholderColor = "#7C8494",
	caretColor = "#9FB3D3",
	caretWidth = 2,
	caretPeriod = 0.5,
	selectionColor = "#35506E",

	maxLength = 0, -- 0 = 不限
	password = false,
	maskChar = "*",

	-- 聚焦时边框颜色/线宽的过渡
	animate = true,
	focusSpringStiffness = 380,
	focusSpringDamping = 28,

	onSubmit = nil,
	onChange = nil,
	onFocus = nil,
	onBlur = nil,
}

function TextInput.new(opts)
	local self = Component.instantiate(proto, opts, DEFAULTS)
	self.text = tostring(self.text or "")
	self._caret = #self.text
	self._anchor = nil
	self._scroll_x = 0
	self._caretTimer = 0
	self._focus = motion.spring({
		value = self:isFocused() and 1 or 0,
		stiffness = self.focusSpringStiffness,
		damping = self.focusSpringDamping,
	})
	return self
end

-- ---------- 文本 ----------

function proto:getText()
	return self.text
end

-- silent = true 时不触发 onChange
function proto:setText(text, silent)
	self.text = tostring(text or "")
	self._caret = #self.text
	self._anchor = nil
	self._scroll_x = 0
	self._caretTimer = 0
	self:invalidateSize()
	if not silent and self.onChange then
		self.onChange(self.text, self)
	end
	return self
end

function proto:clear()
	return self:setText("")
end

function proto:_ensureCaret()
	self._caret = tonumber(self._caret) or 0
	if self._caret < 0 then self._caret = 0 end
	if self._caret > #self.text then self._caret = #self.text end
	self._caret = input.byteOffset(self.text, input.charIndex(self.text, self._caret))
	if self._anchor ~= nil then
		self._anchor = math.max(0, math.min(#self.text, tonumber(self._anchor) or 0))
		self._anchor = input.byteOffset(self.text, input.charIndex(self.text, self._anchor))
	end
end

function proto:_selection()
	self:_ensureCaret()
	if self._anchor ~= nil and self._anchor ~= self._caret then
		return math.min(self._anchor, self._caret), math.max(self._anchor, self._caret)
	end
	return self._caret, self._caret
end

function proto:_setCaret(pos, extend)
	self:_ensureCaret()
	pos = input.byteOffset(self.text, input.charIndex(self.text, pos))
	if extend then
		if self._anchor == nil then self._anchor = self._caret end
	else
		self._anchor = nil
	end
	self._caret = pos
end

function proto:_notifyChanged()
	self._caretTimer = 0
	self:invalidateSize()
	if self.onChange then self.onChange(self.text, self) end
end

function proto:_replaceSelection(chunk)
	chunk = tostring(chunk or "")
	local from, to = self:_selection()
	-- 选择区间先删掉，再插入
	local nextText = input.removeRange(self.text, from, to)
	nextText = input.insert(nextText, from, chunk)
	if (self.maxLength or 0) > 0 and input.length(nextText) > self.maxLength then
		return false
	end
	self.text = nextText
	self._caret = from + #chunk
	self._anchor = nil
	self:_notifyChanged()
	return true
end

local function down(...)
	if love and love.keyboard and love.keyboard.isDown then
		local ok, v = pcall(love.keyboard.isDown, ...)
		if ok then return v end
	end
	return false
end

local function clip_text(self)
	if love and love.system and love.system.getClipboardText then
		local ok, v = pcall(love.system.getClipboardText)
		if ok then return tostring(v or "") end
	end
	return ""
end

function proto:_copySelection()
	local from, to = self:_selection()
	if from == to then return false end
	if love and love.system and love.system.setClipboardText then
		pcall(love.system.setClipboardText, self.text:sub(from + 1, to))
	end
	return true
end

function proto:length()
	return input.length(self.text)
end

function proto:_displayText()
	if self.password then
		return string.rep(self.maskChar or "*", input.length(self.text))
	end
	return self.text
end

-- ---------- 焦点与输入 ----------

function proto:_press()
	self:focus()
	self._caretTimer = 0
	return true
end

function proto:_onFocus()
	self._caretTimer = 0
	-- 移动端：带上输入框矩形，系统会把软键盘弹出来并对准它
	if love.keyboard and love.keyboard.setTextInput then
		love.keyboard.setTextInput(true, self.x, self.y, self.w, self.h)
	end
	if self.onFocus then
		self.onFocus(self)
	end
end

function proto:_onBlur()
	self._caretTimer = 0
	if love.keyboard and love.keyboard.setTextInput then
		love.keyboard.setTextInput(false)
	end
	if self.onBlur then
		self.onBlur(self)
	end
end

function proto:_tick(dt)
	self._caretTimer = (self._caretTimer or 0) + (dt or 0)

	local target = self:isFocused() and 1 or 0
	self._focus:setTarget(target)
	if self.animate == false then
		self._focus:snap(target)
	else
		self._focus:update(dt)
	end
end

function proto:_caretVisible()
	local period = self.caretPeriod or 0.5
	if period <= 0 then
		return true
	end
	return math.floor((self._caretTimer or 0) / period) % 2 == 0
end

function proto:textinput(t)
	if not self:isFocused() or not self.enabled or t == nil or t == "" then
		return false
	end
	return self:_replaceSelection(t)
end

function proto:_press(mx, my)
	self:focus()
	self:_ensureCaret()
	local f = self:font()
	local textX = self.x + self.paddingX - (self._scroll_x or 0)
	local click = (mx or textX) - textX
	local display = self:_displayText()
	local best, bestd = 0, math.huge
	local count = input.length(display)
	for i = 0, count do
		local prefix = display:sub(1, input.byteOffset(display, i))
		local d = math.abs(f:getWidth(prefix) - click)
		if d < bestd then bestd = d; best = i end
	end
	self:_setCaret(input.byteOffset(self.text, best), false)
	self._caretTimer = 0
	return true
end

function proto:keypressed(key)
	if not self:isFocused() then return false end
	local shift = down("lshift", "rshift")
	local ctrl = down("lctrl", "rctrl", "lgui", "rgui")

	if ctrl and (key == "a" or key == "A") then
		self._anchor = 0
		self._caret = #self.text
		return true
	elseif ctrl and (key == "c" or key == "C") then
		self:_copySelection()
		return true
	elseif ctrl and (key == "x" or key == "X") then
		if self:_copySelection() then
			local from, to = self:_selection()
			self.text = input.removeRange(self.text, from, to)
			self._caret = from
			self._anchor = nil
			self:_notifyChanged()
		end
		return true
	elseif ctrl and (key == "v" or key == "V") then
		local ct = clip_text(self)
		if ct ~= "" then self:_replaceSelection(ct) end
		return true
	elseif key == "left" then
		self:_setCaret(input.prevBoundary(self.text, self:_selectionStart()), shift)
		return true
	elseif key == "right" then
		self:_setCaret(input.nextBoundary(self.text, self:_selectionEnd()), shift)
		return true
	elseif key == "home" then
		self:_setCaret(0, shift)
		return true
	elseif key == "end" then
		self:_setCaret(#self.text, shift)
		return true
	elseif key == "backspace" then
		local from, to = self:_selection()
		if from == to then
			from = input.prevBoundary(self.text, self._caret)
			to = self._caret
		end
		if from ~= to then
			self.text = input.removeRange(self.text, from, to)
			self._caret = from
			self._anchor = nil
			self:_notifyChanged()
		end
		return true
	elseif key == "delete" then
		local from, to = self:_selection()
		if from == to then
			from = self._caret
			to = input.nextBoundary(self.text, self._caret)
		end
		if from ~= to then
			self.text = input.removeRange(self.text, from, to)
			self._caret = from
			self._anchor = nil
			self:_notifyChanged()
		end
		return true
	elseif key == "return" or key == "kpenter" then
		if self.onSubmit then self.onSubmit(self.text, self) end
		return true
	elseif key == "escape" then
		self:blur()
		return true
	end
	return false
end

-- 光标移动时用选择边界的远端：无选择时就是光标本身。
function proto:_selectionStart()
	self:_ensureCaret()
	if self._anchor == nil then return self._caret end
	return math.min(self._anchor, self._caret)
end

function proto:_selectionEnd()
	self:_ensureCaret()
	if self._anchor == nil then return self._caret end
	return math.max(self._anchor, self._caret)
end

-- ---------- 尺寸与绘制 ----------

function proto:measure()
	local f = self:font()

	local sample = (self.text ~= "" and self.text) or self.placeholder or ""
	if self.password then
		sample = string.rep(self.maskChar or "*", input.length(sample))
	end

	local declaredW, declaredH = self:declaredWidth(), self:declaredHeight()
	local w = type(declaredW) == "number" and declaredW
		or math.max(160, f:getWidth(tostring(sample)) + self.paddingX * 2 + 12)
	local h = type(declaredH) == "number" and declaredH or (f:getHeight() + self.paddingY * 2)

	return w, h
end

function proto:_draw()
	local f = self:font()
	local r = self:rect()
	local x, y = pixel.xy(r.x, r.y)
	local w, h = pixel.round(r.w), pixel.round(r.h)

	if (self.alpha or 255) < 255 then
		blur.drawBackdrop(x, y, w, h, r.radius)
	end

	color.setColor(self.color, self.alpha)
	love.graphics.rectangle("fill", x, y, w, h, r.radius)

	local focused = self:isFocused()
	local focusT = focused and 1 or 0
	if self.animate ~= false then
		focusT = math.min(1, math.max(0, self._focus and self._focus.value or focusT))
	end
	color.setColor(color.mix(self.borderColor or "#4A5160", self.focusBorderColor or "#9FB3D3", focusT), self.alpha)
	love.graphics.setLineWidth(1 + focusT)
	love.graphics.rectangle("line", x, y, w, h, r.radius)

	local display = self:_displayText()
	self:_ensureCaret()
	local hasText = self.text ~= ""
	local shown = hasText and display or (self.placeholder or "")
	local textY = pixel.round(y + (h - f:getHeight()) / 2)
	local innerW = math.max(1, w - self.paddingX * 2)
	local caretChar = input.charIndex(self.text, self._caret)
	local caretDisp = input.byteOffset(display, caretChar)
	local caretW = f:getWidth(display:sub(1, caretDisp))
	local scroll = self._scroll_x or 0
	if hasText then
		if caretW - scroll > innerW then
			scroll = caretW - innerW + 8
		elseif caretW - scroll < 0 then
			scroll = math.max(0, caretW - 8)
		end
	else
		scroll = 0
	end
	self._scroll_x = scroll
	local textX = x + self.paddingX - scroll

	love.graphics.setFont(f)

	-- 与外层裁剪求交（例如 ScrollView 的视口），不能直接覆盖
	local old, visible = clip.apply(x + 1, y + 1, w - 2, h - 2)
	if visible then
		if hasText then
			local from, to = self:_selection()
			if from < to then
				local d1 = input.byteOffset(display, input.charIndex(self.text, from))
				local d2 = input.byteOffset(display, input.charIndex(self.text, to))
				local sx1 = textX + f:getWidth(display:sub(1, d1))
				local sx2 = textX + f:getWidth(display:sub(1, d2))
				color.setColor(self.selectionColor or "#35506E", self.alpha)
				love.graphics.rectangle("fill", pixel.round(sx1), textY, pixel.round(sx2 - sx1), f:getHeight())
			end
			color.setColor(self.textColor, self.alpha)
			love.graphics.print(display, textX, textY)
		elseif shown ~= "" then
			color.setColor(self.placeholderColor, self.alpha)
			love.graphics.print(shown, textX, textY)
		end

		if focused and self:_caretVisible() then
			local caretX = textX + caretW
			local minX = x + self.paddingX
			local maxX = x + w - self.paddingX
			if caretX < minX then caretX = minX end
			if caretX > maxX then caretX = maxX end
			color.setColor(self.caretColor, self.alpha)
			love.graphics.rectangle("fill", pixel.round(caretX), textY, self.caretWidth or 2, f:getHeight())
		end
	end
	clip.restore(old)
end

setmetatable(TextInput, {
	__call = function(_, opts)
		return TextInput.new(opts)
	end,
})

return TextInput

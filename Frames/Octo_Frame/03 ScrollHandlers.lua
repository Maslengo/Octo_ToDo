local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
-- Панорамирование
function E.func_canPan()
	return E.isPanning
end

function E.func_setPanX(f, deltaX)
	local sx = f.horizontalScrollFrame:GetHorizontalScroll()
	f.horizontalScrollFrame:SetHorizontalScroll(sx + deltaX)
end

function E.func_setPanY(f, deltaY)
	local scrollBox = f.ScrollBoxCenter
	local visibleHeight = scrollBox:GetHeight()
	local scrollPercentage = visibleHeight > 0 and (deltaY / visibleHeight) or 0
	local currentPercentage = scrollBox:GetScrollPercentage()
	scrollBox:SetScrollPercentage(currentPercentage + scrollPercentage)
end

function E.func_setAcceleration(deltaX, deltaY, elapsed)
	local initialAcceleration = .5
	E.accX = deltaX / elapsed * initialAcceleration
	E.accY = deltaY / elapsed * initialAcceleration
end

function E.func_getDeltaAcceleration(curAcc, elapsed)
	local kAcc = -5
	local decay = math.exp(kAcc * elapsed)
	local delta = curAcc * (decay - 1) / kAcc
	local newAcc = curAcc * decay
	if newAcc < 5 and newAcc > -5 then return end
	return delta, newAcc
end

function E.func_updateAcceleration(f, elapsed)
	if E.accX then
		local deltaX, accX = E.func_getDeltaAcceleration(E.accX, elapsed)
		E.accX = accX
		if deltaX then E.func_setPanX(f, deltaX) end
	end
	if E.accY then
		local deltaY, accY = E.func_getDeltaAcceleration(E.accY, elapsed)
		E.accY = accY
		if deltaY then E.func_setPanY(f, deltaY) end
	end
end

function E.func_OnUpdate(f, elapsed)
	if E.func_canPan() then
		local x, y = GetCursorDelta()
		local scale = f:GetEffectiveScale()
		x, y = x / scale, y / scale
		E.func_setPanX(f, -x)
		E.func_setPanY(f, y)
		E.func_setAcceleration(-x, y, elapsed)
	elseif E.accX or E.accY then
		E.func_updateAcceleration(f, elapsed)
	end
end

----------------------------------------------------------------
-- Регистрация скроллов
function E.func_RegisterWithScrollBar(scrollBox, scrollBar)
	local onScrollBarScroll = function(o, scrollPercentage)
		scrollBox:SetScrollPercentage(scrollPercentage, ScrollBoxConstants.NoScrollInterpolation)
	end
	scrollBar:RegisterCallback(BaseScrollBoxEvents.OnScroll, onScrollBarScroll, scrollBox)
	local onScrollBarAllowScroll = function(o, allowScroll)
		scrollBox:SetScrollAllowed(allowScroll)
	end
	scrollBar:RegisterCallback(BaseScrollBoxEvents.OnAllowScrollChanged, onScrollBarAllowScroll, scrollBox)
end

function E.func_RegisterWithScrollBox(scrollBox, scrollBar)
	local onScrollBoxScroll = function(o, scrollPercentage, visibleExtentPercentage, panExtentPercentage)
		scrollBar:SetScrollPercentage(scrollPercentage, ScrollBoxConstants.NoScrollInterpolation)
		scrollBar:SetVisibleExtentPercentage(visibleExtentPercentage)
		scrollBar:SetPanExtentPercentage(panExtentPercentage)
	end
	scrollBox:RegisterCallback(BaseScrollBoxEvents.OnScroll, onScrollBoxScroll, scrollBar)
	local onSizeChanged = function(o, width, height, visibleExtentPercentage)
		scrollBar:SetVisibleExtentPercentage(visibleExtentPercentage)
	end
	scrollBox:RegisterCallback(BaseScrollBoxEvents.OnSizeChanged, onSizeChanged, scrollBar)
	local onScrollBoxAllowScroll = function(o, allowScroll)
		scrollBar:SetScrollAllowed(allowScroll)
	end
	scrollBox:RegisterCallback(BaseScrollBoxEvents.OnAllowScrollChanged, onScrollBoxAllowScroll, scrollBar)
end

function E.func_ApplyInterpolationCompatibility(scrollBox, scrollBar)
	if not scrollBar:CanInterpolateScroll() or not scrollBox:CanInterpolateScroll() then
		scrollBar:SetInterpolateScroll(false)
		scrollBox:SetInterpolateScroll(false)
	end
end
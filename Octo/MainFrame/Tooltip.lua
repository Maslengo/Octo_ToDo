local GlobalAddonName, E = ...
----------------------------------------------------------------
-- Подключаем необходимые библиотеки
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("Octo") -- Локализация
local LibDataBroker = LibStub("LibDataBroker-1.1") -- Для брокера данных
local LibDBIcon = LibStub("LibDBIcon-1.0") -- Для иконки на миникарте
local LibSharedMedia = LibStub("LibSharedMedia-3.0") -- Для медиа-ресурсов
local LibThingsLoad = LibStub("LibThingsLoad-1.0") -- Для асинхронной загрузки
local LibSFDropDown = LibStub("LibSFDropDown-1.5") -- Для выпадающих меню
local LibQTip = LibStub("LibQTip-2.0") -- Для тултипов
----------------------------------------------------------------
function E:func_TooltipOnEnter(frame, first, second, point)
	if not frame.tooltip or #frame.tooltip == 0 then return end
	local tooltip = LibQTip:AcquireTooltip("FooBarTooltip", 3, "LEFT", "RIGHT", "RIGHT")
	tooltip:Clear()

	if frame.tooltip.Header then
		tooltip:AddHeadingRow(frame.tooltip.Header[1], frame.tooltip.Header[2], frame.tooltip.Header[3])
		tooltip:AddSeparator()
	end

	for k, value in ipairs(frame.tooltip) do
		if value[3] then
			tooltip:AddRow(value[1], value[2], value[3])
		elseif value[2] then
			tooltip:AddRow(value[1], " ", value[2])
		elseif value[1] then
			tooltip:AddRow(value[1])
		end
		if value[1]:find("Маслен") then
			print (value[1])
		end
	end



	-- print (frame.tooltip.GUID)
	-- tooltip:GetCell(5):SetColor(1, 0, 0, 1)



	if point then
		local first_point, second_point = unpack(point)
		tooltip:SetPoint(first_point, frame, second_point)
		tooltip:SetClampedToScreen(true)
	else
		tooltip:SetPoint("RIGHT", frame, "LEFT")
	end
	tooltip:SetMaxHeight(512)
	tooltip:SetAutoHideDelay(.25, frame)

	-- print ("GetFont:", tooltip:GetFont())
	-- print ("GetHeaderFont:", tooltip:GetHeaderFont())
	-- print ("GetLineCount:", tooltip:GetLineCount())
	-- print ("GetColumnCount:", E.Green_Color..tooltip:GetColumnCount().."|r")

	tooltip:Show()
end



function E:func_TooltipOnLeave(frame) -- GameTooltip_Hide
	frame.tooltip:Hide()
end


			-- frame:SetScript("OnLeave", function()
			-- 	E:func_TooltipOnLeave(frame)
			-- end)
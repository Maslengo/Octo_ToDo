local GlobalAddonName, E = ...
----------------------------------------------------------------
function E:func_TooltipOnEnter(frame, point)
	if not frame.tooltip or #frame.tooltip == 0 then return end
	-- local tooltip = GameTooltip
	GameTooltip:ClearLines()
	if point then
		GameTooltip:SetOwner(frame, "ANCHOR_NONE")
		local first, second = unpack(point)
		GameTooltip:SetPoint(first, frame, second)
	else
		GameTooltip:SetOwner(frame, "ANCHOR_CURSOR_RIGHT")
	end
	for _, value in ipairs(frame.tooltip) do
		GameTooltip:AddDoubleLine(value[1], value[2], 1,1,1,1,1,1)
	end
	GameTooltip:Show()
end


function E:func_TooltipOnLeave()
	GameTooltip:Hide()
end
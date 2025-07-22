local GlobalAddonName, E = ...
----------------------------------------------------------------
local LibQTip = LibStub("LibQTip-2.0")
----------------------------------------------------------------




-- tooltip[#tooltip+1] = {" ", E.WOW_Artifact_Color..CLOSE.."|r", " "}

function E:func_TooltipOnEnter(frame, point)
	if not frame.tooltip or #frame.tooltip == 0 then return end
	local tooltip = LibQTip:AcquireTooltip("MyAddonTooltip", 3, "LEFT", "RIGHT", "RIGHT")
	tooltip:Clear()
	if frame.tooltip.Header then
		tooltip:AddHeadingRow(frame.tooltip.Header[1], frame.tooltip.Header[2], frame.tooltip.Header[3])
		tooltip:AddSeparator()
	end
	-- for k, value in ipairs(frame.tooltip) do
	-- 	if value[3] then
	-- 		if tooltip:GetColumnCount() == 1 then
	-- 			tooltip:AddColumn("RIGHT")
	-- 			tooltip:AddColumn("RIGHT")
	-- 		end
	-- 		tooltip:AddRow(value[1], value[2], value[3])
	-- 	elseif value[2] then
	-- 		if tooltip:GetColumnCount() == 1 then
	-- 			tooltip:AddColumn("RIGHT")
	-- 		end
	-- 		tooltip:AddRow(value[1], value[2])
	-- 	elseif value[1] then
	-- 		tooltip:AddRow(value[1])
	-- 	end
	-- end
	if tooltip.AddCellProgressBar then
		tooltip:AddLine("Прогресс:")
		tooltip:AddCellProgressBar(1, 2, 50, 100, 100) -- Текущее значение, макс. значение, ширина
	end
	if point then
		local first_point, second_point = unpack(point)
		tooltip:SetPoint(first_point, frame, second_point)
		tooltip:SetClampedToScreen(true)
	else
		tooltip:SetPoint("RIGHT", frame, "LEFT")
	end
	tooltip:SetMaxHeight(512)
	tooltip:UpdateLayout()
	tooltip:SetAutoHideDelay(.1, frame)
	tooltip:Show()
end
function E:func_TooltipOnLeave(frame) -- GameTooltip_Hide
	-- if frame.tooltip then
	-- 	LibQTip:Release()
	-- end
	-- frame.tooltip = nil
	-- return frame.tooltip:Release()
end
-- frame:SetScript("OnLeave", function()
-- E:func_TooltipOnLeave(frame)
-- end)
-- print ("GetRow:", tooltip:GetRow(1))
-- print ("HookScript:", tooltip:HookScript()) -- NOT ALLOWED
-- print ("IsAcquiredBy:", tooltip:IsAcquiredBy(key)) -- key
-- print ("SetCellMarginH:", tooltip:SetCellMarginH())
-- print ("SetCellMarginV:", tooltip:SetCellMarginV())
-- print ("SetColumnLayout:", tooltip:SetColumnLayout())
-- print ("SetDefaultFont:", tooltip:SetDefaultFont(font))
-- print ("SetDefaultHeadingFont:", tooltip:SetDefaultHeadingFont(font))
-- print ("SetHighlightTexCoord:", tooltip:SetHighlightTexCoord())
-- print ("SetHighlightTexture:", tooltip:SetHighlightTexture(filePath, horizontalWrap, verticalWrap, filterMode))
-- print ("SetScript:", tooltip:SetScript())
-- print ("AddColumn:", tooltip:AddColumn("RIGHT"))
-- print ("AddHeadingRow:", tooltip:AddHeadingRow())
-- print ("AddRow:", tooltip:AddRow())
-- print ("AddSeparator:", tooltip:AddSeparator(20, 1, 0, 1, .2))
-- print ("Clear:", tooltip:Clear())
-- print ("Release:", tooltip:Release())
-- print ("SetAutoHideDelay:", tooltip:SetAutoHideDelay())
-- print ("SetMaxHeight:", tooltip:SetMaxHeight())
-- print ("SetScrollStep:", tooltip:SetScrollStep())
-- print ("SmartAnchorTo:", tooltip:SmartAnchorTo(frame))
-- print ("UpdateLayout:", tooltip:UpdateLayout())
-- print ("GetColumn:", tooltip:GetColumn(1))
-- print ("GetColumnCount:", tooltip:GetColumnCount())
-- print ("GetDefaultCellProvider:", tooltip:GetDefaultCellProvider())
-- print ("GetDefaultFont:", tooltip:GetDefaultFont())
-- print ("GetDefaultHeadingFont:", tooltip:GetDefaultHeadingFont())
-- print ("GetHighlightTexCoord:", tooltip:GetHighlightTexCoord())
-- print ("GetHighlightTexture:", tooltip:GetHighlightTexture())
-- print ("GetRowCount:", tooltip:GetRowCount())
-- print ("GetScrollStep:", tooltip:GetScrollStep())
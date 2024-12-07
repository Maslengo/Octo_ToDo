local GlobalAddonName, E = ...
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
----------------------------------------------------------------
-- Octo_ToDo_CreateMenuStyle
-- menuBackdrop = modernMenu
local menuBackdrop = {
	bgFile = "Interface/ChatFrame/ChatFrameBackground",
	edgeFile = "Interface/ChatFrame/ChatFrameBackground",
	tile = true, edgeSize = 1 * E.scale, tileSize = 5 * E.scale,
}
LibSFDropDown:CreateMenuStyle(GlobalAddonName, function(parent)
	local f = CreateFrame("FRAME", nil, parent, "BackdropTemplate")
	f:SetBackdrop(menuBackdrop)
	f:SetPoint("TOPLEFT", 8, -2)
	f:SetPoint("BOTTOMRIGHT", -8, 2)
	f:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	f:SetBackdropBorderColor(0, 0, 0, 1)
	return f
end)
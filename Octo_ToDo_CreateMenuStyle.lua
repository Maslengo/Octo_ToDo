local GlobalAddonName, E = ...
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
----------------------------------------------------------------------------------------------------------------------------------
-- Octo_ToDo_CreateMenuStyle
local menuBackdrop = {
	bgFile = "Interface/ChatFrame/ChatFrameBackground",
	edgeFile = "Interface/ChatFrame/ChatFrameBackground",
	tile = true, edgeSize = 1 * E.Octo_Globals.scale, tileSize = 5 * E.Octo_Globals.scale,
}

LibSFDropDown:CreateMenuStyle(GlobalAddonName, function(parent)
	local f = CreateFrame("FRAME", nil, parent, "BackdropTemplate")
	f:SetBackdrop(menuBackdrop)
	f:SetBackdropColor(E.Octo_Globals.bgCr, E.Octo_Globals.bgCg, E.Octo_Globals.bgCb, E.Octo_Globals.bgCa)
	f:SetBackdropBorderColor(0, 0, 0, 1)
	return f
end)
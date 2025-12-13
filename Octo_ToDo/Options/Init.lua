local GlobalAddonName, E = ...
local EventFrame = CreateFrame("FRAME")
-------------------------------------------------------------------------
function EventFrame:func_InitOptions()
	if not E.func_Octo_Options then return end
	local name = E.func_AddonNameForOptionsInit(GlobalAddonName)
	local parent = E.func_GetAddOnMetadata(E.MainAddonName, "Title")
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(name, E.func_Octo_Options(EventFrame.savedVars))
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions(name, parent)
end
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_LOGIN",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
end
function EventFrame:PLAYER_LOGIN()
	self:func_InitOptions()
end
----------------------------------------------------------------
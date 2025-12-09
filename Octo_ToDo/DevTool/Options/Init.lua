local GlobalAddonName, E = ...
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
function EventFrame:func_InitOptions()
	if not E.func_DevTool_Options then return end
	local name = BINDING_HEADER_DEBUG -- E.func_AddonNameForOptionsInit(GlobalAddonName).." - Debug"
	local parent = E.func_GetAddOnMetadata(E.MainAddonName, "Title")
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(name, E.func_DevTool_Options(EventFrame.savedVars))
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions(name, name, parent)
end
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_LOGIN",
}
E.func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
end
function EventFrame:PLAYER_LOGIN()
	C_Timer.After(1, function() -- САМЫЙ ПОСЛЕДНИЙ В СПИСКЕ
		self:func_InitOptions()
	end)
end
----------------------------------------------------------------
local GlobalAddonName, ns = ...
E = _G.OctoEngine
-- 
local EventFrame = CreateFrame("FRAME")
local funcName = GlobalAddonName.."WTF"
----------------------------------------------------------------
EventFrame[funcName] = function(self)
	EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
	E.func_InitSubTable(EventFrame.savedVars, "Config_Achievements")
	E.func_InitField(EventFrame.savedVars.Config_Achievements, "ShowCompleted", true)
	E.func_InitField(EventFrame.savedVars.Config_Achievements, "AchievementToShow", { [92] = true })
end
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
}
E.func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	EventFrame[funcName](EventFrame)
end
----------------------------------------------------------------
local GlobalAddonName, ns = ...
E = _G.OctoEngine
local EventFrame = CreateFrame("FRAME")
local funcName = GlobalAddonName.."WTF"
----------------------------------------------------------------
EventFrame[funcName] = function(self)
	----------------------------------------------------------------
	local defaultOptions = {
		Config_QC_Quests = true,
		Config_QC_Vignettes = true,
	}
	for k, v in next, (defaultOptions) do
		E.func_InitField(EventFrame.savedVars, k, v)
	end
	E.func_InitSubTable(EventFrame.savedVars, "QC_Quests")
	E.func_InitSubTable(EventFrame.savedVars, "QC_Vignettes")
	----------------------------------------------------------------
end
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
}
----------------------------------------------------------------
E.func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
------------------------------------------------------------
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
	EventFrame[funcName](EventFrame)
end
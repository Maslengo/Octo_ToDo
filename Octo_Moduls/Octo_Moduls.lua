local GlobalAddonName, ns = ...
E = _G.OctoEngine
----------------------------------------------------------------
local Octo_EventFrame_Moduls = CreateFrame("FRAME")
Octo_EventFrame_Moduls:Hide()
----------------------------------------------------------------
function Octo_EventFrame_Moduls:OnLoad()
	for _, func in ipairs(E.Modules) do
		func()
	end
end
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
}
E:func_RegisterMyEventsToFrames(Octo_EventFrame_Moduls, MyEventsTable)
function Octo_EventFrame_Moduls:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil

		self:OnLoad()
		E:func_LoadCVars()
	end
end
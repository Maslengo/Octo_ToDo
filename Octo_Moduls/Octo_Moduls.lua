local GlobalAddonName, ns = ...
E = _G.OctoEngine
--
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
function EventFrame:OnLoad()
	for _, func in ipairs(E.Modules) do
		func()
	end
end
----------------------------------------------------------------
local MyEventsTable = {
	"VARIABLES_LOADED",
}
E.func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
function EventFrame:VARIABLES_LOADED()
	EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
	E.func_CreateMinimapButton(GlobalAddonName, "Moduls", EventFrame.savedVars, Octo_MainFrame_Moduls, nil, "Octo_MainFrame_Moduls")
	self:OnLoad()
end
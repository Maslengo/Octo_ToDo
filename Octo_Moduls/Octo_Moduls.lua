local GlobalAddonName, ns = ...
E = _G.OctoEngine
----------------------------------------------------------------
local Octo_EventFrame = CreateFrame("FRAME")
Octo_EventFrame:Hide()
----------------------------------------------------------------
function Octo_EventFrame:OnLoad()
	for _, func in ipairs(E.Modules) do
		func()
	end
end
----------------------------------------------------------------
local MyEventsTable = {
	"VARIABLES_LOADED",
}
E.func_RegisterMyEventsToFrames(Octo_EventFrame, MyEventsTable)
function Octo_EventFrame:VARIABLES_LOADED()
	E.func_CreateMinimapButton(GlobalAddonName, "Moduls", Octo_Moduls_DB, Octo_MainFrame_Moduls, nil, "Octo_MainFrame_Moduls")

	self:OnLoad()
	E.func_LoadCVars()
end
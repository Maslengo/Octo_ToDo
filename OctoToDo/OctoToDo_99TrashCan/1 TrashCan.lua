local GlobalAddonName, E = ...
local OctoToDo_EventFrame_TrashCan = CreateFrame("FRAME")
OctoToDo_EventFrame_TrashCan:Hide()
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
}
E.RegisterMyEventsToFrames(OctoToDo_EventFrame_TrashCan, MyEventsTable, E.func_DebugPath())
function OctoToDo_EventFrame_TrashCan:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		if OctoToDo_TrashCan == nil then OctoToDo_TrashCan = {} end
		if OctoToDo_TrashCan.Reputations == nil then OctoToDo_TrashCan.Reputations = {} end
		if OctoToDo_TrashCan.OctoToDo_MplusButton == nil then OctoToDo_TrashCan.OctoToDo_MplusButton = {} end
		if OctoToDo_TrashCan.UniversalQuest == nil then OctoToDo_TrashCan.UniversalQuest = {} end
		if OctoToDo_TrashCan.Holiday == nil then OctoToDo_TrashCan.Holiday = {} end
		if OctoToDo_TrashCan.HolidayCollectAll == nil then OctoToDo_TrashCan.HolidayCollectAll = {} end
		----------------------------------------------------------------
		-- E:func_CreateUtilsButton(nil)
		-- E:func_CreateMinimapButton(GlobalAddonName, OctoToDo_TrashCan, nil, function() fpde(OctoToDo_TrashCan) end, "OctoToDo_TrashCan")
	end
end
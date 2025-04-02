local GlobalAddonName = ...
local OctoToDo_EventFrame_TrashCan = CreateFrame("FRAME")
OctoToDo_EventFrame_TrashCan:Hide()
local E = OctoToDo_ToDO_E
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_LOGIN",
}
E.RegisterMyEventsToFrames(OctoToDo_EventFrame_TrashCan, MyEventsTable, E.func_DebugPath())
function OctoToDo_EventFrame_TrashCan:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		if OctoToDo_TrashCan == nil then OctoToDo_TrashCan = {} end
		if OctoToDo_TrashCan.Reputations == nil then OctoToDo_TrashCan.Reputations = {} end
		if OctoToDo_TrashCan.OctoToDo_MplusButton == nil then OctoToDo_TrashCan.OctoToDo_MplusButton = {} end
		if OctoToDo_TrashCan.EncounterAndZoneLists == nil then OctoToDo_TrashCan.EncounterAndZoneLists = {} end
		if OctoToDo_TrashCan.UniversalQuest == nil then OctoToDo_TrashCan.UniversalQuest = {} end
		if OctoToDo_TrashCan.Holiday == nil then OctoToDo_TrashCan.Holiday = {} end
		if OctoToDo_TrashCan.HolidayCollectAll == nil then OctoToDo_TrashCan.HolidayCollectAll = {} end
		----------------------------------------------------------------
	end
end
function OctoToDo_EventFrame_TrashCan:PLAYER_LOGIN()
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
	-- E:func_CreateUtilsButton(nil)
	E:func_CreateMinimapButton(GlobalAddonName, OctoToDo_TrashCan, nil, function() fpde(OctoToDo_TrashCan) end)
end
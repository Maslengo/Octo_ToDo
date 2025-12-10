local GlobalAddonName, E = ... -- ns
----------------------------------------------------------------
-- local OctoTODOQWE = CreateFrame("FRAME", "OctoTODOQWE")
-- E.OctoTODOQWE = OctoTODOQWE

-- local function loadUI(addonName)
-- 	local myAddons = {
-- 		GlobalAddonName,
-- 		"Octo_Achievements",
-- 		"Octo_Moduls",
-- 		"Octo_QuestsChanged",
-- 	}
-- 	for _, a in ipairs(myAddons) do
-- 		if a == addonName then
-- 			function OctoTODOQWE.setMetaNS(ui)
-- 				ui.addon = addon
-- 				setmetatable(E, {__index = ui, __metatable = false})
-- 				setmetatable(ui, {__index = E, __metatable = false})
-- 			end
-- 			OctoTODOQWE:UnregisterEvent("ADDON_LOADED")
-- 			OctoTODOQWE.ADDON_LOADED = nil
-- 			OctoTODOQWE.setMetaNS = nil
-- 		end
-- 	end
-- end

-- OctoTODOQWE:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
-- OctoTODOQWE:RegisterEvent("ADDON_LOADED")

-- function OctoTODOQWE:ADDON_LOADED(addonName)
-- 	loadUI(addonName)
-- end


E.MainAddonName = GlobalAddonName
OctoEngine = E -- в других аддонах





E.OctoTables_Vibor = {}
E.ALL_Currencies = {}
E.ALL_Items = {}
E.ALL_Reputations = {}
E.ALL_UniversalQuests = {}
E.ALL_Additionally = {}
E.ALL_Quests = {}
E.First_Option = {}
E.Second_Option = {}
E.ActiveHoliday = {}
E.Fourth_Option = {}
E.Holiday = {}
E.KeyStoneTBL = {}
E.Modules = {}
E.OctoTable_Expansions = {}
E.OctoTable_Frames = {}
E.OctoTable_GarrisonBuildingIDs = {}
E.OctoTable_itemID_ALL = {}
E.OctoTable_itemID_AutoOpen = {}
E.OctoTable_itemID_Cataloged_Research = {}
E.OctoTable_itemID_Ignore_List = {}
E.OctoTable_itemID_ItemsDelete = {}
E.OctoTable_itemID_ItemsUsable = {}
E.OctoTable_itemID_ItemsUsable_Other = {}
E.OctoTable_itemID_MECHAGON = {}
E.OctoTable_KeystoneAbbr = {}
E.OctoTable_LFGDungeons = {}
E.OctoTable_Mounts = {}
E.OctoTable_Portals = {}
E.OctoTable_QuestID = {}
E.OctoTable_QuestID_Paragon = {}
E.OctoTable_RemixInfinityResearch = {}
E.OctoTable_ReputationsDB = {}
E.OctoTable_SavedVariables = {}
E.OctoTables_DataOtrisovka = {}
E.Octo_ProfessionsskillLine = {}
E.Octo_ProfessionsskillLine_Other = {}
E.Third_Option = {}
E.Timers = {}
E.OctoTable_ALL_Mounts = {}
E.Components = {}
E.OctoTable_CurrencyMountForFuncCurName = {}
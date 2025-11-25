local GlobalAddonName, E = ... -- ns
E.MainAddonName = GlobalAddonName
OctoEngine = E -- в других аддонах




E.ActiveHoliday = {}
E.ALL_Currencies = {}
E.ALL_Items = {}
E.ALL_Reputations = {}
E.ALL_UniversalQuests = {}
E.altStrategies = {}
E.First_Option = {}
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
E.OctoTable_UniversalQuest = {}
E.OctoTables_DataOtrisovka = {}
E.OctoTables_DataOtrisovka_OLD = {}
E.OctoTables_Vibor = {}
E.Octo_ProfessionsskillLine = {}
E.Octo_ProfessionsskillLine_Other = {}
E.Second_Option = {}
E.strategies = {}
E.Third_Option = {}
E.Timers = {}

-- for i = 1, 14 do
-- 	E.OctoTables_Vibor[i] = {}
-- 	E.OctoTables_Vibor[i].icon = 123123
-- 	E.OctoTables_Vibor[i].name = NONE
-- end

local dataMeta = {
	__index = {
		Currencies = {},
		Items = {},
		Reputations = {},
		UniversalQuests = {}
	}
}

for i = 1, 14 do
	E.OctoTables_DataOtrisovka[i] = setmetatable({}, dataMeta)
end
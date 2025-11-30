local GlobalAddonName, E = ... -- ns
E.MainAddonName = GlobalAddonName
OctoEngine = E -- в других аддонах

E.OctoTables_Vibor = {}

E.ALL_Currencies = {}
E.ALL_Items = {}
E.ALL_Reputations = {}
E.ALL_UniversalQuests = {}
E.ALL_Additionally = {}

E.First_Option = {}
E.Second_Option = {}

E.ActiveHoliday = {}
E.altStrategies = {}
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
E.strategies = {}
E.Third_Option = {}
E.Timers = {}


-- local dataMeta = {
-- 	__index = {
-- 		Currencies = {},
-- 		Items = {},
-- 		Reputations = {},
-- 		UniversalQuests = {},
-- 		Additionally = {},
-- 	}
-- }

-- for i = 1, 100 do
-- 	E.OctoTables_DataOtrisovka[i] = setmetatable({}, dataMeta)
-- end


Octo_ToDo_DB_NeedToTrack = Octo_ToDo_DB_NeedToTrack or {}
Octo_ToDo_DB_NeedToTrack.Items = Octo_ToDo_DB_NeedToTrack.Items or {}
Octo_ToDo_DB_NeedToTrack.Reputations = Octo_ToDo_DB_NeedToTrack.Reputations or {}
Octo_ToDo_DB_NeedToTrack.Currencies = Octo_ToDo_DB_NeedToTrack.Currencies or {}
Octo_ToDo_DB_NeedToTrack.Quests = Octo_ToDo_DB_NeedToTrack.Quests or {}
Octo_ToDo_DB_NeedToTrack.Spells = Octo_ToDo_DB_NeedToTrack.Spells or {}
Octo_ToDo_DB_NeedToTrack.Achievements = Octo_ToDo_DB_NeedToTrack.Achievements or {}
Octo_ToDo_DB_NeedToTrack.Mounts = Octo_ToDo_DB_NeedToTrack.Mounts or {}
Octo_ToDo_DB_NeedToTrack.MapNames = Octo_ToDo_DB_NeedToTrack.MapNames or {}
Octo_ToDo_DB_NeedToTrack.npcNames = Octo_ToDo_DB_NeedToTrack.npcNames or {}
Octo_ToDo_DB_NeedToTrack.EventNames = Octo_ToDo_DB_NeedToTrack.EventNames or {}
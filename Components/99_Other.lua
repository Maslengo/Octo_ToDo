local GlobalAddonName, E = ...
----------------------------------------------------------------
local enable = true
local Is_WorldofWarcraft_available = E.func_Is_WorldofWarcraft_available()
----------------------------------------------------------------
if not enable then return end
if not Is_WorldofWarcraft_available then return end;
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale(E.MainAddonName)
----------------------------------------------------------------
local categoryKey = 99
-- local expansionID =
----------------------------------------------------------------
local function tempFunction()
	local OctoTables_DataOtrisovka = {}
	local OctoTables_Vibor = {}
	OctoTables_DataOtrisovka[categoryKey] = {}
	OctoTables_Vibor[categoryKey] = {}
	OctoTables_Vibor[categoryKey].icon = E.ICON_EMPTY
	OctoTables_Vibor[categoryKey].name = OTHER
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Currencies = {
		{id = 1166, defS = false,}, -- Timewarped Badge
		-- {id = 3139, defS = false,}, -- Plunder
		{id = 2032, defS = false,}, -- Trader's Tender
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
		{id = 137642, defS = false,}, -- Mark of Honor
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
	-- 	{
	-- 		sorted = false,
	-- 		TextLeft = function()
	-- 			return RAIDS..select(2, E.func_GetTimewalkingDungeon()) --.. " ("..E.func_GetEventName(1583)..")",
	-- 		end,
	-- 		showTooltip = true,
	-- 		name_save = "Raid",
	-- 		defS = false,
	-- 		reset = "Weekly",
	-- 		desc = categoryKey, -- "HolidaysTimewalk",
	-- 		quests = {
	-- 			{47523, addText = {expansionText = E.func_FormatExpansion(2, "LEFT")}}, -- 2 TBC (A Burning Path Through Time)
	-- 			{50316, addText = {expansionText = E.func_FormatExpansion(3, "LEFT")}}, -- 3 WOTLK (A Frozen Path Through Time)
	-- 			{57637, addText = {expansionText = E.func_FormatExpansion(4, "LEFT")}}, -- 4 Cataclysm (A Shattered Path Through Time)
	-- 			-- {82817}, -- Added in patch 11.0.5 "20th Anniversary Celebration"
	-- 		},
	-- 		forcedMaxQuest = 1,
	-- 	},
	-- 	{
	-- 		sorted = false,
	-- 		TextLeft = function()
	-- 			return DUNGEONS..select(2, E.func_GetTimewalkingDungeon()) --.. " ("..E.func_GetEventName(1583)..")",
	-- 		end,
	-- 		showTooltip = true,
	-- 		name_save = "Dungeons",
	-- 		defS = false,
	-- 		reset = "Weekly",
	-- 		desc = categoryKey, -- "HolidaysTimewalk",
	-- 		quests = {
	-- 			{nil, addText = {IconVignette = "VignetteKillElite"}, forcedText = {text = "Bonus Event Holiday Quests"},},
	-- 			{86731, addText = {expansionText = E.func_FormatExpansion(1, "LEFT")}}, -- 1 CLASSIC (An Original Path Through Time)
	-- 			{83363, addText = {expansionText = E.func_FormatExpansion(2, "LEFT")}}, -- 2 TBC (A Burning Path Through Time)
	-- 			{83365, addText = {expansionText = E.func_FormatExpansion(3, "LEFT")}}, -- 3 WOTLK (A Frozen Path Through Time)
	-- 			{83359, addText = {expansionText = E.func_FormatExpansion(4, "LEFT")}}, -- 4 Cataclysm (A Shattered Path Through Time)
	-- 			{83362, addText = {expansionText = E.func_FormatExpansion(5, "LEFT")}}, -- 5 PANDA (A Shrouded Path Through Time)
	-- 			{83364, addText = {expansionText = E.func_FormatExpansion(6, "LEFT")}}, -- 6 DRAENOR (A Savage Path Through Time)
	-- 			{83360, addText = {expansionText = E.func_FormatExpansion(7, "LEFT")}}, -- 7 LEGION (A Fel Path Through Time)
	-- 			{88805, addText = {expansionText = E.func_FormatExpansion(8, "LEFT")}}, -- 8 BFA (A Scarred Path Through Time)
	-- 			{92649, addText = {expansionText = E.func_FormatExpansion(9, "LEFT")}}, -- 9 SL (Темный путь сквозь время)

	-- 			{nil},
	-- 			{nil, addText = {IconVignette = "VignetteKillElite"}, forcedText = {text = "Weekend Event"},},
	-- 			-- NORMAL TIMEWALK
	-- 			{85947, addText = {expansionText = E.func_FormatExpansion(1, "LEFT")}}, -- 1 CLASSIC
	-- 			{85948, addText = {expansionText = E.func_FormatExpansion(2, "LEFT")}}, -- 2 TBC
	-- 			{85949, addText = {expansionText = E.func_FormatExpansion(3, "LEFT")}}, -- 3 WOTLK
	-- 			{86556, addText = {expansionText = E.func_FormatExpansion(4, "LEFT")}}, -- 4 Cataclysm
	-- 			{86560, addText = {expansionText = E.func_FormatExpansion(5, "LEFT")}}, -- 5 PANDA
	-- 			{86563, addText = {expansionText = E.func_FormatExpansion(6, "LEFT")}}, -- 6 DRAENOR
	-- 			{86564, addText = {expansionText = E.func_FormatExpansion(7, "LEFT")}}, -- 7 LEGION
	-- 			{88808, addText = {expansionText = E.func_FormatExpansion(8, "LEFT")}}, -- 8 BFA
	-- 			{92647, addText = {expansionText = E.func_FormatExpansion(9, "LEFT")}}, -- 9 SL
	-- 		},
	-- 		forcedMaxQuest = 2,
	-- 	},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Additionally = {
		{id = "ListOfQuests", defS = false,},
		{id = "LFGInstance", defS = true,},
		{id = "AllItems", defS = true,},
		{id = "Professions", defS = false,},
		{id = "ItemLevel", defS = true,},
		{id = "Money", defS = true,},
		{id = "WasOnline", defS = true,},
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)
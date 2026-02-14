local GlobalAddonName, E = ...
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local categoryKey = 97
----------------------------------------------------------------
local L = E.L
----------------------------------------------------------------
local function tempFunction()
	local OctoTables_DataOtrisovka = {}
	local OctoTables_Vibor = {}
	OctoTables_DataOtrisovka[categoryKey] = {}
	OctoTables_Vibor[categoryKey] = {}
	OctoTables_Vibor[categoryKey].icon = E.ICON_EMPTY
	OctoTables_Vibor[categoryKey].name = "PVP" -- PVP_OPTIONS -- BUG_CATEGORY14
	OctoTables_Vibor[categoryKey].color = E.COLOR_BLACK
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Currencies = {
		{id = 2123, defS = true,},	-- Bloody Tokens
		{id = 1602, defS = true,}, -- Conquest
		{id = 1792, defS = true,}, -- Honor
		{id = 391, defS = false,}, -- Tol Barad Commendation
		{id = 2797, defS = false,}, -- Trophy of Strife
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
		{id = 137642, defS = true,}, -- Mark of Honor
		-- {id = 215236, defS = false,}, -- Vicious Bloodstone
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
		-- {
		-- 	sorted = false,
		-- 	showTooltip = true,
		-- 	TextLeft = function()
		-- 		return E.func_GetMapName(2339)..": "..E.func_GetQuestName(47148, false)
		-- 	end,
		-- 	name_save = "SomethingDifferent",
		-- 	defS = true,
		-- 	reset = "Weekly",
		-- 	desc = categoryKey,
		-- 	quests = {
		-- 		{47148,},
		-- 	},
		-- 	forcedMaxQuest = 1,
		-- },
		-- {
		-- 	sorted = false,
		-- 	showTooltip = true,
		-- 	TextLeft = function()
		-- 		return E.func_GetMapName(2339)..": "..E.func_GetNPCName(219260) -- "Ruffious"
		-- 	end,
		-- 	name_save = "Ruffious",
		-- 	defS = true,
		-- 	reset = "Weekly",
		-- 	desc = categoryKey,
		-- 	quests = {
		-- 			{80185},
		-- 				{nil},
		-- 			{80184},
		-- 			{80189},
		-- 			{80187},
		-- 			{80188},
		-- 			{80186},
		-- 				{nil},
		-- 			{81796},
		-- 			{81794},
		-- 			{90781},
		-- 			{86853},
		-- 			{81793},
		-- 			{81795},
		-- 	},
		-- 	forcedMaxQuest = 3,
		-- },
		-- wowhead.com/ptr-2/ru/quest=90781
		-- wowhead.com/ptr-2/ru/quest=80186
		-- wowhead.com/ptr-2/ru/quest=80189
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].AdditionallyTOP = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].AdditionallyBOTTOM = {
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)
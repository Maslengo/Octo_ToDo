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
	OctoTables_Vibor[categoryKey].name = PVP -- "PVP" -- PVP_OPTIONS -- BUG_CATEGORY14
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
		{id = 219934, defS = true,}, -- Sparks of War
		{id = 137642, defS = true,}, -- Mark of Honor
		{id = 253307, defS = true,}, -- Vicious Bloodstone
		{id = 215236, defS = false,}, -- Vicious Bloodstone
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
		----------------------------------------------------------------
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("item", 219934) -- L["Sparks of War"]
			end,
			name_save = "SparksofWar",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{93423}, -- Sparks of War: Eversong Woods
				{93424}, -- Sparks of War: Zul'Aman
				{93425}, -- Sparks of War: Harandar
				{93426}, -- Sparks of War: Voidstorm
			},
			rewards = {
				-- {rewID = ЙЦУЙЦУ, rewTYPE = "spell", rewSIZE = nil,}, --
					{rewID = 232875, rewTYPE = "item", rewSIZE = 1 }, -- Spark of Radiance
				-- {rewID = 263467, rewTYPE = "item", rewSIZE = 1, addtext = "Level 90–90"}, -- Avid Learner's Supply Pack (Pinnacle Cache - Midnight Season 1)
				-- {rewID = 268487, rewTYPE = "item", rewSIZE = 1, addtext = "Level 90–90"}, -- Avid Learner's Supply Pack (Pinnacle Cache - Midnight Preseason)
				-- {rewID = 269703, rewTYPE = "item", rewSIZE = 1, addtext = "Level 80–89"}, -- Avid Learner's Supply Pack (Pinnacle Cache - Midnight Season 1)

				{rewID = 2123, rewTYPE = "currency", rewSIZE = 1000,}, -- Bloody Tokens
				{rewID = 1792, rewTYPE = "currency", rewSIZE = 500,}, -- Honor
				{rewID = 1602, rewTYPE = "currency", rewSIZE = 50,}, -- Conquest
				{rewID = 3365, rewTYPE = "currency", rewSIZE = 250,}, -- Silvermoon Court
			},
			forcedMaxQuest = 1, -- any
		},
		----------------------------------------------------------------
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("quest", 89354) -- L["Preparing for Battle"]
			end,
			name_save = "PreparingforBattle",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{89354},
			},
			rewards = {
				-- {rewID = ЙЦУЙЦУ, rewTYPE = "spell", rewSIZE = nil,}, --
					-- {rewID = 232875, rewTYPE = "item", rewSIZE = 1 }, -- Spark of Radiance
				{rewID = 2123, rewTYPE = "currency", rewSIZE = 150,}, -- Bloody Tokens
				{rewID = 1792, rewTYPE = "currency", rewSIZE = 500,}, -- Honor
				{rewID = 3410, rewTYPE = "currency", rewSIZE = 1000,}, -- Slayer's Duellum
			},
			forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("quest", 93865) -- L["Carve Your Way"]
			end,
			name_save = "CarveYourWay",
			defS = true,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{93865},
			},
			rewards = {
				-- {rewID = ЙЦУЙЦУ, rewTYPE = "spell", rewSIZE = nil,}, --
					-- {rewID = 232875, rewTYPE = "item", rewSIZE = 1 }, -- Spark of Radiance
				{rewID = 2123, rewTYPE = "currency", rewSIZE = 50,}, -- Bloody Tokens
				{rewID = 1792, rewTYPE = "currency", rewSIZE = 50,}, -- Honor
				{rewID = 3410, rewTYPE = "currency", rewSIZE = 100,}, -- Slayer's Duellum
			},
			forcedMaxQuest = 1,
		},



		-- {
		-- 	sorted = false,
		-- 	showTooltip = true,
		-- 	TextLeft = function()
		-- 		return E.func_GetName("map", 2339)..": "..L["Weekly quests"].." (PVP)"
		-- 	end,
		-- 	name_save = "WeeklyPVP",
		-- 	defS = false,
		-- 	reset = "Weekly",
		-- 	desc = categoryKey,
		-- 	quests = {
		-- 		-- {nil}, --"PvP Weekly"
		-- 		{80184},
		-- 		{80185},
		-- 		{80186},
		-- 		{80187},
		-- 		{80188},
		-- 		{80189},
		-- 		{nil},
		-- 		-- {nil}, --"World PvP Weekly"
		-- 		{81793},
		-- 		{81794},
		-- 		{81795},
		-- 		{81796},
		-- 		{86853},
		-- 		{90781},
		-- 		{nil}, -- "Brawl Weekly"
		-- 		{47148},
		-- 	},
		-- 	forcedMaxQuest = 3,
		-- },









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
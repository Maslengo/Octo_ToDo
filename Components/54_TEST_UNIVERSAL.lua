local GlobalAddonName, E = ...
----------------------------------------------------------------
if not E.DEBUG then return end
----------------------------------------------------------------
local categoryKey = 54
----------------------------------------------------------------
local L = E.L
----------------------------------------------------------------
local function tempFunction()
	local OctoTables_DataOtrisovka = {}
	local OctoTables_Vibor = {}
	OctoTables_DataOtrisovka[categoryKey] = {}
	OctoTables_Vibor[categoryKey] = {}
	OctoTables_Vibor[categoryKey].icon = E.ICON_EMPTY
	OctoTables_Vibor[categoryKey].name = "TEST_UNIVERSAL"
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Currencies = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2541)..": "..L["Treasures"]
			end,
			name_save = "arcantina_Treasures",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{79550, addText = {IconVignette = "VignetteLoot", coords = 55264393, }, forcedText = {text = L["Treasure"].." 1"}, },
				{92349, addText = {IconVignette = "VignetteLoot", coords = 44966051, }, forcedText = {text = L["Treasure"].." 2"}, },
				{92350, addText = {IconVignette = "VignetteLoot", coords = 28433959, }, forcedText = {text = L["Treasure"].." 3"}, },
				{92351, addText = {IconVignette = "VignetteLoot", coords = 18534417, }, forcedText = {text = L["Treasure"].." 4"}, },
				{92352, addText = {IconVignette = "VignetteLoot", coords = 61315823, }, forcedText = {text = L["Treasure"].." 5"}, },
				{92553, addText = {IconVignette = "VignetteLoot", coords = 39688083, }, forcedText = {text = L["Treasure"].." 6"}, },
				{92354, addText = {IconVignette = "VignetteLoot", coords = 36575489, }, forcedText = {text = L["Treasure"].." 7"}, },

				{92355, addText = {IconVignette = "VignetteLoot", coords = 61875110, }, forcedText = {text = L["Treasure"].." 8"}, },
				{92356, addText = {IconVignette = "VignetteLoot", coords = 33621257, }, forcedText = {text = L["Treasure"].." 9"}, },
				{32957, addText = {IconVignette = "VignetteLoot", coords = 74746281, }, forcedText = {text = L["Treasure"].." 10"}, },

				{92358, addText = {IconVignette = "VignetteLoot", coords = 54494478, }, forcedText = {text = L["Treasure"].." 11"}, },
				{92359, addText = {IconVignette = "VignetteLoot", coords = 42224258, }, forcedText = {text = L["Treasure"].." 12"}, },
				{92360, addText = {IconVignette = "VignetteLoot", coords = 79124579, }, forcedText = {text = L["Treasure"].." 13"}, },

				{92361, addText = {IconVignette = "VignetteLoot", coords = 35467845, }, forcedText = {text = L["Treasure"].." 14"}, },
				{92362, addText = {IconVignette = "VignetteLoot", coords = 35343007, }, forcedText = {text = L["Treasure"].." 15"}, },
				{92363, addText = {IconVignette = "VignetteLoot", coords = 68055216, }, forcedText = {text = L["Treasure"].." 16"}, },
			},
			-- forcedMaxQuest = 19,
		},

		-------------------------------------------------------------------------------
		------------------------------ THE SHADOW ENCLAVE -----------------------------
		-------------------------------------------------------------------------------

		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2502)..": "..L["Treasures"] -- The Shadow Enclave
			end,
			name_save = "delves_2502_Treasures",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{94001, addText = {IconVignette = "VignetteLoot", coords = 54598488, }, forcedText = {text = L["Treasure"].." 1"}, },
				{94002, addText = {IconVignette = "VignetteLoot", coords = 54634885, }, forcedText = {text = L["Treasure"].." 2"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10002000, }, forcedText = {text = L["Treasure"].." 3"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10003000, }, forcedText = {text = L["Treasure"].." 4"}, },
			},
			-- forcedMaxQuest = 19,
		},

		-------------------------------------------------------------------------------
		------------------------------- PARHELION PLAZA -------------------------------
		-------------------------------------------------------------------------------

		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2545)..": "..L["Treasures"]
			end,
			name_save = "delves_2545_Treasures",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10001000, }, forcedText = {text = L["Treasure"].." 1"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10002000, }, forcedText = {text = L["Treasure"].." 2"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10003000, }, forcedText = {text = L["Treasure"].." 3"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10004000, }, forcedText = {text = L["Treasure"].." 4"}, },
			},
			-- forcedMaxQuest = 19,
		},

		-------------------------------------------------------------------------------
		----------------------------- COLLEGIATE CALAMITY -----------------------------
		-------------------------------------------------------------------------------

		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2547)..": "..L["Treasures"]
			end,
			name_save = "delves_2547_Treasures",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10001000, }, forcedText = {text = L["Treasure"].." 1"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10002000, }, forcedText = {text = L["Treasure"].." 2"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10003000, }, forcedText = {text = L["Treasure"].." 3"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10004000, }, forcedText = {text = L["Treasure"].." 4"}, },
			},
			-- forcedMaxQuest = 19,
		},

		-------------------------------------------------------------------------------
		--------------------------------- THE DARKWAY ---------------------------------
		-------------------------------------------------------------------------------

		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(nil)..": "..L["Treasures"]
			end,
			name_save = "delves_nil1_Treasures",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10001000, }, forcedText = {text = L["Treasure"].." 1"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10002000, }, forcedText = {text = L["Treasure"].." 2"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10003000, }, forcedText = {text = L["Treasure"].." 3"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10004000, }, forcedText = {text = L["Treasure"].." 4"}, },
			},
			-- forcedMaxQuest = 19,
		},

		-------------------------------------------------------------------------------
		------------------------------- TWILIGHT CRYPTS -------------------------------
		-------------------------------------------------------------------------------

		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(nil)..": "..L["Treasures"]
			end,
			name_save = "delves_nil2_Treasures",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10001000, }, forcedText = {text = L["Treasure"].." 1"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10002000, }, forcedText = {text = L["Treasure"].." 2"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10003000, }, forcedText = {text = L["Treasure"].." 3"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10004000, }, forcedText = {text = L["Treasure"].." 4"}, },
			},
			-- forcedMaxQuest = 19,
		},

		-------------------------------------------------------------------------------
		-------------------------------- THE GRUDGE PIT -------------------------------
		-------------------------------------------------------------------------------

		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2510)..": "..L["Treasures"]
			end,
			name_save = "delves_2510_Treasures",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10001000, }, forcedText = {text = L["Treasure"].." 1"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10002000, }, forcedText = {text = L["Treasure"].." 2"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10003000, }, forcedText = {text = L["Treasure"].." 3"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10004000, }, forcedText = {text = L["Treasure"].." 4"}, },
			},
			-- forcedMaxQuest = 19,
		},

		-------------------------------------------------------------------------------
		------------------------------ THE GULF OF MEMORY -----------------------------
		-------------------------------------------------------------------------------

		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2505)..": "..L["Treasures"]
			end,
			name_save = "delves_2505_Treasures",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{94023, addText = {IconVignette = "VignetteLoot", coords = 54232518, }, forcedText = {text = L["Treasure"].." 1"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10002000, }, forcedText = {text = L["Treasure"].." 2"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10003000, }, forcedText = {text = L["Treasure"].." 3"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10004000, }, forcedText = {text = L["Treasure"].." 4"}, },
			},
			-- forcedMaxQuest = 19,
		},

		-------------------------------------------------------------------------------
		------------------------------ SUNKILLER SANCTUM ------------------------------
		-------------------------------------------------------------------------------

		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2528)..": "..L["Treasures"]
			end,
			name_save = "delves_2528_Treasures",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10001000, }, forcedText = {text = L["Treasure"].." 1"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10002000, }, forcedText = {text = L["Treasure"].." 2"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10003000, }, forcedText = {text = L["Treasure"].." 3"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10004000, }, forcedText = {text = L["Treasure"].." 4"}, },
			},
			-- forcedMaxQuest = 19,
		},

		-------------------------------------------------------------------------------
		------------------------------ SHADOWGUARD POINT ------------------------------
		-------------------------------------------------------------------------------

		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2506)..": "..L["Treasures"]
			end,
			name_save = "delves_2506_Treasures",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10001000, }, forcedText = {text = L["Treasure"].." 1"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10002000, }, forcedText = {text = L["Treasure"].." 2"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10003000, }, forcedText = {text = L["Treasure"].." 3"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10004000, }, forcedText = {text = L["Treasure"].." 4"}, },
			},
			-- forcedMaxQuest = 19,
		},

		-------------------------------------------------------------------------------
		---------------------------------- ATAL'AMAN ----------------------------------
		-------------------------------------------------------------------------------

		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(1)..": "..L["Treasures"] -- Placeholder map for Atal'Aman
			end,
			name_save = "atalaman_Treasures",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10001000, }, forcedText = {text = L["Treasure"].." 1"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10002000, }, forcedText = {text = L["Treasure"].." 2"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10003000, }, forcedText = {text = L["Treasure"].." 3"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 10004000, }, forcedText = {text = L["Treasure"].." 4"}, },
			},
			-- forcedMaxQuest = 19,
		},

		-------------------------------------------------------------------------------
		--------------------------------- RARES SECTION -------------------------------
		-------------------------------------------------------------------------------

		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2395)..": "..L["Rares"] -- Eversong Woods
			end,
			name_save = "eversong_woods_Rares",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{91280, addText = {IconVignette = "VignetteKill", coords = 51927380, }, forcedText = {text = L["Rare"].." 1"}, },
				{91315, addText = {IconVignette = "VignetteKill", coords = 45057825, }, forcedText = {text = L["Rare"].." 2"}, },
				{92392, addText = {IconVignette = "VignetteKill", coords = 54706018, }, forcedText = {text = L["Rare"].." 3"}, },
				{92366, addText = {IconVignette = "VignetteKill", coords = 36566408, }, forcedText = {text = L["Rare"].." 4"}, },
				{92391, addText = {IconVignette = "VignetteKill", coords = 62744907, }, forcedText = {text = L["Rare"].." 5"}, },
				{92389, addText = {IconVignette = "VignetteKill", coords = 36383637, }, forcedText = {text = L["Rare"].." 6"}, },
				{92393, addText = {IconVignette = "VignetteKill", coords = 36657718, }, forcedText = {text = L["Rare"].." 7"}, },
				{92409, addText = {IconVignette = "VignetteKill", coords = 40198539, }, forcedText = {text = L["Rare"].." 8"}, },
				{92404, addText = {IconVignette = "VignetteKill", coords = 49058775, }, forcedText = {text = L["Rare"].." 9"}, },
				{92395, addText = {IconVignette = "VignetteKill", coords = 34812098, }, forcedText = {text = L["Rare"].." 10"}, },
				{92403, addText = {IconVignette = "VignetteKill", coords = 56427760, }, forcedText = {text = L["Rare"].." 11"}, },
				{92399, addText = {IconVignette = "VignetteKill", coords = 59207920, }, forcedText = {text = L["Rare"].." 12"}, },
				{93550, addText = {IconVignette = "VignetteKill", coords = 42316891, }, forcedText = {text = L["Rare"].." 13"}, },
				{93555, addText = {IconVignette = "VignetteKill", coords = 51684599, }, forcedText = {text = L["Rare"].." 14"}, },
				{93561, addText = {IconVignette = "VignetteKill", coords = 44993855, }, forcedText = {text = L["Rare"].." 15"}, },
			},
		},

		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2413)..": "..L["Rares"] -- Harandar
			end,
			name_save = "harandar_Rares",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{91832, addText = {IconVignette = "VignetteKill", coords = 51164535, }, forcedText = {text = L["Rare"].." 1"}, },
				{92137, addText = {IconVignette = "VignetteKill", coords = 68714070, }, forcedText = {text = L["Rare"].." 2"}, },
				{92142, addText = {IconVignette = "VignetteKill", coords = 69175986, }, forcedText = {text = L["Rare"].." 3"}, },
				{92148, addText = {IconVignette = "VignetteKill", coords = 72636928, }, forcedText = {text = L["Rare"].." 4"}, },
				{92154, addText = {IconVignette = "VignetteKill", coords = 59934684, }, forcedText = {text = L["Rare"].." 5"}, },
				{92161, addText = {IconVignette = "VignetteKill", coords = 64574794, }, forcedText = {text = L["Rare"].." 6"}, },
				{92168, addText = {IconVignette = "VignetteKill", coords = 65553269, }, forcedText = {text = L["Rare"].." 7"}, },
				{92170, addText = {IconVignette = "VignetteKill", coords = 56383299, }, forcedText = {text = L["Rare"].." 8"}, },
				{92172, addText = {IconVignette = "VignetteKill", coords = 45933134, }, forcedText = {text = L["Rare"].." 9"}, },
				{92176, addText = {IconVignette = "VignetteKill", coords = 40654299, }, forcedText = {text = L["Rare"].." 10"}, },
				{92183, addText = {IconVignette = "VignetteKill", coords = 36597516, }, forcedText = {text = L["Rare"].." 11"}, },
				{92190, addText = {IconVignette = "VignetteKill", coords = 28118181, }, forcedText = {text = L["Rare"].." 12"}, },
				{92191, addText = {IconVignette = "VignetteKill", coords = 27277032, }, forcedText = {text = L["Rare"].." 13"}, },
				{92193, addText = {IconVignette = "VignetteKill", coords = 39696070, }, forcedText = {text = L["Rare"].." 14"}, },
				{92194, addText = {IconVignette = "VignetteKill", coords = 44201658, }, forcedText = {text = L["Rare"].." 15"}, },
			},
		},

		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2405)..": "..L["Rares"] -- Voidstorm
			end,
			name_save = "voidstorm_Rares",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{90805, addText = {IconVignette = "VignetteKill", coords = 29515008, }, forcedText = {text = L["Rare"].." 1"}, },
				{91050, addText = {IconVignette = "VignetteKill", coords = 34058198, }, forcedText = {text = L["Rare"].." 2"}, },
				{91048, addText = {IconVignette = "VignetteKill", coords = 36168355, }, forcedText = {text = L["Rare"].." 3"}, },
				{93966, addText = {IconVignette = "VignetteKill", coords = 43665154, }, forcedText = {text = L["Rare"].." 4"}, },
				{93946, addText = {IconVignette = "VignetteKill", coords = 47058063, }, forcedText = {text = L["Rare"].." 5"}, },
				{93944, addText = {IconVignette = "VignetteKill", coords = 39236392, }, forcedText = {text = L["Rare"].." 6"}, },
				{93947, addText = {IconVignette = "VignetteKill", coords = 37897177, }, forcedText = {text = L["Rare"].." 7"}, },
				{93934, addText = {IconVignette = "VignetteKill", coords = 55727945, }, forcedText = {text = L["Rare"].." 8"}, },
				{93895, addText = {IconVignette = "VignetteKill", coords = 48815326, }, forcedText = {text = L["Rare"].." 9"}, },
				{93953, addText = {IconVignette = "VignetteKill", coords = 46334094, }, forcedText = {text = L["Rare"].." 10"}, },
				{93884, addText = {IconVignette = "VignetteKill", coords = 35495023, }, forcedText = {text = L["Rare"].." 11"}, },
				{91047, addText = {IconVignette = "VignetteKill", coords = 39049231, }, forcedText = {text = L["Rare"].." 12"}, },
				{91051, addText = {IconVignette = "VignetteKill", coords = 40174130, }, forcedText = {text = L["Rare"].." 13"}, },
				{93896, addText = {IconVignette = "VignetteKill", coords = 53946272, }, forcedText = {text = L["Rare"].." 14"}, },
			},
		},

		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2437)..": "..L["Rares"] -- Zul'Aman
			end,
			name_save = "zulaman_Rares",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{89569, addText = {IconVignette = "VignetteKill", coords = 34413305, }, forcedText = {text = L["Rare"].." 1"}, },
				{89570, addText = {IconVignette = "VignetteKill", coords = 51801862, }, forcedText = {text = L["Rare"].." 2"}, },
				{89571, addText = {IconVignette = "VignetteKill", coords = 51857291, }, forcedText = {text = L["Rare"].." 3"}, },
				{89575, addText = {IconVignette = "VignetteKill", coords = 28952444, }, forcedText = {text = L["Rare"].." 4"}, },
				{91174, addText = {IconVignette = "VignetteKill", coords = 50876514, }, forcedText = {text = L["Rare"].." 5"}, },
				{91634, addText = {IconVignette = "VignetteKill", coords = 38994997, }, forcedText = {text = L["Rare"].." 6"}, },
				{89578, addText = {IconVignette = "VignetteKill", coords = 30484456, }, forcedText = {text = L["Rare"].." 7"}, },
				{89579, addText = {IconVignette = "VignetteKill", coords = 46295113, }, forcedText = {text = L["Rare"].." 8"}, },
				{89580, addText = {IconVignette = "VignetteKill", coords = 47773422, }, forcedText = {text = L["Rare"].." 9"}, },
				{89581, addText = {IconVignette = "VignetteKill", coords = 21307055, }, forcedText = {text = L["Rare"].." 10"}, },
				{89583, addText = {IconVignette = "VignetteKill", coords = 39402040, }, forcedText = {text = L["Rare"].." 11"}, },
				{89572, addText = {IconVignette = "VignetteKill", coords = 33718897, }, forcedText = {text = L["Rare"].." 12"}, },
				{89573, addText = {IconVignette = "VignetteKill", coords = 47682056, }, forcedText = {text = L["Rare"].." 13"}, },
				{91072, addText = {IconVignette = "VignetteKill", coords = 46394339, }, forcedText = {text = L["Rare"].." 14"}, },
				{91073, addText = {IconVignette = "VignetteKill", coords = 45294170, }, forcedText = {text = L["Rare"].." 15"}, },
			},
		},

		-------------------------------------------------------------------------------
		-------------------------------- TREASURES SECTION ----------------------------
		-------------------------------------------------------------------------------

		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2395)..": "..L["Treasures"] -- Eversong Woods Treasures
			end,
			name_save = "eversong_woods_Treasures",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{93967, addText = {IconVignette = "VignetteLoot", coords = 24346928, }, forcedText = {text = L["Treasure"].." 1"}, },
				{93456, addText = {IconVignette = "VignetteLoot", coords = 38897606, }, forcedText = {text = L["Treasure"].." 2"}, },
				{93544, addText = {IconVignette = "VignetteLoot", coords = 40961945, }, forcedText = {text = L["Treasure"].." 3"}, },
				{93893, addText = {IconVignette = "VignetteLoot", coords = 43276949, }, forcedText = {text = L["Treasure"].." 4"}, },
				{93908, addText = {IconVignette = "VignetteLoot", coords = 44614554, }, forcedText = {text = L["Treasure"].." 5"}, },
				{93455, addText = {IconVignette = "VignetteLoot", coords = 52344543, }, forcedText = {text = L["Treasure"].." 6"}, },
				{93457, addText = {IconVignette = "VignetteLoot", coords = 60686729, }, forcedText = {text = L["Treasure"].." 7"}, },
				{86645, addText = {IconVignette = "VignetteLoot", coords = 40436089, }, forcedText = {text = L["Treasure"].." 8"}, },
				{91358, addText = {IconVignette = "VignetteLoot", coords = 48737544, }, forcedText = {text = L["Treasure"].." 9"}, },
				{93458, addText = {IconVignette = "VignetteLoot", coords = 37805238, }, forcedText = {text = L["Treasure"].." 10"}, },
			},
		},

		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2413)..": "..L["Treasures"] -- Harandar Treasures
			end,
			name_save = "harandar_Treasures",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{92424, addText = {IconVignette = "VignetteLoot", coords = 71683100, }, forcedText = {text = L["Treasure"].." 1"}, },
				{92426, addText = {IconVignette = "VignetteLoot", coords = 47065025, }, forcedText = {text = L["Treasure"].." 2"}, },
				{92427, addText = {IconVignette = "VignetteLoot", coords = 73656535, }, forcedText = {text = L["Treasure"].." 3"}, },
				{92431, addText = {IconVignette = "VignetteLoot", coords = 62905124, }, forcedText = {text = L["Treasure"].." 4"}, },
				{92436, addText = {IconVignette = "VignetteLoot", coords = 55693943, }, forcedText = {text = L["Treasure"].." 5"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 20003500, }, forcedText = {text = L["Treasure"].." 6"}, },
				{93508, addText = {IconVignette = "VignetteLoot", coords = 26736759, }, forcedText = {text = L["Treasure"].." 7"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 20004500, }, forcedText = {text = L["Treasure"].." 8"}, },
				{93587, addText = {IconVignette = "VignetteLoot", coords = 40642802, }, forcedText = {text = L["Treasure"].." 9"}, },
			},
		},

		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2405)..": "..L["Treasures"] -- Voidstorm Treasures
			end,
			name_save = "voidstorm_Treasures",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{93237, addText = {IconVignette = "VignetteLoot", coords = 49947936, }, forcedText = {text = L["Treasure"].." 1"}, },
				{nil, addText = {IconVignette = "VignetteLoot", coords = 25766728, }, forcedText = {text = L["Treasure"].." 2"}, },
				{93431, addText = {IconVignette = "VignetteLoot", coords = 64537547, }, forcedText = {text = L["Treasure"].." 3"}, },
				{93840, addText = {IconVignette = "VignetteLoot", coords = 53364266, }, forcedText = {text = L["Treasure"].." 4"}, },
				{94005, addText = {IconVignette = "VignetteLoot", coords = 53133228, }, forcedText = {text = L["Treasure"].." 5"}, },
				{94454, addText = {IconVignette = "VignetteLoot", coords = 23748369, }, forcedText = {text = L["Treasure"].." 6"}, },
				{94387, addText = {IconVignette = "VignetteLoot", coords = 49052012, }, forcedText = {text = L["Treasure"].." 7"}, },
				{93553, addText = {IconVignette = "VignetteLoot", coords = 55377542, }, forcedText = {text = L["Treasure"].." 8"}, },
				{93500, addText = {IconVignette = "VignetteLoot", coords = 31504451, }, forcedText = {text = L["Treasure"].." 9"}, },
				{93569, addText = {IconVignette = "VignetteLoot", coords = 28337290, }, forcedText = {text = L["Treasure"].." 10"}, },
				{93496, addText = {IconVignette = "VignetteLoot", coords = 35774141, }, forcedText = {text = L["Treasure"].." 11"}, },
				{93493, addText = {IconVignette = "VignetteLoot", coords = 43018194, }, forcedText = {text = L["Treasure"].." 12"}, },
				{93467, addText = {IconVignette = "VignetteLoot", coords = 37696976, }, forcedText = {text = L["Treasure"].." 13"}, },
			},
		},

		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2437)..": "..L["Treasures"] -- Zul'Aman Treasures
			end,
			name_save = "zulaman_Treasures",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{nil, addText = {IconVignette = "VignetteLoot", coords = 44724409, }, forcedText = {text = L["Treasure"].." 1"}, },
				{93560, addText = {IconVignette = "VignetteLoot", coords = 46838186, }, forcedText = {text = L["Treasure"].." 2"}, },
				{93871, addText = {IconVignette = "VignetteLoot", coords = 21897738, }, forcedText = {text = L["Treasure"].." 3"}, },
				{90795, addText = {IconVignette = "VignetteLoot", coords = 20846654, }, forcedText = {text = L["Treasure"].." 4"}, },
				{90796, addText = {IconVignette = "VignetteLoot", coords = 41994779, }, forcedText = {text = L["Treasure"].." 5"}, },
				{90797, addText = {IconVignette = "VignetteLoot", coords = 52326599, }, forcedText = {text = L["Treasure"].." 6"}, },
				{90798, addText = {IconVignette = "VignetteLoot", coords = 40483595, }, forcedText = {text = L["Treasure"].." 7"}, },
				{90799, addText = {IconVignette = "VignetteLoot", coords = 42645243, }, forcedText = {text = L["Treasure"].." 8"}, },
			},
		},

		-------------------------------------------------------------------------------
		------------------------------- ACHIEVEMENTS ---------------------------------
		-------------------------------------------------------------------------------

		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return L["Achievements"]
			end,
			name_save = "midnight_Achievements",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{61081, addText = {IconVignette = "VignetteLoot", coords = 62736680, }, forcedText = {text = L["Achievement"]..": "..L["Share a Drink"]}, },
				{61960, addText = {IconVignette = "VignetteLoot", coords = 62736680, }, forcedText = {text = L["Achievement"]..": "..L["Treasures of Eversong"]}, },
				{61263, addText = {IconVignette = "VignetteLoot", coords = 62736680, }, forcedText = {text = L["Achievement"]..": "..L["Treasures of Harandar"]}, },
				{62126, addText = {IconVignette = "VignetteLoot", coords = 62736680, }, forcedText = {text = L["Achievement"]..": "..L["Treasures of Voidstorm"]}, },
				{62125, addText = {IconVignette = "VignetteLoot", coords = 62736680, }, forcedText = {text = L["Achievement"]..": "..L["Treasures of Zul'Aman"]}, },
			},
		},

		-------------------------------------------------------------------------------
		------------------------------- GLOWING MOTHS --------------------------------
		-------------------------------------------------------------------------------

		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2413)..": "..L["Glowing Moths"] -- Harandar
			end,
			name_save = "harandar_GlowingMoths",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{92196, addText = {IconVignette = "VignetteLoot", coords = 36354839, }, forcedText = {text = L["Glowing Moth"].." 1"}, },
				{92197, addText = {IconVignette = "VignetteLoot", coords = 36112639, }, forcedText = {text = L["Glowing Moth"].." 2"}, },
				{92198, addText = {IconVignette = "VignetteLoot", coords = 49882551, }, forcedText = {text = L["Glowing Moth"].." 3"}, },
				{92199, addText = {IconVignette = "VignetteLoot", coords = 55002755, }, forcedText = {text = L["Glowing Moth"].." 4"}, },
				{92200, addText = {IconVignette = "VignetteLoot", coords = 66306282, }, forcedText = {text = L["Glowing Moth"].." 5"}, },
				{92201, addText = {IconVignette = "VignetteLoot", coords = 33376349, }, forcedText = {text = L["Glowing Moth"].." 6"}, },
				{92202, addText = {IconVignette = "VignetteLoot", coords = 33377561, }, forcedText = {text = L["Glowing Moth"].." 7"}, },
				{92203, addText = {IconVignette = "VignetteLoot", coords = 31848176, }, forcedText = {text = L["Glowing Moth"].." 8"}, },
				{92204, addText = {IconVignette = "VignetteLoot", coords = 42196651, }, forcedText = {text = L["Glowing Moth"].." 9"}, },
				{92205, addText = {IconVignette = "VignetteLoot", coords = 52418078, }, forcedText = {text = L["Glowing Moth"].." 10"}, },
				{92206, addText = {IconVignette = "VignetteLoot", coords = 59445433, }, forcedText = {text = L["Glowing Moth"].." 11"}, },
				{92207, addText = {IconVignette = "VignetteLoot", coords = 38334744, }, forcedText = {text = L["Glowing Moth"].." 12"}, },
				{92208, addText = {IconVignette = "VignetteLoot", coords = 33954404, }, forcedText = {text = L["Glowing Moth"].." 13"}, },
				{92209, addText = {IconVignette = "VignetteLoot", coords = 60344858, }, forcedText = {text = L["Glowing Moth"].." 14"}, },
				{92210, addText = {IconVignette = "VignetteLoot", coords = 43215365, }, forcedText = {text = L["Glowing Moth"].." 15"}, },
				{92211, addText = {IconVignette = "VignetteLoot", coords = 30317339, }, forcedText = {text = L["Glowing Moth"].." 16"}, },
				{92212, addText = {IconVignette = "VignetteLoot", coords = 32628477, }, forcedText = {text = L["Glowing Moth"].." 17"}, },
				{92213, addText = {IconVignette = "VignetteLoot", coords = 32066708, }, forcedText = {text = L["Glowing Moth"].." 18"}, },
				{92214, addText = {IconVignette = "VignetteLoot", coords = 52935065, }, forcedText = {text = L["Glowing Moth"].." 19"}, },
				{92215, addText = {IconVignette = "VignetteLoot", coords = 71385863, }, forcedText = {text = L["Glowing Moth"].." 20"}, },
				{92219, addText = {IconVignette = "VignetteLoot", coords = 55616429, }, forcedText = {text = L["Glowing Moth"].." 21"}, },
				{92220, addText = {IconVignette = "VignetteLoot", coords = 74005723, }, forcedText = {text = L["Glowing Moth"].." 22"}, },
				{92221, addText = {IconVignette = "VignetteLoot", coords = 71715882, }, forcedText = {text = L["Glowing Moth"].." 23"}, },
				{92222, addText = {IconVignette = "VignetteLoot", coords = 60341777, }, forcedText = {text = L["Glowing Moth"].." 24"}, },
				{92223, addText = {IconVignette = "VignetteLoot", coords = 44023812, }, forcedText = {text = L["Glowing Moth"].." 25"}, },
				{92224, addText = {IconVignette = "VignetteLoot", coords = 43063945, }, forcedText = {text = L["Glowing Moth"].." 26"}, },
				{92225, addText = {IconVignette = "VignetteLoot", coords = 46382488, }, forcedText = {text = L["Glowing Moth"].." 27"}, },
				{92226, addText = {IconVignette = "VignetteLoot", coords = 62343714, }, forcedText = {text = L["Glowing Moth"].." 28"}, },
				{92227, addText = {IconVignette = "VignetteLoot", coords = 55143288, }, forcedText = {text = L["Glowing Moth"].." 29"}, },
				{92228, addText = {IconVignette = "VignetteLoot", coords = 66965657, }, forcedText = {text = L["Glowing Moth"].." 30"}, },
				{92234, addText = {IconVignette = "VignetteLoot", coords = 50266966, }, forcedText = {text = L["Glowing Moth"].." 31"}, },
				{92229, addText = {IconVignette = "VignetteLoot", coords = 53765910, }, forcedText = {text = L["Glowing Moth"].." 32"}, },
				{92230, addText = {IconVignette = "VignetteLoot", coords = 41614012, }, forcedText = {text = L["Glowing Moth"].." 33"}, },
				{92231, addText = {IconVignette = "VignetteLoot", coords = 47634696, }, forcedText = {text = L["Glowing Moth"].." 34"}, },
				{92233, addText = {IconVignette = "VignetteLoot", coords = 68693633, }, forcedText = {text = L["Glowing Moth"].." 35"}, },
				{92235, addText = {IconVignette = "VignetteLoot", coords = 49267552, }, forcedText = {text = L["Glowing Moth"].." 36"}, },
				{92236, addText = {IconVignette = "VignetteLoot", coords = 44783569, }, forcedText = {text = L["Glowing Moth"].." 37"}, },
				{92237, addText = {IconVignette = "VignetteLoot", coords = 51382032, }, forcedText = {text = L["Glowing Moth"].." 38"}, },
				{92238, addText = {IconVignette = "VignetteLoot", coords = 58673020, }, forcedText = {text = L["Glowing Moth"].." 39"}, },
				{92241, addText = {IconVignette = "VignetteLoot", coords = 41953772, }, forcedText = {text = L["Glowing Moth"].." 40"}, },
				{92242, addText = {IconVignette = "VignetteLoot", coords = 43264035, }, forcedText = {text = L["Glowing Moth"].." 41"}, },
				{92243, addText = {IconVignette = "VignetteLoot", coords = 46864847, }, forcedText = {text = L["Glowing Moth"].." 42"}, },
				{92247, addText = {IconVignette = "VignetteLoot", coords = 35897426, }, forcedText = {text = L["Glowing Moth"].." 43"}, },
				{92248, addText = {IconVignette = "VignetteLoot", coords = 30806365, }, forcedText = {text = L["Glowing Moth"].." 44"}, },
				{92251, addText = {IconVignette = "VignetteLoot", coords = 48275058, }, forcedText = {text = L["Glowing Moth"].." 45"}, },
				{92253, addText = {IconVignette = "VignetteLoot", coords = 60724540, }, forcedText = {text = L["Glowing Moth"].." 46"}, },
				{92255, addText = {IconVignette = "VignetteLoot", coords = 54493885, }, forcedText = {text = L["Glowing Moth"].." 47"}, },
				{92256, addText = {IconVignette = "VignetteLoot", coords = 36974830, }, forcedText = {text = L["Glowing Moth"].." 48"}, },
				{92257, addText = {IconVignette = "VignetteLoot", coords = 67971999, }, forcedText = {text = L["Glowing Moth"].." 49"}, },
				{92259, addText = {IconVignette = "VignetteLoot", coords = 42192226, }, forcedText = {text = L["Glowing Moth"].." 50"}, },
				{92264, addText = {IconVignette = "VignetteLoot", coords = 65305774, }, forcedText = {text = L["Glowing Moth"].." 51"}, },
				{92265, addText = {IconVignette = "VignetteLoot", coords = 41346807, }, forcedText = {text = L["Glowing Moth"].." 52"}, },
				{92266, addText = {IconVignette = "VignetteLoot", coords = 39095510, }, forcedText = {text = L["Glowing Moth"].." 53"}, },
				{92299, addText = {IconVignette = "VignetteLoot", coords = 56584765, }, forcedText = {text = L["Glowing Moth"].." 54"}, },
				{92300, addText = {IconVignette = "VignetteLoot", coords = 40443446, }, forcedText = {text = L["Glowing Moth"].." 55"}, },
				{92301, addText = {IconVignette = "VignetteLoot", coords = 41592744, }, forcedText = {text = L["Glowing Moth"].." 56"}, },
				{92302, addText = {IconVignette = "VignetteLoot", coords = 50634062, }, forcedText = {text = L["Glowing Moth"].." 57"}, },
				{92303, addText = {IconVignette = "VignetteLoot", coords = 65432712, }, forcedText = {text = L["Glowing Moth"].." 58"}, },
				{92304, addText = {IconVignette = "VignetteLoot", coords = 69033120, }, forcedText = {text = L["Glowing Moth"].." 59"}, },
				{92305, addText = {IconVignette = "VignetteLoot", coords = 59984305, }, forcedText = {text = L["Glowing Moth"].." 60"}, },
				{92306, addText = {IconVignette = "VignetteLoot", coords = 67736886, }, forcedText = {text = L["Glowing Moth"].." 61"}, },
				{92307, addText = {IconVignette = "VignetteLoot", coords = 48545535, }, forcedText = {text = L["Glowing Moth"].." 62"}, },
			},
		},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Additionally = {
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)
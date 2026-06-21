local GlobalAddonName, E = ...
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
if not E.Is_MN_available then return end;
----------------------------------------------------------------
local L = E.L
----------------------------------------------------------------
local categoryKey = 12
local expansionID = 12
----------------------------------------------------------------
local function tempFunction()
	local OctoTables_Vibor = {}
	OctoTables_Vibor[categoryKey] = {}
	OctoTables_Vibor[categoryKey].icon = E.OctoTable_Expansions[expansionID].icon
	OctoTables_Vibor[categoryKey].name = E.OctoTable_Expansions[expansionID].color .. E.OctoTable_Expansions[expansionID].nameBlizzard
	OctoTables_Vibor[categoryKey].color = E.OctoTable_Expansions[expansionID] and E.OctoTable_Expansions[expansionID].color or E.COLOR_BLACK
	----------------------------------------------------------------
	local Currencies = {
		{id = 3418, defS = true, AddedInPatch = "12.0.5.67088", }, -- Nebulous Voidcore (12.0.5 "Midnight") (3513 same, but useless)
		{id = 3405, defS = true, AddedInPatch = "12.0.5.67088", }, -- Field Accolade
		-- фиол
		{id = 3400, defS = false, AddedInPatch = "12.0.0.65390", }, -- Uncontaminated Void Sample
		{id = 3379, defS = false, AddedInPatch = "12.0.0.65390", }, -- Brimming Arcana
		{id = 3378, defS = true, AddedInPatch = "12.0.0.65390", }, -- Dawnlight Manaflux ---------> (CATALYST)
		{id = 3212, defS = false, AddedInPatch = "12.0.0.65390", }, -- Radiant Spark Dust (Midnight Season 1)
		{id = 3028, defS = false, AddedInPatch = "12.0.0.65390", }, -- Restored Coffer Key (Midnight Season 1)
		{id = 3310, defS = false, AddedInPatch = "11.2.0.62253", }, -- Coffer Key Shards
		-- https://www.wowhead.com/currencies/season-1#0+1+3
		{id = 3347, defS = true, AddedInPatch = "12.0.0.65390", }, -- Myth Dawncrest (Midnight Season 1 up to item levels 276-289)
		{id = 3345, defS = true, AddedInPatch = "12.0.0.65390", }, -- Hero Dawncrest (Midnight Season 1 up to item levels 263-276)
		{id = 3343, defS = true, AddedInPatch = "12.0.0.65390", }, -- Champion Dawncrest (Midnight Season 1 up to item levels 250-263)
		{id = 3341, defS = true, AddedInPatch = "12.0.0.65390", }, -- Veteran Dawncrest (Midnight Season 1 up to item levels 237-250)
		{id = 3383, defS = true, AddedInPatch = "12.0.0.65390", }, -- Adventurer Dawncrest (Midnight Season 1 up to item levels 224-237)
		-- {id = 3391, defS = false, AddedInPatch = "12.0.0.65390", }, -- Adventurer Dawncrest (UNUSED)
		-- синий
		{id = 3392, defS = false, AddedInPatch = "12.0.0.65390", }, -- Remnant of Anguish
		{id = 3376, defS = false, AddedInPatch = "12.0.0.65390", }, -- Shard of Dundun
		{id = 3352, defS = false, AddedInPatch = "12.0.0.65390", }, -- Party Favor
		-- зелень
		{id = 3385, defS = false, AddedInPatch = "12.0.0.65390", }, -- Luminous Dust
		{id = 3377, defS = false, AddedInPatch = "12.0.0.65390", }, -- Unalloyed Abundance
		{id = 3373, defS = false, AddedInPatch = "12.0.0.65390", }, -- Angler Pearls
		{id = 3363, defS = false, AddedInPatch = "11.2.7.64587", }, -- Community Coupons
		-- белый
		{id = 3316, defS = false, AddedInPatch = "12.0.0.65390", }, -- Voidlight Marl
		{id = 3393, defS = false, AddedInPatch = "12.0.5.67088", }, -- Illusionary Coin
		-- {id = 3349, defS = false, AddedInPatch = "12.0.0.65390", }, -- [DNT] [PH] Evergreen Initiative Currency
		{id = 3319, defS = false, AddedInPatch = "12.0.0.65390", RemovedInPatch = "12.0.1",}, -- Twilight's Blade Insignia -- MIDNIGHT PREPATCH (REMOVED)
		-- {id = 3356, defS = false, AddedInPatch = "11.2.0.62253", }, -- Untainted Mana-Crystals
		-- {id = 2803, defS = false, AddedInPatch = "11.0.0.55793", }, -- Undercoin
		-- проф
		-- {id = 3266, defS = false, AddedInPatch = "12.0.0.65390", }, -- Artisan Tailor's Moxie
		-- {id = 3265, defS = false, AddedInPatch = "12.0.0.65390", }, -- Artisan Skinner's Moxie
		-- {id = 3264, defS = false, AddedInPatch = "12.0.0.65390", }, -- Artisan Miner's Moxie
		-- {id = 3263, defS = false, AddedInPatch = "12.0.0.65390", }, -- Artisan Leatherworker's Moxie
		-- {id = 3262, defS = false, AddedInPatch = "12.0.0.65390", }, -- Artisan Jewelcrafter's Moxie
		-- {id = 3261, defS = false, AddedInPatch = "12.0.0.65390", }, -- Artisan Scribe's Moxie
		-- {id = 3260, defS = false, AddedInPatch = "12.0.0.65390", }, -- Artisan Herbalist's Moxie
		-- {id = 3259, defS = false, AddedInPatch = "12.0.0.65390", }, -- Artisan Engineer's Moxie
		-- {id = 3258, defS = false, AddedInPatch = "12.0.0.65390", }, -- Artisan Enchanter's Moxie
		-- {id = 3257, defS = false, AddedInPatch = "12.0.0.65390", }, -- Artisan Blacksmith's Moxie
		-- {id = 3256, defS = false, AddedInPatch = "12.0.0.65390", }, -- Artisan Alchemist's Moxie
	}
	----------------------------------------------------------------
	local Items = {
		{id = 232875, defS = false, AddedInPatch = "12.0.0.65390",}, -- Spark of Radiance (Midnight Season 1)
		{id = 267051, defS = false, AddedInPatch = "12.0.5.67088",}, -- Dark Particle
		{id = 265695, defS = false, AddedInPatch = "12.0.0.65390",}, -- Elementary Voidcore Shard
	}
	----------------------------------------------------------------
	local RaidsOrDungeons = {
		-- Raid
		{id = 3004, defS = true, AddedInPatch = "12.1.0",}, -- The Venomous Abyss
		{id = 2987, defS = true, AddedInPatch = "12.1.0",}, -- The Tidebound Grotto
		{id = 1592, defS = true, AddedInPatch = "12.0.7",}, -- "SPOREFALL = 1 BOSS RAID" -> 12.0.7 (summer?)
		{id = 2913, defS = true, AddedInPatch = "12.0.0.65390",}, -- March on Quel'Danas
		{id = 2912, defS = true, AddedInPatch = "12.0.0.65390",}, -- The Voidspire
		{id = 2939, defS = true, AddedInPatch = "12.0.0.65390",}, -- The Dreamrift

		-- {id = 2805, defS = true,}, -- Windrunner Spire
		-- {id = 2915, defS = true,}, -- Nexus-Point Xenas
		-- {id = 2811, defS = true,}, -- Magisters' Terrace
		-- {id = 2874, defS = true,}, -- Maisara Caverns
		-- {id = 2813, defS = true,}, -- Murder Row
		-- {id = 2825, defS = true,}, -- Den of Nalorakk
		-- {id = 2923, defS = true,}, -- Voidscar Arena
		-- {id = 2859, defS = true,}, -- The Blinding Vale
		-- {id = 1209, defS = true,}, -- Skyreach
		-- {id = 1753, defS = true,}, -- Seat of the Triumvirate
		-- {id = 2526, defS = true,}, -- Algeth'ar Academy
		-- {id = 658, defS = true,}, -- Pit of Saron
	}
	----------------------------------------------------------------
	local Reputations = {
		{id = 2792, defS = false, AddedInPatch = E.OctoTable_Reputations_DB[2792].AddedInPatch}, -- Места првоедения Ритуалов
		{id = 2710, defS = false, AddedInPatch = E.OctoTable_Reputations_DB[2710].AddedInPatch}, -- Silvermoon Court (Двор Луносвета)
		{id = 2696, defS = false, AddedInPatch = E.OctoTable_Reputations_DB[2696].AddedInPatch}, -- Amani Tribe (Племя Амани)
		{id = 2704, defS = false, AddedInPatch = E.OctoTable_Reputations_DB[2704].AddedInPatch}, -- Hara'ti (Хара'ти)
		{id = 2699, defS = false, AddedInPatch = E.OctoTable_Reputations_DB[2699].AddedInPatch}, -- The Singularity (Сингулярность)
		{id = 2770, defS = false, AddedInPatch = E.OctoTable_Reputations_DB[2770].AddedInPatch}, -- Slayer's Duellum
		{id = 2744, defS = false, AddedInPatch = E.OctoTable_Reputations_DB[2744].AddedInPatch}, -- Valeera Sanguinar
		{id = 2714, defS = false, AddedInPatch = E.OctoTable_Reputations_DB[2714].AddedInPatch}, -- Shades of the Row
		{id = 2712, defS = false, AddedInPatch = E.OctoTable_Reputations_DB[2712].AddedInPatch}, -- Blood Knights
		{id = 2711, defS = false, AddedInPatch = E.OctoTable_Reputations_DB[2711].AddedInPatch}, -- Magisters
		{id = 2713, defS = false, AddedInPatch = E.OctoTable_Reputations_DB[2713].AddedInPatch}, -- Farstriders
		{id = 2742, defS = false, AddedInPatch = E.OctoTable_Reputations_DB[2742].AddedInPatch}, -- Delves: Season 1 (C_DelvesUI.GetDelvesFactionForSeason())
		{id = 2764, defS = false, AddedInPatch = E.OctoTable_Reputations_DB[2764].AddedInPatch}, -- Prey: Season 1
		-- {id = 2722, defS = true, AddedInPatch = E.OctoTable_Reputations_DB[2722].AddedInPatch}, -- C_DelvesUI.GetDelvesFactionForSeason() для миднайта криво работает
		-- {id = 2764, defS = false, AddedInPatch = E.OctoTable_Reputations_DB[2764].AddedInPatch}, -- Preyseeker's Journey
		-- {id = 2700, defS = false, AddedInPatch = E.OctoTable_Reputations_DB[2700].AddedInPatch}, -- DEPRECATED Fungarian Fighting Ring
		-- {id = 2774, defS = false, AddedInPatch = E.OctoTable_Reputations_DB[2774].AddedInPatch}, -- Slayer's Duellum (Paragon)
		-- {id = 2727, defS = false, AddedInPatch = E.OctoTable_Reputations_DB[2727].AddedInPatch}, -- Silvermoon Court (Paragon)
		-- {id = 2726, defS = false, AddedInPatch = E.OctoTable_Reputations_DB[2726].AddedInPatch}, -- Hara'ti (Paragon)
		-- {id = 2725, defS = false, AddedInPatch = E.OctoTable_Reputations_DB[2725].AddedInPatch}, -- The Singularity (Paragon)
		-- {id = 2705, defS = false, AddedInPatch = E.OctoTable_Reputations_DB[2705].AddedInPatch}, -- Amani Tribe (Paragon)
	}
	----------------------------------------------------------------
	local UniversalQuests = {
		----------------------------------------------------------------
		-- Босс вне подземелья -----------------------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66562",
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return L["RAID_INFO_WORLD_BOSS"]
			end,
			name_save = "WorldBoss",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			questpools = {
				{
					{
						96522,
						AddedInPatch = "12.0.7.67669",
						forcedText = {npcID = 260833},
						addText = {mapID = E.MapID_Naigtal},
					},
				},
				{
					{
						92123,
						AddedInPatch = "12.0.1.66562",
						forcedText = {npcID = 244424},
						addText = {mapID = E.MapID_ZulAman},
					},
					{
						92560,
						AddedInPatch = "12.0.1.66431",
						forcedText = {npcID = 244762},
						addText = {mapID = E.MapID_EversongWoods},
					},
					{
						92636,
						AddedInPatch = "12.0.1.66384",
						forcedText = {npcID = 248864},
						addText = {mapID = E.MapID_Voidstorm},
					},
					{
						92034,
						AddedInPatch = "12.0.1.66709",
						forcedText = {npcID = 249776},
						addText = {mapID = E.MapID_Harandar},
					},
				},
			},
		},
		----------------------------------------------------------------
		-- Луносвет: Событие выходного дня ------------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66431",
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				-- return E.func_GetName("quest", 93593)
				return E.func_GetName("map", E.MapID_Silvermoon) ..": " .. L["Weekend Event"]
			end,
			name_save = "ArchmageAethasSunreaver", -- https://www.wowhead.com/npc=256212/archmage-aethas-sunreaver
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{93593, AddedInPatch = "12.0.1.66431"}, -- A Call to Battle
				-- {93611, addText = {expansionText = E.func_FormatExpansion(4, "LEFT")}}, -- 4 Cataclysm (A Shattered Path Through Time)
				{93611, AddedInPatch = "12.0.1.66709"}, -- 4 Cataclysm (A Shattered Path Through Time)
				{93595, AddedInPatch = "12.0.1.66562"}, -- A Call to Delves
				{93598, AddedInPatch = "12.0.1.66838"}, -- Emissary of War
				{93600, AddedInPatch = "12.0.1.66838"}, -- The Arena Calls
				{93605, AddedInPatch = "12.0.5.67186"}, -- The World Awaits
			},
			rewards = {
				-- {rewID = ЙЦУЙЦУ, rewTYPE = "spell", rewSIZE = nil,}, --
				{rewID = 250117, rewTYPE = "item", rewSIZE = 1 }, -- Cache of Quel'Thalas Treasures
				-- {rewID = 2123, rewTYPE = "currency", rewSIZE = 50,}, -- Bloody Tokens
				-- {rewID = 1792, rewTYPE = "currency", rewSIZE = 50,}, -- Honor
				-- {rewID = 3410, rewTYPE = "currency", rewSIZE = 100,}, -- Slayer's Duellum
			},
			forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
		-- Луносвет: Кошмарное дело -------------------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66431",
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("map", E.MapID_Silvermoon) ..": " ..E.func_GetName("quest", 94446) -- A Nightmarish Task
			end,
			name_save = "ANightmarishTask",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{94446, AddedInPatch = "12.0.1.66431"},
			},
			rewards = {
				{rewID = 253342, rewTYPE = "item", rewSIZE = 1,},
				{rewID = 3316, rewTYPE = "currency", rewSIZE = 500,}, --
				{rewID = 3345, rewTYPE = "currency", rewSIZE = 20,}, --
				{rewID = 3346, rewTYPE = "currency", rewSIZE = 20,}, --
				{rewID = 3392, rewTYPE = "currency", rewSIZE = 50,}, --
			},
			forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
		-- Луносвет: Добыча: предпочтительная жертва ---------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66431",
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("map", E.MapID_Silvermoon) .. ": " .. E.func_GetName("quest", 91277) -- Prey: Preferential Killing
			end,
			name_save = "PreyPreferentialKilling",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{91277, AddedInPatch = "12.0.1.66431"},
			},
			-- rewards = {
			-- -- {rewID = ЙЦУЙЦУ, rewTYPE = "spell", rewSIZE = nil,}, --
			-- -- {rewID = 263037, rewTYPE = "item", rewSIZE = 1 }, --
			-- -- {rewID = 263467, rewTYPE = "item", rewSIZE = 1, addText = "Level 90–90"}, -- Avid Learner's Supply Pack (Pinnacle Cache - Midnight Season 1)
			-- {rewID = 3310, rewTYPE = "currency", rewSIZE = 25,}, -- Coffer Key Shards
			-- {rewID = 3316, rewTYPE = "currency", rewSIZE = 50,}, -- Voidlight Marl
			-- {rewID = 3370, rewTYPE = "currency", rewSIZE = 250,}, -- The Amani Tribe
			-- {rewID = 3383, rewTYPE = "currency", rewSIZE = 10,}, -- Adventurer Dawncrest
			-- },
			-- forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
		--Буря Бездны: Туманный сердечник Бездны -----------------------
		----------------------------------------------------------------
		-- {
		-- AddedInPatch = "12.0.5.67088",
		-- sorted = true,
		-- showTooltip = true,
		-- TextLeft = function()
		-- return E.func_GetName("map", E.MapID_Voidstorm) .. ": " .. E.func_GetName("currency", 3418, E.COLOR_WHITE) -- A Nightmarish Task
		-- end,
		-- name_save = "NebulousVoidcoresCoins",
		-- defS = true,
		-- reset = "Weekly",
		-- desc = categoryKey,
		-- quests = {
		-- {95279, AddedInPatch = "12.0.5.67088"}, -- Nebulous Voidcores: Gold
		-- {95304, AddedInPatch = "12.0.5.67088"}, -- Nebulous Voidcores: Veteran Dawncrest
		-- {95290, AddedInPatch = "12.0.5.67088"}, -- Nebulous Voidcores: Voidlight Marl
		-- },
		-- rewards = {
		-- {rewID = 3418, rewTYPE = "currency", rewSIZE = 2,}, -- Nebulous Voidcore
		-- -- {rewID = 3316, rewTYPE = "currency", rewSIZE = 150,}, -- Voidlight Marl
		-- -- {rewID = 3318, rewTYPE = "currency", rewSIZE = 1500,}, -- Delver's Journey
		-- -- {rewID = 1262418, rewTYPE = "spell", rewSIZE = nil,}, -- Spark of Radiance
		-- -- {rewID = 268490, rewTYPE = "item", rewSIZE = 1,}, -- Apex Cache (Pinnacle Cache - Midnight Season 1)
		-- -- {rewID = 254677, rewTYPE = "item", rewSIZE = 1,}, -- Apex Cache (Pinnacle Cache - Midnight Preseason)
		-- },
		-- forcedMaxQuest = 1,
		-- },
		----------------------------------------------------------------
		-- Midnight: Метазадания ---------------------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1",
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return L["Midnight: Meta Quests"] -- https://www.wowhead.com/npc=256203/lady-liadrin
			end,
			name_save = "MidnightMetaQuest",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				-- https://wago.tools/db2/QuestLabel?filter%5BLabelID%5D = 6072&page = 1
				{93766, AddedInPatch = "12.0.1.66220"}, -- Midnight: World Quests
				{93767, AddedInPatch = "12.0.1.66220"}, -- Midnight: Arcantina
				{93769, AddedInPatch = "12.0.1.66220"}, -- Midnight: Housing
				{93889, AddedInPatch = "12.0.1.66220"}, -- Midnight: Saltheril's Soiree
				{93890, AddedInPatch = "12.0.1.66220"}, -- Midnight: Abundance (https://www.wowhead.com/npc=240279/magovu)
				-- {93891, AddedInPatch = "12.0.1.66220"}, -- Midnight: Legends of the Haranir (REMOVED)
				{93892, AddedInPatch = "12.0.1.66220"}, -- Midnight: Stormarion Assault
				{93909, AddedInPatch = "12.0.1.66220"}, -- Midnight: Delves
				{93910, AddedInPatch = "12.0.1.66220"}, -- Midnight: Prey
				{93911, AddedInPatch = "12.0.1.66220"}, -- Midnight: Dungeons
				{93912, AddedInPatch = "12.0.1.66220"}, -- Midnight: Raid
				{93913, AddedInPatch = "12.0.1.66220"}, -- Midnight: World Boss
				{94457, AddedInPatch = "12.0.1.66220"}, -- Midnight: Battlegrounds
				{95842, AddedInPatch = "12.0.5.67088"}, -- Midnight: Void Assaults
				{95843, AddedInPatch = "12.0.5.67088"}, -- Midnight: Ritual Sites
				{96727, AddedInPatch = "12.0.7.67227"}, -- Midnight: Offworld Showdowns
			},
			rewards = {
				-- {rewID = 2803, rewTYPE = "currency", rewSIZE = 750,}, -- Undercoin
				-- {rewID = 3316, rewTYPE = "currency", rewSIZE = 150,}, -- Voidlight Marl
				-- {rewID = 3318, rewTYPE = "currency", rewSIZE = 1500,}, -- Delver's Journey
				{rewID = 1262418, rewTYPE = "spell", rewSIZE = nil,}, -- Spark of Radiance
				{rewID = 268490, rewTYPE = "item", rewSIZE = 1,}, -- Apex Cache (Pinnacle Cache - Midnight Season 1)
				-- {rewID = 254677, rewTYPE = "item", rewSIZE = 1,}, -- Apex Cache (Pinnacle Cache - Midnight Preseason)
			},
			forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
		-- Вылазки: Зов вылазок ----------------------------------------
		----------------------------------------------------------------
		-- {
		-- AddedInPatch = "12.0.1.66562",
		-- sorted = true,
		-- showTooltip = true,
		-- TextLeft = function()
		-- return L["DELVES_LABEL"] .. ": " .. E.func_GetName("quest", 93595)
		-- end,
		-- name_save = "ACalltoDelves",
		-- defS = true,
		-- reset = "Weekly",
		-- desc = categoryKey,
		-- quests = {
		-- {93595},
		-- },
		-- -- rewards = {
		-- -- {rewID = ЙЦУЙЦУ, rewTYPE = "spell", rewSIZE = nil,}, --
		-- -- {rewID = 137642, rewTYPE = "item", rewSIZE = 1 }, -- Mark of Honor
		-- -- {rewID = 2123, rewTYPE = "currency", rewSIZE = 50,}, -- Bloody Tokens
		-- -- {rewID = 1792, rewTYPE = "currency", rewSIZE = 50,}, -- Honor
		-- -- {rewID = 3410, rewTYPE = "currency", rewSIZE = 100,}, -- Slayer's Duellum
		-- -- },
		-- forcedMaxQuest = 1,
		-- },
		----------------------------------------------------------------
		-- "DELVES_LABEL: Трофей охотника за сокровищами" --------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.0", -- SEASON 1
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				-- TWW S2: 233071 (Клад участника вылазки) L["Delver's Bounty"]
				-- TWW S3: 248142 (Клад участника вылазки) L["Delver's Bounty"] -- This item can be fished in Excavation Site 9
				-- Mid S1: 252415 (Трофей охотника за сокровищами)
				return L["DELVES_LABEL"] .. ": " .. E.func_GetName("item", 252415, 1)
			end,
			name_save = "DelversBountySeason1",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				-- {86371, forcedText = {text = E.func_texturefromIcon(E.func_GetIcon("item", 252415)) .. E.func_GetName("item", 252415)},},
				{86371, forcedText = {itemID = 252415}, addText = {text = E.COLOR_GREEN .. " (" .. format(L["EXPANSION_SEASON_NAME"], "Midnight", 1) .. ")|r"} },
			},
			rewards = {
				-- {rewID = 2803, rewTYPE = "currency", rewSIZE = 750,}, -- Undercoin
				-- {rewID = 3316, rewTYPE = "currency", rewSIZE = 150,}, -- Voidlight Marl
				-- {rewID = 3318, rewTYPE = "currency", rewSIZE = 1500,}, -- Delver's Journey
				-- {rewID = 1262418, rewTYPE = "spell", rewSIZE = nil,}, -- Spark of Radiance
				{rewID = 252415, rewTYPE = "item", rewSIZE = 1,}, -- Apex Cache (Pinnacle Cache - Midnight Season 1)
				-- {rewID = 254677, rewTYPE = "item", rewSIZE = 1,}, -- Apex Cache (Pinnacle Cache - Midnight Preseason)
			},
			forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
		-- Натиски Бездны ----------------------------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.5.67088",
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return L["Void Assaults"]
			end,
			name_save = "VoidAssaults",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{94385, AddedInPatch = "12.0.5.67186"}, -- Added in patch 12.0.5 "Midnight" (12.0.5.66330)
				{94386, AddedInPatch = "12.0.5.67088"}, -- Added in patch 12.0.5 "Midnight" (12.0.5.66330)
				-- {nil, addText = {mapID = E.MapID_Silvermoon},}, -- Void Assaults: Silvermoon City
				-- {94385, addText = {mapID = E.MapID_EversongWoods},}, -- Void Assaults: Eversong Woods
				-- {94386, addText = {mapID = E.MapID_ZulAman},}, -- Void Assaults: Zul'Aman
				-- {nil, addText = {mapID = E.MapID_Harandar},}, -- Void Assaults: Harandar
				-- {nil, addText = {mapID = E.MapID_Voidstorm},}, -- Void Assaults: Voidstorm
				-- {nil, addText = {mapID = E.MapID_IsleOfQuelDanas},}, -- Void Assaults: Isle of Quel'Danas
			},
			rewards = {
				-- {rewID = 2803, rewTYPE = "currency", rewSIZE = 750,}, -- Undercoin
				-- {rewID = 3316, rewTYPE = "currency", rewSIZE = 150,}, -- Voidlight Marl
				-- {rewID = 3318, rewTYPE = "currency", rewSIZE = 1500,}, -- Delver's Journey
				-- {rewID = 1262418, rewTYPE = "spell", rewSIZE = nil,}, -- Spark of Radiance
				{rewID = 264914, rewTYPE = "item", rewSIZE = 1,}, -- Ranger's Cache
				{rewID = 272125, rewTYPE = "item", rewSIZE = 1,}, -- Recruit's Cache
				-- {rewID = 254677, rewTYPE = "item", rewSIZE = 1,}, -- Apex Cache (Pinnacle Cache - Midnight Preseason)
			},
			forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
		-- Вылазки: Ненасытная бездна любопытства ----------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.0.65560",
			isAccount = true,
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return L["DELVES_LABEL"] .. ": " .. E.func_GetName("quest", 93784) -- A Gnawing Void of Curiosity
			end,
			name_save = "AGnawingVoidofCuriosity",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{93784},
			},
			rewards = {
				{rewID = 2803, rewTYPE = "currency", rewSIZE = 750,}, -- Undercoin
				{rewID = 3316, rewTYPE = "currency", rewSIZE = 150,}, -- Voidlight Marl
				{rewID = 3318, rewTYPE = "currency", rewSIZE = 1500,}, -- Delver's Journey
				-- {rewID = 264248, rewTYPE = "item", rewSIZE = 1500,}, --
				-- {rewID = 157980, rewTYPE = "spell", rewSIZE = 1500,}, --
			},
			forcedMaxQuest = 1, -- any
		},
		----------------------------------------------------------------
		-- Вылазки: Вызов в вылазку ------------------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66102",
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return L["DELVES_LABEL"] .. ": " .. L["Delver's Call"]
			end,
			name_save = "DelversCallMID",
			defS = false,
			reset = "Normal",
			desc = categoryKey,
			-- https://www.wowhead.com/quest=93385/delvers-call-the-darkway#comments
			quests = {
				{nil, addText = {mapID = E.MapID_Silvermoon},}, -- Silvermoon City
				{93384}, -- Delver's Call: Collegiate Calamity (Вызов в вылазку: Общая Беда)
				{93385}, -- Delver's Call: The Darkway (Вызов в вылазку: катакомбы тьмы)
				{nil},
				{nil, addText = {mapID = E.MapID_EversongWoods},}, -- Eversong Woods
				{93372}, -- Delver's Call: Shadow Enclave (Вызов в вылазку: анклав Теней)
				{nil},
				{nil, addText = {mapID = E.MapID_ZulAman},}, -- Zul'Aman
				{93409}, -- Delver's Call: Atal'Aman (Вызов в вылазку: Атал'Аман)
				{93410}, -- Delver's Call: Twilight Crypts (Вызов в вылазку: Сумеречные склепы)
				{nil},
				{nil, addText = {mapID = E.MapID_Harandar},}, -- Harandar
				{93416}, -- Delver's Call: The Gulf of Memory (Вызов в вылазку: Залив воспоминаний)
				{93421}, -- Delver's Call: The Grudge Pit (Вызов в вылазку: Грызальня)
				{nil},
				{nil, addText = {mapID = E.MapID_Voidstorm},}, -- Voidstorm
				{93427}, -- Delver's Call: Sunkiller Sanctum (Вызов в вылазку: святилище Солнцеубийцы)
				{93428}, -- Delver's Call: Shadowguard Point (Вызов в вылазку: форпост Темной Стражи)
				{nil},
				{nil, addText = {mapID = E.MapID_IsleOfQuelDanas},}, -- Isle of Quel'Danas
				{93386}, -- Delver's Call: Parhelion Plaza (Вызов в вылазку: Площадь Паргелия)
			},
			-- rewards = {
			-- {rewID = 1239744, rewTYPE = "spell", rewSIZE = nil,}, --
			-- {rewID = 232049, rewTYPE = "item", rewSIZE = nil, addText = ""}, -- Pinnacle Cache
			-- {rewID = 2815, rewTYPE = "currency", rewSIZE = 100,}, -- Resonance Crystals
			-- {rewID = 3278, rewTYPE = "currency", rewSIZE = nil,}, -- Ethereal Strands
			-- },
			-- forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
		-- Найтал: Противостояние в Найтале ----------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.7.67360",
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("map", E.MapID_Naigtal) .. ": " .. E.func_GetName("quest", 96720) -- Showdown on Naigtal
			end,
			name_save = "ShowdownonNaigtal",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			-- questpools = {
			-- 	{
			-- 		{96717, AddedInPatch = "12.0.7.67360",},
			-- 		{96718, AddedInPatch = "12.0.7.67360",}, -- (HEROIC)
			-- 	},
			-- },
			quests = {
				-- {96720, AddedInPatch = "12.0.7.67669",},
				{96717, AddedInPatch = "12.0.7.67360",},
				{96718, AddedInPatch = "12.0.7.67360",}, -- (HEROIC)
			},
			rewards = {
				-- {rewID = ЙЦУЙЦУ, rewTYPE = "currency", rewSIZE = nil,}, --
				-- {rewID = ЙЦУЙЦУ, rewTYPE = "spell", rewSIZE = nil,}, --
				{rewID = 275691, rewTYPE = "item", rewSIZE = 1,}, -- Saltheril's Favor
			},
			-- forcedMaxQuest = 2, -- ???
		},
		----------------------------------------------------------------
		-- Двор Луносвета: Благосклонность Двора -----------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66198",
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("reputation", 2710) .. ": " .. E.func_GetName("quest", 89289) -- Favor of the Court
			end,
			name_save = "FavoroftheCourt",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{89289},
			},
			rewards = {
				-- {rewID = ЙЦУЙЦУ, rewTYPE = "currency", rewSIZE = nil,}, --
				-- {rewID = ЙЦУЙЦУ, rewTYPE = "spell", rewSIZE = nil,}, --
				{rewID = 238987, rewTYPE = "item", rewSIZE = 1,}, -- Saltheril's Favor
			},
			forcedMaxQuest = 1, -- any
		},
		----------------------------------------------------------------
		-- Двор Луносвета: Укрепление рунических камней ----------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66198",
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("reputation", 2710) .. ": " .. L["Fortify the Runestones"]
			end,
			name_save = "FortifytheRunestones",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{90573},
				{90574},
				{90575},
				{90576},
			},
			rewards = {
				-- {rewID = ЙЦУЙЦУ, rewTYPE = "spell", rewSIZE = nil,}, --
				{rewID = 263465, rewTYPE = "item", rewSIZE = 1, addText = "Level 90–90"}, -- Surplus Bag of Party Favors (Pinnacle Cache - Midnight Season 1)
				-- {rewID = 268489, rewTYPE = "item", rewSIZE = 1, addText = "Level 90–90"}, -- Surplus Bag of Party Favors (Pinnacle Cache - Midnight Preseason)
				-- {rewID = 269701, rewTYPE = "item", rewSIZE = 1, addText = "Level 80–89"}, -- Surplus Bag of Party Favors (Pinnacle Cache - Midnight Season 1)
				{rewID = 3316, rewTYPE = "currency", rewSIZE = 200,}, -- Silvermoon Court
				{rewID = 3365, rewTYPE = "currency", rewSIZE = 2000,}, -- Silvermoon Court
				{rewID = 3379, rewTYPE = "currency", rewSIZE = 275,}, -- Brimming Arcana
			},
			forcedMaxQuest = 1, -- any
		},
		----------------------------------------------------------------
		-- Двор Луносвета: Многообещающая вылазка ----------------------
		----------------------------------------------------------------
		{
			isAccount = true,
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("reputation", 2710) .. ": " .. L["Bountiful Delve"] .. E.func_texturefromIcon("questlog-questtypeicon-Delves")
			end,
			name_save = "BountifulDelve2710",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{93821, forcedText = {text = L["Bountiful Delve"] .. E.func_texturefromIcon("questlog-questtypeicon-Delves")},},
			},
			forcedMaxQuest = 1, -- any
		},
		----------------------------------------------------------------
		-- Племя Амани: Изобильные подношения --------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66102",
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("reputation", 2696) .. ": " .. E.func_GetName("quest", 89507) -- Abundant Offerings
			end,
			name_save = "AbundantOfferings",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{89507},
			},
			rewards = {
				-- {rewID = ЙЦУЙЦУ, rewTYPE = "spell", rewSIZE = nil,}, --
				{rewID = 263466, rewTYPE = "item", rewSIZE = 1, addText = "Level 90–90"}, -- Overflowing Abundant Satchel (Pinnacle Cache - Midnight Season 1)
				-- {rewID = 268488, rewTYPE = "item", rewSIZE = 1, addText = "Level 90–90"}, -- Overflowing Abundant Satchel (Pinnacle Cache - Midnight Preseason)
				-- {rewID = 269702, rewTYPE = "item", rewSIZE = 1, addText = "Level 80–89"}, -- Overflowing Abundant Satchel (Pinnacle Cache - Midnight Season 1)
				{rewID = 3310, rewTYPE = "currency", rewSIZE = 50,}, -- Coffer Key Shards
				{rewID = 3316, rewTYPE = "currency", rewSIZE = 200,}, -- Voidlight Marl
				{rewID = 3354, rewTYPE = "currency", rewSIZE = 2000,}, -- The Amani Tribe
			},
			forcedMaxQuest = 1, -- any
		},
		----------------------------------------------------------------
		-- Племя Амани: Многообещающая вылазка -------------------------
		----------------------------------------------------------------
		{
			isAccount = true,
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("reputation", 2696) .. ": " .. L["Bountiful Delve"] .. E.func_texturefromIcon("questlog-questtypeicon-Delves")
			end,
			name_save = "BountifulDelve2696",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{93819, forcedText = {text = L["Bountiful Delve"] .. E.func_texturefromIcon("questlog-questtypeicon-Delves")},},
			},
			forcedMaxQuest = 1, -- any
		},
		----------------------------------------------------------------
		-- Хара'ти: Утраченные легенды ---------------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66220",
			isAccount = true,
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("reputation", 2704) .. ": " .. E.func_GetName("quest", 89268)
			end,
			name_save = "LostLegends",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{89268}, -- Lost Legends
				{nil,},
				{88993}, -- Wey'nan's Ward
				{88994}, -- The Cauldron of Echoes
				{88996}, -- The Echoless Flame
				{88997}, -- Russula's Outreach
				{88995}, -- Aln'hara's Bloom
			},
			rewards = {
				{rewID = 1281792, rewTYPE = "spell", rewSIZE = nil,}, --
				-- {rewID = 263466, rewTYPE = "item", rewSIZE = 1, addText = "Level 90–90"}, --
				-- {rewID = 3310, rewTYPE = "currency", rewSIZE = 50,}, --
			},
			forcedMaxQuest = 2,
		},
		----------------------------------------------------------------
		-- Хара'ти: Восстановленные отголоски --------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66192",
			isAccount = true,
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("reputation", 2704) .. ": " .. E.func_GetName("quest", 92713) -- Echoes Rekindled
			end,
			name_save = "EchoesRekindled",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{92713}, -- Echoes Rekindled
				{nil,},
				{92716}, -- The Story of Wey'nan's Ward
				{92719}, -- The Story of the Cauldron of Echoes
				{92721}, -- The Story of the Echoless Flame
				{92720}, -- The Story of Aln'hara's Bloom
				{92722}, -- The Story of Russula's Outreach
				{92724}, -- The Story of the Root of the World
				{92725}, -- The Story of Sky's Hope
			},
			-- rewards = {
			-- {rewID = 1281792, rewTYPE = "spell", rewSIZE = nil,}, --
			-- -- {rewID = 263466, rewTYPE = "item", rewSIZE = 1, addText = "Level 90–90"}, --
			-- -- {rewID = 3310, rewTYPE = "currency", rewSIZE = 50,}, --
			-- },
			forcedMaxQuest = 2,
		},
		----------------------------------------------------------------
		-- Хара'ти: Легенды хараниров ----------------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66220",
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("reputation", 2704) .. ": " .. L["Legends of the Haranir"]
			end,
			name_save = "LegendsoftheHaranir",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{88993, AddedInPatch = "12.0.1.66220",}, -- Wey'nan's Ward (item=263037/replica-weynans-ward)
				{88994, AddedInPatch = "12.0.1.66220",}, -- The Cauldron of Echoes (item=263315/bubbling-haranir-cauldron)
				{88995, AddedInPatch = "12.0.1.66220",}, -- Aln'hara's Bloom (item=263196/harandar-glowvine-lantern)
				{88996, AddedInPatch = "12.0.1.66220",}, -- The Echoless Flame (https://www.wowhead.com/item=264262/haranir-whistling-arrow)
				{88997, AddedInPatch = "12.0.1.66220",}, -- Russula's Outreach (item=262906/harandar-anvil)
				{88998, AddedInPatch = "12.0.1.66337",}, -- Root of the World
				{88999, AddedInPatch = "12.0.1.66431",}, -- Sky's Hope
			},
			rewards = {
				-- {rewID = ЙЦУЙЦУ, rewTYPE = "spell", rewSIZE = nil,}, --
				-- {rewID = 263037, rewTYPE = "item", rewSIZE = 1 }, --
				{rewID = 263467, rewTYPE = "item", rewSIZE = 1, addText = "Level 90–90"}, -- Avid Learner's Supply Pack (Pinnacle Cache - Midnight Season 1)
				-- {rewID = 268487, rewTYPE = "item", rewSIZE = 1, addText = "Level 90–90"}, -- Avid Learner's Supply Pack (Pinnacle Cache - Midnight Preseason)
				-- {rewID = 269703, rewTYPE = "item", rewSIZE = 1, addText = "Level 80–89"}, -- Avid Learner's Supply Pack (Pinnacle Cache - Midnight Season 1)
				{rewID = 3316, rewTYPE = "currency", rewSIZE = 100,}, -- Voidlight Marl
				{rewID = 3370, rewTYPE = "currency", rewSIZE = 1000,}, -- The Amani Tribe
			},
			forcedMaxQuest = 1, -- any
		},
		----------------------------------------------------------------
		-- Хара'ти: РАЗЫСКИВАЕТСЯ --------------------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66102",
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("reputation", 2704) .. ": " .. L["WANTED"] -- E.func_GetName("map", E.MapID_Harandar) .. ": " ..
			end,
			name_save = "HarandarDailyWanted",
			defS = false,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{91970, AddedInPatch = "12.0.1.66102",}, -- WANTED: Gelatonius
				{91980, AddedInPatch = "12.0.1.66102",}, -- WANTED: Hellebora's Thorn
				{91982, AddedInPatch = "12.0.1.66192",}, -- WANTED: Toadshade's Petals
				{91998, AddedInPatch = "12.0.1.66192",}, -- WANTED: Muckmire's Choking Vines
				{92010, AddedInPatch = "12.0.1.66102",}, -- WANTED: Slewstalk's Stalks
				{92012, AddedInPatch = "12.0.1.66198",}, -- WANTED: Gorebarb's Pincers
				{92013, AddedInPatch = "12.0.1.66220",}, -- WANTED: Dionaea's Thorntusks
			},
			rewards = {
				-- {rewID = ЙЦУЙЦУ, rewTYPE = "spell", rewSIZE = nil,}, --
				-- {rewID = 263037, rewTYPE = "item", rewSIZE = 1 }, --
				-- {rewID = 263467, rewTYPE = "item", rewSIZE = 1, addText = "Level 90–90"}, -- Avid Learner's Supply Pack (Pinnacle Cache - Midnight Season 1)
				-- {rewID = 268487, rewTYPE = "item", rewSIZE = 1, addText = "Level 90–90"}, -- Avid Learner's Supply Pack (Pinnacle Cache - Midnight Preseason)
				-- {rewID = 269703, rewTYPE = "item", rewSIZE = 1, addText = "Level 80–89"}, -- Avid Learner's Supply Pack (Pinnacle Cache - Midnight Season 1)
				{rewID = 3310, rewTYPE = "currency", rewSIZE = 25,}, -- Coffer Key Shards
				{rewID = 3316, rewTYPE = "currency", rewSIZE = 50,}, -- Voidlight Marl
				{rewID = 3370, rewTYPE = "currency", rewSIZE = 250,}, -- The Amani Tribe
				{rewID = 3383, rewTYPE = "currency", rewSIZE = 10,}, -- Adventurer Dawncrest
			},
			forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
		-- Хара'ти: Многообещающая вылазка -----------------------------
		----------------------------------------------------------------
		{
			isAccount = true,
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("reputation", 2704) .. ": " .. L["Bountiful Delve"] .. E.func_texturefromIcon("questlog-questtypeicon-Delves")
			end,
			name_save = "BountifulDelve2704",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{93822, forcedText = {text = L["Bountiful Delve"] .. E.func_texturefromIcon("questlog-questtypeicon-Delves")},},
			},
			forcedMaxQuest = 1, -- any
		},
		----------------------------------------------------------------
		-- Сингулярность: Задания --------------------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66102",
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("reputation", 2699) .. ": " .. L["QUESTS_LABEL"]
			end,
			name_save = "TheSingularityQuests",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{90962, AddedInPatch = "12.0.1.66102",}, -- StormarionAssault

				{94581, AddedInPatch = "12.0.1.66102",}, -- StandYourGround

				{91700, AddedInPatch = "12.0.1.66102",}, -- DarknessUnmade (L["REWARD"]: item=246951)
				{86810, AddedInPatch = "12.0.1.66102",}, -- HarvestingtheVoid (L["REWARD"]: item=246951)
				{92407, AddedInPatch = "12.0.1.66220",}, -- HideyHole (L["REWARD"]: item=246951)
			},
			-- forcedMaxQuest = 5,
		},
		----------------------------------------------------------------
		-- Сингулярность: Многообещающая вылазка -----------------------
		----------------------------------------------------------------
		{
			isAccount = true,
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("reputation", 2699) .. ": " .. L["Bountiful Delve"] .. E.func_texturefromIcon("questlog-questtypeicon-Delves")
			end,
			name_save = "BountifulDelve2699",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{93820, forcedText = {text = L["Bountiful Delve"] .. E.func_texturefromIcon("questlog-questtypeicon-Delves")},},
			},
			forcedMaxQuest = 1, -- any
		},
		----------------------------------------------------------------
		-- Особое поручение --------------------------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66220",
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return L["Special Assignment"]
			end,
			name_save = "SpecialAssignments",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				-- https://wago.tools/db2/QuestV2CliTask?filter%5BField_12_0_5_66330_001_lang%5D = Special%20Assignment&page = 1
				{91390, AddedInPatch = "12.0.1.66220",}, -- Special Assignment: What Remains of a Temple Broken
				{91796, AddedInPatch = "12.0.1.66562",}, -- Special Assignment: Ours Once More!
				{92063, AddedInPatch = "12.0.1.66431",}, -- Special Assignment: A Hunter's Regret
				{92139, AddedInPatch = "12.0.1.66384",}, -- Special Assignment: Shade and Claw
				{92145, AddedInPatch = "12.0.1.66527",}, -- Special Assignment: The Grand Magister's Drink
				{93013, AddedInPatch = "12.0.1.66263",}, -- Special Assignment: Push Back the Light
				{93244, AddedInPatch = "12.0.1.66263",}, -- Special Assignment: Agents of the Shield
				{93438, AddedInPatch = "12.0.1.66220",}, -- Special Assignment: Precision Excision
			},
			forcedMaxQuest = 2,
		},
		----------------------------------------------------------------
		-- Задания: Подземелья -----------------------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1",
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return L["QUESTS_LABEL"] .. ": " .. L["DUNGEONS"] -- L["Dungeon Quest"]
			end,
			name_save = "DungeonQuest",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				-- https://wago.tools/db2/QuestLabel?filter%5BLabelID%5D = 4887&page = 1
				{93751, AddedInPatch = "12.0.1.66838",}, -- Windrunner Spire
				{93752, AddedInPatch = "12.0.1.66220",}, -- Murder Row
				{93753, AddedInPatch = "12.0.1.66220",}, -- Magisters' Terrace
				{93754, AddedInPatch = "12.0.1.66263",}, -- Maisara Caverns
				{93755, AddedInPatch = "12.0.1.66431",}, -- Den of Nalorakk
				{93756, AddedInPatch = "12.0.1.66562",}, -- The Blinding Vale
				{93757, AddedInPatch = "12.0.1.66709",}, -- Voidscar Arena
				{93758, AddedInPatch = "12.0.1.66838",}, -- Nexus-Point Xenas
			},
			forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
		-- Добыча: Обычная сложность -----------------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66102",
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				-- return L["Prey"] .. ": " .. L["Normal"]
				return L["Prey: Normal"]
			end,
			name_save = "PreyNormal",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				-- https://wago.tools/db2/QuestLabel?filter%5BLabelID%5D = 6036&page = 1
				{91124}, -- Prey: Dengzag, the Darkened Blaze (Normal)
				{91123}, -- Prey: Grothoz, the Burning Shadow (Normal)
				{91122}, -- Prey: Thorn-Witch Liset (Normal)
				{91121}, -- Prey: Thornspeaker Edgath (Normal)
				{91120}, -- Prey: Neydra the Starving (Normal)
				{91119}, -- Prey: Lost Theldrin (Normal)
				{91118}, -- Prey: Vylenna the Defector (Normal)
				{91117}, -- Prey: Knight-Errant Bloodshatter (Normal)
				{91116}, -- Prey: Imperator Enigmalia (Normal)
				{91115}, -- Prey: Executor Kaenius (Normal)
				{91114}, -- Prey: Consul Nebulor (Normal)
				{91113}, -- Prey: Praetor Singularis (Normal)
				{91112}, -- Prey: Crusader Luxia Maxwell (Normal)
				{91111}, -- Prey: High Vindicator Vureem (Normal)
				{91110}, -- Prey: Lamyne of the Undercroft (Normal)
				{91109}, -- Prey: Petyoll the Razorleaf (Normal)
				{91108}, -- Prey: Lieutenant Blazewing (Normal)
				{91107}, -- Prey: Ranger Swiftglade (Normal)
				{91106}, -- Prey: The Wing of Akil'zon (Normal)
				{91105}, -- Prey: The Talon of Jan'alai (Normal)
				{91104}, -- Prey: Zadu, Fist of Nalorakk (Normal)
				{91103}, -- Prey: Jo'zolo the Breaker (Normal)
				{91102}, -- Prey: Nexus-Edge Hadim (Normal)
				{91101}, -- Prey: Phaseblade Talasha (Normal)
				{91100}, -- Prey: Deliah Gloomsong (Normal)
				{91099}, -- Prey: Mordril Shadowfell (Normal)
				{91098}, -- Prey: L-N-0R the Recycler (Normal)
				{91097}, -- Prey: Senior Tinker Ozwold (Normal)
				{91096}, -- Prey: Magistrix Emberlash (Normal)
				{91095}, -- Prey: Magister Sunbreaker (Normal)
			},
			forcedMaxQuest = 4,
		},
		----------------------------------------------------------------
		-- Добыча: Высокая сложность -----------------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66102",
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return L["Prey: Hard"]
			end,
			name_save = "PreyHard",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				-- https://wago.tools/db2/QuestLabel?filter%5BLabelID%5D = 6036&page = 1
				{91255}, -- Prey: Dengzag, the Darkened Blaze (Hard)
				{91254}, -- Prey: Grothoz, the Burning Shadow (Hard)
				{91253}, -- Prey: Thorn-Witch Liset (Hard)
				{91252}, -- Prey: Thornspeaker Edgath (Hard)
				{91251}, -- Prey: Neydra the Starving (Hard)
				{91250}, -- Prey: Lost Theldrin (Hard)
				{91249}, -- Prey: Vylenna the Defector (Hard)
				{91248}, -- Prey: Knight-Errant Bloodshatter (Hard)
				{91247}, -- Prey: Imperator Enigmalia (Hard)
				{91246}, -- Prey: Executor Kaenius (Hard)
				{91245}, -- Prey: Consul Nebulor (Hard)
				{91244}, -- Prey: Praetor Singularis (Hard)
				{91243}, -- Prey: Crusader Luxia Maxwell (Hard)
				{91242}, -- Prey: High Vindicator Vureem (Hard)
				{91240}, -- Prey: Lamyne of the Undercroft (Hard)
				{91238}, -- Prey: Petyoll the Razorleaf (Hard)
				{91236}, -- Prey: Lieutenant Blazewing (Hard)
				{91234}, -- Prey: Ranger Swiftglade (Hard)
				{91232}, -- Prey: The Wing of Akil'zon (Hard)
				{91230}, -- Prey: The Talon of Jan'alai (Hard)
				{91228}, -- Prey: Zadu, Fist of Nalorakk (Hard)
				{91226}, -- Prey: Jo'zolo the Breaker (Hard)
				{91224}, -- Prey: Nexus-Edge Hadim (Hard)
				{91222}, -- Prey: Phaseblade Talasha (Hard)
				{91220}, -- Prey: Deliah Gloomsong (Hard)
				{91218}, -- Prey: Mordril Shadowfell (Hard)
				{91216}, -- Prey: L-N-0R the Recycler (Hard)
				{91214}, -- Prey: Senior Tinker Ozwold (Hard)
				{91212}, -- Prey: Magistrix Emberlash (Hard)
				{91210}, -- Prey: Magister Sunbreaker (Hard)
			},
			forcedMaxQuest = 4,
		},
		----------------------------------------------------------------
		-- Добыча: Кошмарная сложность ---------------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66102",
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return L["Prey: Nightmare"]
			end,
			name_save = "PreyNightmare",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				-- 94446 ???? -- A Nightmarish Task
				-- https://wago.tools/db2/QuestLabel?filter%5BLabelID%5D = 6036&page = 1
				{91269}, -- Prey: Dengzag, the Darkened Blaze (Nightmare)
				{91268}, -- Prey: Grothoz, the Burning Shadow (Nightmare)
				{91267}, -- Prey: Thorn-Witch Liset (Nightmare)
				{91266}, -- Prey: Thornspeaker Edgath (Nightmare)
				{91265}, -- Prey: Neydra the Starving (Nightmare)
				{91264}, -- Prey: Lost Theldrin (Nightmare)
				{91263}, -- Prey: Vylenna the Defector (Nightmare)
				{91262}, -- Prey: Knight-Errant Bloodshatter (Nightmare)
				{91261}, -- Prey: Imperator Enigmalia (Nightmare)
				{91260}, -- Prey: Executor Kaenius (Nightmare)
				{91259}, -- Prey: Consul Nebulor (Nightmare)
				{91258}, -- Prey: Praetor Singularis (Nightmare)
				{91257}, -- Prey: Crusader Luxia Maxwell (Nightmare)
				{91256}, -- Prey: High Vindicator Vureem (Nightmare)
				{91241}, -- Prey: Lamyne of the Undercroft (Nightmare)
				{91239}, -- Prey: Petyoll the Razorleaf (Nightmare)
				{91237}, -- Prey: Lieutenant Blazewing (Nightmare)
				{91235}, -- Prey: Ranger Swiftglade (Nightmare)
				{91233}, -- Prey: The Wing of Akil'zon (Nightmare)
				{91231}, -- Prey: The Talon of Jan'alai (Nightmare)
				{91229}, -- Prey: Zadu, Fist of Nalorakk (Nightmare)
				{91227}, -- Prey: Jo'zolo the Breaker (Nightmare)
				{91225}, -- Prey: Nexus-Edge Hadim (Nightmare)
				{91223}, -- Prey: Phaseblade Talasha (Nightmare)
				{91221}, -- Prey: Deliah Gloomsong (Nightmare)
				{91219}, -- Prey: Mordril Shadowfell (Nightmare)
				{91217}, -- Prey: L-N-0R the Recycler (Nightmare)
				{91215}, -- Prey: Senior Tinker Ozwold (Nightmare)
				{91213}, -- Prey: Magistrix Emberlash (Nightmare)
				{91211}, -- Prey: Magister Sunbreaker (Nightmare)
			},
			forcedMaxQuest = 4,
		},
		----------------------------------------------------------------
		-- Вилла Салтерила ---------------------------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66198",
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("quest", 91627) -- L["Saltheril's Haven"]
			end,
			name_save = "SaltherilsHaven",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				-- https://wago.tools/db2/QuestLabel?filter%5BLabelID%5D = 5316&page = 1
				{89276}, -- Light Snacks
				{89277}, -- Illuminate the Space
				{89278}, -- Minding Our Duty
				{91971}, -- Hitting the Hammer
				{91972}, -- Hold the Watch
				{91973}, -- Naga Blades
				{91974}, -- Sunfire to the Blade
				{91975}, -- That's Our Wood
				{91976}, -- Lightbloom Dimmed
				{91977}, -- Less Lawless
				{91978}, -- Taxing the Tideborne
				{91979}, -- Chop It Down
				{91983}, -- Lovely Plumage
				{91984}, -- Sungrub Silk
				{91985}, -- ?
				{91986}, -- Put a Little Snap in Their Step
				{91987}, -- Potted Lashers
				{91988}, -- Brightwing Conservation
				{91989}, -- Ghostland Peppers
				{91990}, -- Sunset to Sea
				{91991}, -- A Little Errand
				{91992}, -- Where Has the Wine Gone?
				{91993}, -- Diminutive Demand
				{91994}, -- Pyrepetal Purposes
				{91995}, -- What Horrible Magic
				{91996}, -- Fit for a Magister
				{91997}, -- Power Clean
				{91999}, -- A Bit of Bloodthistle
				{92000}, -- Bring the Ruckus
				{92001}, -- One Smuggler to Another
				{92002}, -- Dangerous Showpieces
				{92003}, -- Artisanal Replicas
				{92004}, -- Shady Dealings
				{92005}, -- Throw the Dice
				{92006}, -- We Need a Refill
				{92007}, -- Begged, Borrowed, or Stolen
			},
			forcedMaxQuest = 3,
		},
		----------------------------------------------------------------
		-- Званый ужин у Салтерила -------------------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66198",
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("quest", 91966) -- L["Saltheril's Soiree"]
			end,
			name_save = "SaltherilsSoiree",
			defS = false,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{91966, AddedInPatch = "12.0.1.66198",},
			},
			forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
		-- Исследовательская консоль: изучение Бездны ------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66220",
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("quest", 94790) -- L["Research Console: Exploring the Void"]
			end,
			name_save = "ResearchConsole:ExploringtheVoid",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{94790, AddedInPatch = "12.0.1.66220",},
			},
			forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
		-- Профессии ---------------------------------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66220",
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return L["TRADE_SKILLS"]
			end,
			name_save = "ProfessionWeeklies",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{93691, prof = 164, }, -- Blacksmithing Services Requested
				{93692, prof = 202, }, -- Engineering Services Requested
				{93693, prof = 773, }, -- Inscription Services Requested
				{93694, prof = 755, }, -- Jewelcrafting Services Requested
				{93695, prof = 165, }, -- Leatherworking Services Requested
				{93696, prof = 197, }, -- Tailoring Services Requested
				{93690, prof = 171, }, -- Alchemy Services Requested
				-- Mining
				{93705, prof = 186, }, -- Copper for Your Thoughts?
				{93706, prof = 186, }, -- Aggressive Tin-dencies
				{93707, prof = 186, }, -- ?
				{93708, prof = 186, }, -- Conductive Metals
				{93709, prof = 186, }, -- Stocking the Staples
				-- Skinning
				{93710, prof = 393, }, -- Tempered in Darkness
				{93711, prof = 393, }, -- The Chill of the Void
				{93712, prof = 393, }, -- Style and Skill
				{93713, prof = 393, }, -- ?
				{93714, prof = 393, }, -- Minor Scales
				-- Enchanting
				{93697, prof = 333, }, -- Just a Pinch
				{93698, prof = 333, }, -- Just a Pinch
				{93699, prof = 333, }, -- Just a Pinch
				-- Herbalism
				{93700, prof = 182, }, -- Experience Tranquility
				{93701, prof = 182, }, -- ?
				{93702, prof = 182, }, -- The Root of Life
				{93703, prof = 182, }, -- Sin'dorei Vices
				{93704, prof = 182, }, -- Traditional Harvests
			},
			forcedMaxQuest = 2,
		},
		----------------------------------------------------------------
		-- Талассийский трактат ----------------------------------------
		----------------------------------------------------------------
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return L["Thalassian Treatise"]
			end,
			name_save = "ThalassianTreatise",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{95127, forcedText = {itemID = 245755}, prof = 171, }, -- Thalassian Treatise on Alchemy
				{95128, forcedText = {itemID = 245763}, prof = 164, }, -- Thalassian Treatise on Blacksmithing
				{95129, forcedText = {itemID = 245759}, prof = 333, }, -- Thalassian Treatise on Enchanting
				{95138, forcedText = {itemID = 245809}, prof = 202, }, -- Thalassian Treatise on Engineering
				{95130, forcedText = {itemID = 245761}, prof = 182, }, -- Thalassian Treatise on Herbalism
				{95131, forcedText = {itemID = 245757}, prof = 773, }, -- Thalassian Treatise on Inscription
				{95133, forcedText = {itemID = 245760}, prof = 755, }, -- Thalassian Treatise on Jewelcrafting
				{95134, forcedText = {itemID = 245758}, prof = 165, }, -- Thalassian Treatise on Leatherworking
				{95135, forcedText = {itemID = 245762}, prof = 186, }, -- Thalassian Treatise on Mining
				{95136, forcedText = {itemID = 245828}, prof = 393, }, -- Thalassian Treatise on Skinning
				{95137, forcedText = {itemID = 245756}, prof = 197, }, -- Thalassian Treatise on Tailoring
			},
			forcedMaxQuest = 2,
		},
		----------------------------------------------------------------
		-- Weekly Profession Knowledge Drops from Treasures around the World
		----------------------------------------------------------------
		-- {
		-- sorted = true,
		-- showTooltip = true,
		-- TextLeft = function()
		-- return L["Weekly Profession Knowledge Drops from Treasures around the World"]
		-- end,
		-- name_save = "WeeklyProfessionKnowledgeDropsfromTreasuresaroundtheWorld",
		-- defS = false,
		-- reset = "Weekly",
		-- desc = categoryKey,
		-- quests = {
		-- {93530},
		-- {93531},
		-- {93540},
		-- {93541},
		-- {93528},
		-- {93529},
		-- {93542},
		-- {93543},
		-- {93534},
		-- {93535},
		-- {93532},
		-- {93533},
		-- {93539},
		-- {93538},
		-- {93536},
		-- {93537},
		-- },
		-- rewards = {
		-- -- {rewID = ЙЦУЙЦУ, rewTYPE = "currency", rewSIZE = nil,}, --
		-- -- {rewID = ЙЦУЙЦУ, rewTYPE = "spell", rewSIZE = nil,}, --
		-- {rewID = 259190, rewTYPE = "item", rewSIZE = 1,},
		-- {rewID = 259191, rewTYPE = "item", rewSIZE = 1,},
		-- {rewID = 259200, rewTYPE = "item", rewSIZE = 1,},
		-- {rewID = 259201, rewTYPE = "item", rewSIZE = 1,},
		-- {rewID = 259188, rewTYPE = "item", rewSIZE = 1,},
		-- {rewID = 259189, rewTYPE = "item", rewSIZE = 1,},
		-- {rewID = 259202, rewTYPE = "item", rewSIZE = 1,},
		-- {rewID = 259203, rewTYPE = "item", rewSIZE = 1,},
		-- {rewID = 259194, rewTYPE = "item", rewSIZE = 1,},
		-- {rewID = 259195, rewTYPE = "item", rewSIZE = 1,},
		-- {rewID = 259192, rewTYPE = "item", rewSIZE = 1,},
		-- {rewID = 259193, rewTYPE = "item", rewSIZE = 1,},
		-- {rewID = 259198, rewTYPE = "item", rewSIZE = 1,},
		-- {rewID = 259199, rewTYPE = "item", rewSIZE = 1,},
		-- {rewID = 259196, rewTYPE = "item", rewSIZE = 1,},
		-- {rewID = 259197, rewTYPE = "item", rewSIZE = 1,},
		-- },
		-- forcedMaxQuest = 2,
		-- },
		----------------------------------------------------------------
		-- Треснувший ключ ---------------------------------------------
		----------------------------------------------------------------
		{
			AddedInPatch = "12.0.1.66102",
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("quest", 92600)
			end,
			name_save = "CrackedKeystone",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{92600, AddedInPatch = "12.0.1.66102",},
			},
			rewards = {
				{rewID = 3348, rewTYPE = "currency", rewSIZE = 15,}, -- Myth Dawncrest
				{rewID = 3346, rewTYPE = "currency", rewSIZE = 15,}, -- Hero Dawncrest
			},
			forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
	}
	----------------------------------------------------------------
	-- local AdditionallyTOP = {
	-- }
	-- local AdditionallyBOTTOM = {
	-- }
	-- local Maps = {
	-- }
	-- local Quests =
	-- }
	-- local AdditionallyCENTER = {
	-- }
	local OctoTables_DataOtrisovka = {}
	OctoTables_DataOtrisovka[categoryKey] = {}
	-- OctoTables_DataOtrisovka[categoryKey].AdditionallyTOP = E.FilterByVersion(AdditionallyTOP)
	OctoTables_DataOtrisovka[categoryKey].Currencies = E.FilterByVersion(Currencies)
	OctoTables_DataOtrisovka[categoryKey].Items = E.FilterByVersion(Items)
	OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = E.FilterByVersion(RaidsOrDungeons)
	-- OctoTables_DataOtrisovka[categoryKey].AdditionallyCENTER = E.FilterByVersion(AdditionallyCENTER)
	-- OctoTables_DataOtrisovka[categoryKey].Quests = E.FilterByVersion(Quests)
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = E.FilterByVersion(UniversalQuests, true)
	OctoTables_DataOtrisovka[categoryKey].Reputations = E.FilterByVersion(Reputations)
	-- OctoTables_DataOtrisovka[categoryKey].AdditionallyBOTTOM = E.FilterByVersion(AdditionallyBOTTOM)
	-- OctoTables_DataOtrisovka[categoryKey].Maps = E.FilterByVersion(Maps)

	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)
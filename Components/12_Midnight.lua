local GlobalAddonName, E = ...
----------------------------------------------------------------
local enable = true
local Is_Midnight_available = E.func_Is_Midnight_available()
----------------------------------------------------------------
if not enable then return end
if not Is_Midnight_available then return end;
----------------------------------------------------------------
local L = E.L
----------------------------------------------------------------
local categoryKey = 12
local expansionID = 12
----------------------------------------------------------------
local function tempFunction()
	local OctoTables_DataOtrisovka = {}
	local OctoTables_Vibor = {}
	OctoTables_DataOtrisovka[categoryKey] = {}
	OctoTables_Vibor[categoryKey] = {}
	OctoTables_Vibor[categoryKey].icon = E.OctoTable_Expansions[expansionID].icon
	OctoTables_Vibor[categoryKey].name = E.OctoTable_Expansions[expansionID].color..E.OctoTable_Expansions[expansionID].nameBlizzard
	OctoTables_Vibor[categoryKey].color = E.OctoTable_Expansions[expansionID] and E.OctoTable_Expansions[expansionID].color or E.COLOR_BLACK
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Currencies = {
		-- фиол
		{id = 3400, defS = false,}, -- Uncontaminated Void Sample
		{id = 3379, defS = false,}, -- Brimming Arcana
		{id = 3378, defS = true,}, -- Dawnlight Manaflux       ---------> (CATALYST)
		{id = 3212, defS = false,}, -- Radiant Spark Dust (Midnight Season 1)
		{id = 3028, defS = false,}, -- Restored Coffer Key (Midnight Season 1)
		{id = 3310, defS = false,}, -- Coffer Key Shards
		-- https://www.wowhead.com/currencies/season-1#0+1+3
		{id = 3347, defS = true,}, -- Myth Dawncrest (Midnight Season 1 up to item levels 276-289)
		{id = 3345, defS = true,}, -- Hero Dawncrest (Midnight Season 1 up to item levels 263-276)
		{id = 3343, defS = true,}, -- Champion Dawncrest (Midnight Season 1 up to item levels 250-263)
		{id = 3341, defS = true,}, -- Veteran Dawncrest (Midnight Season 1 up to item levels 237-250)
		{id = 3383, defS = true,}, -- Adventurer Dawncrest (Midnight Season 1 up to item levels 224-237)
		-- {id = 3391, defS = false,}, -- Adventurer Dawncrest (UNUSED)
		-- синий
		-- {id = 3394, defS = false,}, -- УДАЛЁН
		{id = 3392, defS = false,}, -- Remnant of Anguish
		{id = 3376, defS = false,}, -- Shard of Dundun
		{id = 3352, defS = false,}, -- Party Favor
		-- зелень
		{id = 3385, defS = false,}, -- Luminous Dust
		{id = 3377, defS = false,}, -- Unalloyed Abundance
		{id = 3373, defS = false,}, -- Angler Pearls
		{id = 3363, defS = false,}, -- Community Coupons
		-- белый
		{id = 3316, defS = false,}, -- Voidlight Marl
		-- {id = 3349, defS = false,}, -- [DNT] [PH] Evergreen Initiative Currency
		-- {id = 3319, defS = false,}, -- Twilight's Blade Insignia -- MIDNIGHT PREPATCH (REMOVED)
		-- {id = 3356, defS = false,}, -- Untainted Mana-Crystals
		-- {id = 3028, defS = false,}, -- Restored Coffer Key
		-- {id = 2803, defS = false,}, -- Undercoin
		-- проф
		-- {id = 3266, defS = false,}, -- Artisan Tailor's Moxie
		-- {id = 3265, defS = false,}, -- Artisan Skinner's Moxie
		-- {id = 3264, defS = false,}, -- Artisan Miner's Moxie
		-- {id = 3263, defS = false,}, -- Artisan Leatherworker's Moxie
		-- {id = 3262, defS = false,}, -- Artisan Jewelcrafter's Moxie
		-- {id = 3261, defS = false,}, -- Artisan Scribe's Moxie
		-- {id = 3260, defS = false,}, -- Artisan Herbalist's Moxie
		-- {id = 3259, defS = false,}, -- Artisan Engineer's Moxie
		-- {id = 3258, defS = false,}, -- Artisan Enchanter's Moxie
		-- {id = 3257, defS = false,}, -- Artisan Blacksmith's Moxie
		-- {id = 3256, defS = false,}, -- Artisan Alchemist's Moxie
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = {
		-- Raid
		-- "SPOREFALL = 1 BOSS RAID" -> 12.0.7 (summer?)
		{id = 2913, defS = true,}, -- March on Quel'Danas
		{id = 2912, defS = true,}, -- The Voidspire
		{id = 2939, defS = true,}, -- The Dreamrift
		-- Dungeon -- /dump C_ChallengeMode.GetMapTable() -- НЕ ТО
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
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
		{id = 2710, defS = true,}, -- Silvermoon Court (Двор Луносвета)
		{id = 2696, defS = true,}, -- Amani Tribe (Племя Амани)
		{id = 2704, defS = true,}, -- Hara'ti (Хара'ти)
		{id = 2699, defS = true,}, -- The Singularity (Сингулярность)
		{id = 2770, defS = false,}, -- Slayer's Duellum
		{id = 2744, defS = false,}, -- Valeera Sanguinar
		{id = 2714, defS = false,}, -- Shades of the Row
		{id = 2712, defS = false,}, -- Blood Knights
		{id = 2711, defS = false,}, -- Magisters
		{id = 2713, defS = false,}, -- Farstriders
		{id = 2742, defS = true,}, -- Delves: Season 1
		{id = 2764, defS = true,}, -- Prey: Season 1
		-- {id = 2722, defS = true,}, -- C_DelvesUI.GetDelvesFactionForSeason() для миднайта криво работает
		-- {id = 2764, defS = false,}, -- Preyseeker's Journey
		-- {id = 2700, defS = false,}, -- DEPRECATED Fungarian Fighting Ring
		-- {id = 2774, defS = false,}, -- Slayer's Duellum (Paragon)
		-- {id = 2727, defS = false,}, -- Silvermoon Court (Paragon)
		-- {id = 2726, defS = false,}, -- Hara'ti (Paragon)
		-- {id = 2725, defS = false,}, -- The Singularity (Paragon)
		-- {id = 2705, defS = false,}, -- Amani Tribe (Paragon)
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
		----------------------------------------------------------------
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return RAID_INFO_WORLD_BOSS -- L["World Boss"]
			end,
			name_save = "WorldBoss",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				-- {81630, forcedText = {npcID = 221084}, addText = {mapID = 2248},}, -- Кордак (221084) Остров Дорн
				-- {82653, addText = {mapID = 2214},}, -- Гулкие глубины.
				-- {81653, forcedText = {npcID = 221224}, addText = {mapID = 2215},}, -- Шуррай (221224) Тайносводье
				-- {81624, forcedText = {npcID = 221067}, addText = {mapID = 2213},}, -- Орта (221067) Город Нитей
				-- {nil},
				-- {85088, forcedText = {npcID = 231821}, addText = {mapID = 2346},}, -- Гоблионе (231821) Нижняя Шахта
				-- {nil},
				-- {87354, forcedText = {npcID = 238319}, addText = {mapID = 2371},}, -- Reshanor (238319) К'ареш
				{92123, forcedText = {npcID = 244424}, addText = {mapID = 2437},}, -- Cragpine (244424) К'ареш
				{92560, forcedText = {npcID = 244762}, addText = {mapID = 2395},}, -- Lu'ashal (244762) К'ареш
				{92636, forcedText = {npcID = 248864}, addText = {mapID = 2405},}, -- Predaxas (248864) К'ареш
				{92034, forcedText = {npcID = 249776}, addText = {mapID = 2413},}, -- Thorm'belan (249776) К'ареш
			},
			forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
		{
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
				{93766}, -- Midnight: World Quests
				{93767}, -- Midnight: Arcantina
				{93769}, -- Midnight: Housing
				{93889}, -- Midnight: Saltheril's Soiree
				{93891}, -- Midnight: Legends of the Haranir
				{93892}, -- Midnight: Stormarion Assault
				{93909}, -- Midnight: Delves
				{93910}, -- Midnight: Prey
				{93911}, -- Midnight: Dungeons
				{94457}, -- Midnight: Battlegrounds
				{93890}, -- Midnight: Abundance (https://www.wowhead.com/npc=240279/magovu)
				{93912}, -- Midnight: Raid
				{93913}, -- Midnight: World Boss
				{95842}, -- Midnight: Void Assaults
				{95843}, -- Midnight: Ritual Sites
			},
			forcedMaxQuest = 2,
		},
		----------------------------------------------------------------
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return DELVES_LABEL..": "..E.func_GetName("quest", 93784) -- A Gnawing Void of Curiosity
			end,
			name_save = "AGnawingVoidofCuriosity",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{93784},
			},
			forcedMaxQuest = 1, -- any
		},

		----------------------------------------------------------------
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				-- TWW S2: 233071 (Клад участника вылазки) L["Delver's Bounty"]
				-- TWW S3: 248142 (Клад участника вылазки) L["Delver's Bounty"]  -- This item can be fished in Excavation Site 9
				-- Mid S1: 252415 (Трофей охотника за сокровищами)
				return DELVES_LABEL..": " .. E.func_GetName("item", 252415, 1)
			end,
			name_save = "DelversBountySeason1",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				-- {86371, forcedText = {text = E.func_texturefromIcon(E.func_GetItemIcon(252415))..E.func_GetName("item", 252415)},},
				{86371, forcedText = {itemID = 252415}, addText = {text = E.COLOR_GREEN.." ("..format(EXPANSION_SEASON_NAME, "Midnight", 1)..")|r"}  },
			},
			forcedMaxQuest = 1,
		},










		----------------------------------------------------------------
		-- Silvermoon Court --------------------------------------------
		----------------------------------------------------------------
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("reputation", 2710)..": "..E.func_GetName("quest", 89289) -- Favor of the Court
			end,
			name_save = "FavoroftheCourt",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{89289},
			},
			forcedMaxQuest = 1, -- any
		},
		----------------------------------------------------------------
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("reputation", 2710)..": "..L["Fortify the Runestones"]
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
			forcedMaxQuest = 1, -- any
		},
		----------------------------------------------------------------
		-- Amani Tribe -------------------------------------------------
		----------------------------------------------------------------
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("reputation", 2696)..": "..E.func_GetName("quest", 89507) -- Abundant Offerings
			end,
			name_save = "AbundantOfferings",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{89507},
			},
			forcedMaxQuest = 1, -- any
		},
		----------------------------------------------------------------
		-- Harandar ----------------------------------------------------
		----------------------------------------------------------------
		{
			isAccount = true,
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("reputation", 2704)..": "..E.func_GetName("quest", 89268)  -- Утраченные легенды
			end,
			name_save = "LostLegends",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{89268}, -- Lost Legends
			},
			forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("reputation", 2704)..": "..L["Legends of the Haranir"]
			end,
			name_save = "LegendsoftheHaranir",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{88993}, -- Wey'nan's Ward
				{88994}, -- The Cauldron of Echoes
				{88995}, -- Aln'hara's Bloom
				{88996}, -- The Echoless Flame
				{88997}, -- Russula's Outreach
					{88998}, -- Root of the World
					{88999}, -- Sky's Hope
			},
			forcedMaxQuest = 1, -- any
		},
		----------------------------------------------------------------
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("reputation", 2704)..": "..L["WANTED"] -- E.func_GetName("map", 2413)..": "..
			end,
			name_save = "HarandarDailyWanted",
			defS = false,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{91970}, -- WANTED: Gelatonius
				{91980}, -- WANTED: Hellebora's Thorn
				{91982}, -- WANTED: Toadshade's Petals
				{91998}, -- WANTED: Muckmire's Choking Vines
				{92010}, -- WANTED: Slewstalk's Stalks
				{92012}, -- WANTED: Gorebarb's Pincers
				{92013}, -- WANTED: Dionaea's Thorntusks
			},
			forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
		-- The Singularity ---------------------------------------------
		----------------------------------------------------------------
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("reputation", 2699)..": "..QUESTS_LABEL
			end,
			name_save = "TheSingularityQuests",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{90962}, -- StormarionAssault
				{nil},
				{94581}, -- StandYourGround
				{nil},
				{91700}, -- DarknessUnmade
				{86810}, -- HarvestingtheVoid
				{92407}, -- HideyHole
			},
			forcedMaxQuest = 5,
		},
		----------------------------------------------------------------
		-- Slayer's Duellum --------------------------------------------
		----------------------------------------------------------------
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("reputation", 2770)..": "..E.func_GetName("quest", 89354)
			end,
			name_save = "PreparingforBattle",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{89354},
			},
			forcedMaxQuest = 1,
		},
		----------------------------------------------------------------











		----------------------------------------------------------------
		{
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
				{91390}, -- Special Assignment: What Remains of a Temple Broken
				{91796}, -- Special Assignment: Ours Once More!
				{92063}, -- Special Assignment: A Hunter's Regret
				{92139}, -- Special Assignment: Shade and Claw
				{92145}, -- Special Assignment: The Grand Magister's Drink
				{93013}, -- Special Assignment: Push Back the Light
				{93244}, -- Special Assignment: Agents of the Shield
				{93438}, -- Special Assignment: Precision Excision
			},
			forcedMaxQuest = 2,
		},
		----------------------------------------------------------------
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return QUESTS_LABEL .. ": " .. DUNGEONS -- L["Dungeon Quest"]
			end,
			name_save = "DungeonQuest",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				-- https://wago.tools/db2/QuestLabel?filter%5BLabelID%5D = 4887&page = 1
				{93751}, -- Windrunner Spire
				{93752}, -- Murder Row
				{93753}, -- Magisters' Terrace
				{93754}, -- Maisara Caverns
				{93755}, -- Den of Nalorakk
				{93756}, -- The Blinding Vale
				{93757}, -- Voidscar Arena
				{93758}, -- Nexus-Point Xenas
			},
			forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				-- return L["Prey"]..": "..L["Normal"]
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
		{
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
		{
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
		{
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
		{
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
				{91966},
			},
			forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
		{
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
				{94790},
			},
			forcedMaxQuest = 1,
		},
		----------------------------------------------------------------
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				-- return E.func_GetName("map", 2393)..": "..TRADE_SKILLS
				-- return L["Profession Weeklies"]
				return TRADE_SKILLS
			end,
			name_save = "ProfessionWeeklies",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				-- itemID = 263455
				{93691, addText = {IconVignette = "Mobile-Blacksmithing",}, }, -- Blacksmithing Services Requested
				-- itemID = 263456
				{93692, addText = {IconVignette = "Mobile-Enginnering",}, }, -- Engineering Services Requested
				-- itemID = 263457
				{93693, addText = {IconVignette = "Mobile-Inscription",}, }, -- Inscription Services Requested
				-- itemID = 263458
				{93694, addText = {IconVignette = "Mobile-Jewelcrafting",}, }, -- Jewelcrafting Services Requested
				-- itemID = 263459
				{93695, addText = {IconVignette = "Mobile-Leatherworking",}, }, -- Leatherworking Services Requested
				-- itemID = 263460
				{93696, addText = {IconVignette = "Mobile-Tailoring",}, }, -- Tailoring Services Requested
				-- itemID = 263454
				{93690, addText = {IconVignette = "Mobile-Alchemy",}, }, -- Alchemy Services Requested
				-- itemID = 263463
				-- https://wago.tools/db2/QuestLabel?filter%5BLabelID%5D = 6082&page = 1
				{93705, addText = {IconVignette = "Mobile-Mining",}, }, -- Copper for Your Thoughts?
				{93706, addText = {IconVignette = "Mobile-Mining",}, }, -- Aggressive Tin-dencies
				{93707, addText = {IconVignette = "Mobile-Mining",}, }, -- ?
				{93708, addText = {IconVignette = "Mobile-Mining",}, }, -- Conductive Metals
				{93709, addText = {IconVignette = "Mobile-Mining",}, }, -- Stocking the Staples
				-- itemID = 263461
				-- https://wago.tools/db2/QuestLabel?filter%5BLabelID%5D = 6083&page = 1
				{93710, addText = {IconVignette = "Mobile-Skinning",}, }, -- Tempered in Darkness
				{93711, addText = {IconVignette = "Mobile-Skinning",}, }, -- The Chill of the Void
				{93712, addText = {IconVignette = "Mobile-Skinning",}, }, -- Style and Skill
				{93713, addText = {IconVignette = "Mobile-Skinning",}, }, -- ?
				{93714, addText = {IconVignette = "Mobile-Skinning",}, }, -- Minor Scales
				-- itemID = 263464
				-- https://wago.tools/db2/QuestLabel?filter%5BLabelID%5D = 6079&page = 1
				{93697, addText = {IconVignette = "Mobile-Enchanting",}, }, -- Just a Pinch -- зачаровывателя
				{93698, addText = {IconVignette = "Mobile-Enchanting",}, }, -- Just a Pinch -- зачаровывателя
				{93699, addText = {IconVignette = "Mobile-Enchanting",}, }, -- Just a Pinch -- зачаровывателя
				-- itemID = 263462
				-- https://wago.tools/db2/QuestLabel?filter%5BLabelID%5D = 6080&page = 1
				{93700, addText = {IconVignette = "Mobile-Herbalism",}, }, -- Experience Tranquility
				{93701, addText = {IconVignette = "Mobile-Herbalism",}, }, -- ?
				{93702, addText = {IconVignette = "Mobile-Herbalism",}, }, -- The Root of Life
				{93703, addText = {IconVignette = "Mobile-Herbalism",}, }, -- Sin'dorei Vices
				{93704, addText = {IconVignette = "Mobile-Herbalism",}, }, -- Traditional Harvests
			},
			forcedMaxQuest = 2,
		},
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
				{95127, forcedText = {itemID = 245755}}, -- Thalassian Treatise on Alchemy
				{95128, forcedText = {itemID = 245763}}, -- Thalassian Treatise on Blacksmithing
				{95129, forcedText = {itemID = 245759}}, -- Thalassian Treatise on Enchanting
				{95138, forcedText = {itemID = 245809}}, -- Thalassian Treatise on Engineering
				{95130, forcedText = {itemID = 245761}}, -- Thalassian Treatise on Herbalism
				{95131, forcedText = {itemID = 245757}}, -- Thalassian Treatise on Inscription
				{95133, forcedText = {itemID = 245760}}, -- Thalassian Treatise on Jewelcrafting
				{95134, forcedText = {itemID = 245758}}, -- Thalassian Treatise on Leatherworking
				{95135, forcedText = {itemID = 245762}}, -- Thalassian Treatise on Mining
				{95136, forcedText = {itemID = 245828}}, -- Thalassian Treatise on Skinning
				{95137, forcedText = {itemID = 245756}}, -- Thalassian Treatise on Tailoring
			},
			forcedMaxQuest = 2,
		},
		----------------------------------------------------------------
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].AdditionallyTOP = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].AdditionallyBOTTOM = {
		{id = "MythicZero", defS = false,},
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)

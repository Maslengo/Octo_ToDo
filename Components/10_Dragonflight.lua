local GlobalAddonName, E = ...
----------------------------------------------------------------
local enable = true
local Is_Dragonflight_available = E.func_Is_Dragonflight_available()
----------------------------------------------------------------
if not enable then return end
if not Is_Dragonflight_available then return end;
----------------------------------------------------------------
local L = E.L
----------------------------------------------------------------
local categoryKey = 10
local expansionID = 10
----------------------------------------------------------------
local function tempFunction()
	local OctoTables_Vibor = {}
	-- wipe(OctoTables_Vibor)
	local OctoTables_DataOtrisovka = {}
	-- wipe(OctoTables_DataOtrisovka)
	OctoTables_DataOtrisovka[categoryKey] = {}
	-- wipe(OctoTables_DataOtrisovka[categoryKey])
	OctoTables_Vibor[categoryKey] = {}
	-- wipe(OctoTables_Vibor[categoryKey])
	OctoTables_Vibor[categoryKey].icon = E.OctoTable_Expansions[expansionID].icon
	OctoTables_Vibor[categoryKey].name = E.OctoTable_Expansions[expansionID].color..E.OctoTable_Expansions[expansionID].nameBlizzard
	OctoTables_Vibor[categoryKey].color = E.OctoTable_Expansions[expansionID] and E.OctoTable_Expansions[expansionID].color or E.COLOR_BLACK
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Currencies = {
		{id = 2122, defS = true,},
		{id = 2118, defS = true,},
		{id = 2003, defS = true,},
		{id = 2245, defS = true,},
		{id = 2594, defS = true,},
		-- {id = 2812, defS = false,}, -- (УСТАРЕЛО АСПЕКТЫ )
		-- {id = 2809, defS = false,}, -- (УСТАРЕЛО АСПЕКТЫ )
		-- {id = 2807, defS = false,}, -- (УСТАРЕЛО АСПЕКТЫ )
		-- {id = 2806, defS = false,}, -- (УСТАРЕЛО АСПЕКТЫ )
		-- Dragonflight
		-- https://warcraft.wiki.gg/wiki/Catalyst
		{id = 2912, defS = true,}, -- Renascent Awakening ()
		{id = 2796, defS = false,}, -- Renascent Dream (Season 3)
		{id = 2533, defS = false,}, -- Renascent Shadowflame (Season 2)
		{id = 2167, defS = false,}, -- Catalyst Charges (Season 1)
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
		{id = 209856, defS = false,},
		{id = 207002, defS = false,},
		{id = 210254, defS = false,},
		{id = 213089, defS = false,},
		{id = 211516, defS = false,},
		{id = 211515, defS = false,},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = {
		-- Raid
		{id = 2549, defS = true,}, -- Amirdrassil, the Dream's Hope
		{id = 2569, defS = true,}, -- Aberrus, the Shadowed Crucible
		{id = 2522, defS = true,}, -- Vault of the Incarnates
		-- Dungeon
		-- {id = 2521, defS = true,}, -- Ruby Life Pools
		-- {id = 2515, defS = true,}, -- The Azure Vault
		-- {id = 2516, defS = true,}, -- The Nokhud Offensive
		-- {id = 2451, defS = true,}, -- Uldaman: Legacy of Tyr
		-- {id = 2526, defS = true,}, -- Algeth'ar Academy
		-- {id = 2519, defS = true,}, -- Neltharus
		-- {id = 2527, defS = true,}, -- Halls of Infusion
		-- {id = 2520, defS = true,}, -- Brackenhide Hollow
		-- {id = 2662, defS = true,}, -- The Dawnbreaker
		-- {id = 2579, defS = true,}, -- Dawn of the Infinite
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
		-- header = {icon = E.OctoTable_Expansions[categoryKey].icon, name = E.OctoTable_Expansions[categoryKey].color..E.OctoTable_Expansions[categoryKey].name.."|r",},
		-- ["Dragonflight"] = {
		{id = 2507, defS = true,}, --name = "Драконья экспедиция", side = "-", category = "Dragonflight", }, --[faction=2507]
		{id = 2574, defS = true,}, --name = "Стражи Сна", side = "-", category = "Dragonflight", }, --[faction=2574]
		{id = 2511, defS = true,}, --name = "Искарские клыкарры", side = "-", category = "Dragonflight", }, --[faction=2511]
		{id = 2564, defS = true,}, --name = "Лоаммские ниффы", side = "-", category = "Dragonflight", }, --[faction=2564]
		{id = 2503, defS = true,}, --name = "Кентавры Маруук", side = "-", category = "Dragonflight", }, --[faction=2503]
		{id = 2510, defS = true,}, --name = "Союз Вальдраккена", side = "-", category = "Dragonflight", }, --[faction=2510]
		----------------------------------------------------------------
		{id = 2550, defS = false,}, --name = "Кобальтовая ассамблея", side = "-", category = "Союз Вальдраккена", }, --[faction=2550]
		{id = 2544, defS = false,}, --name = "Консорциум ремесленников – филиал на Драконьих островах", side = "-", category = "Союз Вальдраккена", }, --[faction=2544]
		{id = 2553, defS = false,}, --name = "Соридорми", side = "-", category = "Союз Вальдраккена", }, --[faction=2553]
		{id = 2518, defS = false,}, --name = "Сабеллиан", side = "-", category = "Союз Вальдраккена", }, --[faction=2518]
		{id = 2517, defS = false,}, --name = "Гневион", side = "-", category = "Союз Вальдраккена", }, --[faction=2517]
		----------------------------------------------------------------
		{id = 2568, defS = false,}, --name = "Гонщик Мерцающего Огга", side = "-", category = "Dragonflight", }, --[faction=2568]
		----------------------------------------------------------------
		{id = 2615, defS = false,}, --name = "Азеротские Архивы", side = "-", category = "Драконья экспедиция", }, --[faction=2615]
		----------------------------------------------------------------
		{id = 2593, defS = false,}, --name = "Команда Бочконога", side = "-", category = "Другое", }, --[faction=2593]
		{id = 2526, defS = false,}, --name = "Фурболги из клана Зимней Шкуры", side = "-", category = "Dragonflight", }, --[faction=2526]
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetQuestName(70750, true)
			end,
			name_save = "AidingtheAccord",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{70750},
				{72068},
				{72374},
				{77976},
				{75861},
				{72373},
				{72375},
				{77254},
				{75860},
				{75859},
				{75259},
				{78446},
				{78447},
				{80385},
				{80386},
				{80388},
			},
			forcedMaxQuest = 1,
		},
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
				{69927, forcedText = {npcID = 193532}, addText = {mapID = 2024},}, -- Базуал <Чудовищное Пламя> 193532 (Лазурный Простор)
				{69928, forcedText = {npcID = 193533}, addText = {mapID = 2025},}, -- Лисканот <Крах Мироздания> 193533 (Будущее воинов стихий)
				{69929, forcedText = {npcID = 193534}, addText = {mapID = 2023},}, -- Струнраан <Бедствие Небес> 193534 (Равнины Он'ары)
				{69930, forcedText = {npcID = 193535}, addText = {mapID = 2022},}, -- Базрикрон <Каменное Крыло> 193535 (Берега Пробуждения)
				{nil},
				{74892, addText = {mapID = 2133},}, -- Старейшины закали (Пещера Заралек)
				{nil},
				{76367, forcedText = {npcID = 209574}, addText = {mapID = 2200},}, -- Ауростор <Пережидающий Зиму> 209574 Изумрудный Сон (6).
			},
			forcedMaxQuest = 3,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.Timers.DF_CommunityFeast()..E.func_GetQuestName(70893, false)
			end,
			name_save = "CommunityFeast",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{70893},
			},
			-- forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.Timers.DF_ToDragonbaneKeep()..L["Siege on Dragonbane Keep"]
			end,
			name_save = "DragonbaneKeep",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{70866, forcedText = {text = L["Siege on Dragonbane Keep"]},},
			},
			-- forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.Timers.DF_GrandHunts()..L["Grand Hunt"]
			end,
			name_save = "TheGrandHunt",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{70906, forcedText = {text = L["Grand Hunt"]},},
			},
			-- forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.Timers.DF_PrimalStorms()..L["The Storm's Fury"]
			end,
			name_save = "StormsFury",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{73162, forcedText = {text = L["The Storm's Fury"]},},
			},
			-- forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2200)..": "..E.func_GetQuestName(78444, true)
			end,
			name_save = "EmeraldDream_AWorthyAllyDreamWardens",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{78444},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2200)..": "..E.func_GetQuestName(78821, false)
			end,
			name_save = "EmeraldDream_BloomingDreamseeds",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{78821},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2200)..": "..E.Timers.DF_Flower()..E.func_GetQuestName(78319, false)
			end,
			name_save = "EmeraldDream_TheSuperbloom",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{78319},
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2200)..": ".."Rares"
			end,
			name_save = "EmeraldDream_Rares",
			defS = true,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{77942, forcedText = {npcID = 210050},},
				{77867, forcedText = {npcID = 209898},},
				{77862, forcedText = {npcID = 209909},},
				{77878, forcedText = {npcID = 209929},},
				{78015, forcedText = {npcID = 209893},},
				{77846, forcedText = {npcID = 209913},},
				{77982, forcedText = {npcID = 209936},},
				{77944, forcedText = {npcID = 210075},},
				{77864, forcedText = {npcID = 209620},},
				{77989, forcedText = {npcID = 209919},},
				{78211, forcedText = {npcID = 210046},},
				{78213, forcedText = {npcID = 210051},},
				{77941, forcedText = {npcID = 208658},},
				{77943, forcedText = {npcID = 210064},},
				{78210, forcedText = {npcID = 210045},},
				{77940, forcedText = {npcID = 210070},},
				{77570, forcedText = {npcID = 209113},},
				{77890, forcedText = {npcID = 210161},},
				{78212, forcedText = {npcID = 210047},},
				{77863, forcedText = {npcID = 209365},},
				{78263, forcedText = {npcID = 210111},},
				{77994, forcedText = {npcID = 209902},},
				{77990, forcedText = {npcID = 209911},},
				{78214, forcedText = {npcID = 210508},},
				{78039, forcedText = {npcID = 210559},},
				{77859, forcedText = {npcID = 209912},},
				{77856, forcedText = {npcID = 209915},},
			},
			-- forcedMaxQuest = 27,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2200)..": "..L["Treasures"]
			end,
			name_save = "EmeraldDream_Treasures",
			defS = false,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{77872, forcedText = {itemID = 208067}, addText = {coords = 34105633}, }, -- Item -- quest = {77855, 77857, 77860, 77872},
				{78006, forcedText = {itemID = 208067}, addText = {coords = 55275726}, }, -- item
				{77950, forcedText = {itemID = 208047}, addText = {coords = 39146553}, },
				{78005, forcedText = {itemID = 208047}, addText = {coords = 61625960}, },
				{78107, forcedText = {itemID = 210434}, addText = {coords = 47055309}, }, -- Transmog
				{78359, forcedText = {itemID = 210631}, addText = {coords = 63863509}, }, -- Transmog
				{77858, forcedText = {itemID = 210725}, addText = {coords = 47493485}, }, -- toy
				{78120, forcedText = {itemID = 210411}, addText = {coords = 37263069}, }, -- toy
				{78360, forcedText = {itemID = 210659}, addText = {coords = 64231928}, }, -- Transmog
				{78361, forcedText = {itemID = 210660}, addText = {coords = 32938325}, }, -- Transmog
				{78550, forcedText = {itemID = 210686}, addText = {coords = 69575284}, }, -- Transmog
				{78551, forcedText = {itemID = 210678}, addText = {coords = 55324538}, }, -- Transmog
				{78547, forcedText = {itemID = 210675}, addText = {coords = 55672258}, }, -- Transmog
				{78552, forcedText = {itemID = 210682}, addText = {coords = 46408615}, }, -- Transmog
				{78831, forcedText = {itemID = 210049}, addText = {coords = 49816171}, }, -- Book
				{78911, forcedText = {itemID = 210737}, addText = {coords = 60834489}, }, -- Book
				{78833, forcedText = {itemID = 208649}, addText = {coords = 54462464}, }, -- Book
				{78834, forcedText = {itemID = 210346}, addText = {coords = 59641910}, }, -- Book
				{78835, forcedText = {itemID = 208619}, addText = {coords = 53712395}, }, -- Book
			},
			-- forcedMaxQuest = 19,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2200)..": "..E.func_GetQuestName(78381, false)
			end,
			name_save = "EmeraldDream_DreamsUnified",
			defS = false,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{78381},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2200)..": ".."Seeds"
			end,
			name_save = "EmeraldDream_Seeds",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{77350, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Seeds".." 1"},},
				{77353, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Seeds".." 2"},},
				{77354, addText = {IconVignette = "VignetteLoot",}, forcedText = {text = "Seeds".." 3"},},
			},
			forcedMaxQuest = 5,
		},
		-- {
		-- sorted = false,
		-- showTooltip = true,
		-- TextLeft = function()
		-- return E.func_GetMapName(2200)..": ".."TheGilneasReclamation_Storylines"
		-- end,
		-- name_save = "TheGilneasReclamation_Storylines",
		-- defS = true,
		-- reset = "Regular",
		-- desc = categoryKey,
		-- quests = {
		-- {78178},
		-- {78180},
		-- {78181},
		-- {78182},
		-- {78183},
		-- {78184},
		-- {78185},
		-- {78186},
		-- {78187},
		-- {78188},
		-- {78189},
		-- {78597},
		-- {79137},
		-- },
		-- forcedMaxQuest = 13,
		-- },
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2239)..": "..L["Treasures"]
			end,
			name_save = "Amirdrassil_Treasures",
			defS = false,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				-- {82823, addText = {IconVignette = "VignetteLoot",},  addText = {itemID = 213012}, forcedText = {text = L["Treasure"].." 1"},}, -- 79490, 53475574
				-- {82826, addText = {IconVignette = "VignetteLoot",},  addText = {itemID = 213008}, forcedText = {text = L["Treasure"].." 2"},}, -- 79496, 31311613
				-- {82831, addText = {IconVignette = "VignetteLoot",},  addText = {itemID = 213160}, forcedText = {text = L["Treasure"].." 3"},}, -- 79520, 29042885
				-- {82829, addText = {IconVignette = "VignetteLoot",},  addText = {itemID = 213011}, forcedText = {text = L["Treasure"].." 4"},}, -- 79499, 47905688
				-- {82830, addText = {IconVignette = "VignetteLoot",},  addText = {itemID = 213013}, forcedText = {text = L["Treasure"].." 5"},}, -- 79500, 51910589
				-- {82821, addText = {IconVignette = "VignetteLoot",},  addText = {itemID = 213010}, forcedText = {text = L["Treasure"].." 6"},}, -- 79472, 55306436
				-- {82824, addText = {IconVignette = "VignetteLoot",},  addText = {itemID = 213009}, forcedText = {text = L["Treasure"].." 7"},}, -- 79493, 48287641
				-- {82827, addText = {IconVignette = "VignetteLoot",},  addText = {itemID = 213007}, forcedText = {text = L["Treasure"].." 8"},}, -- 79497, 49137030
				-- {82828, addText = {IconVignette = "VignetteLoot",},  addText = {itemID = 213006}, forcedText = {text = L["Treasure"].." 9"},}, -- 79498, 58465190
				-- {82822, addText = {IconVignette = "VignetteLoot",},  addText = {itemID = 213003}, forcedText = {text = L["Treasure"].." 10"},}, -- 79473, 54697720
				-- {82825, addText = {IconVignette = "VignetteLoot",},  addText = {itemID = 213005}, forcedText = {text = L["Treasure"].." 11"},}, -- 79494, 52541771
				{82823, forcedText = {itemID = 213012}, addText = {coords = 53475574}, }, -- 79490,
				{82826, forcedText = {itemID = 213008}, addText = {coords = 31311613}, }, -- 79496,
				{82831, forcedText = {itemID = 213160}, addText = {coords = 29042885}, }, -- 79520,
				{82829, forcedText = {itemID = 213011}, addText = {coords = 47905688}, }, -- 79499,
				{82830, forcedText = {itemID = 213013}, addText = {coords = 51910589}, }, -- 79500,
				{82821, forcedText = {itemID = 213010}, addText = {coords = 55306436}, }, -- 79472,
				{82824, forcedText = {itemID = 213009}, addText = {coords = 48287641}, }, -- 79493,
				{82827, forcedText = {itemID = 213007}, addText = {coords = 49137030}, }, -- 79497,
				{82828, forcedText = {itemID = 213006}, addText = {coords = 58465190}, }, -- 79498,
				{82822, forcedText = {itemID = 213003}, addText = {coords = 54697720}, }, -- 79473,
				{82825, forcedText = {itemID = 213005}, addText = {coords = 52541771}, }, -- 79494,
			},
			-- forcedMaxQuest = 11,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2133)..": "..E.func_GetQuestName(75665, true)
			end,
			name_save = "ZaralekCavernAWorthyAllyLoammNiffen",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{75665},
			},
			-- forcedMaxQuest = 1,
		},
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2133)..": ".."Rares"
			end,
			name_save = "ZaralekCavernRares",
			defS = true,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{75271, forcedText = {npcID = 203468},},
				{75285, forcedText = {npcID = 203515},},
				{75298, forcedText = {npcID = 203593},},
				{75326, forcedText = {npcID = 203621},},
				{75576, forcedText = {npcID = 204096},}, --WHAT?
				{75314, forcedText = {npcID = 203611},},
				{75296, forcedText = {npcID = 203592},},
				{75353, forcedText = {npcID = 203646},},
				{75358, forcedText = {npcID = 203660},},
				{75274, forcedText = {npcID = 203477},},
				{75366, forcedText = {npcID = 201029},},
				{75336, forcedText = {npcID = 203627},},
				{75269, forcedText = {npcID = 203466},},
				{75334, forcedText = {npcID = 203625},},
				{75322, forcedText = {npcID = 203618},},
				{75267, forcedText = {npcID = 203462},},
				{75476, forcedText = {npcID = 204093},},
				{75276, forcedText = {npcID = 203480},},
				{75342, forcedText = {npcID = 203642},},
				{75338, forcedText = {npcID = 203630},},
				{75340, forcedText = {npcID = 200111},},
				{75360, forcedText = {npcID = 203662},},
				{75292, forcedText = {npcID = 203521},},
				{75349, forcedText = {npcID = 203643},},
				{75364, forcedText = {npcID = 203664},},
			},
			-- forcedMaxQuest = 25,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2133)..": ".."Events"
			end,
			name_save = "ZaralekCavernEvents",
			defS = false,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{75612},
				{75471},
				{75455},
				{75664},
				{75611},
				{75478},
				{75451},
				{75461},
				{75705},
				{75454},
				{75450},
				{75222},
				{75370},
				{75494},
				{75441},
				{75156},
				{75624},
				{74352},
			},
			-- forcedMaxQuest = 18,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2133)..": "..L["Sniffenseeking"]
			end,
			name_save = "ZaralekCavernSniffenseeking",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{75459},
				{76027},
				{75621},
				{75397},
				{75517},
				{75619},
				{76014},
				{75620},
				{76081},
				{75390},
				{75234},
				{75516},
				{75996},
				{76016},
				{75393},
				{76015},
				{76084},
			},
			-- forcedMaxQuest = 17,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2133)..": ".. L["Sniffenseeking"].." ("..ITEMS..")"
			end,
			name_save = "ZaralekCavernSniffenseekingItems",
			defS = false,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{75771},
				{75772},
				{75767},
				{75768},
				{75765},
				{75936},
				{75766},
				{75769},
				{75770},
				{75998},
				{75773},
				{76004},
			},
			-- forcedMaxQuest = 12,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2133)..": "..E.func_GetQuestName(74906, false).." "..E.Timers.DF_ResearchersUnderFire()
			end,
			name_save = "ResearchersUnderFire",
			defS = true,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{75630, forcedText = {text = MAW_BUFF_QUALITY_STRING_EPIC}},
				{75629, forcedText = {text = MAW_BUFF_QUALITY_STRING_RARE}},
				{75628, forcedText = {text = MAW_BUFF_QUALITY_STRING_UNCOMMON}},
				{75627, forcedText = {text = MAW_BUFF_QUALITY_STRING_COMMON}},
			},
			-- forcedMaxQuest = 4,
		},
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2151)..": ".."Rares" -- Запретный край.
			end,
			name_save = "TheForbiddenReachRares",
			defS = true,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{74331, forcedText = {npcID = 200740},},
				{74347, forcedText = {npcID = 201013},},
				{74345, forcedText = {npcID = 200904},},
				{74336, forcedText = {npcID = 200584},},
				{74337, forcedText = {npcID = 200537},},
				{74342, forcedText = {npcID = 200717},},
				{74321, forcedText = {npcID = 200722},},
				{74343, forcedText = {npcID = 200721},},
				{74338, forcedText = {npcID = 200579},},
				{74329, forcedText = {npcID = 200738},},
				{74307, forcedText = {npcID = 200622},},
				{74325, forcedText = {npcID = 200730},},
				{74346, forcedText = {npcID = 201181},},
				{74344, forcedText = {npcID = 200885},},
				{74332, forcedText = {npcID = 200742},},
				{74306, forcedText = {npcID = 200621},},
				{74333, forcedText = {npcID = 200743},},
				{74341, forcedText = {npcID = 200681},},
				{74305, forcedText = {npcID = 200620},},
				{74339, forcedText = {npcID = 200600},},
				{74300, forcedText = {npcID = 200619},},
				{74349, forcedText = {npcID = 200956},},
				{74322, forcedText = {npcID = 200725},},
				{74330, forcedText = {npcID = 200739},},
				{74328, forcedText = {npcID = 200737},},
			},
			-- forcedMaxQuest = 25,
		},
		{
			showTooltip = true,
			TextLeft = E.func_GetMapName(2151)..": "..L["Storm-Bound Chest"],
			name_save = "StormBoundChest",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{74567, forcedText = {text = L["Storm-Bound Chest"]},},
			},
			-- forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2022)..": "..E.func_GetQuestName(66133, false)
			end,
			name_save = "KeysofLoyalty",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{66133},
			},
			-- forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return L["Fyrakk Assaults"] -- 7432 AREA POI ID
			end,
			name_save = "FyrakkAssaults",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{74501},
				{75280},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return L["Disciple of Fyrakk"]
			end,
			name_save = "DiscipleofFyrakk",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{75467, forcedText = {text = L["Disciple of Fyrakk"]},},
			},
			-- forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.func_GetMapName(2025)..": "..L["Time Rift"].." "..E.Timers.DF_TimeRift()
			end,
			name_save = "DFTimeRift",
			defS = false,
			reset = "Weekly",
			desc = categoryKey,
			quests = {
				{77836, forcedText = {text = L["Time Rift"]},},
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			TextLeft = function()
				return E.Timers.DF_Dreamsurges()..E.func_GetQuestName(77414, false)
			end,
			name_save = "DreamsurgeInvestigation",
			defS = false,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{77414},
			},
			forcedMaxQuest = 1,
		},
		-- {
		-- showTooltip = true,
		-- TextLeft = function()
		-- return E.func_GetQuestName(77251, false)
		-- end,
		-- name_save = "ShapingtheDreamsurge",
		-- defS = false,
		-- reset = "Weekly",
		-- desc = categoryKey,
		-- quests = {
		-- {77251},
		-- },
		-- forcedMaxQuest = 1,
		-- },
		-- {
		-- showTooltip = true,
		-- TextLeft = function()
		-- return E.func_GetQuestName(77236, false)
		-- end,
		-- name_save = "WhenTimeNeedsMending",
		-- defS = false,
		-- reset = "Weekly",
		-- desc = categoryKey,
		-- quests = {
		-- {77236},
		-- },
		-- forcedMaxQuest = 1,
		-- },
		{
			showTooltip = true,
			TextLeft = E.func_GetAchievementName(18554),
			name_save = "TemporalAcquisitionsSpecialist",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{76406},
				{76547},
				{76521},
				{76404},
				{76548},
				{76379},
				{76459},
				{76362},
				{76546},
				{76453},
				{76544},
				{76449},
				{76351},
				{76533},
			},
			forcedMaxQuest = 14,
		},
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
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
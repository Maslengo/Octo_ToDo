local GlobalAddonName, E = ...
----------------------------------------------------------------
local enable = true
local Is_WarlordsofDraenor_available = E.Is_WarlordsofDraenor_available
----------------------------------------------------------------
if not enable then return end
if not Is_WarlordsofDraenor_available then return end;
----------------------------------------------------------------
local L = E.L
----------------------------------------------------------------
local categoryKey = 6
local expansionID = 6
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
		{id = 824, defS = true,},
		{id = 1101, defS = true,},
		{id = 823, defS = true,},
		{id = 1129, defS = true,}, -- MONETKA
		{id = 994, defS = true,}, -- MONETKA
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = {
		-- Raid
		{id = 1448, defS = true,}, -- Hellfire Citadel
		{id = 1205, defS = true,}, -- Blackrock Foundry
		{id = 1228, defS = true,}, -- Highmaul
		-- Dungeon
		-- {id = 1358, defS = true,}, -- Upper Blackrock Spire
		-- {id = 1195, defS = true,}, -- Iron Docks
		-- {id = 1279, defS = true,}, -- The Everbloom
		-- {id = 1175, defS = true,}, -- Bloodmaul Slag Mines
		-- {id = 1209, defS = true,}, -- Skyreach
		-- {id = 1176, defS = true,}, -- Shadowmoon Burial Grounds
		-- {id = 1208, defS = true,}, -- Grimrail Depot
		-- {id = 1182, defS = true,}, -- Auchindoun
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
		-- header = {icon = E.OctoTable_Expansions[categoryKey].icon, name = E.OctoTable_Expansions[categoryKey].color..E.OctoTable_Expansions[categoryKey].name.."|r",},
		-- ["Warlords of Draenor"] = {
		{id = 1850, defS = true,}, --name = "Охотники за саблеронами", side = "-", category = "Warlords of Draenor", }, --[faction=1850]
		{id = 1849, defS = true,}, --name = "Орден Пробудившихся", side = "-", category = "Warlords of Draenor", }, --[faction=1849]
		{id = 1711, defS = true,}, --name = "Археологическое общество Хитрой Шестеренки", side = "-", category = "Warlords of Draenor", }, --[faction=1711]
		{id = 1515, defS = true,}, --name = "Араккоа-изгои", side = "-", category = "Warlords of Draenor", }, --[faction=1515]
		----------------------------------------------------------------
		{id = 1708, defS = false,}, --name = "Клан Веселого Черепа", side = "-", category = "Warlords of Draenor", }, --[faction=1708] -- ОРДА
		{id = 1445, defS = false,}, --name = "Клан Северного Волка", side = "-", category = "Warlords of Draenor", }, --[faction=1445] -- ОРДА
		{id = 1848, defS = false,}, --name = "Охотники за головами", side = "-", category = "Warlords of Draenor", }, --[faction=1848] -- ОРДА
		----------------------------------------------------------------
		{id = 1731, defS = false,}, --name = "Совет экзархов", side = "-", category = "Warlords of Draenor", }, --[faction=1731] -- АЛЬЯНС
		{id = 1710, defS = false,}, --name = "Защитники Ша'тар", side = "-", category = "Warlords of Draenor", }, --[faction=1710] -- АЛЬЯНС
		{id = 1847, defS = false,}, --name = "Длань Пророка", side = "-", category = "Warlords of Draenor", }, --[faction=1847] -- АЛЬЯНС
		----------------------------------------------------------------
		{id = 1741, defS = false,}, --name = "Леорадж", side = "-", category = "Телохранители из казарм", }, --[faction=1741]
		{id = 1740, defS = false,}, --name = "Аеда Ясная Заря", side = "-", category = "Телохранители из казарм", }, --[faction=1740]
		{id = 1739, defS = false,}, --name = "Вивианна", side = "-", category = "Телохранители из казарм", }, --[faction=1739]
		{id = 1738, defS = false,}, --name = "Защитница Иллона", side = "-", category = "Телохранители из казарм", }, --[faction=1738]
		{id = 1737, defS = false,}, --name = "Жрец Когтя Ишааль", side = "-", category = "Телохранители из казарм", }, --[faction=1737]
		{id = 1736, defS = false,}, --name = "Тормок", side = "-", category = "Телохранители из казарм", }, --[faction=1736]
		{id = 1733, defS = false,}, --name = "Делвар Железный Кулак", side = "-", category = "Телохранители из казарм", }, --[faction=1733]
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
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
				{37460, forcedText = {npcID = 81252}, addText = {mapID = 543}, }, -- Drov the Ruiner (Горгронд)
				{37462, forcedText = {npcID = 81535}, addText = {mapID = 543}, }, -- Tarlna the Ageless (Горгронд)
				{37464, forcedText = {npcID = 87493}, addText = {mapID = 542}, }, -- Rukhmar (Пики Аррака)
				{39380, forcedText = {npcID = 94015}, addText = {mapID = 534}, }, -- Supreme Lord Kazzak (Джунгли)
			},
			forcedMaxQuest = 4,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return GARRISON_LOCATION_TOOLTIP
			end,
			name_save = "GarrisonLevel",
			defS = true,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{34378, FactionOrClass = {Horde = true,},},
				{34586, FactionOrClass = {Alliance = true,},},
				{36567, FactionOrClass = {Horde = true,},},
				{36592, FactionOrClass = {Alliance = true,},},
				{36614, FactionOrClass = {Horde = true,},},
				{36615, FactionOrClass = {Alliance = true,},},
			},
			rewards = {
				-- {rewID = 823, rewTYPE = "currency", rewSIZE = "800-1000",}, -- Apexis Crystal
				-- {rewID = 3316, rewTYPE = "currency", rewSIZE = 150,}, -- Voidlight Marl
				-- {rewID = 3318, rewTYPE = "currency", rewSIZE = 1500,}, -- Delver's Journey
				{rewID = 173838, rewTYPE = "spell", rewSIZE = nil,}, -- Book of Garrison Blueprints
				{rewID = 110560, rewTYPE = "item", rewSIZE = 1,}, -- Garrison Hearthstone
				{rewID = 244315, rewTYPE = "item", rewSIZE = 1,}, -- Orcish Warlord's Planning Table
				{rewID = 248800, rewTYPE = "item", rewSIZE = 1,}, -- Architect's Drafting Table

			},
			forcedMaxQuest = 3,
		},




		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("quest", 39246, false) -- Владычество над морями
			end,
			name_save = "Garrison_NavalDomination",
			defS = false,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{39246, FactionOrClass = {Horde = true,},},
				{39068, FactionOrClass = {Alliance = true,},},
			},
			rewards = {
				-- {rewID = 823, rewTYPE = "currency", rewSIZE = "800-1000",}, -- Apexis Crystal
				-- {rewID = 3316, rewTYPE = "currency", rewSIZE = 150,}, -- Voidlight Marl
				-- {rewID = 3318, rewTYPE = "currency", rewSIZE = 1500,}, -- Delver's Journey
				{rewID = 187788, rewTYPE = "spell", rewSIZE = nil,}, -- Garrison: Shipyard, Level 3
				{rewID = 127267, rewTYPE = "item", rewSIZE = 1,}, -- Ship Blueprint: Carrier
				-- {rewID = 254677, rewTYPE = "item", rewSIZE = 1,}, -- Apex Cache (Pinnacle Cache - Midnight Preseason)
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = false,
			showTooltip = true,
			TextLeft = function()
				return E.func_GetName("quest", 38242, false) -- Раскопанная магия
			end,
			name_save = "Garrison_UnearthedMagic",
			defS = false,
			reset = "Regular",
			desc = categoryKey,
			quests = {
				{38242, FactionOrClass = {Horde = true,},},
				{38241, FactionOrClass = {Alliance = true,},},
			},
			rewards = {
				-- {rewID = 823, rewTYPE = "currency", rewSIZE = "800-1000",}, -- Apexis Crystal
				-- {rewID = 3316, rewTYPE = "currency", rewSIZE = 150,}, -- Voidlight Marl
				-- {rewID = 3318, rewTYPE = "currency", rewSIZE = 1500,}, -- Delver's Journey
				-- {rewID = 1262418, rewTYPE = "spell", rewSIZE = nil,}, -- Spark of Radiance
				{rewID = 122457, rewTYPE = "item", rewSIZE = 1,}, -- Ultimate Battle-Training Stone
				-- {rewID = 254677, rewTYPE = "item", rewSIZE = 1,}, -- Apex Cache (Pinnacle Cache - Midnight Preseason)
			},
			forcedMaxQuest = 1,
		},
		{
			sorted = true,
			showTooltip = true,
			TextLeft = function()
				-- return E.func_GetName("quest", 38242, false) -- Раскопанная магия
				return L["Garrison_Assault"]
			end,
			name_save = "Garrison_Assault",
			defS = false,
			reset = "Daily",
			desc = categoryKey,
			quests = {
				{36649, FactionOrClass = {Alliance = true,},},
				{36679, FactionOrClass = {Alliance = true,},},
				{36676, FactionOrClass = {Alliance = true,},},
				{36681, FactionOrClass = {Alliance = true,},},
				{36648, FactionOrClass = {Alliance = true,},},
				{36675, FactionOrClass = {Alliance = true,},},
				{36680, FactionOrClass = {Alliance = true,},},
				{36677, FactionOrClass = {Alliance = true,},},
				{36683, FactionOrClass = {Alliance = true,},},
				{36678, FactionOrClass = {Alliance = true,},},
				{36685, FactionOrClass = {Alliance = true,},},
				{36684, FactionOrClass = {Alliance = true,},},
				{38201, FactionOrClass = {Alliance = true,},},
				{38196, FactionOrClass = {Alliance = true,},},
				{38192, FactionOrClass = {Alliance = true,},},
				{38198, FactionOrClass = {Alliance = true,},},
				{38189, FactionOrClass = {Alliance = true,},},
				{38190, FactionOrClass = {Alliance = true,},},
				{38197, FactionOrClass = {Alliance = true,},},
				{38193, FactionOrClass = {Alliance = true,},},
				{38200, FactionOrClass = {Alliance = true,},},
				{40944, FactionOrClass = {Alliance = true,},},
				{40942, FactionOrClass = {Alliance = true,},},
				{38199, FactionOrClass = {Alliance = true,},},
				{38191, FactionOrClass = {Alliance = true,},},
				{36686, FactionOrClass = {Alliance = true,},},
				{36682, FactionOrClass = {Alliance = true,},},
				{36674, FactionOrClass = {Alliance = true,},},
				{36687, FactionOrClass = {Alliance = true,},},
				{38195, FactionOrClass = {Alliance = true,},},

				{36667, FactionOrClass = {Horde = true,},},
				{36692, FactionOrClass = {Horde = true,},},
				{36695, FactionOrClass = {Horde = true,},},
				{36669, FactionOrClass = {Horde = true,},},
				{36697, FactionOrClass = {Horde = true,},},
				{36694, FactionOrClass = {Horde = true,},},
				{36688, FactionOrClass = {Horde = true,},},
				{36693, FactionOrClass = {Horde = true,},},
				{36699, FactionOrClass = {Horde = true,},},
				{36698, FactionOrClass = {Horde = true,},},
				{36700, FactionOrClass = {Horde = true,},},
				{38187, FactionOrClass = {Horde = true,},},
				{38182, FactionOrClass = {Horde = true,},},
				{38179, FactionOrClass = {Horde = true,},},
				{38176, FactionOrClass = {Horde = true,},},
				{38177, FactionOrClass = {Horde = true,},},
				{38183, FactionOrClass = {Horde = true,},},
				{38186, FactionOrClass = {Horde = true,},},
				{40943, FactionOrClass = {Horde = true,},},
				{38181, FactionOrClass = {Horde = true,},},
				{40941, FactionOrClass = {Horde = true,},},
				{38185, FactionOrClass = {Horde = true,},},
				{38178, FactionOrClass = {Horde = true,},},
				{36701, FactionOrClass = {Horde = true,},},
				{36689, FactionOrClass = {Horde = true,},},
				{36696, FactionOrClass = {Horde = true,},},
				{36690, FactionOrClass = {Horde = true,},},
				{36691, FactionOrClass = {Horde = true,},},
				{38184, FactionOrClass = {Horde = true,},},
				{38180, FactionOrClass = {Horde = true,},},
			},
			rewards = {
				{rewID = 823, rewTYPE = "currency", rewSIZE = "800-1000",}, -- Apexis Crystal
				-- {rewID = 3316, rewTYPE = "currency", rewSIZE = 150,}, -- Voidlight Marl
				-- {rewID = 3318, rewTYPE = "currency", rewSIZE = 1500,}, -- Delver's Journey
				-- {rewID = 1262418, rewTYPE = "spell", rewSIZE = nil,}, -- Spark of Radiance
				-- {rewID = 268490, rewTYPE = "item", rewSIZE = 1,}, -- Apex Cache (Pinnacle Cache - Midnight Season 1)
				-- {rewID = 254677, rewTYPE = "item", rewSIZE = 1,}, -- Apex Cache (Pinnacle Cache - Midnight Preseason)
			},
			forcedMaxQuest = 1,
		},
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
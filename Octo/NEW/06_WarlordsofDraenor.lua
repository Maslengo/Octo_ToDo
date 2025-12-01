local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local currentSTATE = 6
E.OctoTables_DataOtrisovka[currentSTATE] = {}
E.OctoTables_Vibor[currentSTATE] = {}
E.OctoTables_Vibor[currentSTATE].icon = E.OctoTable_Expansions[currentSTATE].icon
E.OctoTables_Vibor[currentSTATE].name = E.OctoTable_Expansions[currentSTATE].color..E.OctoTable_Expansions[currentSTATE].name
local function localfunc()
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[currentSTATE].Currencies = {
		824,
		1101,
		823,
		1129, -- MONETKA
		994, -- MONETKA
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[currentSTATE].Items = {
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[currentSTATE].Reputations = {
		-- header = {icon = E.OctoTable_Expansions[currentSTATE].icon, name = E.OctoTable_Expansions[currentSTATE].color..E.OctoTable_Expansions[currentSTATE].name.."|r",},
		-- ["Warlords of Draenor"] = {
		1850, --name = "Охотники за саблеронами", side = "-", category = "Warlords of Draenor", }, --[faction=1850]
		1849, --name = "Орден Пробудившихся", side = "-", category = "Warlords of Draenor", }, --[faction=1849]
		1711, --name = "Археологическое общество Хитрой Шестеренки", side = "-", category = "Warlords of Draenor", }, --[faction=1711]
		1515, --name = "Араккоа-изгои", side = "-", category = "Warlords of Draenor", }, --[faction=1515]
		----------------------------------------------------------------
		1708, --name = "Клан Веселого Черепа", side = "-", category = "Warlords of Draenor", }, --[faction=1708] -- ОРДА
		1445, --name = "Клан Северного Волка", side = "-", category = "Warlords of Draenor", }, --[faction=1445] -- ОРДА
		1848, --name = "Охотники за головами", side = "-", category = "Warlords of Draenor", }, --[faction=1848] -- ОРДА
		----------------------------------------------------------------
		1731, --name = "Совет экзархов", side = "-", category = "Warlords of Draenor", }, --[faction=1731] -- АЛЬЯНС
		1710, --name = "Защитники Ша'тар", side = "-", category = "Warlords of Draenor", }, --[faction=1710] -- АЛЬЯНС
		1847, --name = "Длань Пророка", side = "-", category = "Warlords of Draenor", }, --[faction=1847] -- АЛЬЯНС
		----------------------------------------------------------------
		1741, --name = "Леорадж", side = "-", category = "Телохранители из казарм", }, --[faction=1741]
		1740, --name = "Аеда Ясная Заря", side = "-", category = "Телохранители из казарм", }, --[faction=1740]
		1739, --name = "Вивианна", side = "-", category = "Телохранители из казарм", }, --[faction=1739]
		1738, --name = "Защитница Иллона", side = "-", category = "Телохранители из казарм", }, --[faction=1738]
		1737, --name = "Жрец Когтя Ишааль", side = "-", category = "Телохранители из казарм", }, --[faction=1737]
		1736, --name = "Тормок", side = "-", category = "Телохранители из казарм", }, --[faction=1736]
		1733, --name = "Делвар Железный Кулак", side = "-", category = "Телохранители из казарм", }, --[faction=1733]
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[currentSTATE].UniversalQuests = {
		{
			sorted = false,
			showTooltip = true,
			textleft = L["World Boss"],
			name_save = "WorldBoss",
			reset = "Weekly",
			desc = currentSTATE,
			quests = {
				{37460, forcedText = {npcID = 81252}, addText = {mapID = 543},  }, -- Drov the Ruiner (Горгронд)
				{37462, forcedText = {npcID = 81535}, addText = {mapID = 543},  }, -- Tarlna the Ageless (Горгронд)
				{37464, forcedText = {npcID = 87493}, addText = {mapID = 542},  }, -- Rukhmar (Пики Аррака)
				{39380, forcedText = {npcID = 94015}, addText = {mapID = 534},  }, -- Supreme Lord Kazzak (Джунгли)
			},
			forcedMaxQuest = 4,
		},
		{
			sorted = false,
			showTooltip = true,
			textleft = GARRISON_LOCATION_TOOLTIP,
			name_save = "GarrisonLevel",
			reset = "Once",
			desc = currentSTATE,
			quests = {
				{34378, faction = "Horde",},
				{34586, faction = "Alliance",},
				{36567, faction = "Horde",},
				{36592, faction = "Alliance",},
				{36614, faction = "Horde",},
				{36615, faction = "Alliance",},
			},
			forcedMaxQuest = 3,
		},
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[currentSTATE].Additionally = {
	}
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function localfunc2()
	return
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
tinsert(E.newOTRISOVKA, localfunc)
tinsert(E.newOTRISOVKA2, localfunc2)

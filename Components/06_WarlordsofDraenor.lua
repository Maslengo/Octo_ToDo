local GlobalAddonName, E = ...
----------------------------------------------------------------
local enable = true
local Is_WarlordsofDraenor_available = E.func_Is_WarlordsofDraenor_available()
----------------------------------------------------------------
if not enable then return end
if not Is_WarlordsofDraenor_available then return end;
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale(E.MainAddonName)
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
			{id = 669, defS = true,}, -- Hellfire Citadel
			{id = 457, defS = true,}, -- Blackrock Foundry
			{id = 477, defS = true,}, -- Highmaul
			-- {id = 557, defS = true,}, -- Draenor
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
		{id = 1708, defS = true,}, --name = "Клан Веселого Черепа", side = "-", category = "Warlords of Draenor", }, --[faction=1708] -- ОРДА
		{id = 1445, defS = true,}, --name = "Клан Северного Волка", side = "-", category = "Warlords of Draenor", }, --[faction=1445] -- ОРДА
		{id = 1848, defS = true,}, --name = "Охотники за головами", side = "-", category = "Warlords of Draenor", }, --[faction=1848] -- ОРДА
		----------------------------------------------------------------
		{id = 1731, defS = true,}, --name = "Совет экзархов", side = "-", category = "Warlords of Draenor", }, --[faction=1731] -- АЛЬЯНС
		{id = 1710, defS = true,}, --name = "Защитники Ша'тар", side = "-", category = "Warlords of Draenor", }, --[faction=1710] -- АЛЬЯНС
		{id = 1847, defS = true,}, --name = "Длань Пророка", side = "-", category = "Warlords of Draenor", }, --[faction=1847] -- АЛЬЯНС
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
			TextLeft = L["World Boss"],
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
			TextLeft = GARRISON_LOCATION_TOOLTIP,
			name_save = "GarrisonLevel",
			defS = true,
			reset = "Once",
			desc = categoryKey,
			quests = {
				{34378, FactionOrClass = {Horde = true,},},
				{34586, FactionOrClass = {Alliance = true,},},
				{36567, FactionOrClass = {Horde = true,},},
				{36592, FactionOrClass = {Alliance = true,},},
				{36614, FactionOrClass = {Horde = true,},},
				{36615, FactionOrClass = {Alliance = true,},},
			},
			forcedMaxQuest = 3,
		},
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Additionally = {
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)
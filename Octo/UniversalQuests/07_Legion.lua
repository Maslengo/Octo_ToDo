local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
function E.func_Universal_07_Legion()
	local OctoTable_Universal = {
		{
			sorted = false,
			showTooltip = true,
			textleft = L["World Boss"],
			name_save = "WorldBoss",
			reset = "Weekly",
			desc = "Legion",
			quests = {
				{43193, forcedText = {npcID = 109331}, addText = {mapID = 630},}, -- Каламир 109331 Азсуна  (4).
				{43192, forcedText = {npcID = 108829}, addText = {mapID = 630},}, -- Левантия 108829 Азсуна  (2).
				{44287, forcedText = {npcID = 102075}, addText = {mapID = 630},}, -- Иссохший Дж'им 102075 Азсуна  (4).
				{nil},
				{42819, forcedText = {npcID = 108879}, addText = {mapID = 641},}, -- Хумонгрис <Чародей> 108879 Валь'шара  (5).
				{42779, forcedText = {npcID = 108678}, addText = {mapID = 641},}, -- Шар'тос 108678 Валь'шара  (6).
				{nil},
				{43448, forcedText = {npcID = 110378}, addText = {mapID = 650},}, -- Драгон Зиморожденный 110378 Крутогорье  (4).
				{43985, forcedText = {npcID = 99929}, addText = {mapID = 650},}, -- Обломок 99929 Крутогорье  (2).
				{nil},
				{42270, forcedText = {npcID = 107023}, addText = {mapID = 634},}, -- Нитхегг 107023 Штормхейм  (3).
				{42269, addText = {mapID = 634},}, -- Капитан Хринг 106981, Пленительница душ Мевра 106984, Разоритель Йдорн 106982, Штормхейм  (5).
				{nil},
				{43512, forcedText = {npcID = 109943}, addText = {mapID = 680},}, --  Ана-Муз 109943 Сурамар .
				{43513, forcedText = {npcID = 110321}, addText = {mapID = 680},}, -- На'зак Одержимый 110321 Сурамар  (10).
				{nil},
				{47061, forcedText = {npcID = 121124}, addText = {mapID = 646},}, -- Апокрон 121124 Расколотый берег  (4).
				{46947, forcedText = {npcID = 117239}, addText = {mapID = 646},}, -- Бруталл 117239 Расколотый берег  (6).
				{46948, forcedText = {npcID = 117303}, addText = {mapID = 646},}, -- Малификус 117303 Расколотый берег  (6).
				{46945, forcedText = {npcID = 117470}, addText = {mapID = 646},}, -- Си'ваш 117470 Расколотый берег  (6).
			},
			forcedMaxQuest = 1,
		},
		{
			showTooltip = true,
			textleft = E.func_questName(43533),
			name_save = "BalanceofPower",
			reset = "Once",
			desc = "Legion",
			MainquestID = 43533,
			quests = {
				{43496},
				{43503},
				{43501},
				{43505},
				{40668},
				{43514},
				{43517},
				{43518},
				{43519},
				{43581},
				{43520},
				{43521},
				{43522},
				{43938},
				{43527},
				{43937},
				{43523},
				{40673},
				{43524},
				{40675},
				{43525},
				{40678},
				{43526},
				{40603},
				{40608},
				{40613},
				{40614},
				{40672},
				{40615},
				{43898},
				{43528},
				{43530},
				{43531},
				{43532},
				{43533},
			},
			forcedMaxQuest = 33,
		},
		{
			showTooltip = true,
			textleft = E.Timers.Legion_Invasion(),
			name_save = "InvasionQuests",
			reset = "Daily",
			desc = "Legion",
			quests = {
				{45838},
				{45812},
				{45840},
				{45839},
			},
			forcedMaxQuest = 1,
		},
	}
	return OctoTable_Universal
end
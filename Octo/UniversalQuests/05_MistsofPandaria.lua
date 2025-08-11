local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
function E.func_Universal_05_MistsofPandaria()
	local OctoTable_Universal = {
		{

			showTooltip = true,
			textleft = L["World Boss"],
			name_save = "WorldBoss",
			reset = "Weekly",
			desc = "MistsofPandaria",
			quests = {
				{33118, forcedText = {npcID = 72057},  addText = {mapID = 554},   }, -- Ordos <Fire-God of the Yaungol> (Вневременный остров)
				{33117, forcedText = {achievementID = 7333},  addText = {mapID = 554},   }, -- Celestrials (Вневременный остров)
				{32519, forcedText = {npcID = 69161},  addText = {mapID = 507},   }, -- "Oondasta" (Остров Великанов

				-- {33109}, -- Nalak HIDDEN
				{32518, forcedText = {npcID = 69099},  addText = {mapID = 504},   }, -- "Nalak, The Storm Lord" (Остров Грома)

				{32098, forcedText = {npcID = 62346},  addText = {mapID = 376},   }, -- "Salyis's Warband" (Долина Четырех Ветров)
				{32099, forcedText = {npcID = 60491},  addText = {mapID = 379},   }, -- "Sha of Anger" (Вершина Кунь-Лай)
			},
			-- forcedMaxQuest = 6,
		},
	}
	return OctoTable_Universal
end
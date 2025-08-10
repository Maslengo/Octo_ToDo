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
				{33118, forcedText = {npcID = 72057},}, -- Ordos <Fire-God of the Yaungol>
				{33117, forcedText = {achievementID = 7333},}, -- Celestrials
				{32519, forcedText = {npcID = 69161},}, -- "Oondasta"

				-- {33109}, -- Nalak HIDDEN
				{32518, forcedText = {npcID = 69099},}, -- "Nalak, The Storm Lord"

				{32098, forcedText = {npcID = 62346},}, -- "Salyis's Warband"
				{32099, forcedText = {npcID = 60491},}, -- "Sha of Anger"
			},
			-- forcedMaxQuest = 6,
		},
	}
	return OctoTable_Universal
end
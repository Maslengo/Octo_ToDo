local GlobalAddonName, E = ...
----------------------------------------------------------------
-- https://warcraft.wiki.gg/wiki/DifficultyID
----------------------------------------------------------------
E.OctoTable_DifficultyTable = {
	-- 1. Looking For Raid / Story
	[151] = {prior = 1, abbr = "LFR"}, -- Looking For Raid (Timewalking)
	[17] = {prior = 2, abbr = "LFR"}, -- Looking For Raid
	[7] = {prior = 3, abbr = "LFR"}, -- Looking For Raid (Legacy)
	[220] = {prior = 4, abbr = "Solo"}, -- Story (solo) raid

	-- 2. Normal
	[1] = {prior = 5, abbr = "N"}, -- Normal (party)
	[150] = {prior = 6, abbr = "N"}, -- Normal (party)
	[14] = {prior = 7, abbr = "N"}, -- Normal (raid)
	[3] = {prior = 8, abbr = "10N"}, -- 10 Player (Normal)
	[4] = {prior = 9, abbr = "25N"}, -- 25 Player (Normal)
	[9] = {prior = 10, abbr = "40N"}, -- 40 Player (Normal)
	[12] = {prior = 11, abbr = "NS"}, -- Normal Scenario
	[38] = {prior = 12, abbr = "NS"}, -- Normal Scenario
	[147] = {prior = 13, abbr = "N"}, -- Normal (Warfronts)

	-- 3. Heroic
	[2] = {prior = 14, abbr = "H"}, -- Heroic (party)
	[15] = {prior = 15, abbr = "H"}, -- Heroic (raid)
	[5] = {prior = 16, abbr = "10H"}, -- 10 Player (Heroic)
	[6] = {prior = 17, abbr = "25H"}, -- 25 Player (Heroic)
	[11] = {prior = 18, abbr = "HS"}, -- Heroic Scenario
	[39] = {prior = 19, abbr = "HS"}, -- Heroic Scenario
	[149] = {prior = 20, abbr = "H"}, -- Heroic (Warfronts)
	[230] = {prior = 21, abbr = "H"}, -- Heroic (none)

	-- 4. Mythic
	[23] = {prior = 22, abbr = "M"}, -- Mythic (party)
	[16] = {prior = 23, abbr = "M"}, -- Mythic (raid)
	[40] = {prior = 24, abbr = "MS"}, -- Mythic Scenario

	-- 5. Mythic Keystone
	[8] = {prior = 25, abbr = "M+"}, -- Mythic Keystone

	-- 6. Timewalking
	[24] = {prior = 26, abbr = "TW"}, -- Timewalking (party)
	[33] = {prior = 27, abbr = "TW"}, -- Timewalking (raid)

	-- 7. PvP / PvEvP
	[34] = {prior = 28, abbr = "PvP"}, -- PvP
	[45] = {prior = 29, abbr = "PvP"}, -- PvP Scenario
	[25] = {prior = 30, abbr = "PvEvP"}, -- PvEvP Scenario
	[32] = {prior = 31, abbr = "WPvP"}, -- World PvP Scenario

	-- 8. Event / Scenario / Story
	[20] = {prior = 32, abbr = "ES"}, -- Event Scenario
	[30] = {prior = 33, abbr = "E"}, -- Event (scenario)
	[18] = {prior = 34, abbr = "E"}, -- Event (raid)
	[19] = {prior = 35, abbr = "E"}, -- Event (party)

	-- 9. Other scenarios / dungeons
	[152] = {prior = 36, abbr = "V"}, -- Visions of N'Zoth
	[153] = {prior = 37, abbr = "TI"}, -- Teeming Island
	[167] = {prior = 38, abbr = "T"}, -- Torghast
	[168] = {prior = 39, abbr = "PoA"}, -- Path of Ascension: Courage
	[169] = {prior = 40, abbr = "PoA"}, -- Path of Ascension: Loyalty
	[170] = {prior = 41, abbr = "PoA"}, -- Path of Ascension: Wisdom
	[171] = {prior = 42, abbr = "PoA"}, -- Path of Ascension: Humility
	[208] = {prior = 43, abbr = "D"}, -- Delves
	[172] = {prior = 44, abbr = "WB"}, -- World Boss
	[192] = {prior = 45, abbr = "CL1"}, -- Challenge Level 1
	[205] = {prior = 46, abbr = "F"}, -- Follower
	[216] = {prior = 47, abbr = "Q"}, -- Quest
}
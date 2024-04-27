local GlobalAddonName, E = ...
local AddonTitle = GetAddOnMetadata(GlobalAddonName, "Title")
--------------------------------------------------------------------------------
E.Octo_Table.OctoTable_instanceDifficulty = {
	1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 14, 15, 16, 17, 18, 19, 20, 23, 24,
	25, 29, 30, 32, 33, 34, 38, 39, 40, 45, 147, 149, 150, 151, 152, 153,
	167, 168, 169, 170, 171, 172, 192,
}
E.Octo_Table.OctoTable_journalInstanceID = {
	33, 34, 36, 43, 47, 48, 70, 90, 109, 129, 209, 229, 230, 249, 269, 289,
	329, 349, 389, 409, 429, 469, 509, 531, 532, 533, 534, 540, 542, 543,
	544, 545, 546, 547, 548, 550, 552, 553, 554, 555, 556, 557, 558, 560,
	564, 565, 568, 574, 575, 576, 578, 580, 585, 595, 599, 600, 601, 602,
	603, 604, 608, 615, 616, 619, 624, 631, 632, 643, 644, 645, 649, 650,
	657, 658, 668, 669, 670, 671, 720, 724, 725, 754, 755, 757, 859, 938,
	939, 940, 959, 960, 961, 962, 967, 994, 996, 1001, 1004, 1007, 1008,
	1009, 1011, 1098, 1136, 1175, 1176, 1182, 1195, 1205, 1208, 1209, 1228,
	1279, 1358, 1448, 1456, 1458, 1466, 1477, 1492, 1493, 1501, 1516, 1520,
	1530, 1544, 1571, 1594, 1648, 1651, 1676, 1677, 1712, 1753, 1754, 1762,
	1763, 1771, 1822, 1841, 1861, 1862, 1864, 1877, 2070, 2096, 2097, 2164,
	2217, 2284, 2285, 2286, 2287, 2289, 2290, 2291, 2293, 2296, 2441, 2450,
	2451, 2481, 2515, 2516, 2519, 2520, 2521, 2522, 2526, 2527, 2569, 2579
}
E.Octo_Table.OctoTable_KeystoneAbbr = {
	{mapChallengeModeID = 2, abbreviation = "TJS"}, -- Temple of the Jade Serpent
	{mapChallengeModeID = 56, abbreviation = "SB"}, -- Stormstout Brewery
	{mapChallengeModeID = 57, abbreviation = "GSS"}, -- Gate of the Setting Sun
	{mapChallengeModeID = 58, abbreviation = "SPM"}, -- Shado-Pan Monastery
	{mapChallengeModeID = 59, abbreviation = "SoNT"}, -- Siege of Niuzao Temple
	{mapChallengeModeID = 60, abbreviation = "MP"}, -- Mogu'shan Palace
	{mapChallengeModeID = 76, abbreviation = "Scho"}, -- Scholomance
	{mapChallengeModeID = 77, abbreviation = "SH"}, -- Scarlet Halls
	{mapChallengeModeID = 78, abbreviation = "SM"}, -- Scarlet Monastery
	{mapChallengeModeID = 161, abbreviation = "Sky"}, -- Skyreach
	{mapChallengeModeID = 163, abbreviation = "BSM"}, -- Bloodmaul Slag Mines
	{mapChallengeModeID = 164, abbreviation = "Auch"}, -- Auchindoun
	{mapChallengeModeID = 165, abbreviation = "SBG"}, -- Shadowmoon Burial Grounds
	{mapChallengeModeID = 166, abbreviation = "GD"}, -- Grimrail Depot
	{mapChallengeModeID = 167, abbreviation = "UBS"}, -- Upper Blackrock Spire
	-- {mapChallengeModeID = 168, abbreviation = "TE"}, -- The Everbloom
	{mapChallengeModeID = 169, abbreviation = "ID"}, -- Iron Docks
	{mapChallengeModeID = 197, abbreviation = "EoA"}, -- Eye of Azshara
	-- {mapChallengeModeID = 198, abbreviation = "DHT"}, -- Darkheart Thicket
	-- {mapChallengeModeID = 199, abbreviation = "BRH"}, -- Black Rook Hold
	{mapChallengeModeID = 200, abbreviation = "HoV"}, -- Halls of Valor
	{mapChallengeModeID = 206, abbreviation = "NL"}, -- Neltharion's Lair
	{mapChallengeModeID = 207, abbreviation = "VotW"}, -- Vault of the Wardens
	{mapChallengeModeID = 208, abbreviation = "MoS"}, -- Maw of Souls
	{mapChallengeModeID = 209, abbreviation = "TA"}, -- The Arcway
	{mapChallengeModeID = 210, abbreviation = "CoS"}, -- Court of Stars
	{mapChallengeModeID = 227, abbreviation = "RtKL"}, -- Return to Karazhan: Lower
	{mapChallengeModeID = 233, abbreviation = "CoEN"}, -- Cathedral of Eternal Night
	{mapChallengeModeID = 234, abbreviation = "RtKU"}, -- Return to Karazhan: Upper
	{mapChallengeModeID = 239, abbreviation = "SotT"}, -- Seat of the Triumvirate
	-- {mapChallengeModeID = 244, abbreviation = "AD"}, -- Atal'Dazar
	{mapChallengeModeID = 245, abbreviation = "FH"}, -- Freehold
	{mapChallengeModeID = 246, abbreviation = "TD"}, -- Tol Dagor
	{mapChallengeModeID = 247, abbreviation = "ML"}, -- The MOTHERLODE!!
	-- {mapChallengeModeID = 248, abbreviation = "WM"}, -- Waycrest Manor
	{mapChallengeModeID = 249, abbreviation = "KR"}, -- Kings' Rest
	{mapChallengeModeID = 250, abbreviation = "ToS"}, -- Temple of Sethraliss
	{mapChallengeModeID = 251, abbreviation = "UNDR"}, -- The Underrot
	{mapChallengeModeID = 252, abbreviation = "SotS"}, -- Shrine of the Storm
	{mapChallengeModeID = 353, abbreviation = "SoB"}, -- Siege of Boralus
	{mapChallengeModeID = 369, abbreviation = "OMJ"}, -- Operation: Mechagon - Junkyard
	{mapChallengeModeID = 370, abbreviation = "OMW"}, -- Operation: Mechagon - Workshop
	{mapChallengeModeID = 375, abbreviation = "MoTS"}, -- Mists of Tirna Scithe
	{mapChallengeModeID = 376, abbreviation = "TNW"}, -- The Necrotic Wake
	{mapChallengeModeID = 377, abbreviation = "DOS"}, -- De Other Side
	{mapChallengeModeID = 378, abbreviation = "HoA"}, -- Halls of Atonement
	{mapChallengeModeID = 379, abbreviation = "PF"}, -- Plaguefall
	{mapChallengeModeID = 380, abbreviation = "SD"}, -- Sanguine Depths
	{mapChallengeModeID = 381, abbreviation = "SoA"}, -- Spires of Ascension
	{mapChallengeModeID = 382, abbreviation = "ToP"}, -- Theater of Pain
	{mapChallengeModeID = 391, abbreviation = "STRT"}, -- Tazavesh: Streets of Wonder
	{mapChallengeModeID = 392, abbreviation = "GMBT"}, -- Tazavesh: So'leah's Gambit
	{mapChallengeModeID = 399, abbreviation = "RLP"}, -- Ruby Life Pools
	{mapChallengeModeID = 400, abbreviation = "NO"}, -- The Nokhud Offensive
	{mapChallengeModeID = 401, abbreviation = "AV"}, -- The Azure Vault
	{mapChallengeModeID = 402, abbreviation = "AA"}, -- Algeth'ar Academy
	{mapChallengeModeID = 403, abbreviation = "ULD"}, -- Uldaman: Legacy of Tyr
	{mapChallengeModeID = 404, abbreviation = "NELT"}, -- Neltharus
	{mapChallengeModeID = 405, abbreviation = "BH"}, -- Brackenhide Hollow
	{mapChallengeModeID = 406, abbreviation = "HOI"}, -- Halls of Infusion
	{mapChallengeModeID = 438, abbreviation = "VP"}, -- The Vortex Pinnacle
	-- {mapChallengeModeID = 456, abbreviation = "TotT"}, -- Throne of the Tides (Cataclysm)
	-- {mapChallengeModeID = 463, abbreviation = "DotI:Galakrond's Fall"}, -- Dawn of the Infinites: Galakrond's Fall
	-- {mapChallengeModeID = 464, abbreviation = "DotI:Murozond's Rise"} -- Dawn of the Infinites: Murozond's Rise
	{mapChallengeModeID = 199, abbreviation = "BRH"}, -- "BRH"}, -- Black Rook Hold
	{mapChallengeModeID = 244, abbreviation = "AD"}, -- "AD"}, -- Atal'Dazar
	{mapChallengeModeID = 463, abbreviation = "FALL"}, -- "DotI:Galakrond's Fall"}, -- Dawn of the Infinites: Galakrond's Fall Dawn of the Infinite: Galakrond's Fall
	{mapChallengeModeID = 464, abbreviation = "RISE"}, -- "DotI:Murozond's Rise"} -- Dawn of the Infinites: Murozond's Rise Dawn of the Infinite: Murozond's Rise
	{mapChallengeModeID = 198, abbreviation = "DHT"}, -- "DHT"}, -- Darkheart Thicket
	{mapChallengeModeID = 168, abbreviation = "EB"}, -- "TE"}, -- The Everbloom
	{mapChallengeModeID = 456, abbreviation = "TOTT"}, -- "TotT"}, -- Throne of the Tides (Cataclysm)
	{mapChallengeModeID = 248, abbreviation = "WM"} -- "WM"}, -- Waycrest Manor
}
E.Octo_Table.OctoTable_LFGDungeons = {
	-- [1045] = "Случайное подземелье Легиона",
	-- [1046] = "Случайное подземелье Легиона (героич.)",
	-- [301] = "Случайное подземелье Cataclysm (героич.)",
	-- [788] = "Случайное подземелье Warlords of Draenor",
	-- [789] = "Случайное подземелье Warlords of Draenor (героич.)",
	-- [1671] = "Случайное подземелье Battle For Azeroth (героич.)",
	-- [434] = "Случайное подземелье \"Времени Сумерек\" (героич.)",
	[287] = "Корен Худовар",
	[285] = "Всадник без головы"
	-- [2087] = "Случайное подземелье Shadowlands (героич.)",
	-- [258] = "Случайное подземелье классической игры",
	-- [259] = "Случайное подземелье Burning Crusade",
	-- [2350] = "Случайное подземелье (Dragonflight)",
	-- [2351] = "Случайное подземелье в героическом режиме (Dragonflight)",
	-- [260] = "Случайное подземелье Burning Crusade (героич.)",
	-- [463] = "Случайное подземелье Mists of Pandaria",
	-- [462] = "Случайное подземелье Mists of Pandaria (героич.)",
	-- [1670] = "Случайное подземелье Battle For Azeroth",
	-- [261] = "Случайное подземелье Lich King",
	-- [300] = "Случайное подземелье Cataclysm",
	-- [2086] = "Случайное подземелье Shadowlands",
	-- [262] = "Случайное подземелье Lich King (героич.)",
}


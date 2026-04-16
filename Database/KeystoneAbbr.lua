local GlobalAddonName, E = ...
--------------------------------------------------------------------------------
E.OctoTable_KeystoneAbbr = {
	-- Wrath of the Lich King
	[556] = {abbreviation = "POS", portal = 1254555}, -- Pit of Saron
	-- Cataclysm
	[438] = {abbreviation = "VP", portal = 410080}, -- The Vortex Pinnacle
	[456] = {abbreviation = "TOTT", portal = 424142}, -- Throne of the Tides (Cataclysm)
	[507] = {abbreviation = "GB", portal = 445424}, -- Grim Batol
	-- Mists of Pandaria
	[2] = {abbreviation = "TJS", portal = 131204}, -- Temple of the Jade Serpent
	-- Warlords of Draenor
	[161] = {abbreviation = "SR", portal = 159898}, -- Skyreach XXX 1254557 seems incorrect
	[165] = {abbreviation = "SBG", portal = 159899}, -- Shadowmoon Burial Grounds
	[166] = {abbreviation = "GD", portal = 159900}, -- Grimrail Depot
	[168] = {abbreviation = "EB", portal = 159901}, -- "TE"}, -- The Everbloom
	[169] = {abbreviation = "ID", portal = 159896}, -- Iron Docks
	-- Legion
	[197] = {abbreviation = "EoA", portal = 000000}, -- Eye of Azshara
	[198] = {abbreviation = "DHT", portal = 424163}, -- Darkheart Thicket
	[199] = {abbreviation = "BRH", portal = 424153}, -- Black Rook Hold
	[200] = {abbreviation = "HOV", portal = 393764}, -- Halls of Valor
	[206] = {abbreviation = "NL", portal = 410078}, -- Neltharion's Lair
	[207] = {abbreviation = "VotW", portal = 000000}, -- Vault of the Wardens
	[208] = {abbreviation = "MoS", portal = 000000}, -- Maw of Souls
	[209] = {abbreviation = "TA", portal = 000000}, -- The Arcway
	[210] = {abbreviation = "CoS", portal = 393766}, -- Court of Stars
	[227] = {abbreviation = "RtKL", portal = 373262}, -- Return to Karazhan: Lower
	[233] = {abbreviation = "CoEN", portal = 000000}, -- Cathedral of Eternal Night
	[234] = {abbreviation = "RtKU", portal = 373262}, -- Return to Karazhan: Upper
	[239] = {abbreviation = "SotT", portal = 1254551}, -- Seat of the Triumvirate
	-- Battle for Azeroth
	[244] = {abbreviation = "AD", portal = 424187}, -- Atal'Dazar
	[245] = {abbreviation = "FH", portal = 410071}, -- Freehold
	[246] = {abbreviation = "TD", portal = 000000}, -- Tol Dagor
	[247] = {abbreviation = "ML", Horde = 467555, Alliance = 467553,}, -- The MOTHERLODE!!
	[248] = {abbreviation = "WM", portal = 424167}, -- Waycrest Manor
	[249] = {abbreviation = "KR", portal = 000000}, -- Kings' Rest
	[250] = {abbreviation = "ToS", portal = 000000}, -- Temple of Sethraliss
	[251] = {abbreviation = "UNDR", portal = 410074}, -- The Underrot
	[252] = {abbreviation = "SOTS", portal = 000000}, -- Shrine of the Storm
	[353] = {abbreviation = "SIEGE", Horde = 464256, Alliance = 445418,}, -- Siege of Boralus
	[369] = {abbreviation = "OMJ", portal = 373274}, -- Operation: Mechagon - Junkyard
	[370] = {abbreviation = "OMW", portal = 373274}, -- Operation: Mechagon - Workshop
	-- Shadowlands
	[375] = {abbreviation = "MoTS", portal = 354464}, -- Mists of Tirna Scithe
	[376] = {abbreviation = "TNW", portal = 354462}, -- The Necrotic Wake
	[377] = {abbreviation = "DOS", portal = 354468}, -- De Other Side
	[378] = {abbreviation = "HoA", portal = 354465}, -- Halls of Atonement
	[379] = {abbreviation = "PF", portal = 354463}, -- Plaguefall
	[380] = {abbreviation = "SD", portal = 354469}, -- Sanguine Depths
	[381] = {abbreviation = "SoA", portal = 354466}, -- Spires of Ascension
	[382] = {abbreviation = "ToP", portal = 354467}, -- Theater of Pain
	[391] = {abbreviation = "STRT", portal = 367416}, -- Tazavesh: Streets of Wonder
	[392] = {abbreviation = "GMBT", portal = 367416}, -- Tazavesh: So'leah's Gambit
	-- Dragonflight
	[399] = {abbreviation = "RLP", portal = 393256}, -- Ruby Life Pools
	[400] = {abbreviation = "NO", portal = 393262}, -- The Nokhud Offensive
	[401] = {abbreviation = "AV", portal = 393279}, -- The Azure Vault
	[402] = {abbreviation = "AA", portal = 393273}, -- Algeth'ar Academy
	[403] = {abbreviation = "ULD", portal = 393222}, -- Uldaman: Legacy of Tyr
	[404] = {abbreviation = "NELT", portal = 393276}, -- Neltharus
	[405] = {abbreviation = "BH", portal = 393267}, -- Brackenhide Hollow
	[406] = {abbreviation = "HOI", portal = 393283}, -- Halls of Infusion
	[463] = {abbreviation = "FALL", portal = 424197}, -- Dawn of the Infinite: Galakrond's Fall
	[464] = {abbreviation = "RISE", portal = 424197}, -- Dawn of the Infinite: Murozond's Rise
	-- The War Within
	[499] = {abbreviation = "PSF", portal = 445444}, -- Priory of the Sacred Flame /PRIO
	[500] = {abbreviation = "ROOK", portal = 445443}, -- The Rookery
	[501] = {abbreviation = "SV", portal = 445269}, -- The Stonevault
	[502] = {abbreviation = "COT", portal = 445416}, -- City of Threads
	[503] = {abbreviation = "ARAK", portal = 445417}, -- Ara-Kara, city of echoes
	[504] = {abbreviation = "DFC", portal = 445441}, -- Darkflame Cleft
	[505] = {abbreviation = "DAWN", portal = 445414}, -- The Dawnbreaker
	[506] = {abbreviation = "BREW", portal = 445440}, -- Cinderbrew Maedery
	[525] = {abbreviation = "FLOOD", portal = 1216786}, -- Операция: шлюз
	[542] = {abbreviation = "EDA", portal = 1237215}, -- Eco-Dome Al'dani
	-- OTHER
	[56] = {abbreviation = "SB", portal = 131205}, -- Stormstout Brewery
	[57] = {abbreviation = "GSS", portal = 131225}, -- Gate of the Setting Sun
	[58] = {abbreviation = "SPM", portal = 131206}, -- Shado-Pan Monastery
	[59] = {abbreviation = "SoNT", portal = 131228}, -- Siege of Niuzao Temple
	[60] = {abbreviation = "MP", portal = 131222}, -- Mogu'shan Palace
	[76] = {abbreviation = "Scho", portal = 131232}, -- Scholomance
	[77] = {abbreviation = "SH", portal = 131231}, -- Scarlet Halls
	[78] = {abbreviation = "SM", portal = 131229}, -- Scarlet Monastery
	[163] = {abbreviation = "BSM", portal = 159895}, -- Bloodmaul Slag Mines
	[164] = {abbreviation = "Auch", portal = 159897}, -- Auchindoun
	[167] = {abbreviation = "UBS", portal = 159902}, -- Upper Blackrock Spire
	-- 1216786
	-- AATDH - raid
	-- Midnight
	[557] = {abbreviation = "WS", portal = 1254400}, -- Windrunner Spire
	[558] = {abbreviation = "MT", portal = 1254572}, -- Magisters' Terrace
	[559] = {abbreviation = "NPX", portal = 1254563}, -- Nexus-Point Xenas
	[560] = {abbreviation = "MC", portal = 1254559}, -- Maisara Caverns
	[583] = {abbreviation = "SotT", portal = 000000}, -- "Seat of the Triumvirate"
	[541] = {abbreviation = "TS?", portal = 000000}, -- "The Stonecore"
}
-- function E.ValidateMplusDatabase()
--     local currentSeasonMaps = {}
--     local allExistingMaps = {}
--     local mapNameById = {}
--     for mapId = 1, 2000 do
--         local name, id, timeLimit = C_ChallengeMode.GetMapUIInfo(mapId)
--         if name then
--             allExistingMaps[id] = true
--             mapNameById[id] = name
--             if timeLimit then
--                 currentSeasonMaps[id] = true
--             end
--         end
--     end
--     local totalCurrent = 0
--     for _ in pairs(currentSeasonMaps) do
--         totalCurrent = totalCurrent + 1
--     end
--     local totalMine = 0
--     for mapId in pairs(E.OctoTable_KeystoneAbbr) do
--         if currentSeasonMaps[mapId] then
--             totalMine = totalMine + 1
--         end
--     end
--     -- Недостающие ID
--     local missingIds = {}
--     for mapId in pairs(currentSeasonMaps) do
--         if not E.OctoTable_KeystoneAbbr[mapId] then
--             missingIds[mapId] = mapNameById[mapId]
--         end
--     end
--     -- Несуществующие ID
--     local invalidIds = {}
--     local invalidCount = 0
--     for mapId in pairs(E.OctoTable_KeystoneAbbr) do
--         if not allExistingMaps[mapId] then
--             invalidIds[mapId] = true
--             invalidCount = invalidCount + 1
--         end
--     end
--     local missingCount = 0
--     for _ in pairs(missingIds) do missingCount = missingCount + 1 end
--     print("TOTAL M+:", totalCurrent)
--     print("In my table:", totalMine)
--     print("missing:", missingCount)
--     print("MUST TO DELETE:", invalidCount)
--     if next(missingIds) then
--         print("\n--- NEED TO ADD ---")
--         for mapId, name in pairs(missingIds) do
--             print(string.format("[%d] = \"%s\",", mapId, name))
--         end
--     end
--     if next(invalidIds) then
--         print("\n--- MUST TO DELETE ---")
--         for mapId in pairs(invalidIds) do
--             print(mapId)
--         end
--     end
--     opde(mapNameById)
--     return missingIds, invalidIds
-- end
-- C_Timer.After(1, function()
--     E.ValidateMplusDatabase()
-- end)
local GlobalAddonName, E = ...
--------------------------------------------------------------------------------
E.OctoTable_KeystoneAbbr = {
	{mapChallengeModeID = 2, abbreviation = "TJS", portal = 131204}, -- Temple of the Jade Serpent
	{mapChallengeModeID = 56, abbreviation = "SB", portal = 131205}, -- Stormstout Brewery
	{mapChallengeModeID = 57, abbreviation = "GSS", portal = 131225}, -- Gate of the Setting Sun
	{mapChallengeModeID = 58, abbreviation = "SPM", portal = 131206}, -- Shado-Pan Monastery
	{mapChallengeModeID = 59, abbreviation = "SoNT", portal = 131228}, -- Siege of Niuzao Temple
	{mapChallengeModeID = 60, abbreviation = "MP", portal = 131222}, -- Mogu'shan Palace
	{mapChallengeModeID = 76, abbreviation = "Scho", portal = 131232}, -- Scholomance
	{mapChallengeModeID = 77, abbreviation = "SH", portal = 131231}, -- Scarlet Halls
	{mapChallengeModeID = 78, abbreviation = "SM", portal = 131229}, -- Scarlet Monastery
	{mapChallengeModeID = 161, abbreviation = "Sky", portal = 159898}, -- Skyreach
	{mapChallengeModeID = 163, abbreviation = "BSM", portal = 159895}, -- Bloodmaul Slag Mines
	{mapChallengeModeID = 164, abbreviation = "Auch", portal = 159897}, -- Auchindoun
	{mapChallengeModeID = 165, abbreviation = "SBG", portal = 159899}, -- Shadowmoon Burial Grounds
	{mapChallengeModeID = 166, abbreviation = "GD", portal = 159900}, -- Grimrail Depot
	{mapChallengeModeID = 167, abbreviation = "UBS", portal = 159902}, -- Upper Blackrock Spire
	{mapChallengeModeID = 169, abbreviation = "ID", portal = 159896}, -- Iron Docks
	{mapChallengeModeID = 197, abbreviation = "EoA", portal = 000000}, -- Eye of Azshara
	{mapChallengeModeID = 200, abbreviation = "HoV", portal = 393764}, -- Halls of Valor
	{mapChallengeModeID = 206, abbreviation = "NL", portal = 410078}, -- Neltharion's Lair
	{mapChallengeModeID = 207, abbreviation = "VotW", portal = 000000}, -- Vault of the Wardens
	{mapChallengeModeID = 208, abbreviation = "MoS", portal = 000000}, -- Maw of Souls
	{mapChallengeModeID = 209, abbreviation = "TA", portal = 000000}, -- The Arcway
	{mapChallengeModeID = 210, abbreviation = "CoS", portal = 393766}, -- Court of Stars
	{mapChallengeModeID = 227, abbreviation = "RtKL", portal = 373262}, -- Return to Karazhan: Lower
	{mapChallengeModeID = 233, abbreviation = "CoEN", portal = 000000}, -- Cathedral of Eternal Night
	{mapChallengeModeID = 234, abbreviation = "RtKU", portal = 373262}, -- Return to Karazhan: Upper
	{mapChallengeModeID = 239, abbreviation = "SotT", portal = 000000}, -- Seat of the Triumvirate
	{mapChallengeModeID = 245, abbreviation = "FH", portal = 410071}, -- Freehold
	{mapChallengeModeID = 246, abbreviation = "TD", portal = 000000}, -- Tol Dagor
	{mapChallengeModeID = 247, abbreviation = "ML", portal = 467553}, -- The MOTHERLODE!!
	{mapChallengeModeID = 249, abbreviation = "KR", portal = 000000}, -- Kings' Rest
	{mapChallengeModeID = 250, abbreviation = "ToS", portal = 000000}, -- Temple of Sethraliss
	{mapChallengeModeID = 251, abbreviation = "UNDR", portal = 410074}, -- The Underrot
	{mapChallengeModeID = 252, abbreviation = "SotS", portal = 000000}, -- Shrine of the Storm
	{mapChallengeModeID = 353, abbreviation = "SIEGE", portal = 445418, f = "Alliance"}, -- Siege of Boralus
	{mapChallengeModeID = 353, abbreviation = "SIEGE", portal = 464256, f = "Horde"}, -- Siege of Boralus
	{mapChallengeModeID = 369, abbreviation = "OMJ", portal = 373274}, -- Operation: Mechagon - Junkyard
	{mapChallengeModeID = 370, abbreviation = "OMW", portal = 373274}, -- Operation: Mechagon - Workshop
	{mapChallengeModeID = 375, abbreviation = "MoTS", portal = 354464}, -- Mists of Tirna Scithe
	{mapChallengeModeID = 376, abbreviation = "TNW", portal = 354462}, -- The Necrotic Wake
	{mapChallengeModeID = 377, abbreviation = "DOS", portal = 354468}, -- De Other Side
	{mapChallengeModeID = 378, abbreviation = "HoA", portal = 354465}, -- Halls of Atonement
	{mapChallengeModeID = 379, abbreviation = "PF", portal = 354463}, -- Plaguefall
	{mapChallengeModeID = 380, abbreviation = "SD", portal = 354469}, -- Sanguine Depths
	{mapChallengeModeID = 381, abbreviation = "SoA", portal = 354466}, -- Spires of Ascension
	{mapChallengeModeID = 382, abbreviation = "ToP", portal = 354467}, -- Theater of Pain
	{mapChallengeModeID = 391, abbreviation = "STRT", portal = 367416}, -- Tazavesh: Streets of Wonder
	{mapChallengeModeID = 392, abbreviation = "GMBT", portal = 367416}, -- Tazavesh: So'leah's Gambit
	{mapChallengeModeID = 399, abbreviation = "RLP", portal = 393256}, -- Ruby Life Pools
	{mapChallengeModeID = 400, abbreviation = "NO", portal = 393262}, -- The Nokhud Offensive
	{mapChallengeModeID = 401, abbreviation = "AV", portal = 393279}, -- The Azure Vault
	{mapChallengeModeID = 402, abbreviation = "AA", portal = 393273}, -- Algeth'ar Academy
	{mapChallengeModeID = 403, abbreviation = "ULD", portal = 393222}, -- Uldaman: Legacy of Tyr
	{mapChallengeModeID = 404, abbreviation = "NELT", portal = 393276}, -- Neltharus
	{mapChallengeModeID = 405, abbreviation = "BH", portal = 393267}, -- Brackenhide Hollow
	{mapChallengeModeID = 406, abbreviation = "HOI", portal = 393283}, -- Halls of Infusion
	{mapChallengeModeID = 438, abbreviation = "VP", portal = 410080}, -- The Vortex Pinnacle
	-- {mapChallengeModeID = 456, abbreviation = , portal = 000000,"TotT"}, -- Throne of the Tides (Cataclysm)
	-- {mapChallengeModeID = 463, abbreviation = , portal = 000000,"DotI:Galakrond's Fall"}, -- Dawn of the Infinites: Galakrond's Fall
	-- {mapChallengeModeID = 464, abbreviation = , portal = 000000,"DotI:Murozond's Rise"} -- Dawn of the Infinites: Murozond's Rise
	{mapChallengeModeID = 199, abbreviation = "BRH", portal = 424153}, -- "BRH"}, -- Black Rook Hold
	{mapChallengeModeID = 244, abbreviation = "AD", portal = 424187}, -- "AD"}, -- Atal'Dazar
	{mapChallengeModeID = 463, abbreviation = "FALL", portal = 424197}, -- "DotI:Galakrond's Fall"}, -- Dawn of the Infinites: Galakrond's Fall Dawn of the Infinite: Galakrond's Fall
	{mapChallengeModeID = 464, abbreviation = "RISE", portal = 424197}, -- "DotI:Murozond's Rise"} -- Dawn of the Infinites: Murozond's Rise Dawn of the Infinite: Murozond's Rise
	{mapChallengeModeID = 198, abbreviation = "DHT", portal = 424163}, -- "DHT"}, -- Darkheart Thicket
	{mapChallengeModeID = 168, abbreviation = "EB", portal = 159901}, -- "TE"}, -- The Everbloom
	{mapChallengeModeID = 456, abbreviation = "TOTT", portal = 424142}, -- "TotT"}, -- Throne of the Tides (Cataclysm)
	{mapChallengeModeID = 248, abbreviation = "WM", portal = 424167}, -- "WM"}, -- Waycrest Manor
	{mapChallengeModeID = 501, abbreviation = "SV", portal = 445269}, -- The Stonevault
	{mapChallengeModeID = 502, abbreviation = "COT", portal = 445416}, -- City of Threads
	{mapChallengeModeID = 503, abbreviation = "ARAK", portal = 445417}, -- Ara-Kara, city of echoes
	{mapChallengeModeID = 505, abbreviation = "DAWN", portal = 445414}, -- The Dawnbreaker
	{mapChallengeModeID = 507, abbreviation = "GB", portal = 445424}, -- Grim Batol
	{mapChallengeModeID = 499, abbreviation = "PotSF", portal = 445444}, -- Priory of the Sacred Flame
	{mapChallengeModeID = 500, abbreviation = "TR", portal = 445443}, -- The Rookery
	{mapChallengeModeID = 504, abbreviation = "DC", portal = 445441}, -- Darkflame Cleft
	{mapChallengeModeID = 506, abbreviation = "CM", portal = 445440}, -- Cinderbrew Maedery
	-- AATDH - raid



	{mapChallengeModeID = 525, abbreviation = "FG", portal = 123123} -- Операция: шлюз
	-- 1216786

}
E.OctoTable_LFGDungeons = {
	[287] = "Корен Худовар",
	[285] = "Всадник без головы"
	-- [2714] = "Кодекс Хроми",
	-- [1045] = "Случайное подземелье Легиона",
	-- [1046] = "Случайное подземелье Легиона (героич.)",
	-- [301] = "Случайное подземелье Cataclysm (героич.)",
	-- [788] = "Случайное подземелье Warlords of Draenor",
	-- [789] = "Случайное подземелье Warlords of Draenor (героич.)",
	-- [1671] = "Случайное подземелье Battle For Azeroth (героич.)",
	-- [434] = "Случайное подземелье \"Времени Сумерек\" (героич.)",
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
	-- [2634] = "Случайное подземелье, путеш. во времени (Classic)",
	-- [2516] = "Случайное подземелье (The War Within)",
	-- [1971] = "Случайное подземелье, путеш. во времени (Warlords of Draenor)",
	-- [2517] = "Случайное подземелье (The War Within, героический режим)",
	-- [2274] = "Случайное подземелье, путеш. во времени (Legion)",
	-- [2723] = "Случайное героическое подземелье (1-й сезон The War Within)",
	-- [1146] = "Случайное подземелье, путеш. во времени (Cataclysm)",
	-- [2537] = "Случайное героическое подземелье (Mists of Pandaria)",
	-- [995] = "Случайное подземелье, путеш. во времени (Wrath of the Lich King)",
	-- [2538] = "Случайное подземелье, путешествие во времени (Mists of Pandaria)",
	-- [744] = "Случайное подземелье, путеш. во времени (The Burning Crusade)",
	-- [1453] = "Случайное подземелье, путеш. во времени (Mists of Pandaria)",
	-- [2539] = "Случайное подземелье (Mists of Pandaria, героич.)",
}

local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
--------------------------------------------------------------------------------
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
	{mapChallengeModeID = 463, abbreviation = "FALL"}, -- "DotI:Galakrond's Fall"}, -- Dawn of the Infinites: Galakrond's Fall
	{mapChallengeModeID = 464, abbreviation = "RISE"}, -- "DotI:Murozond's Rise"} -- Dawn of the Infinites: Murozond's Rise
	{mapChallengeModeID = 198, abbreviation = "DHT"}, -- "DHT"}, -- Darkheart Thicket
	{mapChallengeModeID = 168, abbreviation = "EB"}, -- "TE"}, -- The Everbloom
	{mapChallengeModeID = 456, abbreviation = "TOTT"}, -- "TotT"}, -- Throne of the Tides (Cataclysm)
	{mapChallengeModeID = 248, abbreviation = "WM"} -- "WM"}, -- Waycrest Manor
}

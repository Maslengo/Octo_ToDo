local GlobalAddonName, E = ...
----------------------------------------------------------------
local enable = false
local Is_TheLastTitan_available = E.func_Is_TheLastTitan_available()
----------------------------------------------------------------
if not enable then return end
-- if not Is_TheLastTitan_available then return end;
----------------------------------------------------------------
local L = E.L
----------------------------------------------------------------
local categoryKey = 13
local expansionID = 13
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
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = {
			-- EJ INSTANCES

			-- DUNGEONS
			-- {id = 77, defS = true,}, -- Zul'Aman
			-- {id = 76, defS = true,}, -- Zul'Gurub
			-- {id = 1319, defS = true,}, -- Keystone Dungeons
			-- {id = 1316, defS = true,}, -- Nexus-Point Xenas
			-- {id = 1315, defS = true,}, -- Maisara Caverns
			-- {id = 1313, defS = true,}, -- Voidscar Arena
			-- {id = 1311, defS = true,}, -- Den of Nalorakk
			-- {id = 1310, defS = true,}, -- Zekvir's Lair
			-- {id = 1309, defS = true,}, -- The Blinding Vale
			-- {id = 1304, defS = true,}, -- Murder Row
			-- {id = 1303, defS = true,}, -- Eco-Dome Al'dani
			-- {id = 1300, defS = true,}, -- Magisters' Terrace
			-- {id = 1299, defS = true,}, -- Windrunner Spire
			-- {id = 1298, defS = true,}, -- Operation: Floodgate
			-- {id = 1292, defS = true,}, -- Stratholme - Service Entrance
			-- {id = 1277, defS = true,}, -- Dire Maul - Gordok Commons
			-- {id = 1276, defS = true,}, -- Dire Maul - Warpwood Quarter
			-- {id = 1274, defS = true,}, -- City of Threads
			-- {id = 1272, defS = true,}, -- Cinderbrew Meadery
			-- {id = 1271, defS = true,}, -- Ara-Kara, City of Echoes
			-- {id = 1270, defS = true,}, -- The Dawnbreaker
			-- {id = 1269, defS = true,}, -- The Stonevault
			-- {id = 1268, defS = true,}, -- The Rookery
			-- {id = 1267, defS = true,}, -- Priory of the Sacred Flame
			-- {id = 1210, defS = true,}, -- Darkflame Cleft
			-- {id = 1209, defS = true,}, -- Dawn of the Infinite
			-- {id = 1206, defS = true,}, -- The Nokud Offensive
			-- {id = 1204, defS = true,}, -- Halls of Infusion
			-- {id = 1203, defS = true,}, -- The Azure Vault
			-- {id = 1202, defS = true,}, -- Ruby Life Pools
			-- {id = 1201, defS = true,}, -- Algeth'ar Academy
			-- {id = 1199, defS = true,}, -- Neltharus
			-- {id = 1198, defS = true,}, -- The Nokhud Offensive
			-- {id = 1197, defS = true,}, -- Uldaman: Legacy of Tyr
			-- {id = 1196, defS = true,}, -- Brackenhide Hollow
			-- {id = 1194, defS = true,}, -- Tazavesh, the Veiled Market
			-- {id = 1189, defS = true,}, -- Sanguine Depths
			-- {id = 1188, defS = true,}, -- De Other Side
			-- {id = 1187, defS = true,}, -- Theater of Pain
			-- {id = 1186, defS = true,}, -- Spires of Ascension
			-- {id = 1185, defS = true,}, -- Halls of Atonement
			-- {id = 1184, defS = true,}, -- Mists of Tirna Scithe
			-- {id = 1183, defS = true,}, -- Plaguefall
			-- {id = 1182, defS = true,}, -- The Necrotic Wake
			-- {id = 1178, defS = true,}, -- Operation: Mechagon
			-- {id = 1041, defS = true,}, -- Kings' Rest
			-- {id = 1036, defS = true,}, -- Shrine of the Storm
			-- {id = 1030, defS = true,}, -- Temple of Sethraliss
			-- {id = 1023, defS = true,}, -- Siege of Boralus
			-- {id = 1022, defS = true,}, -- The Underrot
			-- {id = 1021, defS = true,}, -- Waycrest Manor
			-- {id = 1012, defS = true,}, -- The MOTHERLODE!!
			-- {id = 1002, defS = true,}, -- Tol Dagor
			-- {id = 1001, defS = true,}, -- Freehold
			-- {id = 968, defS = true,}, -- Atal'Dazar
			-- {id = 945, defS = true,}, -- Seat of the Triumvirate
			-- {id = 900, defS = true,}, -- Cathedral of Eternal Night
			-- {id = 860, defS = true,}, -- Return to Karazhan
			-- {id = 800, defS = true,}, -- Court of Stars
			-- {id = 777, defS = true,}, -- Assault on Violet Hold
			-- {id = 767, defS = true,}, -- Neltharion's Lair
			-- {id = 762, defS = true,}, -- Darkheart Thicket
			-- {id = 740, defS = true,}, -- Black Rook Hold
			-- {id = 727, defS = true,}, -- Maw of Souls
			-- {id = 726, defS = true,}, -- The Arcway
			-- {id = 721, defS = true,}, -- Halls of Valor
			-- {id = 716, defS = true,}, -- Eye of Azshara
			-- {id = 707, defS = true,}, -- Vault of the Wardens
			-- {id = 559, defS = true,}, -- Upper Blackrock Spire
			-- {id = 558, defS = true,}, -- Iron Docks
			-- {id = 556, defS = true,}, -- The Everbloom
			-- {id = 547, defS = true,}, -- Auchindoun
			-- {id = 537, defS = true,}, -- Shadowmoon Burial Grounds
			-- {id = 536, defS = true,}, -- Grimrail Depot
			-- {id = 476, defS = true,}, -- Skyreach
			-- {id = 385, defS = true,}, -- Bloodmaul Slag Mines
			-- {id = 324, defS = true,}, -- Siege of Niuzao Temple
			-- {id = 321, defS = true,}, -- Mogu'shan Palace
			-- {id = 316, defS = true,}, -- Scarlet Monastery
			-- {id = 313, defS = true,}, -- Temple of the Jade Serpent
			-- {id = 312, defS = true,}, -- Shado-Pan Monastery
			-- {id = 311, defS = true,}, -- Scarlet Halls
			-- {id = 303, defS = true,}, -- Gate of the Setting Sun
			-- {id = 302, defS = true,}, -- Stormstout Brewery
			-- {id = 286, defS = true,}, -- Utgarde Pinnacle
			-- {id = 285, defS = true,}, -- Utgarde Keep
			-- {id = 284, defS = true,}, -- Trial of the Champion
			-- {id = 283, defS = true,}, -- The Violet Hold
			-- {id = 282, defS = true,}, -- The Oculus
			-- {id = 281, defS = true,}, -- The Nexus
			-- {id = 280, defS = true,}, -- The Forge of Souls
			-- {id = 279, defS = true,}, -- The Culling of Stratholme
			-- {id = 278, defS = true,}, -- Pit of Saron
			-- {id = 277, defS = true,}, -- Halls of Stone
			-- {id = 276, defS = true,}, -- Halls of Reflection
			-- {id = 275, defS = true,}, -- Halls of Lightning
			-- {id = 274, defS = true,}, -- Gundrak
			-- {id = 273, defS = true,}, -- Drak'Tharon Keep
			-- {id = 272, defS = true,}, -- Azjol-Nerub
			-- {id = 271, defS = true,}, -- Ahn'kahet: The Old Kingdom
			-- {id = 262, defS = true,}, -- The Underbog
			-- {id = 261, defS = true,}, -- The Steamvault
			-- {id = 260, defS = true,}, -- The Slave Pens
			-- {id = 259, defS = true,}, -- The Shattered Halls
			-- {id = 258, defS = true,}, -- The Mechanar
			-- {id = 257, defS = true,}, -- The Botanica
			-- {id = 256, defS = true,}, -- The Blood Furnace
			-- {id = 255, defS = true,}, -- The Black Morass
			-- {id = 254, defS = true,}, -- The Arcatraz
			-- {id = 253, defS = true,}, -- Shadow Labyrinth
			-- {id = 252, defS = true,}, -- Sethekk Halls
			-- {id = 251, defS = true,}, -- Old Hillsbrad Foothills
			-- {id = 250, defS = true,}, -- Mana-Tombs
			-- {id = 249, defS = true,}, -- Magisters' Terrace
			-- {id = 248, defS = true,}, -- Hellfire Ramparts
			-- {id = 247, defS = true,}, -- Auchenai Crypts
			-- {id = 246, defS = true,}, -- Scholomance
			-- {id = 241, defS = true,}, -- Zul'Farrak
			-- {id = 240, defS = true,}, -- Wailing Caverns
			-- {id = 239, defS = true,}, -- Uldaman
			-- {id = 238, defS = true,}, -- The Stockade
			-- {id = 237, defS = true,}, -- The Temple of Atal'hakkar
			-- {id = 236, defS = true,}, -- Stratholme - Main Gate
			-- {id = 234, defS = true,}, -- Razorfen Kraul
			-- {id = 233, defS = true,}, -- Razorfen Downs
			-- {id = 232, defS = true,}, -- Maraudon
			-- {id = 231, defS = true,}, -- Gnomeregan
			-- {id = 230, defS = true,}, -- Dire Maul - Capital Gardens
			-- {id = 229, defS = true,}, -- Lower Blackrock Spire
			-- {id = 228, defS = true,}, -- Blackrock Depths
			-- {id = 227, defS = true,}, -- Blackfathom Deeps
			-- {id = 226, defS = true,}, -- Ragefire Chasm
			-- {id = 186, defS = true,}, -- Hour of Twilight
			-- {id = 185, defS = true,}, -- Well of Eternity
			-- {id = 184, defS = true,}, -- End Time
			-- {id = 71, defS = true,}, -- Grim Batol
			-- {id = 70, defS = true,}, -- Halls of Origination
			-- {id = 69, defS = true,}, -- Lost City of the Tol'vir
			-- {id = 68, defS = true,}, -- The Vortex Pinnacle
			-- {id = 67, defS = true,}, -- The Stonecore
			-- {id = 66, defS = true,}, -- Blackrock Caverns
			-- {id = 65, defS = true,}, -- Throne of the Tides
			-- {id = 64, defS = true,}, -- Shadowfang Keep
			-- {id = 63, defS = true,}, -- Deadmines

	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Additionally = {
	}
	----------------------------------------------------------------
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)
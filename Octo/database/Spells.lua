local GlobalAddonName, E = ...
----------------------------------------------------------------
E.Octo_ProfessionsskillLine = {
	[164] = true,
	[165] = true,
	[171] = true,
	[182] = true,
	[186] = true,
	[197] = true,
	[202] = true,
	[333] = true,
	[393] = true,
	[755] = true,
	[773] = true,
}
E.Octo_ProfessionsskillLine_Other = {
	[129] = true,
	[185] = true,
	[356] = true,
	[794] = true,
}
E.OctoTable_Portals = {
	-- {
	-- {id = 187898, curType = "item", level = 20,},
	-- {id = 187869, curType = "item", level = 20,},
	-- {id = 187875, curType = "item", level = 20,},
	-- {id = 187895, curType = "item", level = 20,},
	-- {id = 187897, curType = "item", level = 20,},
	-- {id = 187896, curType = "item", level = 20,},
	-- {id = 187899, curType = "item", level = 20,},
	-- {id = 187900, curType = "item", level = 20,},
	-- {id = 150743, curType = "item", level = 20, faction = "Alliance",},-- ALLY
	-- {id = 150744, curType = "item", level = 20, faction = "Horde",},-- HORDE
	-- {id = 150746, curType = "item", level = 20, faction = "Alliance",},-- ALLY
	-- {id = 150745, curType = "item", level = 20, faction = "Horde",},-- HORDE
	-- },
	-- OTHER
	{
		{id = 110560, curType = "toy",},
		{id = 6948, curType = "item",},
		{id = 140192, curType = "toy",},
		{id = 128353, curType = "item", itemInBag = true,},
		{id = 141605, curType = "item", itemInBag = true,},
		436854, -- режим полёта
		-- 72286, -- НЕПОБЕДИМЫЙ
		{id = 193753, class = "DRUID",},
		{id = 50977, class = "DEATHKNIGHT",},
		{id = 53428, class = "DEATHKNIGHT",},
		{id = 556, class = "SHAMAN",},
		{id = 126892, class = "MONK",},
		-- {id = 126895, class = "MONK",},
		-- {id = 126896, class = "MONK",},
		-- {id = 293866, class = "MONK",},
		-- {id = 200617, class = "MONK",},
		{id = 265225, race = "DarkIronDwarf",},
		{id = 312370, race = "Vulpera",},
		{id = 312372, race = "Vulpera",},
		460905,
		431280,
		{id = 187339, curType = "toy",},
	},
	-- Engineering
	{
		{id = 48933, curType = "toy", profession = "Engineering",}, -- WOTLK
		{id = 87215, curType = "toy", profession = "Engineering",}, -- PANDA
		{id = 112059, curType = "toy", profession = "Engineering",}, -- DRAENOR
		{id = 151652, curType = "toy", profession = "Engineering",}, -- LEGION
		{id = 168808, curType = "toy", profession = "Engineering",}, -- BFA
		{id = 168807, curType = "toy", profession = "Engineering",}, -- BFA
		{id = 172924, curType = "toy", profession = "Engineering",}, -- SL
		{id = 198156, curType = "toy", profession = "Engineering",}, -- DF
	},
	--["Portals_Mage_Solo"] = {
	{
		{id = 3567, faction = "Horde", class = "MAGE",},
		{id = 3563, faction = "Horde", class = "MAGE",},
		{id = 3566, faction = "Horde", class = "MAGE",},
		{id = 32272, faction = "Horde", class = "MAGE",},
		{id = 49358, faction = "Horde", class = "MAGE",},
		{id = 35715, faction = "Horde", class = "MAGE",},
		{id = 53140, faction = "Horde", class = "MAGE",},
		{id = 88344, faction = "Horde", class = "MAGE",},
		{id = 120145, faction = "Horde", class = "MAGE",},
		{id = 132627, faction = "Horde", class = "MAGE",},
		{id = 176242, faction = "Horde", class = "MAGE",},
		{id = 224869, faction = "Horde", class = "MAGE",},
		{id = 281404, faction = "Horde", class = "MAGE",},
		{id = 344587, faction = "Horde", class = "MAGE",},
		{id = 395277, faction = "Horde", class = "MAGE",},
		{id = 446540, faction = "Horde", class = "MAGE",},
		{id = 193759, faction = "Horde", class = "MAGE",},
		{id = 3561, faction = "Alliance", class = "MAGE",},
		{id = 3562, faction = "Alliance", class = "MAGE",},
		{id = 3565, faction = "Alliance", class = "MAGE",},
		{id = 32271, faction = "Alliance", class = "MAGE",},
		{id = 49359, faction = "Alliance", class = "MAGE",},
		{id = 33690, faction = "Alliance", class = "MAGE",},
		{id = 53140, faction = "Alliance", class = "MAGE",},
		{id = 88342, faction = "Alliance", class = "MAGE",},
		{id = 120145, faction = "Alliance", class = "MAGE",},
		{id = 132621, faction = "Alliance", class = "MAGE",},
		{id = 176248, faction = "Alliance", class = "MAGE",},
		{id = 224869, faction = "Alliance", class = "MAGE",},
		{id = 281403, faction = "Alliance", class = "MAGE",},
		{id = 344587, faction = "Alliance", class = "MAGE",},
		{id = 395277, faction = "Alliance", class = "MAGE",},
		{id = 446540, faction = "Alliance", class = "MAGE",},
		{id = 193759, faction = "Alliance", class = "MAGE",},
		-- {id = 204287, class = "MAGE",}, -- REMIX
	},
	--["Portals_Mage_Group"] = {
	{
		{id = 11417, faction = "Horde", class = "MAGE",},
		{id = 11418, faction = "Horde", class = "MAGE",},
		{id = 11420, faction = "Horde", class = "MAGE",},
		{id = 32267, faction = "Horde", class = "MAGE",},
		{id = 49361, faction = "Horde", class = "MAGE",},
		{id = 35717, faction = "Horde", class = "MAGE",},
		{id = 53142, faction = "Horde", class = "MAGE",},
		{id = 88346, faction = "Horde", class = "MAGE",},
		{id = 120146, faction = "Horde", class = "MAGE",},
		{id = 132626, faction = "Horde", class = "MAGE",},
		{id = 176244, faction = "Horde", class = "MAGE",},
		{id = 224871, faction = "Horde", class = "MAGE",},
		{id = 281402, faction = "Horde", class = "MAGE",},
		{id = 344597, faction = "Horde", class = "MAGE",},
		{id = 395289, faction = "Horde", class = "MAGE",},
		{id = 446534, faction = "Horde", class = "MAGE",},
		{id = 10059, faction = "Alliance", class = "MAGE",},
		{id = 11416, faction = "Alliance", class = "MAGE",},
		{id = 11419, faction = "Alliance", class = "MAGE",},
		{id = 32266, faction = "Alliance", class = "MAGE",},
		{id = 49360, faction = "Alliance", class = "MAGE",},
		{id = 33691, faction = "Alliance", class = "MAGE",},
		{id = 53142, faction = "Alliance", class = "MAGE",},
		{id = 88345, faction = "Alliance", class = "MAGE",},
		{id = 120146, faction = "Alliance", class = "MAGE",},
		{id = 132620, faction = "Alliance", class = "MAGE",},
		{id = 176246, faction = "Alliance", class = "MAGE",},
		{id = 224871, faction = "Alliance", class = "MAGE",},
		{id = 281400, faction = "Alliance", class = "MAGE",},
		{id = 344597, faction = "Alliance", class = "MAGE",},
		{id = 395289, faction = "Alliance", class = "MAGE",},
		{id = 446534, faction = "Alliance", class = "MAGE",},
	},
	--["Cataclysm"] = {
	{
		445424, -- name = "GB", expansion = "cataclysm", mapID = {507}}, -- Grim Batol
		424142, -- name = "TOTT", expansion = "cataclysm", mapID = {456}}, -- Throne of the Tides
		410080, -- name = "VP", expansion = "cataclysm", mapID = {438}}, -- The Vortex Pinnacle
	},
	--["MistsofPandaria"] = {
	{
		131204, -- name = "TOJS", expansion = "mist of pandaria", mapID = {2}}, -- Temple of the Jade Serpent
		131232,
		131231,
		131229,
		131228,
		131222,
		131225,
		131205,
	},
	--["WarlordsofDraenor"] = {
	{
		159897, -- name = "AUCH", expansion = "warlords of draenor", mapID = {164}}, -- Auchindoun
		159895, -- name = "BSM", expansion = "warlords of draenor", mapID = {163}}, -- Bloodmaul Slag Mines
		159900, -- name = "GD", expansion = "warlords of draenor", mapID = {166}}, -- Grimrail Depot
		159896, -- name = "ID", expansion = "warlords of draenor", mapID = {169}}, -- Iron Docks
		159899, -- name = "SBG", expansion = "warlords of draenor", mapID = {165}}, -- Shadowmoon Burial Grounds
		159898, -- name = "SR", expansion = "warlords of draenor", mapID = {161}}, -- Skyreach
		159901, -- name = "EB", expansion = "warlords of draenor", mapID = {168}}, -- The Everbloom
		159902, -- name = "UBS", expansion = "warlords of draenor", mapID = {167}}, -- Upper Blackrock Spire
	},
	--["Legion"] = {
	{
		393766, -- name = "COS", expansion = "legion", mapID = {210}}, -- Court of Stars
		424153, -- name = "BRH", expansion = "legion", mapID = {199}}, -- Black Rook Hold
		424163, -- name = "DH", expansion = "legion", mapID = {198}}, -- Darkheart Thicket
		393764, -- name = "HOV", expansion = "legion", mapID = {200}}, -- Halls of Valor
		410078, -- name = "NL", expansion = "legion", mapID = {206}}, -- Neltharion's Lair
		373262, -- name = "KARA", expansion = "legion", mapID = {277, 234}}, -- Return to Karazhan
	},
	--["BattleforAzeroth"] = {
	{
		424187, -- name = "AD", expansion = "battle for azeroth", mapID = {244}}, -- Atal'Dazar
		410071, -- name = "FH", expansion = "battle for azeroth", mapID = {245}}, -- Freehold
		373274, -- name = "MECH", expansion = "battle for azeroth", mapID = {369, 370}}, -- Operation: Mechagon
		{id = 467555, faction = "Horde",}, -- name = "ML", expansion = "battle for azeroth", mapID = {247}}, -- The MOTHERLODE
		{id = 467553, faction = "Alliance",}, -- name = "ML", expansion = "battle for azeroth", mapID = {247}}, -- The MOTHERLODE
		410074, -- name = "UR", expansion = "battle for azeroth", mapID = {251}}, -- The Underrot
		424167, -- name = "WM", expansion = "battle for azeroth", mapID = {248}}, -- Waycrest Manor
		{id = 464256, faction = "Horde",},-- name = "SOB", expansion = "battle for azeroth", mapID = {353}}, -- Siege of Boralus (Horde)
		{id = 445418, faction = "Alliance",}, -- name = "SOB", expansion = "battle for azeroth", mapID = {353}}, -- Siege of Boralus (Alliance)
	},
	--["Shadowlands"] = {
	{
		354468, -- name = "DOS", expansion = "shadowlands", mapID = {377}}, -- De Other Side
		354465, -- name = "HOA", expansion = "shadowlands", mapID = {378}}, -- Halls of Atonement
		354464, -- name = "MOTS", expansion = "shadowlands", mapID = {375}}, -- Mist of Tirna Scithe
		354463, -- name = "PF", expansion = "shadowlands", mapID = {379}}, -- Plaguefall
		354469, -- name = "SD", expansion = "shadowlands", mapID = {380}}, -- Sanguine Depths
		354466, -- name = "SOA", expansion = "shadowlands", mapID = {381}}, -- Spires of Ascension
		367416, -- name = "TAZA", expansion = "shadowlands", mapID = {391, 392}}, -- Tazavesh, the Veiled Market
		354462, -- name = "NW", expansion = "shadowlands", mapID = {376}}, -- The Necrotic Wake
		354467, -- name = "TOP", expansion = "shadowlands", mapID = {382}}, -- Theater of Pain
		--Shadowlands
		373190, -- name = "CN", expansion = "shadowlands"}, --Castle Nathria
		373191, -- name = "SOD", expansion = "shadowlands"}, --Sanctum of Domination
		373192, -- name = "SOFO", expansion = "shadowlands"}, --Sepulcher of the First Ones
	},
	--["Dragonflight"] = {
	{
		393273, -- name = "AA", expansion = "dragonflight", mapID = {402}}, -- Algeth'ar Academy
		393267, -- name = "BH", expansion = "dragonflight", mapID = {405}}, -- Brakenhide Hollow
		424197, -- name = "DOTI", expansion = "dragonflight", mapID = {463, 464}}, -- Dawn of the infinite
		393283, -- name = "HOI", expansion = "dragonflight", mapID = {406}}, -- Halls of Infusion
		393276, -- name = "NELT", expansion = "dragonflight", mapID = {404}}, -- Neltharus
		393256, -- name = "RLP", expansion = "dragonflight", mapID = {399}}, -- Ruby Life Pools
		393279, -- name = "AV", expansion = "dragonflight", mapID = {401}}, -- The Azure Vault
		393262, -- name = "NO", expansion = "dragonflight", mapID = {400}}, -- The Nokhud Offensive
		393222, -- name = "ULD", expansion = "dragonflight", mapID = {403}}, -- Uldaman:Legacy of Tyr
		--Dragonflight
		432257, -- name = "ATSC", expansion = "dragonflight"}, --Aberrus, the Shadowed Crucible
		432258, -- name = "ATDH", expansion = "dragonflight"}, --Amirdrassil, the Dream's Hope
		432254, -- name = "VOTI", expansion = "dragonflight"}, --Vault of the Incarnates
	},
	--["TheWarWithin"] = {
	{
		445417, -- name = "AK", expansion = "the war within", mapID = {503}}, -- Ara-Kara, City of Echoes
		445440, -- name = "CM", expansion = "the war within", mapID = {506}}, -- Cinderbrew Meadery
		445416, -- name = "COT", expansion = "the war within", mapID = {502}}, -- City of Threads
		445441, -- name = "DC", expansion = "the war within", mapID = {504}}, -- Darkflame Cleft
		1216786, -- name = "OF", expansion = "the war within", mapID = {525}}, -- Operation: Floodgate
		445444, -- name = "PSF", expansion = "the war within", mapID = {499}}, -- Priory of the Sacred Flame
		445414, -- name = "DB", expansion = "the war within", mapID = {505}}, -- The Dawnbreaker
		445443, -- name = "ROOK", expansion = "the war within", mapID = {500}}, -- The Rookery
		445269, -- name = "SV", expansion = "the war within", mapID = {501}}, -- The Stonevault
	},
	-- TWW S1
	-- {
	-- {id = 464256, faction = "Horde",},-- name = "SOB", expansion = "battle for azeroth", mapID = {353}}, -- Siege of Boralus (Horde)
	-- {id = 445418, faction = "Alliance",}, -- name = "SOB", expansion = "battle for azeroth", mapID = {353}}, -- Siege of Boralus (Alliance)
	-- 354464, -- Mists
	-- 354462, -- Necrotic Wake
	-- 445269, -- Stonevault
	-- 445416, -- City of Threads
	-- 445417, -- Ara Ara
	-- 445414, -- The Dawnbreaker
	-- 445424, -- Grim Batol
	-- },
	-- TWW S2
	{
		{id = 467555, faction = "Horde",}, -- name = "ML", expansion = "battle for azeroth", mapID = {247}}, -- The MOTHERLODE
		{id = 467553, faction = "Alliance",}, -- name = "ML", expansion = "battle for azeroth", mapID = {247}}, -- The MOTHERLODE
		373274, -- Operation: Mechagon - Workshop
		354467, -- Theater of Pain
		445444, -- Priory of the Sacred Flame
		445443, -- The Rookery
		445441, -- Darkflame Cleft
		445440, -- Cinderbrew Meadery
		1216786, -- Operation: Floodgate
	},
}
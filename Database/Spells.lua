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
		{id = 395277, faction = "Horde", class = "MAGE",}, -- Телепортация: Вальдраккен
		{id = 446540, faction = "Horde", class = "MAGE",}, -- Телепортация: Дорногал
		{id = 193759, faction = "Horde", class = "MAGE",}, -- Телепортация: Оплот Хранителя
		{id = 1259190, faction = "Horde", class = "MAGE",}, -- Телепортация: Луносвет
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
		{id = 395277, faction = "Alliance", class = "MAGE",}, -- Телепортация: Вальдраккен
		{id = 446540, faction = "Alliance", class = "MAGE",}, -- Телепортация: Дорногал
		{id = 193759, faction = "Alliance", class = "MAGE",}, -- Телепортация: Оплот Хранителя
		{id = 1259190, faction = "Alliance", class = "MAGE",}, -- Телепортация: Луносвет
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
		{id = 395289, faction = "Horde", class = "MAGE",}, -- Портал: Вальдраккен
		{id = 446534, faction = "Horde", class = "MAGE",}, -- Портал в Дорногал
		{id = 1259194, faction = "Horde", class = "MAGE",}, -- Портал в Луносвет
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
		{id = 395289, faction = "Alliance", class = "MAGE",}, -- Портал: Вальдраккен
		{id = 446534, faction = "Alliance", class = "MAGE",}, -- Портал в Дорногал
		{id = 1259194, faction = "Alliance", class = "MAGE",}, -- Портал в Луносвет
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
		393262, -- name = "L["NO"]", expansion = "dragonflight", mapID = {400}}, -- The Nokhud Offensive
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
		-- The War Within Raids
		1226482, -- Liberation of Undermine
		1239155, -- Manaforge Omega
	},

	--["Midnight"] = {
	{
		1254400, -- Windrunner Spire
		1254559, -- Maisara Caverns
		1254563, -- Nexus-Point Xenas
		1254572, -- Magisters' Terrace
		1254555, -- Pit of Saron
		1254551, -- Seat of the Triumvirate
		-- Midnight Raids (пока нет ID)
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



E.Octo_Table = E.Octo_Table or {}

E.Octo_Table.Octo_ProfessionsskillLine = {
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
E.Octo_Table.Octo_ProfessionsskillLine_Other = {
	[129] = true,
	[185] = true,
	[356] = true,
	[794] = true,
}
E.Octo_Table.Octo_ProfessionsSkillLinedb = {
	129, 164, 2477, 2476, 2475, 2474, 2473, 2472, 2454, 2437, 2751, 2822,
	165, 2532, 2531, 2530, 2529, 2528, 2527, 2526, 2525, 2758, 2830, 171,
	2485, 2484, 2483, 2482, 2481, 2480, 2479, 2478, 2750, 2823, 182, 2556,
	2555, 2554, 2553, 2552, 2551, 2550, 2549, 2760, 2832, 185, 2548, 2547,
	2546, 2545, 2544, 2543, 2542, 2541, 2752, 2824, 186, 2572, 2571, 2570,
	2569, 2568, 2567, 2566, 2565, 2761, 2833, 197, 2540, 2539, 2538, 2537,
	2536, 2535, 2534, 2533, 2759, 2831, 202, 2506, 2505, 2504, 2503, 2502,
	2501, 2500, 2499, 2755, 2827, 333, 2494, 2493, 2492, 2491, 2489, 2488,
	2487, 2486, 2753, 2825, 356, 2592, 2591, 2590, 2589, 2588, 2587, 2586,
	2585, 2754, 2826, 393, 2564, 2563, 2562, 2561, 2560, 2559, 2558, 2557,
	2762, 2834, 755, 2524, 2523, 2522, 2521, 2520, 2519, 2518, 2517, 2757,
	2829, 773, 2514, 2513, 2512, 2511, 2510, 2509, 2508, 2507, 2756, 2828,
	794,
}
E.Octo_Table.OctoTable_Portals_MoP = {
	131232, 131231, 131229, 131228, 131222, 131225, 131205, 131205, 131204,
}
E.Octo_Table.OctoTable_Portals_WoD = {
	159902, 159901, 159900, 159899, 159898, 159897, 159896, 159895,
}
E.Octo_Table.OctoTable_Portals_Legion = {
	393764, 393766, 373262, 410078,
}
E.Octo_Table.OctoTable_Portals_BfA = {
	410074, 373274, 410071,
}
E.Octo_Table.OctoTable_Portals_SL = {
	367416, 354469, 354465, 354463, 354467, 354468, 354464, 354466, 354462,
}
E.Octo_Table.OctoTable_Portals_DF = {
	393279, 393273, 393262, 393256, 393267, 393283, 393276, 393222, 410080,
}
E.Octo_Table.OctoTable_Portals_DF_S3 = {
	159901, 424163, 424153, 424187, 424167, 424142, 424197,
}

E.Octo_Table.OctoTable_Portals_TWW = {
	159898, -- [161] Skyreach XXX 1254557 seems incorrect
	393273, -- [402] Algeth'ar Academy
	1254555, -- [556] Pit of Saron
	1254400, -- [557] Windrunner Spire
	1254572, -- [558] Magisters' Terrace
	1254563, -- [559] Nexus-Point Xenas
	1254559, -- [560] Maisara Caverns
	1254551, -- [239] Seat of the Triumvirate
}
E.Octo_Table.OctoTable_Portals_MN = {
	445417, -- name = "AK", expansion = "the war within", mapID = {503}}, -- Ara-Kara, City of Echoes
	445440, -- name = "CM", expansion = "the war within", mapID = {506}}, -- Cinderbrew Meadery
	445416, -- name = "COT", expansion = "the war within", mapID = {502}}, -- City of Threads
	445441, -- name = "DC", expansion = "the war within", mapID = {504}}, -- Darkflame Cleft
	1216786, -- name = "OF", expansion = "the war within", mapID = {525}}, -- Operation: Floodgate
	445444, -- name = "PSF", expansion = "the war within", mapID = {499}}, -- Priory of the Sacred Flame
	445414, -- name = "DB", expansion = "the war within", mapID = {505}}, -- The Dawnbreaker
	445443, -- name = "ROOK", expansion = "the war within", mapID = {500}}, -- The Rookery
	445269, -- name = "SV", expansion = "the war within", mapID = {501}}, -- The Stonevault
	-- The War Within Raids
	1226482, -- Liberation of Undermine
	1239155, -- Manaforge Omega
}



E.Octo_Table.OctoTable_Portals_Mage_Solo_Horde = {
	3567, 3563, 3566, 32272, 49358, 35715, 53140, 88344, 120145, 132627,
	176242, 224869, 281404, 344587, 395277, 446540, 1259190, 193759
}
E.Octo_Table.OctoTable_Portals_Mage_Group_Horde = {
	11417, 11418, 11420, 32267, 49361, 35717, 53142, 88346, 120146, 132626,
	176244, 224871, 281402, 344597, 395289, 446534, 1259194,
}
E.Octo_Table.OctoTable_Portals_Mage_Solo_Alliance = {
	3561, 3562, 3565, 32271, 49359, 33690, 53140, 88342, 120145, 132621,
	176248, 224869, 281403, 344587, 395277, 446540, 1259190, 193759
}
E.Octo_Table.OctoTable_Portals_Mage_Group_Alliance = {
	10059, 11416, 11419, 32266, 49360, 33691, 53142, 88345, 120146, 132620,
	176246, 224871, 281400, 344597, 395289, 446534, 1259194,
}
E.Octo_Table.OctoTable_Portals_DRUID = {
	193753,
}
E.Octo_Table.OctoTable_Portals_DEATHKNIGHT = {
	50977,
}
E.Octo_Table.OctoTable_Portals_SHAMAN = {
	556,
}
E.Octo_Table.OctoTable_Portals_MONK = {
	126892,
}
E.Octo_Table.ALL_Professions = {
}
E.Octo_Table.FirstAid = {
	129,
}
E.Octo_Table.Blacksmithing = {
	164, 2477, 2476, 2475, 2474, 2473, 2472, 2454, 2437, 2751, 2822,
}
E.Octo_Table.Leatherworking = {
	165, 2532, 2531, 2530, 2529, 2528, 2527, 2526, 2525, 2758, 2830,
}
E.Octo_Table.Alchemy = {
	171, 2485, 2484, 2483, 2482, 2481, 2480, 2479, 2478, 2750, 2823,
}
E.Octo_Table.Herbalism = {
	182, 2556, 2555, 2554, 2553, 2552, 2551, 2550, 2549, 2760, 2832,
}
E.Octo_Table.Cooking = {
	185, 2548, 2547, 2546, 2545, 2544, 2543, 2542, 2541, 2752, 2824,
}
E.Octo_Table.Mining = {
	186, 2572, 2571, 2570, 2569, 2568, 2567, 2566, 2565, 2761, 2833,
}
E.Octo_Table.Tailoring = {
	197, 2540, 2539, 2538, 2537, 2536, 2535, 2534, 2533, 2759, 2831,
}
E.Octo_Table.Engineering = {
	202, 2506, 2505, 2504, 2503, 2502, 2501, 2500, 2499, 2755, 2827,
}
E.Octo_Table.Enchanting = {
	333, 2494, 2493, 2492, 2491, 2489, 2488, 2487, 2486, 2753, 2825,
}
E.Octo_Table.Fishing = {
	356, 2592, 2591, 2590, 2589, 2588, 2587, 2586, 2585, 2754, 2826,
}
E.Octo_Table.Skinning = {
	393, 2564, 2563, 2562, 2561, 2560, 2559, 2558, 2557, 2762, 2834,
}
E.Octo_Table.Jewelcrafting = {
	755, 2524, 2523, 2522, 2521, 2520, 2519, 2518, 2517, 2757, 2829,
}
E.Octo_Table.Inscription = {
	773, 2514, 2513, 2512, 2511, 2510, 2509, 2508, 2507, 2756, 2828,
}
E.Octo_Table.Archeology = {
	794,
}
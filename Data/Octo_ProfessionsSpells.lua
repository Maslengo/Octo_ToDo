local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
--------------------------------------------------------------------------------
-- https://docs.google.com/spreadsheets/d/1FEBCvYp19_x3Cikh1xV6RyN1Q-BVRVFdSzUQiz-eIns/edit#gid=1913676639
E.Octo_Table.Octo_ProfessionsSpells = {
									--First Aid
									--Blacksmithing
									--Leatherworking
									--Alchemy
									--Herbalism
									--Cooking
									--Mining
									--Tailoring
									--Engineering
									--Enchanting
									--Fishing
									--Skinning
									--Jewelcrafting Bc icon
									--Inscription Wrath of the Lich King
									--Archeology Cataclysm
}


E.Octo_Table.Octo_ProfessionsskillLine_ALL = {

}
E.Octo_Table.Octo_ProfessionsskillLine = {
	[164] = true,--Blacksmithing
	[165] = true,--Leatherworking
	[171] = true,--Alchemy
	[182] = true,--Herbalism
	[186] = true,--Mining
	[197] = true,--Tailoring
	[202] = true,--Engineering
	[333] = true,--Enchanting
	[393] = true,--Skinning
	[755] = true,--Jewelcrafting Bc icon
	[773] = true,--Inscription Wrath of the Lich King
}
E.Octo_Table.Octo_ProfessionsskillLine_Other = {
	[129] = true, --First Aid
	[185] = true,--Cooking
	[356] = true,--Fishing
	[794] = true, --Archeology Cataclysm
}
-- https://wowpedia.fandom.com/wiki/TradeSkillLineID
E.Octo_Table.Octo_ProfessionsSkillLinedb = {
	129, --First Aid
	164, 2477, 2476, 2475, 2474, 2473, 2472, 2454, 2437, 2751, 2822, --Blacksmithing
	165, 2532, 2531, 2530, 2529, 2528, 2527, 2526, 2525, 2758, 2830, --Leatherworking
	171, 2485, 2484, 2483, 2482, 2481, 2480, 2479, 2478, 2750, 2823, --Alchemy
	182, 2556, 2555, 2554, 2553, 2552, 2551, 2550, 2549, 2760, 2832, --Herbalism
	185, 2548, 2547, 2546, 2545, 2544, 2543, 2542, 2541, 2752, 2824, --Cooking
	186, 2572, 2571, 2570, 2569, 2568, 2567, 2566, 2565, 2761, 2833, --Mining
	197, 2540, 2539, 2538, 2537, 2536, 2535, 2534, 2533, 2759, 2831, --Tailoring
	202, 2506, 2505, 2504, 2503, 2502, 2501, 2500, 2499, 2755, 2827, --Engineering
	333, 2494, 2493, 2492, 2491, 2489, 2488, 2487, 2486, 2753, 2825, --Enchanting
	356, 2592, 2591, 2590, 2589, 2588, 2587, 2586, 2585, 2754, 2826, --Fishing
	393, 2564, 2563, 2562, 2561, 2560, 2559, 2558, 2557, 2762, 2834, --Skinning
	755, 2524, 2523, 2522, 2521, 2520, 2519, 2518, 2517, 2757, 2829, --Jewelcrafting Bc icon
	773, 2514, 2513, 2512, 2511, 2510, 2509, 2508, 2507, 2756, 2828, --Inscription Wrath of the Lich King
	794, --Archeology Cataclysm
}

E.Octo_Table.WORLD_QUEST_ICONS_BY_PROFESSION = {
	[129] = "worldquest-icon-firstaid",
	[164] = "worldquest-icon-blacksmithing",
	[165] = "worldquest-icon-leatherworking",
	[171] = "worldquest-icon-alchemy",
	[182] = "worldquest-icon-herbalism",
	[186] = "worldquest-icon-mining",
	[202] = "worldquest-icon-engineering",
	[333] = "worldquest-icon-enchanting",
	[755] = "worldquest-icon-jewelcrafting",
	[773] = "worldquest-icon-inscription",
	[794] = "worldquest-icon-archaeology",
	[356] = "worldquest-icon-fishing",
	[185] = "worldquest-icon-cooking",
	[197] = "worldquest-icon-tailoring",
	[393] = "worldquest-icon-skinning",
};
local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------
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
E.Octo_Table.OctoTable_Portals_Mage_Solo_Horde = {
	3567, 3563, 3566, 32272, 49358, 35715, 53140, 88344, 120145, 132627,
	176242, 224869, 281404, 344587, 395277, 193759,
}
E.Octo_Table.OctoTable_Portals_Mage_Group_Horde = {
	11417, 11418, 11420, 32267, 49361, 35717, 53142, 88346, 120146, 132626,
	176244, 224871, 281402, 344597, 395289,
}
E.Octo_Table.OctoTable_Portals_Mage_Solo_Alliance = {
	3561, 3562, 3565, 32271, 49359, 33690, 53140, 88342, 120145, 132621,
	176248, 224869, 281403, 344587, 395277, 193759,
}
E.Octo_Table.OctoTable_Portals_Mage_Group_Alliance = {
	10059, 11416, 11419, 32266, 49360, 33691, 53142, 88345, 120146, 132620,
	176246, 224871, 281400, 344597, 395289,
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
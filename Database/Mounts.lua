local GlobalAddonName, E = ...
local ALWAYS = _G.ALWAYS or "Always"
local PRICE_5K   = 5000
local PRICE_10K  = 10000
local PRICE_20K  = 20000
local PRICE_40K  = 40000
local PRICE_100K = 100000
function E.func_Mounts_1166() -- Timewalk
	local colorGray = E.COLOR_GRAY or "|cFF808080"
	local source2 = E.func_FormatExpansion(2)
	local source3 = E.func_FormatExpansion(3)
	local source4 = E.func_FormatExpansion(4)
	local source5 = E.func_FormatExpansion(5)
	local source6 = E.func_FormatExpansion(6)
	local source7 = E.func_FormatExpansion(7)
	local source8 = E.func_FormatExpansion(8)
	local source9 = E.func_FormatExpansion(9)
	local source11 = E.func_FormatExpansion(11)
	local SOURCE_ALWAYS = (colorGray) .. ALWAYS .. "|r"
	local tbl = {
		-- TBC Timewalking
		{itemID = 129923, price = PRICE_5K, mountID = 778,   source = source2},
		{itemID = 224399, price = PRICE_5K, mountID = 2225,  source = source2},
		-- Wrath Timewalking
		{itemID = 129922, price = PRICE_5K, mountID = 552,   source = source3},
		{itemID = 231374, price = PRICE_5K, mountID = 2317,  source = source3},
		-- Cataclysm Timewalking
		{itemID = 234730, price = PRICE_5K, mountID = 2473,  source = source4},
		-- Mists Timewalking
		{itemID = 234740, price = PRICE_5K, mountID = 2474,  source = source5},
		-- WoD Timewalking
		{itemID = 167894, price = PRICE_5K, mountID = 1242,  source = source6},
		{itemID = 167895, price = PRICE_5K, mountID = 1243,  source = source6}, -- https://www.wowhead.com/mount/1243
		{itemID = 234716, price = PRICE_5K, mountID = 2470,  source = source6},
		-- Legion Timewalking
		{itemID = 187595, price = PRICE_5K, mountID = 1521,  source = source7},
		{itemID = 234721, price = PRICE_5K, mountID = 2471,  source = source7},
		-- BfA Timewalking
		{itemID = 133543, price = PRICE_5K, mountID = 781,   source = source8}, -- Infinite Timereaver https://www.wowhead.com/mount/781
		{itemID = 245695, price = PRICE_5K, mountID = 2586,  source = source8},
		{itemID = 245694, price = PRICE_5K, mountID = 2587,  source = source8},
		-- Shadowlands Timewalking
		{itemID = 258515, price = PRICE_5K, mountID = 2804,  source = source9},
		{itemID = 259463, price = PRICE_5K, mountID = 2815,  source = source9},
		-- Dragonflight Timewalking
		{itemID = 186469, price = PRICE_5K, mountID = 293,   source = source11},
		{itemID = 208572, price = PRICE_5K, mountID = 1798,  source = source11},
		{itemID = 224398, price = PRICE_5K, mountID = 2224,  source = source11},
		-- Always available
		{itemID = 232624, price = PRICE_5K, mountID = 2321,  source = SOURCE_ALWAYS},
		{itemID = 205208, price = PRICE_5K, mountID = 1737,  source = SOURCE_ALWAYS},
		{itemID = 238739, price = PRICE_5K, mountID = 2518,  source = SOURCE_ALWAYS},


		-- https://www.wowhead.com/achievement=61394/
		-- https://www.wowhead.com/quest=92857/

		{itemID = 257511, price = PRICE_5K, mountID = 2795,  source = SOURCE_ALWAYS},
		{itemID = 257513, price = PRICE_5K, mountID = 2796,  source = SOURCE_ALWAYS},
		{itemID = 257514, price = PRICE_5K, mountID = 2797,  source = SOURCE_ALWAYS},
		{itemID = 257516, price = PRICE_5K, mountID = 2798,  source = SOURCE_ALWAYS},
	}
	return tbl
end
function E.func_Mounts_3252() -- Bronze (Legion)
	local source7 = E.func_FormatExpansion(7)
	local tbl = {
		-- Mounts with price PRICE_10K
		-- {itemID = 153193, price = PRICE_10K, mountID = 999999999, source = source7,}, -- TOY? how?
		{itemID = 250192, price = PRICE_10K, mountID = 2653, source = source7},
		{itemID = 250428, price = PRICE_10K, mountID = 2663, source = source7},
		{itemID = 250728, price = PRICE_10K, mountID = 2670, source = source7},
		{itemID = 250757, price = PRICE_10K, mountID = 2678, source = source7},
		{itemID = 250723, price = PRICE_10K, mountID = 2666, source = source7},
		{itemID = 250721, price = PRICE_10K, mountID = 2574, source = source7},
		{itemID = 250761, price = PRICE_10K, mountID = 2679, source = source7},
		{itemID = 239687, price = PRICE_10K, mountID = 2546, source = source7},
		{itemID = 250803, price = PRICE_10K, mountID = 2688, source = source7},
		{itemID = 250758, price = PRICE_10K, mountID = 2683, source = source7},
		{itemID = 250429, price = PRICE_10K, mountID = 2665, source = source7},
		{itemID = 250751, price = PRICE_10K, mountID = 2675, source = source7},
		{itemID = 239665, price = PRICE_10K, mountID = 2542, source = source7},
		{itemID = 250427, price = PRICE_10K, mountID = 2664, source = source7},
		{itemID = 250760, price = PRICE_10K, mountID = 2681, source = source7},
		{itemID = 250759, price = PRICE_10K, mountID = 2682, source = source7},
		{itemID = 250748, price = PRICE_10K, mountID = 2674, source = source7},
		{itemID = 250747, price = PRICE_10K, mountID = 2673, source = source7},
		{itemID = 239667, price = PRICE_10K, mountID = 2544, source = source7},
		{itemID = 250802, price = PRICE_10K, mountID = 2686, source = source7},
		{itemID = 251795, price = PRICE_10K, mountID = 2706, source = source7},
		{itemID = 250745, price = PRICE_10K, mountID = 2671, source = source7},
		{itemID = 250752, price = PRICE_10K, mountID = 2676, source = source7},
		{itemID = 250756, price = PRICE_10K, mountID = 2677, source = source7},
		{itemID = 250426, price = PRICE_10K, mountID = 2662, source = source7},
		{itemID = 250425, price = PRICE_10K, mountID = 2661, source = source7},
		{itemID = 250804, price = PRICE_10K, mountID = 2689, source = source7},
		{itemID = 250805, price = PRICE_10K, mountID = 2690, source = source7},
		{itemID = 250746, price = PRICE_10K, mountID = 2672, source = source7},
		{itemID = 250806, price = PRICE_10K, mountID = 2691, source = source7},
		{itemID = 250424, price = PRICE_10K, mountID = 2660, source = source7},
		{itemID = 251796, price = PRICE_10K, mountID = 2705, source = source7},
		{itemID = 250423, price = PRICE_10K, mountID = 2593, source = source7},
		-- Mounts with price PRICE_20K
		-- {itemID = 253024, price = PRICE_20K, mountID = 999999999, source = source7,}, -- DRUID FORM
		{itemID = 138201, price = PRICE_20K, mountID = 2678, source = source7},
		{itemID = 138258, price = PRICE_20K, mountID = 802,  source = source7},
		{itemID = 252954, price = PRICE_20K, mountID = 2720, source = source7},
		{itemID = 253032, price = PRICE_20K, mountID = 2730, source = source7},
		{itemID = 253013, price = PRICE_20K, mountID = 2721, source = source7},
		{itemID = 253033, price = PRICE_20K, mountID = 2731, source = source7},
		{itemID = 253028, price = PRICE_20K, mountID = 2726, source = source7},
		{itemID = 253031, price = PRICE_20K, mountID = 2729, source = source7},
		{itemID = 253029, price = PRICE_20K, mountID = 2727, source = source7},
		{itemID = 253025, price = PRICE_20K, mountID = 2723, source = source7},
		{itemID = 253030, price = PRICE_20K, mountID = 2728, source = source7},
		{itemID = 253026, price = PRICE_20K, mountID = 2724, source = source7},
		{itemID = 253027, price = PRICE_20K, mountID = 2725, source = source7},
		{itemID = 147805, price = PRICE_20K, mountID = 944,  source = source7},
		{itemID = 147806, price = PRICE_20K, mountID = 943,  source = source7},
		{itemID = 143764, price = PRICE_20K, mountID = 905,  source = source7},
		{itemID = 147804, price = PRICE_20K, mountID = 942,  source = source7},
		{itemID = 153043, price = PRICE_20K, mountID = 984,  source = source7},
		{itemID = 147807, price = PRICE_20K, mountID = 941,  source = source7},
		{itemID = 153042, price = PRICE_20K, mountID = 983,  source = source7},
		{itemID = 153044, price = PRICE_20K, mountID = 985,  source = source7},
		-- Mounts with price PRICE_40K
		{itemID = 131734, price = PRICE_40K, mountID = 779,  source = source7},
		{itemID = 152814, price = PRICE_40K, mountID = 970,  source = source7},
		{itemID = 152904, price = PRICE_40K, mountID = 980,  source = source7},
		{itemID = 152903, price = PRICE_40K, mountID = 981,  source = source7},
		{itemID = 152790, price = PRICE_40K, mountID = 955,  source = source7},
		{itemID = 152905, price = PRICE_40K, mountID = 979,  source = source7},
		{itemID = 152842, price = PRICE_40K, mountID = 974,  source = source7},
		{itemID = 152840, price = PRICE_40K, mountID = 976,  source = source7},
		{itemID = 152844, price = PRICE_40K, mountID = 973,  source = source7},
		{itemID = 152843, price = PRICE_40K, mountID = 906,  source = source7},
		{itemID = 152841, price = PRICE_40K, mountID = 975,  source = source7},
		-- Mounts with price PRICE_100K
		{itemID = 152816, price = PRICE_100K, mountID = 971, source = source7},
		{itemID = 152789, price = PRICE_100K, mountID = 954, source = source7},
		{itemID = 142236, price = PRICE_100K, mountID = 875, source = source7},
		{itemID = 143643, price = PRICE_100K, mountID = 899, source = source7},
		{itemID = 141713, price = PRICE_100K, mountID = 847, source = source7},
		{itemID = 137575, price = PRICE_100K, mountID = 633, source = source7},
		{itemID = 137574, price = PRICE_100K, mountID = 791, source = source7},
	}
	return tbl
end
function E.func_Mounts_2778() -- Bronze (Pandaria)
	local source5 = E.func_FormatExpansion(5)
	local tbl = {
		{itemID = 213609, price = 2200, mountID = 2080, source = source5},
		{itemID = 213608, price = 2200, mountID = 2078, source = source5},
		{itemID = 213576, price = 2200, mountID = 2060, source = source5},
		{itemID = 213604, price = 2200, mountID = 2077, source = source5},
		{itemID = 213584, price = 2200, mountID = 2063, source = source5},
		{itemID = 213582, price = 2200, mountID = 2064, source = source5},
		{itemID = 213628, price = 2200, mountID = 2088, source = source5},
		{itemID = 213606, price = 2200, mountID = 2075, source = source5},
		{itemID = 213607, price = 2200, mountID = 2076, source = source5},
		{itemID = 213602, price = 2200, mountID = 2072, source = source5},
		{itemID = 213627, price = 2200, mountID = 2089, source = source5},
		{itemID = 213603, price = 2200, mountID = 2073, source = source5},
		{itemID = 213595, price = 2200, mountID = 2069, source = source5},
		{itemID = 213605, price = 2200, mountID = 2074, source = source5},

		{itemID = 213624, price = 4400, mountID = 2085, source = source5},
		{itemID = 213625, price = 4400, mountID = 2086, source = source5},
		{itemID = 213626, price = 4400, mountID = 2087, source = source5},
		{itemID = 213623, price = 4400, mountID = 2081, source = source5},
		{itemID = 218111, price = 4400, mountID = 2118, source = source5},
		{itemID = 213622, price = 4400, mountID = 2083, source = source5},
		{itemID = 213621, price = 4400, mountID = 2084, source = source5},

		{itemID = 213600, price = 6600, mountID = 2071, source = source5},
		{itemID = 213601, price = 6600, mountID = 2070, source = source5},
		{itemID = 213596, price = 6600, mountID = 2065, source = source5},
		{itemID = 213598, price = 6600, mountID = 2068, source = source5},
		{itemID = 213597, price = 6600, mountID = 2067, source = source5},
	}
	return tbl
end
-- if id == 3252 or id == 1166 or id == 2778 then
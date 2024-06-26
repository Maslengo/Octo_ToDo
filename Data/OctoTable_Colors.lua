local GlobalAddonName, E = ...
local AddonTitle = GetAddOnMetadata(GlobalAddonName, "Title")
--------------------------------------------------------------------------------
E.Octo_Table.OctoTable_Colors = {
	{
		name = "Class_Warrior_Color",
		hex = "C69B6D"
	},
	{
		name = "Class_Paladin_Color",
		hex = "F48CBA"
	},
	{
		name = "Class_Hunter_Color",
		hex = "AAD372"
	},
	{
		name = "Class_Rogue_Color",
		hex = "FFF468"
	},
	{
		name = "Class_Priest_Color",
		hex = "FFFFFF"
	},
	{
		name = "Class_Shaman_Color",
		hex = "0070DD"
	},
	{
		name = "Class_Mage_Color",
		hex = "3FC7EB"
	},
	{
		name = "Class_Warlock_Color",
		hex = "8788EE"
	},
	{
		name = "Class_Monk_Color",
		hex = "00FF98"
	},
	{
		name = "Class_Druid_Color",
		hex = "FF7C0A"
	},
	{
		name = "Class_DemonHunter_Color",
		hex = "A330C9"
	},
	{
		name = "Class_DeathKnight_Color",
		hex = "C41E3A"
	},
	{
		name = "Class_Evoker_Color",
		hex = "33937F"
	},
	{
		name = "Classic_Color",
		hex = "68CCEF"
	},
	{
		name = "TheBurningCrusade_Color",
		hex = "4FFF79"
	},
	{
		name = "WrathoftheLichKing_Color",
		hex = "00A3FF"
	},
	{
		name = "Cataclysm_Color",
		hex = "FFB300"
	},
	{
		name = "MistsofPandaria_Color",
		hex = "00FFBA"
	},
	{
		name = "WarlordsofDraenor_Color",
		hex = "C86400"
	},
	{
		name = "Legion_Color",
		hex = "1EFF00"
	},
	{
		name = "BattleforAzeroth_Color",
		hex = "6464FF"
	},
	{
		name = "Shadowlands_Color",
		hex = "C9C3AA"
	},
	{
		name = "Dragonflight_Color",
		hex = "E8E379"
	},
	{
		name = "WOW_Poor_Color",
		hex = "9D9D9D"
	},
	{
		name = "WOW_Common_Color",
		hex = "FFFFFF"
	},
	{
		name = "WOW_Uncommon_Color",
		hex = "1EFF00"
	},
	{
		name = "WOW_Rare_Color",
		hex = "0070DD"
	},
	{
		name = "WOW_Epic_Color",
		hex = "A335EE"
	},
	{
		name = "WOW_Legendary_Color",
		hex = "FF8000"
	},
	{
		name = "WOW_Artifact_Color",
		hex = "D9CC80"
	},
	{
		name = "WOW_Heirloom_Color",
		hex = "00CCFF"
	},
	{
		name = "WOW_WoWToken_Color",
		hex = "00CCFF"
	},
	{
		name = "Kyrian_Color",
		hex = "6FA8DC"
	},
	{
		name = "Necrolord_Color",
		hex = "93C47D"
	},
	{
		name = "NightFae_Color",
		hex = "B4A7D6"
	},
	{
		name = "Venthyr_Color",
		hex = "EA9999"
	},
	{
		name = "Black_Color",
		hex = "000000"
	},
	{
		name = "DarkGray_Color",
		hex = "252525"
	},
	{
		name = "Gray_Color",
		hex = "505050"
	},
	-- Ломает 505050 из-за NONE
	{
		name = "LightGray_Color",
		hex = "757575"
	},
	{
		name = "White_Color",
		hex = "FFFFFF"
	},
	{
		name = "Addon_Left_Color",
		hex = "D177FF"
	},
	{
		name = "Addon_Right_Color",
		hex = "63A4E0"
	},
	{
		name = "Red_Color",
		hex = "FF4C4F"
	},
	{
		name = "Orange_Color",
		hex = "FF661A"
	},
	{
		name = "Darkorange_Color",
		hex = "FF8C00"
	},
	{
		name = "Gold_Color",
		hex = "FFD600"
	},
	{
		name = "Yellow_Color",
		hex = "FFF371"
	},
	-- "FFFF00"
	{
		name = "Greenyellow_Color",
		hex = "ACFF2F"
	},
	{
		name = "Green_Color",
		hex = "4FFF79"
	},
	{
		name = "Cyan_Color",
		hex = "00FFFF"
	},
	{
		name = "Blue_Color",
		hex = "00A3FF"
	},
	{
		name = "Purple_Color",
		hex = "AF61FF"
	},
	{
		name = "Indigo_Color",
		hex = "4B0082"
	},
	{
		name = "Magenta_Color",
		hex = "FF00FF"
	},
	{
		name = "Pink_Color",
		hex = "FF69B3"
	},
	{
		name = "Skyblue_Color",
		hex = "87CDEB"
	},
	{
		name = "Steelblue_Color",
		hex = "4682B3"
	},
	{
		name = "Slategray_Color",
		hex = "708090"
	},
	{
		name = "Brown_Color",
		hex = "964B00"
	},
}
E.Octo_Table.OctoTable_RIO_COLORS = {
	{
		["score"] = 10000,
		["color"] = {
			1,
			0.5,
			0
		}
	},
	{
		["score"] = 3975,
		["color"] = {
			1,
			0.5,
			0
		}
	},
	{
		["score"] = 3900,
		["color"] = {
			1,
			0.49,
			0.07
		}
	},
	{
		["score"] = 3875,
		["color"] = {
			0.99,
			0.49,
			0.11
		}
	},
	{
		["score"] = 3850,
		["color"] = {
			0.99,
			0.48,
			0.14
		}
	},
	{
		["score"] = 3825,
		["color"] = {
			0.99,
			0.48,
			0.17
		}
	},
	{
		["score"] = 3805,
		["color"] = {
			0.98,
			0.47,
			0.19
		}
	},
	{
		["score"] = 3780,
		["color"] = {
			0.98,
			0.47,
			0.22
		}
	},
	{
		["score"] = 3755,
		["color"] = {
			0.98,
			0.46,
			0.24
		}
	},
	{
		["score"] = 3730,
		["color"] = {
			0.97,
			0.45,
			0.25
		}
	},
	{
		["score"] = 3705,
		["color"] = {
			0.97,
			0.45,
			0.27
		}
	},
	{
		["score"] = 3685,
		["color"] = {
			0.96,
			0.44,
			0.29
		}
	},
	{
		["score"] = 3660,
		["color"] = {
			0.96,
			0.44,
			0.31
		}
	},
	{
		["score"] = 3635,
		["color"] = {
			0.96,
			0.43,
			0.33
		}
	},
	{
		["score"] = 3610,
		["color"] = {
			0.95,
			0.42,
			0.35
		}
	},
	{
		["score"] = 3585,
		["color"] = {
			0.95,
			0.42,
			0.36
		}
	},
	{
		["score"] = 3565,
		["color"] = {
			0.95,
			0.41,
			0.38
		}
	},
	{
		["score"] = 3540,
		["color"] = {
			0.94,
			0.41,
			0.4
		}
	},
	{
		["score"] = 3515,
		["color"] = {
			0.93,
			0.4,
			0.41
		}
	},
	{
		["score"] = 3490,
		["color"] = {
			0.93,
			0.39,
			0.43
		}
	},
	{
		["score"] = 3465,
		["color"] = {
			0.93,
			0.39,
			0.44
		}
	},
	{
		["score"] = 3445,
		["color"] = {
			0.92,
			0.38,
			0.46
		}
	},
	{
		["score"] = 3420,
		["color"] = {
			0.91,
			0.38,
			0.47
		}
	},
	{
		["score"] = 3395,
		["color"] = {
			0.91,
			0.37,
			0.49
		}
	},
	{
		["score"] = 3370,
		["color"] = {
			0.9,
			0.36,
			0.51
		}
	},
	{
		["score"] = 3345,
		["color"] = {
			0.9,
			0.36,
			0.52
		}
	},
	{
		["score"] = 3325,
		["color"] = {
			0.89,
			0.35,
			0.54
		}
	},
	{
		["score"] = 3300,
		["color"] = {
			0.89,
			0.35,
			0.55
		}
	},
	{
		["score"] = 3275,
		["color"] = {
			0.88,
			0.34,
			0.56
		}
	},
	{
		["score"] = 3250,
		["color"] = {
			0.87,
			0.33,
			0.58
		}
	},
	{
		["score"] = 3225,
		["color"] = {
			0.87,
			0.33,
			0.6
		}
	},
	{
		["score"] = 3205,
		["color"] = {
			0.86,
			0.32,
			0.61
		}
	},
	{
		["score"] = 3180,
		["color"] = {
			0.85,
			0.32,
			0.63
		}
	},
	{
		["score"] = 3155,
		["color"] = {
			0.84,
			0.31,
			0.64
		}
	},
	{
		["score"] = 3130,
		["color"] = {
			0.84,
			0.31,
			0.66
		}
	},
	{
		["score"] = 3105,
		["color"] = {
			0.83,
			0.3,
			0.67
		}
	},
	{
		["score"] = 3085,
		["color"] = {
			0.82,
			0.29,
			0.69
		}
	},
	{
		["score"] = 3060,
		["color"] = {
			0.81,
			0.29,
			0.7
		}
	},
	{
		["score"] = 3035,
		["color"] = {
			0.8,
			0.28,
			0.72
		}
	},
	{
		["score"] = 3010,
		["color"] = {
			0.8,
			0.27,
			0.73
		}
	},
	{
		["score"] = 2985,
		["color"] = {
			0.78,
			0.27,
			0.75
		}
	},
	{
		["score"] = 2965,
		["color"] = {
			0.78,
			0.27,
			0.76
		}
	},
	{
		["score"] = 2940,
		["color"] = {
			0.76,
			0.26,
			0.78
		}
	},
	{
		["score"] = 2915,
		["color"] = {
			0.76,
			0.25,
			0.8
		}
	},
	{
		["score"] = 2890,
		["color"] = {
			0.75,
			0.25,
			0.81
		}
	},
	{
		["score"] = 2865,
		["color"] = {
			0.73,
			0.24,
			0.82
		}
	},
	{
		["score"] = 2845,
		["color"] = {
			0.72,
			0.24,
			0.84
		}
	},
	{
		["score"] = 2820,
		["color"] = {
			0.71,
			0.23,
			0.85
		}
	},
	{
		["score"] = 2795,
		["color"] = {
			0.7,
			0.23,
			0.87
		}
	},
	{
		["score"] = 2770,
		["color"] = {
			0.68,
			0.22,
			0.89
		}
	},
	{
		["score"] = 2745,
		["color"] = {
			0.67,
			0.22,
			0.9
		}
	},
	{
		["score"] = 2725,
		["color"] = {
			0.65,
			0.21,
			0.92
		}
	},
	{
		["score"] = 2700,
		["color"] = {
			0.64,
			0.21,
			0.93
		}
	},
	{
		["score"] = 2660,
		["color"] = {
			0.62,
			0.23,
			0.93
		}
	},
	{
		["score"] = 2635,
		["color"] = {
			0.6,
			0.25,
			0.93
		}
	},
	{
		["score"] = 2610,
		["color"] = {
			0.58,
			0.27,
			0.92
		}
	},
	{
		["score"] = 2585,
		["color"] = {
			0.55,
			0.29,
			0.92
		}
	},
	{
		["score"] = 2560,
		["color"] = {
			0.53,
			0.31,
			0.91
		}
	},
	{
		["score"] = 2540,
		["color"] = {
			0.51,
			0.32,
			0.91
		}
	},
	{
		["score"] = 2515,
		["color"] = {
			0.48,
			0.34,
			0.91
		}
	},
	{
		["score"] = 2490,
		["color"] = {
			0.46,
			0.35,
			0.9
		}
	},
	{
		["score"] = 2465,
		["color"] = {
			0.43,
			0.36,
			0.9
		}
	},
	{
		["score"] = 2440,
		["color"] = {
			0.4,
			0.37,
			0.89
		}
	},
	{
		["score"] = 2420,
		["color"] = {
			0.37,
			0.38,
			0.89
		}
	},
	{
		["score"] = 2395,
		["color"] = {
			0.34,
			0.4,
			0.89
		}
	},
	{
		["score"] = 2370,
		["color"] = {
			0.3,
			0.4,
			0.88
		}
	},
	{
		["score"] = 2345,
		["color"] = {
			0.26,
			0.42,
			0.88
		}
	},
	{
		["score"] = 2320,
		["color"] = {
			0.21,
			0.42,
			0.87
		}
	},
	{
		["score"] = 2300,
		["color"] = {
			0.14,
			0.43,
			0.87
		}
	},
	{
		["score"] = 2275,
		["color"] = {
			0,
			0.44,
			0.87
		}
	},
	{
		["score"] = 2195,
		["color"] = {
			0.08,
			0.45,
			0.85
		}
	},
	{
		["score"] = 2170,
		["color"] = {
			0.13,
			0.46,
			0.85
		}
	},
	{
		["score"] = 2145,
		["color"] = {
			0.16,
			0.47,
			0.84
		}
	},
	{
		["score"] = 2120,
		["color"] = {
			0.19,
			0.48,
			0.83
		}
	},
	{
		["score"] = 2100,
		["color"] = {
			0.21,
			0.49,
			0.82
		}
	},
	{
		["score"] = 2075,
		["color"] = {
			0.23,
			0.5,
			0.81
		}
	},
	{
		["score"] = 2050,
		["color"] = {
			0.24,
			0.51,
			0.8
		}
	},
	{
		["score"] = 2025,
		["color"] = {
			0.26,
			0.51,
			0.78
		}
	},
	{
		["score"] = 2000,
		["color"] = {
			0.27,
			0.53,
			0.78
		}
	},
	{
		["score"] = 1980,
		["color"] = {
			0.28,
			0.53,
			0.76
		}
	},
	{
		["score"] = 1955,
		["color"] = {
			0.29,
			0.55,
			0.76
		}
	},
	{
		["score"] = 1930,
		["color"] = {
			0.3,
			0.55,
			0.75
		}
	},
	{
		["score"] = 1905,
		["color"] = {
			0.31,
			0.56,
			0.73
		}
	},
	{
		["score"] = 1880,
		["color"] = {
			0.32,
			0.57,
			0.73
		}
	},
	{
		["score"] = 1860,
		["color"] = {
			0.33,
			0.58,
			0.71
		}
	},
	{
		["score"] = 1835,
		["color"] = {
			0.33,
			0.59,
			0.7
		}
	},
	{
		["score"] = 1810,
		["color"] = {
			0.34,
			0.6,
			0.69
		}
	},
	{
		["score"] = 1785,
		["color"] = {
			0.35,
			0.61,
			0.68
		}
	},
	{
		["score"] = 1760,
		["color"] = {
			0.35,
			0.62,
			0.67
		}
	},
	{
		["score"] = 1740,
		["color"] = {
			0.36,
			0.63,
			0.66
		}
	},
	{
		["score"] = 1715,
		["color"] = {
			0.36,
			0.64,
			0.65
		}
	},
	{
		["score"] = 1690,
		["color"] = {
			0.36,
			0.65,
			0.64
		}
	},
	{
		["score"] = 1665,
		["color"] = {
			0.36,
			0.66,
			0.63
		}
	},
	{
		["score"] = 1640,
		["color"] = {
			0.37,
			0.67,
			0.62
		}
	},
	{
		["score"] = 1620,
		["color"] = {
			0.37,
			0.68,
			0.61
		}
	},
	{
		["score"] = 1595,
		["color"] = {
			0.37,
			0.69,
			0.6
		}
	},
	{
		["score"] = 1570,
		["color"] = {
			0.37,
			0.7,
			0.58
		}
	},
	{
		["score"] = 1545,
		["color"] = {
			0.37,
			0.71,
			0.57
		}
	},
	{
		["score"] = 1520,
		["color"] = {
			0.37,
			0.72,
			0.56
		}
	},
	{
		["score"] = 1500,
		["color"] = {
			0.37,
			0.73,
			0.55
		}
	},
	{
		["score"] = 1475,
		["color"] = {
			0.37,
			0.74,
			0.54
		}
	},
	{
		["score"] = 1450,
		["color"] = {
			0.37,
			0.75,
			0.53
		}
	},
	{
		["score"] = 1425,
		["color"] = {
			0.37,
			0.76,
			0.51
		}
	},
	{
		["score"] = 1400,
		["color"] = {
			0.37,
			0.77,
			0.5
		}
	},
	{
		["score"] = 1380,
		["color"] = {
			0.37,
			0.78,
			0.49
		}
	},
	{
		["score"] = 1355,
		["color"] = {
			0.36,
			0.79,
			0.47
		}
	},
	{
		["score"] = 1330,
		["color"] = {
			0.36,
			0.8,
			0.46
		}
	},
	{
		["score"] = 1305,
		["color"] = {
			0.36,
			0.82,
			0.45
		}
	},
	{
		["score"] = 1280,
		["color"] = {
			0.35,
			0.82,
			0.44
		}
	},
	{
		["score"] = 1260,
		["color"] = {
			0.35,
			0.84,
			0.42
		}
	},
	{
		["score"] = 1235,
		["color"] = {
			0.34,
			0.84,
			0.41
		}
	},
	{
		["score"] = 1210,
		["color"] = {
			0.34,
			0.85,
			0.39
		}
	},
	{
		["score"] = 1185,
		["color"] = {
			0.33,
			0.87,
			0.38
		}
	},
	{
		["score"] = 1160,
		["color"] = {
			0.32,
			0.87,
			0.36
		}
	},
	{
		["score"] = 1140,
		["color"] = {
			0.31,
			0.89,
			0.35
		}
	},
	{
		["score"] = 1115,
		["color"] = {
			0.31,
			0.9,
			0.33
		}
	},
	{
		["score"] = 1090,
		["color"] = {
			0.29,
			0.91,
			0.31
		}
	},
	{
		["score"] = 1065,
		["color"] = {
			0.28,
			0.92,
			0.29
		}
	},
	{
		["score"] = 1040,
		["color"] = {
			0.27,
			0.93,
			0.27
		}
	},
	{
		["score"] = 1020,
		["color"] = {
			0.26,
			0.94,
			0.25
		}
	},
	{
		["score"] = 995,
		["color"] = {
			0.24,
			0.95,
			0.23
		}
	},
	{
		["score"] = 970,
		["color"] = {
			0.22,
			0.96,
			0.2
		}
	},
	{
		["score"] = 945,
		["color"] = {
			0.2,
			0.97,
			0.17
		}
	},
	{
		["score"] = 920,
		["color"] = {
			0.18,
			0.98,
			0.14
		}
	},
	{
		["score"] = 900,
		["color"] = {
			0.15,
			0.99,
			0.09
		}
	},
	{
		["score"] = 875,
		["color"] = {
			0.12,
			1,
			0
		}
	},
	{
		["score"] = 850,
		["color"] = {
			0.22,
			1,
			0.13
		}
	},
	{
		["score"] = 825,
		["color"] = {
			0.29,
			1,
			0.19
		}
	},
	{
		["score"] = 800,
		["color"] = {
			0.35,
			1,
			0.24
		}
	},
	{
		["score"] = 775,
		["color"] = {
			0.4,
			1,
			0.29
		}
	},
	{
		["score"] = 750,
		["color"] = {
			0.44,
			1,
			0.33
		}
	},
	{
		["score"] = 725,
		["color"] = {
			0.47,
			1,
			0.36
		}
	},
	{
		["score"] = 700,
		["color"] = {
			0.51,
			1,
			0.4
		}
	},
	{
		["score"] = 675,
		["color"] = {
			0.55,
			1,
			0.44
		}
	},
	{
		["score"] = 650,
		["color"] = {
			0.58,
			1,
			0.47
		}
	},
	{
		["score"] = 625,
		["color"] = {
			0.6,
			1,
			0.5
		}
	},
	{
		["score"] = 600,
		["color"] = {
			0.64,
			1,
			0.53
		}
	},
	{
		["score"] = 575,
		["color"] = {
			0.66,
			1,
			0.56
		}
	},
	{
		["score"] = 550,
		["color"] = {
			0.69,
			1,
			0.59
		}
	},
	{
		["score"] = 525,
		["color"] = {
			0.71,
			1,
			0.62
		}
	},
	{
		["score"] = 500,
		["color"] = {
			0.74,
			1,
			0.65
		}
	},
	{
		["score"] = 475,
		["color"] = {
			0.76,
			1,
			0.68
		}
	},
	{
		["score"] = 450,
		["color"] = {
			0.79,
			1,
			0.71
		}
	},
	{
		["score"] = 425,
		["color"] = {
			0.81,
			1,
			0.74
		}
	},
	{
		["score"] = 400,
		["color"] = {
			0.83,
			1,
			0.77
		}
	},
	{
		["score"] = 375,
		["color"] = {
			0.85,
			1,
			0.8
		}
	},
	{
		["score"] = 350,
		["color"] = {
			0.88,
			1,
			0.83
		}
	},
	{
		["score"] = 325,
		["color"] = {
			0.9,
			1,
			0.85
		}
	},
	{
		["score"] = 300,
		["color"] = {
			0.92,
			1,
			0.88
		}
	},
	{
		["score"] = 275,
		["color"] = {
			0.94,
			1,
			0.91
		}
	},
	{
		["score"] = 250,
		["color"] = {
			0.96,
			1,
			0.94
		}
	},
	{
		["score"] = 225,
		["color"] = {
			0.98,
			1,
			0.97
		}
	},
	{
		["score"] = 200,
		["color"] = {
			1,
			1,
			1
		}
	},
}
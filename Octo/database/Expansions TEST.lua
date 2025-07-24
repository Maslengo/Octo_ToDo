function()
	print ("START")
	local Expansions = {
		{
			color = --[[E:func_rgb2hex(EXPANSION_COLOR_1.r, EXPANSION_COLOR_1.g, EXPANSION_COLOR_1.b) or]] E.WorldofWarcraft_Color,
			-- revers = 11,
			name = EXPANSION_NAME0 or "World of Warcraft",
			nameVeryShort = "WoW",
			icon = 1385726, --254094,
		},
		{
			color = --[[E:func_rgb2hex(EXPANSION_COLOR_2.r, EXPANSION_COLOR_2.g, EXPANSION_COLOR_2.b) or]] E.TheBurningCrusade_Color,
			-- revers = 10,
			name = EXPANSION_NAME1 or "The Burning Crusade",
			nameVeryShort = "TBC",
			icon = 1378987, --236415,
		},
		{
			color = --[[E:func_rgb2hex(EXPANSION_COLOR_3.r, EXPANSION_COLOR_3.g, EXPANSION_COLOR_3.b) or]] E.WrathoftheLichKing_Color,
			-- revers = 9,
			name = EXPANSION_NAME2 or "Wrath of the Lich King",
			nameVeryShort = "WotLK",
			icon = 607688, --341221,
		},
		{
			color = --[[E:func_rgb2hex(EXPANSION_COLOR_4.r, EXPANSION_COLOR_4.g, EXPANSION_COLOR_4.b) or]] E.Cataclysm_Color,
			-- revers = 8,
			name = EXPANSION_NAME3 or "Cataclysm",
			nameVeryShort = "Cata",
			icon = 536055, --574788,
		},
		{
			color = --[[E:func_rgb2hex(EXPANSION_COLOR_5.r, EXPANSION_COLOR_5.g, EXPANSION_COLOR_5.b) or]] E.MistsofPandaria_Color,
			-- revers = 7,
			name = EXPANSION_NAME4 or "Mists of Pandaria",
			nameVeryShort = "MoP",
			icon = 901157, -- 896622,
		},
		{
			color = --[[E:func_rgb2hex(EXPANSION_COLOR_6.r, EXPANSION_COLOR_6.g, EXPANSION_COLOR_6.b) or]] E.WarlordsofDraenor_Color,
			-- revers = 6,
			name = EXPANSION_NAME5 or "Warlords of Draenor",
			nameVeryShort = "WoD",
			icon = 1134497, -- 1113431,
		},
		{
			color = --[[E:func_rgb2hex(EXPANSION_COLOR_7.r, EXPANSION_COLOR_7.g, EXPANSION_COLOR_7.b) or]] E.Legion_Color,
			-- revers = 5,
			name = EXPANSION_NAME6 or "Legion",
			nameVeryShort = "Legion",
			icon = 1715536, -- 1711335,
		},
		{
			color = --[[E:func_rgb2hex(EXPANSION_COLOR_8.r, EXPANSION_COLOR_8.g, EXPANSION_COLOR_8.b) or]] E.BattleforAzeroth_Color,
			-- revers = 4,
			name = EXPANSION_NAME7 or "Battle for Azeroth",
			nameVeryShort = "BfA",
			icon = 3256381, -- 3194610,
		},
		{
			color = --[[E:func_rgb2hex(EXPANSION_COLOR_9.r, EXPANSION_COLOR_9.g, EXPANSION_COLOR_9.b) or]] E.Shadowlands_Color,
			-- revers = 3,
			name = EXPANSION_NAME8 or "Shadowlands",
			nameVeryShort = "SL",
			icon = 4465334, -- 4254080,
		},
		{
			color = --[[E:func_rgb2hex(EXPANSION_COLOR_10.r, EXPANSION_COLOR_10.g, EXPANSION_COLOR_10.b) or]] E.Dragonflight_Color,
			-- revers = 2,
			name = EXPANSION_NAME9 or "Dragonflight",
			nameVeryShort = "DF",
			icon = 5409250, -- 5342925,
		},
		{
			color = --[[E:func_rgb2hex(EXPANSION_COLOR_11.r, EXPANSION_COLOR_11.g, EXPANSION_COLOR_11.b) or]] E.TheWarWithin_Color,
			-- revers = 1,
			name = EXPANSION_NAME10 or "The War Within",
			nameVeryShort = "TWW",
			icon = 6377935, -- 5779391,
		},
		{
			color = --[[E:func_rgb2hex(EXPANSION_COLOR_12.r, EXPANSION_COLOR_12.g, EXPANSION_COLOR_12.b) or]] E.Midnight_Color,
			name = EXPANSION_NAME11 or "Midnight",
			nameVeryShort = "MN",
			icon = 132123,
		},
		{
			color = --[[E:func_rgb2hex(EXPANSION_COLOR_13.r, EXPANSION_COLOR_13.g, EXPANSION_COLOR_13.b) or]] E.TheLastTitan_Color,
			name = EXPANSION_NAME12 or "The Last Titan",
			nameVeryShort = "TLT",
			icon = 4622478,
		},
	}
	for i, v in ipairs(Expansions) do
		print (i, v.name)
	end
	print ("END")
	return
end
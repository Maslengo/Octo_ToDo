local GlobalAddonName, E = ...
-- https://warcraft.wiki.gg/wiki/Catalyst
E.OctoTable_Catalysts = {
	-- The War Within
	-- (Season 4)
	-- (Season 3)
	3116, -- Essence of Kaja'mite (Season 2)
	-- 2813, -- Harmonized Silk (Season 1)
	-- Dragonflight
	-- 2912, -- Renascent Awakening ()
	-- 2796, -- Renascent Dream (Season 3)
	-- 2533, -- Renascent Shadowflame (Season 2)
	-- 2167, -- Catalyst Charges (Season 1)
}
E.OctoTables_DataOtrisovka = {
	-- "World of Warcraft",
	{
		["Items"] = {
		},
		["Currencies"] = {
		},
	},
	-- "The Burning Crusade",
	{
		["Items"] = {
			23572,
			30183,
			32428,
			34664,
			{24581, 24579},
			-- 24581, -- HORDE
			-- 24579, -- ALLIANCE
		},
		["Currencies"] = {
		},
	},
	-- "Wrath of the Lich King",
	{
		["Items"] = {
			45087, 47556, 49908,
		},
		["Currencies"] = {
			241, -- Champion's Seal
		},
	},
	-- "Cataclysm",
	{
		["Items"] = {
			52078,
			69237,
			71998,
		},
		["Currencies"] = {
			391, -- Tol Barad Commendation
			416, -- Mark of the World Tree
		},
	},
	-- "Mists of Pandaria",
	{
		["Items"] = {
		},
		["Currencies"] = {
			402, -- Ironpaw Token
			738, -- Lesser Charm of Good Fortune
			752, -- Mogu Rune of Fate
			776, -- Warforged Seal
			777,
			789,
			697, -- (697 MONETKA)
		},
	},
	-- "Warlords of Draenor",
	{
		["Items"] = {
		},
		["Currencies"] = {
			1101, 823, 1129, 994, -- (1129, 994 MONETKA) (824 GARRISON_RESOURCE_ID)
		},
	},
	-- "Legion",
	{
		["Items"] = {
		},
		["Currencies"] = {
			1508,
			1342,
			1220,
			1226,
			1533,
			1155,
			1149,
			1416,
			1273, -- (1273 MONETKA)

			3292, -- E.func_IsRemix()
			3268, -- E.func_IsRemix()
			3252, -- E.func_IsRemix()


		},
	},
	-- "Battle for Azeroth",
	-- {1803, 1755, 1719, 1721, 1718, 1580, 1560, 1717, 1716, 1710, }, -- ДОБАВИТЬ ИТЕМ 173363 к 1719 (1580 MONETKA)
	{
		["Items"] = {
		},
		["Currencies"] = {
			1560, 1721, 1803, 1755, 1719, 1710, 1716, 1717, 1718, 1580,
		},
	},
	-- "Shadowlands",
	-- {2009, 1979, 1977, 1931, 1816, 1904, 1906, 1828, 1767, 1820, 1889, 1885, 1810, },
	{
		["Items"] = {
		},
		["Currencies"] = {
			2009, 1906, 1828, 1979, 1931,
		},
	},
	-- "Dragonflight",
	{
		["Items"] = {
			209856, 207002, 210254, 213089, 211516, 211515,
		},
		["Currencies"] = {
			2122, 2118, 2003, 1191, 1602, 2245, 2594, -- (УСТАРЕЛО АСПЕКТЫ 2812, 2809, 2807, 2806)
		},
	},
	-- "The War Within",
	{
		["Items"] = {
		},
		["Currencies"] = {
			-- 3056, 2815,
			-- season 3
			3356, 3290, 3288, 3286, 3284, 3141, 3028, 3008, 2803,
			-- 3149, 3226, 3218, 3090, 3028, 2803, 3116, 2815, 3056, 3008, 3110, 3109, 3108, 3107,
		},
	},
	-- "Midnight",
	{
		["Items"] = {
		},
		["Currencies"] = {
		},
	},
	-- "The Last Titan",
	{
		["Items"] = {
		},
		["Currencies"] = {
		},
	},
}
E.OctoTable_Currencies = {
	81, -- Epicurean Award
	515, -- Darkmoon Prize Ticket
	2588, -- Riders of Azeroth Badge
	-- Wrath of the Lich King
	241, -- Champion's Seal
	-- Cataclysm
	391, -- Tol Barad Commendation
	416, -- Mark of the World Tree
	-- Mists of Pandaria
	402, -- Ironpaw Token
	697, -- Elder Charm of Good Fortune
	738, -- Lesser Charm of Good Fortune
	752, -- Mogu Rune of Fate
	776, -- Warforged Seal
	777, -- Timeless Coin
	789, -- Bloody Coin
	-- Warlords of Draenor
	823, -- Apexis Crystal
	824, -- Garrison Resources
	994, -- Seal of Tempered Fate
	1101, -- Oil
	1129, -- Seal of Inevitable Fate
	1149, -- Sightless Eye
	1155, -- Ancient Mana
	1166, -- Timewarped Badge
	-- Legion
	1220, -- Order Resources
	1226, -- Nethershards
	1273, -- Seal of Broken Fate
	1275, -- Curious Coin
	1299, -- Brawler's Gold
	1314, -- Lingering Soul Fragment
	1342, -- Legionfall War Supplies
	1501, -- Writhing Essence
	1508, -- Veiled Argunite
	1533, -- Wakening Essence
	-- Battle for Azeroth
	1710, -- Seafarer's Dubloon
	1580, -- Seal of Wartorn Fate
	1560, -- War Resources
	1587, -- War Supplies
	1716, -- Honorbound Service Medal
	1717, -- 7th Legion Service Medal
	1718, -- Titan Residuum
	1721, -- Prismatic Manapearl
	1719, -- Corrupted Memento
	1755, -- Coalescing Visions
	1803, -- Echoes of Ny'alotha
	-- Shadowlands
	1754, -- Argent Commendation
	1191, -- Valor
	1602, -- Conquest
	1792, -- Honor
	1822, -- Renown
	1767, -- Stygia
	1828, -- Soul Ash
	1810, -- Redeemed Soul
	1813, -- Reservoir Anima
	1816, -- Sinstone Fragments
	1819, -- Medallion of Service
	1820, -- Infused Ruby
	1885, -- Grateful Offering
	1889, -- Adventure Campaign Progress
	1904, -- Tower Knowledge
	1906, -- Soul Cinders
	1931, -- Cataloged Research
	1977, -- Stygian Ember
	1979, -- Cyphers of the First Ones
	2009, -- Cosmic Flux
	2000, -- Motes of Fate
	-- Dragonflight
	2003, -- Dragon Isles Supplies
	2245, -- Flightstones
	2123, -- Bloody Tokens
	2797, -- Trophy of Strife
	2045, -- Dragon Glyph Embers
	2118, -- Elemental Overflow
	2122, -- Storm Sigil
	2409, -- Whelpling Crest Fragment Tracker [DNT]
	2410, -- Drake Crest Fragment Tracker [DNT]
	2411, -- Wyrm Crest Fragment Tracker [DNT]
	2412, -- Aspect Crest Fragment Tracker [DNT]
	2413, -- 10.1 Professions - Personal Tracker - S2 Spark Drops (Hidden)
	2533, -- Renascent Shadowflame
	2594, -- Paracausal Flakes
	2650, -- Emerald Dewdrop
	2651, -- Seedbloom
	2777, -- Dream Infusion
	2796, -- Renascent Dream
	2706, -- Whelpling's Dreaming Crest
	2707, -- Drake's Dreaming Crest
	2708, -- Wyrm's Dreaming Crest
	2709, -- Aspect's Dreaming Crest
	2774, -- 10.2 Professions - Personal Tracker - S3 Spark Drops (Hidden)
	2657, -- Mysterious Fragment
	2912, -- Renascent Awakening
	2806, -- Whelpling's Awakened Crest
	2807, -- Drake's Awakened Crest
	2809, -- Wyrm's Awakened Crest
	2812, -- Aspect's Awakened Crest
	2800, -- 10.2.6 Professions - Personal Tracker - S4 Spark Drops (Hidden)
	3010, -- 10.2.6 Rewards - Personal Tracker - S4 Dinar Drops (Hidden)
	2778, -- Bronze
	-- The War Within
	3089, -- Residual Memories
	2803, -- Undercoin
	2815, -- Resonance Crystals
	3028, -- Restored Coffer Key
	3056, -- Kej
	3008, -- Valorstones
	2813, -- Harmonized Silk
	2914, -- Weathered Harbinger Crest
	2915, -- Carved Harbinger Crest
	2916, -- Runed Harbinger Crest
	2917, -- Gilded Harbinger Crest
	3023, -- 11.0 Professions - Personal Tracker - S1 Spark Drops (Hidden)
	3100, -- Bronze Celebration Token
	3090, -- Flame-Blessed Iron
	3218, -- Empty Kaja'Cola Can
	3220, -- Vintage Kaja'Cola Can
	3226, -- Market Research
	3116, -- Essence of Kaja'mite
	3107, -- Weathered Undermine Crest
	3108, -- Carved Undermine Crest
	3109, -- Runed Undermine Crest
	3110, -- Gilded Undermine Crest
	3132, -- 11.1 Professions - Personal Tracker - S2 Spark Drops (Hidden)
	3216, -- Bounty's Remnants
	3309, -- Осколок камня Преисподней
	2815,
	3055,
	3223,
	3093,
	2839,
	3139,
	3149, -- Displaced Corrupted Mementos
	3303, -- Untethered Coin
	3356, -- Untainted Mana-Crystals
	3269, -- Ethereal Voidsplinter
	3284, -- Weathered Ethereal Crest
	3286, -- Carved Ethereal Crest
	3288, -- Runed Ethereal Crest
	3290, -- Gilded Ethereal Crest
	3141, -- Starlight Spark Dust


	3292, -- E.func_IsRemix()
	3268, -- E.func_IsRemix()
	3252, -- E.func_IsRemix()


}
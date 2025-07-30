local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
function E:func_Universal_11_TheWarWithin()
	local OctoTable_Universal = {
		{
			icon = E.Icon_WorldBoss,
			textleft = L["World Boss"],
			name_save = "WorldBoss",
			reset = "Weekly",
			desc = "TheWarWithin",
			questID = {
				81630,
				82653,
				81653,
				81624,
				85088,
			},
			max = 1,
		},
		{
			icon = E:func_GetItemIconByID(227794),
			textleft = E:func_questName(84370),
			name_save = "TheKeytoSuccess",
			reset = "Weekly",
			desc = "TheWarWithin",
			questID = {
				84370,
			},
			max = 1,
		},
		{
			icon = E:func_GetItemIconByID(224784),
			textleft = E:func_questName(82449),
			name_save = "TheCalloftheWorldsoul",
			reset = "Weekly",
			desc = "TheWarWithin",
			-- https://wago.tools/db2/QuestLineXQuest?filter[QuestLineID]=5572&page=1&sort[OrderIndex]=asc
			questID = {
				-- 87424,
				-- 87423,
				-- 87422,
				-- 87419,
				-- 87417,
				-- 82659,
				-- 82516,
				-- 82512,
				-- 82511,
				-- 82510,
				-- 82509,
				-- 82508,
				-- 82507,
				-- 82506,
				-- 82505,
				-- 82504,
				-- 82503,
				-- 82502,
				-- 82501,
				-- 82500,
				-- 82499,
				-- 82498,
				-- 82497,
				-- 82496,
				-- 82495,
				-- 82494,
				-- 82493,
				-- 82492,
				-- 82491,
				-- 82490,
				-- 82489,
				-- 82488,
				-- 82487,
				-- 82486,
				-- 82485,
				-- 82483,
				-- 82482,
				-- 82453,
				-- 82452,
				-- 82321,
				-- 82286,
				-- 82285,
				-- 82263,
				-- 82260,
				-- 82207,
				-- 82164,
				-- 81985,
				82482, -- Worldsoul: Snuffling
				82516, -- Worldsoul: Forging a Pact
				82483, -- Worldsoul: Spreading the Light
				82453, -- Worldsoul: Encore!
				82489, -- Worldsoul: The Dawnbreaker
				82659, -- Worldsoul: Nerub-ar Palace
				87417, -- Worldsoul: Dungeons
				87419, -- Worldsoul: Delves
				82490, -- Worldsoul: Priory of the Sacred Flame
				82491, -- Worldsoul: Ara-Kara, City of Echoes
				82492, -- Worldsoul: City of Threads
				82493, -- Worldsoul: The Dawnbreaker
				82494, -- Worldsoul: Ara-Kara, City of Echoes
				82496, -- Worldsoul: City of Threads
				82497, -- Worldsoul: The Stonevault
				82498, -- Worldsoul: Darkflame Cleft
				82499, -- Worldsoul: Priory of the Sacred Flame
				82500, -- Worldsoul: The Rookery
				82501, -- Worldsoul: The Dawnbreaker
				82502, -- Worldsoul: Ara-Kara, City of Echoes
				82503, -- Worldsoul: Cinderbrew Meadery
				82504, -- Worldsoul: City of Threads
				82505, -- Worldsoul: The Stonevault
				82506, -- Worldsoul: Darkflame Cleft
				82507, -- Worldsoul: Priory of the Sacred Flame
				82508, -- Worldsoul: The Rookery
				82509, -- Worldsoul: Nerub-ar Palace
				82510, -- Worldsoul: Nerub-ar Palace
				82511, -- Worldsoul: Awakening Machine
				89514, -- Worldsoul: Horrific Visions Revisited
				82512, -- Worldsoul: World Boss
				87423, -- Worldsoul: Undermine Explorer
				87424, -- Worldsoul: World Bosses
				82488, -- Worldsoul: Darkflame Cleft
				82487, -- Worldsoul: The Stonevault
				82486, -- Worldsoul: The Rookery
				82485, -- Worldsoul: Cinderbrew Meadery
				82452, -- Worldsoul: World Quests
				87422, -- Worldsoul: Undermine World Quests
				82495, -- Worldsoul: Cinderbrew Meadery
				89502, -- Worldsoul: Nightfall
			},
			max = 1,
		},
		{
			icon = E:func_GetItemIconByID(224784),
			textleft = "Archives",
			name_save = "Archives",
			reset = "Weekly",
			desc = "TheWarWithin",
			questID = {
				82678,
				82679,
			},
			max = 1,
		},
		{
			icon = E:func_GetItemIconByID(224784),
			textleft = "Delves",
			name_save = "Delves",
			reset = "Weekly",
			desc = "TheWarWithin",
			questID = {
				82708,
				82707,
				82706,
				82709,
				82710,
				82711,
				82712,
				82746,
				39020,
				39033,
				40792,
				39042,
				39021,
				39034,
				39040,
				39041,
				44174,
				64970,
				72719,
				72724,
				72725,
				72726,
				83365,
				72727,
				83363,
				72810,
				83345,
				84776,
				83347,
				83358,
				83357,
				83366,
			},
			max = 1,
		},
		{
			icon = E:func_GetItemIconByID(226263),
			textleft = E.Timers.TWW_BeledarCycle()..E:func_questName(83240),
			name_save = "TheTheaterTroupe",
			reset = "Weekly",
			desc = "TheWarWithin",
			questID = {
				83240,
			},
			max = 1,
		},
		{
			icon = E:func_GetItemIconByID(220756),
			textleft = E:func_questName(76586),
			name_save = "SpreadingtheLight",
			reset = "Weekly",
			desc = "TheWarWithin",
			questID = {
				76586,
			},
			max = 1,
		},
		{
			icon = E:func_GetItemIconByID(226273),
			textleft = E:func_questName(83333),
			name_save = "GearingUpforTrouble",
			reset = "Weekly",
			desc = "TheWarWithin",
			questID = {
				83333,
			},
			max = 1,
		},
		{
			icon = E.Icon_Empty,
			textleft = "SpecialAssignments",
			name_save = "SpecialAssignments",
			reset = "Weekly",
			desc = "TheWarWithin",
			questID = {
				82355,
				81649,
				81691,
				83229,
				82852,
				82787,
				82414,
				82531,
			},
			max = 2,
		},
		{
			icon = E:func_GetItemIconByID(227792),
			textleft = E:func_questName(82946),
			name_save = "RollinDownintheDeeps",
			reset = "Weekly",
			desc = "TheWarWithin",
			questID = {
				82946,
			},
			max = 1,
		},
		{
			icon = E:func_GetItemIconByID(237014),
			textleft = "BiergothDungeonQuest",
			name_save = "BiergothDungeonQuest",
			reset = "Weekly",
			desc = "TheWarWithin",
			questID = {
				83432,
				83436,
				83443,
				83457,
				83458,
				83459,
				83465,
				83469,
				83460,
			},
			max = 1,
		},
		{
			icon = E:func_GetSpellIcon(2575), -- PROFESSION
			textleft = "TWWProfessionWeeklies",
			name_save = "TWWProfessionWeeklies",
			reset = "Weekly",
			desc = "TheWarWithin",
			questID = {
				84127,
				84128,
				84129,
				84130,
				84131,
				84132,
				84133,
				83103,
				83102,
				83104,
				83106,
				83105,
				83097,
				83100,
				82993,
				83098,
				82992,
				84086,
				84084,
				84085,
				82970,
				82962,
				82965,
				82958,
				82916,
			},
			max = 2,
		},
		{
			icon = E:func_GetSpellIcon(2575), -- PROFESSION
			textleft = "TWWAlgariTreatise",
			name_save = "TWWAlgariTreatise",
			reset = "Weekly",
			desc = "TheWarWithin",
			questID = {
				83725,
				83726,
				83727,
				83728,
				83729,
				83730,
				83731,
				83732,
				83733,
				83734,
				83735,
			},
			max = 2,
		},
		{
			icon = E:func_GetItemIconByID(224172),
			textleft = "AnniversaryRestoredCofferKey",
			name_save = "AnniversaryRestoredCofferKey",
			reset = "Weekly",
			desc = "TheWarWithin",
			questID = {
				86202,
			},
			max = 1,
		},
		{
			icon = E.Icon_Empty,
			textleft = "SirenIsleWeekly",
			name_save = "SirenIsleWeekly",
			reset = "Weekly",
			desc = "TheWarWithin",
			questID = {
				84852,
				84680,
				83932,
				84432,
				84248,
				84222,
				84851,
				83753,
				84299,
				84619,
				83827,
				84001,
				84850,
				85589,
				84430,
				85051,
				84627,
			},
			max = 6,
		},
		{
			icon = E:func_GetItemIconByID(142307),
			textleft = "MajorKeyflames",
			name_save = "MajorKeyflames",
			reset = "Weekly",
			desc = "TheWarWithin",
			questID = {
				79471,
				79470,
				79469,
				79380,
				79329,
				78657,
				78590,
				76338,
			},
			max = 8,
		},
		{
			icon = E:func_GetItemIconByID(142307),
			textleft = "MinorKeyflames",
			name_save = "MinorKeyflames",
			reset = "Weekly",
			desc = "TheWarWithin",
			questID = {
				81632,
				-- 81574,
				-- 80562,
				80004,
				-- 79346,
				-- 79216,
				79173,
				-- 79158,
				78972,
				-- 78933,
				-- 78915,
				78656,
				76997,
				-- 76733,
				76600,
				76394,
				-- 76169,
				-- SAVEDINSTANCE
				-- 76169, -- Glow in the Dark
				-- 76394, -- Shadows of Flavor
				-- 76600, -- Right Between the Gyros-Optics
				-- 76733, -- Tater Trawl
				-- 76997, -- Lost in Shadows
				-- 78656, -- Hose It Down
				-- 78915, -- Squashing the Threat
				-- 78933, -- The Sweet Eclipse
				-- 78972, -- Harvest Havoc
				-- 79158, -- Seeds of Salvation
				-- 79173, -- Supply the Effort
				-- 79216, -- Web of Manipulation
				-- 79346, -- Chew On That
				-- 80004, -- Crab Grab
				-- 80562, -- Blossoming Delight
				-- 81574, -- Sporadic Growth
				-- 81632, -- Lizard Looters
			},
			max = 8,
		},
		{
			icon = 5315246,
			textleft = L["Delver's Call"],
			name_save = "DelversCall",
			reset = "Once",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				83766,
				85649,
				85648,
				83758,
				83759,
				83769,
				85664,
				83767,
				83768,
				83770,
				85666,
				83771,
				85667,
			},
			max = 13,
		},






		{
			icon = E.Icon_Empty,
			textleft = "tww-weekly-cache",
			name_save = "tww-weekly-cache",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				84736,
				84737,
				84738,
				84739,
			},
			max = 4,
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-lesser-keyflame",
			name_save = "tww-lesser-keyflame",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				76169, -- Glow in the Dark
				76394, -- Shadows of Flavor
				76600, -- Right Between the Gyros-Optics
				76733, -- Tater Trawl
				76997, -- Lost in Shadows
				78656, -- Hose It Down
				78915, -- Squashing the Threat
				78933, -- The Sweet Eclipse
				78972, -- Harvest Havoc
				79158, -- Seeds of Salvation
				79173, -- Supply the Effort
				79216, -- Web of Manipulation
				79346, -- Chew On That
				80004, -- Crab Grab
				80562, -- Blossoming Delight
				81574, -- Sporadic Growth
				81632, -- Lizard Looters
			},
			max = 8,
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-brawl-weekly",
			name_save = "tww-brawl-weekly",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				47148,
			},
			max = 1,
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-pvp-weekly",
			name_save = "tww-pvp-weekly",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				80184, -- Preserving in Battle
				80185, -- Preserving Solo
				80186, -- Preserving in War
				80187, -- Preserving in Skirmishes
				80188, -- Preserving in Arenas
				80189, -- Preserving Teamwork
			},
			max = 6, -- ОДИН?
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-pvp-world",
			name_save = "tww-pvp-world",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				81793, -- Sparks of War: Isle of Dorn
				81794, -- Sparks of War: The Ringing Deeps
				81795, -- Sparks of War: Hallowfall
				81796, -- Sparks of War: Azj-Kahet
				86853, -- Sparks of War: Undermine
			},
			max = 5, -- ОДИН?
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-the-severed-threads",
			name_save = "tww-the-severed-threads",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				80670, -- Eyes of the Weaver
				80671, -- Blade of the General
				80672, -- Hand of the Vizier
			},
			max = 3,
		},
		{
			icon = E.Icon_Horde,
			textleft = "tww-the-call-of-the-worldsoul",
			name_save = "tww-the-call-of-the-worldsoul",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				-- https://wago.tools/db2/QuestLineXQuest?filter[QuestLineID]=5572&page=1&sort[OrderIndex]=asc
				82482, -- Worldsoul: Snuffling
				82516, -- Worldsoul: Forging a Pact
				82483, -- Worldsoul: Spreading the Light
				82453, -- Worldsoul: Encore!
				82489, -- Worldsoul: The Dawnbreaker
				82659, -- Worldsoul: Nerub-ar Palace
				87417, -- Worldsoul: Dungeons
				87419, -- Worldsoul: Delves
				82490, -- Worldsoul: Priory of the Sacred Flame
				82491, -- Worldsoul: Ara-Kara, City of Echoes
				82492, -- Worldsoul: City of Threads
				82493, -- Worldsoul: The Dawnbreaker
				82494, -- Worldsoul: Ara-Kara, City of Echoes
				82496, -- Worldsoul: City of Threads
				82497, -- Worldsoul: The Stonevault
				82498, -- Worldsoul: Darkflame Cleft
				82499, -- Worldsoul: Priory of the Sacred Flame
				82500, -- Worldsoul: The Rookery
				82501, -- Worldsoul: The Dawnbreaker
				82502, -- Worldsoul: Ara-Kara, City of Echoes
				82503, -- Worldsoul: Cinderbrew Meadery
				82504, -- Worldsoul: City of Threads
				82505, -- Worldsoul: The Stonevault
				82506, -- Worldsoul: Darkflame Cleft
				82507, -- Worldsoul: Priory of the Sacred Flame
				82508, -- Worldsoul: The Rookery
				82509, -- Worldsoul: Nerub-ar Palace
				82510, -- Worldsoul: Nerub-ar Palace
				82511, -- Worldsoul: Awakening Machine
				89514, -- Worldsoul: Horrific Visions Revisited
				82512, -- Worldsoul: World Boss
				87423, -- Worldsoul: Undermine Explorer
				87424, -- Worldsoul: World Bosses
				82488, -- Worldsoul: Darkflame Cleft
				82487, -- Worldsoul: The Stonevault
				82486, -- Worldsoul: The Rookery
				82485, -- Worldsoul: Cinderbrew Meadery
				82452, -- Worldsoul: World Quests
				87422, -- Worldsoul: Undermine World Quests
				82495, -- Worldsoul: Cinderbrew Meadery
				89502, -- Worldsoul: Nightfall
			},
			max = 1,
		},







		{
			icon = E.Icon_Empty,
			textleft = "tww-archives",
			name_save = "tww-archives",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				-- https://wago.tools/db2/QuestLineXQuest?filter[QuestLineID]=5572&page=1&sort[OrderIndex]=asc
				82679, -- Archives: Seeking History
				82678, -- Archives: The First Disc
			},
			max = 2,
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-delves",
			name_save = "tww-delves",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				-- https://wago.tools/db2/QuestLineXQuest?filter[QuestLineID]=5572&page=1&sort[OrderIndex]=asc
				82708, -- Delves: Nerubian Menace
				82707, -- Delves: Earthen Defense
				82706, -- Delves: Worldwide Research
				82709, -- Delves: Percussive Archaeology
				82710, -- Delves: Empire-ical Exploration
				82711, -- Delves: Lost and Found
				82712, -- Delves: Trouble Up and Down Khaz Algar
				82746, -- Delves: Breaking Tough to Loot Stuff
			},
			max = 8,
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-the-theater-trope",
			name_save = "tww-the-theater-trope",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				83240,
			},
			max = 1,
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-spreading-the-light",
			name_save = "tww-spreading-the-light",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				76586,
			},
			max = 1,
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-gearing-up-for-trouble",
			name_save = "tww-gearing-up-for-trouble",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				83333,
			},
			max = 1,
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-special-assignments",
			name_save = "tww-special-assignments",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				82355, -- Special Assignment: Cinderbee Surge (Completing)
				81647, -- Special Assignment: Titanic Resurgence (Completing)
				81649, -- Special Assignment: Titanic Resurgence (Completing)
				81650, -- Special Assignment: Titanic Resurgence (Completing)
				81691, -- Special Assignment: Shadows Below (Completing)
				83229, -- Special Assignment: When the Deeps Stir (Completing)
				82852, -- Special Assignment: Lynx Rescue (Completing)
				82787, -- Special Assignment: Rise of the Colossals (Completing)
				82414, -- Special Assignment: A Pound of Cure (Completing)
				82531, -- Special Assignment: Bombs from Behind (Completing)
				85487, -- Special Assignment: Boom! Headshot! (Completing)
				85488, -- Special Assignment: Security Detail (Completing)
			},
			max = 3,
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-rollin-down-in-the-deeps",
			name_save = "tww-rollin-down-in-the-deeps",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				82946,
			},
			max = 1,
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-biergoth-dungeon-quest",
			name_save = "tww-biergoth-dungeon-quest",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				83432, -- The Rookery
				83436, -- Cinderbrew Meadery
				83443, -- Darkflame Cleft
				83457, -- The Stonevault
				83458, -- Priory of the Sacred Flame
				83459, -- The Dawnbreaker
				83465, -- Ara-Kara, City of Echoes
				83469, -- City of Threads
				86203, -- Operation: Floodgate
			},
			max = 1, -- "any"
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-the-key-to-success",
			name_save = "tww-the-key-to-success",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				84370,
			},
			max = 1,
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-services-requested",
			name_save = "tww-services-requested",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				84127, -- Blacksmithing Services Requested
				84128, -- Engineering Services Requested
				84129, -- Inscription Services Requested
				84130, -- Jewelcrafting Services Requested
				84131, -- Leatherworking Services Requested
				84132, -- Tailoring Services Requested
				84133, -- Alchemy Services Requested
				83103, -- Acquiring Aqirite
				83102, -- Bismuth is Business
				83104, -- Identifying Ironclaw
				83106, -- Null Pebble Excavation
				83105, -- Rush-order Requisition
				83097, -- Cinder and Storm
				83100, -- Cracking the Shell
				82993, -- From Shadows
				83098, -- Snap and Crackle
				82992, -- Stormcharged Goods
				84086, -- A Rare Necessity
				84084, -- Just a Pinch
				84085, -- The Power of Potential
				82970, -- A Bloom and A Blossom
				82962, -- A Handful of Luredrops
				82965, -- Light and Shadow
				82958, -- Little Blessings
				82916, -- When Fungi Bloom
			},
			max = 2,
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-algari-treatise",
			name_save = "tww-algari-treatise",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				83725, -- Algari Treatise on Alchemy
				83726, -- Algari Treatise on Blacksmithing
				83727, -- Algari Treatise on Enchanting
				83728, -- Algari Treatise on Engineering
				83729, -- Algari Treatise on Herbalism
				83730, -- Algari Treatise on Inscription
				83731, -- Algari Treatise on Jewelcrafting
				83732, -- Algari Treatise on Leatherworking
				83733, -- Algari Treatise on Mining
				83734, -- Algari Treatise on Skinning
				83735, -- Algari Treatise on Tailoring
			},
			max = 2,
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-anniversary-restored-coffer-key",
			name_save = "tww-anniversary-restored-coffer-key",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				86202,
			},
			max = 1,
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-siren-isle-weekly",
			name_save = "tww-siren-isle-weekly",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				-- Vrykul invasion
				84852, -- Legacy of the Vrykul
				84680, -- Rock 'n Stone Revival
				83932, -- Historical Documents
				84432, -- Longship Landing
				84248, -- A Ritual of Runes
				84222, -- Secure the Perimeter
				-- Pirate invasion
				84851, -- Tides of Greed
				83753, -- Cannon Karma
				84299, -- Pirate Plunder
				84619, -- Ooker Dooker Literature Club
				83827, -- Silence the Song
				84001, -- Cart Blanche
				-- Naga invasion
				84850, -- Serpent's Wrath
				85589, -- Ruffled Pages
				84430, -- Crystal Crusade
				85051, -- Beach Comber
				84627, -- Three Heads of the Deep
			},
			max = 6,
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-free-chett-list",
			name_save = "tww-free-chett-list",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				87296,
			},
			max = 1,
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-chett-list",
			name_save = "tww-chett-list",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				86915, -- Side with a Cartel
				86917, -- Ship Right
				86918, -- Reclaimed Scrap
				86919, -- Side Gig
				86920, -- War Mode Violence
				86923, -- Go Fish
				86924, -- Gotta Catch at Least a Few
				87302, -- Rare Rivals
				87303, -- Clean the Sidestreets
				87304, -- Time to Vacate
				87305, -- Desire to D.R.I.V.E.
				87306, -- Kaja Cruising
				87307, -- Garbage Day
			},
			max = 4,
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-delvers-bounty",
			name_save = "tww-delvers-bounty",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				86371,
			},
			max = 1,
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-nightfall-scenario",
			name_save = "tww-nightfall-scenario",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				91173,
			},
			max = 1,
		},
		{
			icon = E.Icon_Empty,
			textleft = "tww-nightfall-daily",
			name_save = "tww-nightfall-daily",
			reset = "Weekly",
			desc = "TheWarWithin", -- STORYLINE
			questID = {
				87475, -- Sureki Incursion: Hold the Wall
				87477, -- Sureki Incursion: Southern Swarm
				87480, -- Sureki Incursion: The Eastern Assault
				88711, -- Radiant Incursion: Toxins and Pheromones
				88916, -- Radiant Incursion: Sureki's End
				88945, -- Radiant Incursion: Rak-Zakaz
			},
			max = 3,
		},
	}
	return OctoTable_Universal
end
-- IF YOU WANT TO CHANGE OR ADD YOUR OWN ITEMS OR CURRENCIES TO THE TRACKER, PLEASE USE THE CUSTOM OPTIONS TAB IN WEAKAURAS.
-- DO NOT TOUCH ANYTHING BELOW THIS IF YOU DON'T KNOW WHAT YOU'RE DOING.
-- THE FIRST ENTRY IN aura_env.trackables IS AN EXAMPLE THAT SHOWS ALL POSSIBLE FIELDS.

local aura_env = aura_env
local LOG = function(...)
    if aura_env.config.debug then
        if IsAddOnLoaded("DevTool") then
            DevTool:AddData(...)
        end
    end
end
aura_env.special = {}
aura_env.UnitStatus = {}
aura_env.cooldownsToWatch = {}
aura_env.throttle_events = {}
aura_env.throttle_time = 0.2
aura_env.ActiveMaps = {uiMapID={}, area={}, zone={}, parent={}, always={}}
aura_env.covenantMaps = {1707,1708, 1698, 1701,1702,1703, 1699,1700,} --K,NL,NF,V
aura_env.delveMaps = {2269,2249,2250,2302,2251,2312,2277,2310,2300,2301,2313,2347,2259,2314,2299,2348,2396,2420,2421}
aura_env.tocversion = select(4,GetBuildInfo())

aura_env.currencies = {}
aura_env.items = {}
aura_env.trackables = {
    [999] = {
        -- ==FOR TESTING USE ONLY==
        {--Crystal Vial (all possible options)
            id = 3371,
            type = "item",
            zones = "Uldum ,Zuldazar",
            excludeByZoneText = "Torghast, Tower of the Damned",
            uiMapIDs = { 1530, [1670] = false},
            parentMapIDs = {0, "r2255",}, --recursive childs
            excludeMapIDs = {14,15,},
            areaMapIDs = {5034, 8499},
            restrict = true,
            hide = not aura_env.config.debug,
            hideZero = true,
            warnings = {enabled=true, value=10, operator=3}, --1== 2~= 3> 4< 5>= 6<=
            faction = "horde",
            shortenAmount = 1, --1=short, 2=large, 0=disabled
            always = true,
            expansion = 0, --0=Classic, -1=Any/Custom
            customColorToggle = true,
            customColor = {215/255, 184/255, 219/255, 1}, --r,g,b,a
            priority = 1, --sort priority Default:0
            value = {enabled=true, value=5, operator=3}, --1== 2~= 3> 4< 5>= 6<=
        },
    },
    [10] = {
        -- ===THE WAR WITHIN===
        -- currencies:
        {--Valorstones
            id = 3008,
            type = "currency",
            uiMapIDs = {2339},
            parentMapIDs = {"r2274"},
            excludeMapIDs = aura_env.delveMaps,
            customColorToggle = true,
            customColor = {0,0.8,1,1}, --r,g,b,a
            priority = 1,
        },
        {--Weathered Crest
            id = 3107,
            type = "currency",
            uiMapIDs = {2339},
            parentMapIDs = {"r2274"},
            excludeMapIDs = aura_env.delveMaps,
            customColorToggle = true,
            customColor = {0.12, 1, 0, 1}, --r,g,b,a
            priority = 2,
            hide = true,
        },
        {--Carved Crest
            id = 3108,
            type = "currency",
            uiMapIDs = {2339},
            parentMapIDs = {"r2274"},
            excludeMapIDs = aura_env.delveMaps,
            customColorToggle = true,
            customColor = {0,0.44,0.87,1}, --r,g,b,a
            priority = 3,
            hide = true,
        },
        {--Runed Crest
            id = 3109,
            type = "currency",
            uiMapIDs = {2339},
            parentMapIDs = {"r2274"},
            excludeMapIDs = aura_env.delveMaps,
            customColorToggle = true,
            customColor = {0.64,0.21,0.93,1}, --r,g,b,a
            priority = 4,
            hide = true,
        },
        {--Gilded Crest
            id = 3110,
            type = "currency",
            uiMapIDs = {2339},
            parentMapIDs = {"r2274"},
            excludeMapIDs = aura_env.delveMaps,
            customColorToggle = true,
            customColor = {1,0.5,0,1}, --r,g,b,a
            priority = 5,
        },
        {--Kej
            id = 3056,
            type = "currency",
            parentMapIDs = {2255},
        },
        {--Resonance Crystals
            id = 2815,
            type = "currency",
            areaMapIDs = {14796,15545,14755,15044,15043},
            excludeMapIDs = aura_env.delveMaps,
            shortenAmount = 1,
        },
        {--Essence of Kaja'mite
            id = 3116,
            type = "currency",
            areaMapIDs = {15043},
        },
        {--Undercoin
            id = 2803,
            type = "currency",
            areaMapIDs = {15329},
            uiMapIDs = aura_env.delveMaps,
        },
        {--Restored Coffer Key
            id = 3028,
            type = "currency",
            areaMapIDs = {15329},
            uiMapIDs = aura_env.delveMaps,
        },
        {--Flame-Blessed Iron
            id = 3090,
            type = "currency",
            parentMapIDs = {"r2369"},
        },
        {--Empty Kaja'Cola Can
            id = 3218,
            type = "currency",
            uiMapIDs = {2346},
        },
        {--Market Research
            id = 3226,
            type = "currency",
            uiMapIDs = {2346},
            hideZero = true,
        },    
        {--Displaced Corrupted Mementos
            id = 3149,
            type = "currency",
            uiMapIDs = {2404},
            areaMapIDs = {15046},
            hideZero = true,
        },  
        
        -- items:
        {--Coffer Key Shard
            id = 236096,
            type = "item",
            uiMapIDs = {2339, unpack(aura_env.delveMaps)},
            parentMapIDs = {"r2274"},
            warnings = {enabled=true, value=100, operator=5}, --1== 2~= 3> 4< 5>= 6<=
            hideZero = true,
            value = {enabled=true, value=100, operator=">="}
        },
        {--Radiant Echo
            id = 235897,
            type = "item",
            uiMapIDs = aura_env.delveMaps,
            areaMapIDs = {15329,15357,15356,15384,15148,15451,15330,15450,15360,15647},
        },
        {--Artisan's Acuity
            id = 210814,
            type = "item",
            areaMapIDs = {15043},
            zones = "Crafter's Enclave", --has no areaID
        },
        {--Radiant Remnant
            id = 206350,
            type = "item",
            areaMapIDs = {14854,15037,15094,14851,15114,14850,14852,15024,15025,15106},
        },
        {--Radiant Emblem of Service
            id = 238920,
            type = "item",
            areaMapIDs = {15335},
            hideZero = true,
        },
    },    
    [9] = {
        -- ===DRAGONFLIGHT===
        -- currencies:
        {--Paracausal Flakes
            id = 2594,
            type = "currency",
            hideZero = true,
            areaMapIDs = {13802},            
        },
        {--Flightstones
            id = 2245,
            type = "currency",
            uiMapIDs = {2112,2200},
            parentMapIDs = {1978},
            customColorToggle = true,
            customColor = {0,0.8,1,1}, --r,g,b,a
            priority = 1,
        },
        {--Conquest
            id = 1602,
            type = "currency",
            zones = "Gladiator's Refuge",
            areaMapIDs = {14499},
        },
        {--Valor
            id = 1191,
            type = "currency",
            zones = "Gladiator's Refuge",
            areaMapIDs = {14499},
        },
        {--Dragon Isles Supplies
            id = 2003,
            type = "currency",
            parentMapIDs = {1978,2025},
            shortenAmount = 1,
            tocversion = 100002,
        },
        {--Elemental Overflow
            id = 2118,
            type = "currency",
            zones = "The Sapphire Enclave",
            areaMapIDs = {14504},
            shortenAmount = 1,
            tocversion = 100002,
        },
        {--Storm Sigil
            id = 2122,
            type = "currency",
            zones = "The Sapphire Enclave",
            areaMapIDs = {14504},
            shortenAmount = 1,
            tocversion = 100002,
        },
        {--Whelpling's Awakened Crest
            id = 2806,
            type = "currency",
            uiMapIDs = {2200,2112},
            areaMapIDs = {14960},
            customColorToggle = true,
            customColor = {0.12, 1, 0, 1}, --r,g,b,a
            priority = 2,
            hide = true,
        },
        {--Drake's Awakened Crest
            id = 2807,
            type = "currency",
            uiMapIDs = {2200,2112},
            areaMapIDs = {14960},
            customColorToggle = true,
            customColor = {0,0.44,0.87,1}, --r,g,b,a
            priority = 3,
            hide = true,
        },
        {--Wyrm's Awakened Crest
            id = 2809,
            type = "currency",
            uiMapIDs = {2200,2112},
            areaMapIDs = {14960},
            customColorToggle = true,
            customColor = {0.64,0.21,0.93,1}, --r,g,b,a
            priority = 4,
            hide = true,
        },
        {--Aspect's Awakened Crest
            id = 2812,
            type = "currency",
            uiMapIDs = {2200,2112},
            areaMapIDs = {14960},
            parentMapIDs = {1978},
            customColorToggle = true,
            customColor = {1,0.5,0,1}, --r,g,b,a
            priority = 5,
        },
        
        -- items:
        {--Antique Bronze Bullion
            id = 213089,
            type = "item",
            hideZero = false,
            areaMapIDs = {14502},
        },
        {--Dilated Time Pod
            id = 209856,
            type = "item",
            hideZero = true,
            areaMapIDs = {13802},
        },
        {--Centaur Hunting Trophy
            id = 200093,
            type = "item",
            zones = "Maruukai",
            tocversion = 100002,
            warnings = {enabled=true, value=1, operator=5}
        },
        {--Restored Obsidian Key
            id = 191264,
            type = "item",
            zones = "Obsidian Throne, Obsidian Citadel, The Slagmire",
            areaMapIDs = {13941, 13717, 14012},
            tocversion = 100002,
            warnings = {enabled=true, value=100, operator=1} --1== 2~= 3> 4< 5>= 6<=
        },
        {--Key Framing
            id = 193201,
            type = "item",
            zones = "Obsidian Throne, Obsidian Citadel, The Slagmire",
            areaMapIDs = {13941, 13717, 14012},
            tocversion = 100002,
        },
        {--Key Fragments
            id = 191251,
            type = "item",
            zones = "Obsidian Throne, Obsidian Citadel, The Slagmire",
            areaMapIDs = {13941, 13717, 14012},
            tocversion = 100002,
        },
        {--Sargha's Signet
            id = 201991,
            type = "item",
            zones = "Obsidian Throne",
            areaMapIDs = {13941},
            tocversion = 100002,
            hideZero = true,
        },
        {--Mark of Sargha
            id = 200224,
            type = "item",
            zones = "Obsidian Throne",
            areaMapIDs = {13941},
            tocversion = 100002,
            hideZero = true,
        },
        {--Magmote
            id = 202173,
            type = "item",
            zones = "Smoldering Perch",
            areaMapIDs = {13976},
            tocversion = 100002,
        },
        {--Dragon Isles Artifact
            id = 192055,
            type = "item",
            zones = "Dragonscale Basecamp",
            areaMapIDs = {13732},
            tocversion = 100002,
        },
        {--Titan Relic
            id = 199906,
            type = "item",
            zones = "Valdrakken",
            areaMapIDs = {13862},
            hideZero = true,
            tocversion = 100002,
        },
        {--Zskera Vault Key
            id = 202196,
            type = "item",
            uiMapIDs = {2151},
            tocversion = 100007,
        },
    },
    [8] = {
        -- ===SHADOWLANDS===
        -- currencies:
        {--Reservoir Anima
            id = 1813,
            type = "currency",
            uiMapIDs = {1961,1819,unpack(aura_env.covenantMaps)},
            zones = "Heart of the Forest",
            parentMapIDs = {1550,},
            shortenAmount = 1,
        },
        {--Redeemed Soul
            id = 1810,
            type = "currency",
            uiMapIDs = aura_env.covenantMaps,
            zones = "Heart of the Forest",
            customColorToggle = true,
            customColor = {215/255, 184/255, 219/255, 1} --r,g,b,a
        },
        {--Grateful Offering
            id = 1885,
            type = "currency",
            uiMapIDs = aura_env.covenantMaps,
            zones = "Glitterfall Basin, Heart of the Forest",
        },
        {--Adventure Campaign Progress (Mission Table)
            id = 1889,
            type = "currency",
            uiMapIDs = aura_env.covenantMaps,
            zones = "Heart of the Forest",
            hide = true,
        },
        {--Infused Ruby
            id = 1820,
            type = "currency",
            zones = "Revendreth",
        },
        {--Stygia
            id = 1767,
            type = "currency",
            uiMapIDs = {1543},
            parentMapIDs = {1543},
            excludeByZoneText = "Torghast, Tower of the Damned",
            shortenAmount = 1,
        },
        {--Soul Ash
            id = 1828,
            type = "currency",
            uiMapIDs = {1912, 1911},
            shortenAmount = 1,
        },
        {--Soul Cinders
            id = 1906,
            type = "currency",
            uiMapIDs = {1912, 1911},
            shortenAmount = 1,
            tocversion = 90100,
        },
        {--Tower Knowledge
            id = 1904,
            type = "currency",
            uiMapIDs = {1912, 1911},
            shortenAmount = 1,
            tocversion = 90100,
            hideZero = true,
        },
        {--Honor
            id = 1792,
            type = "currency",
            uiMapIDs = {1670},
        },
        {--Sinstone Fragments
            id = 1816,
            type = "currency",
            uiMapIDs = {1525,},
            zones = "Halls of Atonement",
            restrict = true,
            hideZero = true,
        },
        {--Cataloged Research
            id = 1931,
            type = "currency",
            uiMapIDs = {1961},
            tocversion = 90100,
            shortenAmount = 1,
        },
        {--Stygian Ember
            id = 1977,
            type = "currency",
            zones = "Keeper's Respite",
        },
        {--Cyphers of the First Ones
            id = 1979,
            type = "currency",
            uiMapIDs = {1970},
            zones = "Exile's Hollow",
            tocversion = 90200,
        },
        {--Cosmic Flux
            id = 2009,
            type = "currency",
            uiMapIDs = {1970, 1912, 1911},
            tocversion = 90200,
            shortenAmount = 2,
        },
        
        -- items:
        {--Sandworn Relic
            id = 190189,
            type = "item",
            zones = "Pilgrim's Grace"
        },
        {--Genesis Mote
            id = 188957,
            type = "item",
            uiMapIDs = {1970},
            tocversion = 90200,
            hideZero = true,
        },
        {--Cypher of Relocation
            id = 180817,
            type = "item",
            uiMapIDs = {1543},
            parentMapIDs = {1543},
            excludeMapIDs = {1961},
            excludeByZoneText = "Torghast, Tower of the Damned",
        },
        {--Grand Inquisitor's Sinstone Fragment
            id = 180451,
            type = "item",
            uiMapIDs = {1525,},
            zones = "Halls of Atonement",
            restrict = true,
            hideZero = true,
        },
        {--Korthian Archivists' Key
            id = 186984,
            type = "item",
            uiMapIDs = {1961},
            tocversion = 90100,
            hideZero = true,
        },
        {--Teleporter Repair Kit
            id = 186972,
            type = "item",
            uiMapIDs = {1961},
            tocversion = 90100,
            hideZero = true,
        },
        {--Repaired Riftkey
            id = 186731,
            type = "item",
            uiMapIDs = {1961},
            tocversion = 90100,
            hideZero = true,
        },
        --**Queen's Conservatory Items**
        {--Greater Dutiful Spirit
            id = 178880,
            type = "item",
            uiMapIDs = {1662},
            hideZero = true,
        },
        {--Greater Martial Spirit
            id = 178877,
            type = "item",
            uiMapIDs = {1662},
            hideZero = true,
        },
        {--Greater Untamed Spirit
            id = 177699,
            type = "item",
            uiMapIDs = {1662},
            hideZero = true,
        },
        {--Greater Prideful Spirit
            id = 178883,
            type = "item",
            uiMapIDs = {1662},
            hideZero = true,
        },
        --**ETHEREAL The Maw Items**
        {--Stygic Dampener
            id = 183787,
            type = "item",
            uiMapIDs = {1543},
            parentMapIDs = {1543},
            excludeByZoneText = "Torghast, Tower of the Damned",
            hideZero = true,
            warnings = {enabled=true, value=1, operator=5}, --1== 2~= 3> 4< 5>= 6<=
        },
        {--Stygic Dampener
            id = 183165,
            type = "item",
            uiMapIDs = {1543},
            parentMapIDs = {1543},
            excludeByZoneText = "Torghast, Tower of the Damned",
            hideZero = true,
            warnings = {enabled=true, value=1, operator=5}, --1== 2~= 3> 4< 5>= 6<=
        },
        {--Shifting Catalyst
            id = 183799,
            type = "item",
            uiMapIDs = {1543},
            hideZero = true,
            warnings = {enabled=true, value=1, operator=5}, --1== 2~= 3> 4< 5>= 6<=
            restrict = true,
            zones = "Soulstained Fields, Torturer's Hovel",
        },
    },
    [7] = {
        -- ===BATTLE FOR AZEROTH===
        {--Seafarer's Dubloon
            id = 1710,
            type = "currency",
            zones = "Port of Zandalar, Boralus Harbor",
            always = false,
        },
        {--Honorbound Service Medal
            id = 1716,
            type = "currency",
            zones = "Port of Zandalar, Darkshore, Arathi Highlands",
            faction = "horde",
            expansion = 8,
        },
        {--7th Legion Service Medal
            id = 1717,
            type = "currency",
            zones = "Boralus Harbor, Darkshore, Arathi Highlands",
            faction = "alliance",
            expansion = 8,
        },
        {--War Resources
            id = 1560,
            type = "currency",
            zones = "The Banshee's Wail, Wind's Redemption, Darkshore, Arathi Highlands, The Maelstrom Mercantile,Tradewinds Market",
        },
        {--Brawler's Gold
            id = 1299,
            type = "currency",
            zones = "Brawl'gar Arena",
        },
        {--Seal of Wartorn Fate
            id = 1580,
            type = "currency",
            zones = "The Maelstrom Mercantile, Tradewinds Market",
        },
        {--Titan Residuum
            id = 1718,
            type = "currency",
            zones = "The Maelstrom Mercantile, Vault of Kings, Tradewinds Market",
        },
        --Nazjatar stuff start
        {--Prismatic Manapearl
            id = 1721,
            type = "currency",
            zones = "Nazjatar, Mardivas's Laboratory",
        },
        {--Nazjatar Battle Commendation
            id = 168802,
            type = "item",
            zones = "Newhome, Mezzamere",
        },
        --Nazjatar stuff end
        --Mechagon start
        {--Galvanic OScillator
            id = 168832,
            type = "item",
            zones = "Mechagon",
        },
        {--S.P.A.R.E. Crate
            id = 169610,
            type = "item",
            zones = "Mechagon",
        },
        {--Spare Parts
            id = 166846,
            type = "item",
            zones = "Mechagon",
        },
        {--Energy Cell
            id = 166970,
            type = "item",
            zones = "Mechagon",
        },
        {--Chain Ignitercoil
            id = 168327,
            type = "item",
            zones = "Mechagon",
        },
        --Mechagon end
        --Visions of N'zoth start
        {--Corrupted Memento
            id = 1719,
            type = "currency",
            zones = "Chamber of Heart",
            uiMapIDs = {1570,1571,},
            shortenAmount = 1,
        },
        {--Corrupted Memento (vision)
            id = 1744,
            type = "currency",
            uiMapIDs = {1469,1470,},
        },
        {--Coalescing Visions
            id = 1755,
            type = "currency",
            zones = "Chamber of Heart, Uldum, Ramkahen",
            uiMapIDs = {1530,1570,1527,1571,1579,},
            shortenAmount = 1,
        },
        {--Vessel of Horrific Visions
            id = 173363,
            type = "item",
            zones = "Chamber of Heart",
        },
        {--Vial of Self Preservation
            id = 173293,
            type = "item",
            uiMapIDs = {1570,1571,},
            hideZero = true,
        },
        {--Resilient Soul
            id = 169294,
            type = "item",
            uiMapIDs = {1570,1571,},
            hideZero = true,
            warnings = {enabled=true, value=5, operator=5}, --1== 2~= 3> 4< 5>= 6<=
        },
        {--Shard of Self Sacrifice
            id = 173888,
            type = "item",
            uiMapIDs = {1570,1571,},
            hideZero = true,
            warnings = {enabled=true, value=5, operator=5}, --1== 2~= 3> 4< 5>= 6<=
        },
        {--Aqir Relic Fragment
            id = 174756,
            type = "item",
            uiMapIDs = {1527,},
            hideZero = true,
            warnings = {enabled=true, value=6, operator=5}, --1== 2~= 3> 4< 5>= 6<=
        },
        {--Aqir Relic
            id = 174761,
            type = "item",
            uiMapIDs = {1527,},
            hideZero = true,
            warnings = {enabled=true, value=1, operator=5}, --1== 2~= 3> 4< 5>= 6<=
        },
        {--Tol'vir Relic Fragment
            id = 174764,
            type = "item",
            uiMapIDs = {1527,},
            hideZero = true,
            warnings = {enabled=true, value=6, operator=5}, --1== 2~= 3> 4< 5>= 6<=
        },
        {--Tol'vir Relic
            id = 174765,
            type = "item",
            uiMapIDs = {1527,},
            hideZero = true,
            warnings = {enabled=true, value=1, operator=5}, --1== 2~= 3> 4< 5>= 6<=
        },
        {--Mantid Relic Fragment
            id = 174760,
            type = "item",
            uiMapIDs = {1530,},
            hideZero = true,
            warnings = {enabled=true, value=6, operator=5}, --1== 2~= 3> 4< 5>= 6<=
        },
        {--Mantid Relic
            id = 174766,
            type = "item",
            uiMapIDs = {1530,},
            hideZero = true,
            warnings = {enabled=true, value=1, operator=5}, --1== 2~= 3> 4< 5>= 6<=
        },
        {--Mogu Relic Fragment
            id = 174759,
            type = "item",
            uiMapIDs = {1530,},
            hideZero = true,
            warnings = {enabled=true, value=6, operator=5}, --1== 2~= 3> 4< 5>= 6<=
        },
        {--Mogu Relic
            id = 174767,
            type = "item",
            uiMapIDs = {1530,},
            hideZero = true,
            warnings = {enabled=true, value=1, operator=5}, --1== 2~= 3> 4< 5>= 6<=
        },
        {--Voidwarped Relic Fragment
            id = 174758,
            type = "item",
            uiMapIDs = {1530,1527,},
            hideZero = true,
            warnings = {enabled=true, value=6, operator=5}, --1== 2~= 3> 4< 5>= 6<=
        },
        {--Cursed Relic
            id = 174768,
            type = "item",
            uiMapIDs = {1530,1527,},
            hideZero = true,
            warnings = {enabled=true, value=1, operator=5}, --1== 2~= 3> 4< 5>= 6<=
        },
        {--Echoes of Ny'alotha
            id = 1803,
            type = "currency",
            zones = "Seat of Ramkahen, The Silent Sanctuary, Vault of Kings, Seat of Knowledge",
            uiMapIDs = {1473,},
            hideZero = true,
            shortenAmount = 1,
        },
        --Visions of N'zoth end
        
    },
    [6] = {
        -- ===LEGION===
        {--Coins of Air
            id = 1416,
            type = "currency",
            zones = "The Hall of Shadows",
        },
        {--Wakening Essence
            id = 1533,
            type = "currency",
            zones = "Tanks for Everything, Lorlathil, Thunder Totem, Valdisdall, Crumbled Palace, Wardens' Redoubt, Shal'Aran, The Vindicaar, Deliverance Point",
            uiMapIDs = {646,830,882,885,831,832,883,884,887,680,627,628,641,650,634,630,},
            restrict = true
        },
        {-- Nethershard
            id = 1226,
            type = "currency",
            zones = "Deliverance Point, Broken Shore",
        },
        {--Veiled Argunite
            id = 1508,
            type = "currency",
            zones = "The Vindicaar",
            uiMapIDs = {905,}
        },
        {--Ancient Mana
            id = 1155,
            type = "currency",
            zones = "Suramar",
        },
        {--Legiofall War Supplies
            id = 1342,
            type = "currency",
            zones = "Broken Shore, Deliverance Point",
        },
        {--Sightless Eye
            id = 1149,
            type = "currency",
            zones = "NoneExistingZone",
            uiMapIDs = {628,}
        },
        {--Seal of Broken Fate
            id = 1273,
            type = "currency",
            zones = "NonExistingZone",
            uiMapIDs = {625,}
        },
        {--Order Resources
            id = 1220,
            type = "currency",
            zones = "The Dreamgrove, Netherlight Temple, Dreadscar Rift, Heart of Azeroth, Fel Hammer, Acherus, Sanctum of Light, Temple of Five Dawns, Hall of Shadows, Hall of the Guardian, Trueshot Lodge, Skyhold, Magus Commerce Exchange",
            uiMapIDs = {625,},
            excludeMapIDs = {125,}
        },
    },
    [5] = {
        -- ===WARLORDS OF DRAENOR===
        {--Apexis Cystal
            id = 823,
            type = "currency",
            zones = "Tanaan Jungle",
        },
        {--Garrison Resources
            id = 824,
            type = "currency",
            zones = "Frostwall Shipyard, Lunarfall Shipyard",
            uiMapIDs = {590,582}
        },
        {--Oil
            id = 1101,
            type = "currency",
            zones = "Frostwall Shipyard, Lunarfall Shipyard",
            uiMapIDs = {590,582}
        },
        {--Seal of Tempered Fate
            id = 994,
            type = "currency",
            zones = "Warspear, Stormshield",
        },
        {--Seal of Inevitable Fate
            id = 1129,
            type = "currency",
            zones = "Warspear, Stormshield",
        },
    },
    [4] = {
        -- ===MISTS OF PANDARIA===
        {--Bloody Coin
            id = 789,
            type = "currency",
            zones = "Timeless Isle",
        },
        {--Timeless Coin
            id = 777,
            type = "currency",
            zones = "Timeless Isle",
        },
        {--Skyshard
            id = 86547,
            type = "item",
            uiMapIDs = {1530,390},
            hideZero = true,
        },
        {--Elder Charm of Good Fortune
            id = 697,
            type = "currency",
            uiMapIDs = {504},
        },
        {--Giant Dinosaur Bone
            id = 94288,
            type = "item",
            uiMapIDs = {507},
            zones = "Isle of Giants",
            hideZero = true,
        },
    },
    
    [3] = {
        -- ===CATACLYSM===
    },
    [2] = {
        -- ===WRATH OF THE LICH KING===
        {--Champion's Seal
            id = 241,
            type = "currency",
            zones = "Argent Tournament Grounds, Sunreaver Pavilion, Silver Covenant Pavilion, The Alliance Valiants' Ring, The Aspirants' Ring, The Argent Valiants' Ring, The Ring of Champions, The Horde Valiants' Ring",
            excludeMapIDs = {1819,}
        },
    },
    [1] = {
        -- ===THE BURNING CRUSADE===
    },
    [0] = {
        -- ===CLASSIC===
    },
    [-1] = {
        -- ===OTHER===
        {--Epicurean's Award
            id = 81,
            type = "currency",
            zones = "Orgrimmar, Undercity, Thunder Bluff, Stormwind City, Darnassus, City of Ironforge, Argent Tournament Grounds",
            uiMapIDs = {125,}
        },
        {--Ironpaw Token
            id = 402,
            type = "currency",
            zones = "The Halfhill Market",
        },
        {--Darkmoon Prize Ticket
            id = 515,
            type = "currency",
            zones = "Darkmoon Island",
        },
        {--Darkmoon Ride Ticket
            id = 81055,
            type = "item",
            zones = "Darkmoon Island",
            customColorToggle = true,
            customColor = {255/255, 255/255, 0/255, 1} --r,g,b,a
        },
        {--Argent Commendation (Shadowlands Pre-patch event)
            id = 1754,
            type = "currency",
            uiMapIDs = {118,},
            expansion = 8,
        }
    },
}

---Set
---Accepts a table and returns all indices as keypairs with value true
---@param list table
---@return table
local function Set(list)
    local set = {}
    for _,v in ipairs(list) do set[v] = true end
    return set
end

-- include numbered indexes to support backwards compatibility
aura_env.operators = {
    ["=="] = function(a, b) return a == b end,
    [1] = function(a, b) return a == b end,
    ["~="] = function(a, b) return a ~= b end,
    [2] = function(a, b) return a ~= b end,
    [">"] = function(a, b) return a > b end,
    [3] = function(a, b) return a > b end,
    ["<"] = function(a, b) return a < b end,
    [4] = function(a, b) return a < b end,
    [">="] = function(a, b) return a >= b end,
    [5] = function(a, b) return a >= b end,
    ["<="] = function(a, b) return a <= b end,
    [6] = function(a, b) return a <= b end,        
}

aura_env.checkValue = function(value, triggerValue, operator)
    if not value or not triggerValue or not operator then return end
    return aura_env.operators[operator](value, triggerValue)
end

---init
local function init()
    --explode the expansions inside aura_env.trackables
    local trackables = {}
    for expansion,v in pairs(aura_env.trackables) do
        for i, trackable in ipairs(v) do
            --Convert indexed tables in aura_env.trackables to keypair tables
            if trackable.uiMapIDs then trackable.uiMapIDs = Set(trackable.uiMapIDs) end
            if trackable.excludeMapIDs then trackable.excludeMapIDs = Set(trackable.excludeMapIDs) end
            if trackable.parentMapIDs then trackable.parentMapIDs = Set(trackable.parentMapIDs) end
            if trackable.areaMapIDs then trackable.areaMapIDs = Set(trackable.areaMapIDs) end
            
            if not trackable.expansion then trackable.expansion = expansion end
            if not trackable.priority then trackable.priority = 999 end
            aura_env.SetActiveMaps(trackable)
            aura_env.WatchCooldown(trackable)
            table.insert(trackables, trackable)
        end
    end
    aura_env.trackables = trackables
    aura_env.handleCustomTrackables();
    
    --Separate trackables in their own table by type
    for _, trackable in pairs(aura_env.trackables) do
        if trackable.type == "currency" then
            aura_env.currencies[trackable.id] = trackable
        end
        if trackable.type == "item" then
            aura_env.items[trackable.id] = trackable
        end
    end    
    
    --adjust indices in author options to align with real expansion numbers
    local expansions = {}
    for i,v in ipairs(aura_env.config.expansions) do
        if i == 1 then expansions[-1] = v end
        if i >= 2 then i = i-2; expansions[i] = v; end
    end
    aura_env.config.expansions = expansions
end

---aura_env.special.ReservoirAnima
---Counts all anima from bags
---@return table trackable
aura_env.special.ReservoirAnima = function(...)
    local trackable = ...
    local Animas = { --[Anima Deposit SpellID] = quantity
        [347555] = 3,
        [345706] = 5,
        [336327] = 35,
        [336456] = 250,
    }
    local depositAmount = 0;
    --Loop all bag slots to find items with an Anima Deposit Spell
    for bagID=BANK_CONTAINER, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
        local slots = C_Container.GetContainerNumSlots(bagID)
        for slot=1, slots do
            local containerItemInfo = C_Container.GetContainerItemInfo(bagID,slot)
            if containerItemInfo then
                local _,spellID = GetItemSpell(containerItemInfo.itemID)
                if spellID and Animas[spellID] then
                    depositAmount = depositAmount + (Animas[spellID]*containerItemInfo.stackCount)
                end
            end
        end
    end
    local depositAmount_original = depositAmount
    if depositAmount > 0 then
        if trackable.shortenAmount and trackable.shortenAmount ~= 0 then
            depositAmount =
            (trackable.shortenAmount == 1 and AbbreviateNumbers(depositAmount))
            or (trackable.shortenAmount == 2 and AbbreviateLargeNumbers(depositAmount))
        end
    end
    trackable.displayText = trackable.displayText or {}
    trackable.displayText.extra = depositAmount_original > 0 and "(+"..depositAmount..")"  or ""
    trackable.amount_extra = depositAmount_original
    return trackable
end

---aura_env.special.CatalogedRelics
---Counts all Cataloged Research you can get from relics in your bags
---@return table trackable
aura_env.special.CatalogedResearch = function(...)
    local trackable = ...
    local RelicSpells = { --[Anima Deposit SpellID] = quantity
        [356933] = 1,
        [356931] = 6,
        [356934] = 8,
        [356935] = 16,
        [356937] = 26,
        [356936] = 48,
        [356938] = 100,
        [356939] = 150,
        [356940] = 300,
    }
    local deliverAmount = 0;
    --Loop all bag slots to find items with an Relic Deliver Spell
    for bagID=BANK_CONTAINER, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
        local slots = C_Container.GetContainerNumSlots(bagID)
        for slot=1, slots do
            local containerItemInfo = C_Container.GetContainerItemInfo(bagID,slot)
            if containerItemInfo then
                local _,spellID = GetItemSpell(containerItemInfo.itemID)
                if spellID and RelicSpells[spellID] then
                    deliverAmount = deliverAmount + (RelicSpells[spellID]*containerItemInfo.stackCount)
                end
            end
        end
    end
    local deliverAmount_original = deliverAmount
    if deliverAmount > 0 then
        if trackable.shortenAmount and trackable.shortenAmount ~= 0 then
            deliverAmount =
            (trackable.shortenAmount == 1 and AbbreviateNumbers(deliverAmount))
            or (trackable.shortenAmount == 2 and AbbreviateLargeNumbers(deliverAmount))
        end
    end
    trackable.displayText = trackable.displayText or {}
    trackable.displayText.extra = deliverAmount_original > 0 and "(+".. deliverAmount ..")"  or ""
    trackable.amount_extra = deliverAmount_original
    return trackable
end

---aura_env.special.ObsidianKeys
---Counts all Restored Obsidian Keys you can get from key framings and key fragments in your bags
---@return table keysTrackable
aura_env.special.ObsidianKeys = function(...)
    local keysTrackable = ...
    local keyFramings, keyFragments = GetItemCount(193201) or 0, GetItemCount(191251) or 0
    local obsidianKeyFramings = math.floor(keyFramings/3)
    local obsidianKeyFragments = math.floor(keyFragments/30)
    local obsidianKeysTotal = math.min(obsidianKeyFramings, obsidianKeyFragments)
    
    keysTrackable.displayText = keysTrackable.displayText or {}
    keysTrackable.displayText.extra = "(+"..obsidianKeysTotal..")"
    keysTrackable.amount_extra = obsidianKeysTotal
    
    return keysTrackable
end

---aura_env.special.CombineCrests
---Instead of showing all crests seperate, it shows one aura with info for all crests
---@return table keysTrackable
aura_env.special.CombineCrests = function(...)
    local crestTrackable = ...
    local crests = {3107,3108,3109,3110}
    local amounts = {}
    for i, crestID in pairs(crests) do
        local trackable = aura_env.currencies[crestID]
        local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(crestID)
        if currencyInfo then
            local quantity = currencyInfo.quantity 
            
            --check for season/weekly/regular capped
            if (
                currencyInfo.maxQuantity 
                and currencyInfo.maxQuantity > 0 
                and currencyInfo.useTotalEarnedForMaxQty 
                and currencyInfo.totalEarned >= currencyInfo.maxQuantity
            ) or (
                currencyInfo.maxWeeklyQuantity 
                and currencyInfo.maxWeeklyQuantity > 0 
                and currencyInfo.quantityEarnedThisWeek >= currencyInfo.maxWeeklyQuantity
            ) or (
                currencyInfo.maxQuantity 
                and currencyInfo.maxQuantity > 0 
                and currencyInfo.useTotalEarnedForMaxQty == false
                and currencyInfo.quantity >= currencyInfo.maxQuantity
            )
            then
                local colorMixin = CreateColor(1,0,0,1)
                quantity = colorMixin:WrapTextInColorCode(quantity)
                
            elseif trackable.customColorToggle and trackable.customColor then
                local colorMixin = CreateColor(unpack(trackable.customColor))
                quantity = colorMixin:WrapTextInColorCode(quantity)
            end
            
            amounts[#amounts+1] = quantity
        end
    end
    crestTrackable.displayText = crestTrackable.displayText or {}
    crestTrackable.displayText.special = table.concat(amounts, " || ")
    
    return crestTrackable
end


aura_env.specialTrackables = {
    [1813] = aura_env.special.ReservoirAnima,
    [1931] = aura_env.special.CatalogedResearch,
    [191264] = aura_env.special.ObsidianKeys,
    [3110] = aura_env.special.CombineCrests,
}

---aura_env.handleCustomTrackables
---update existing trackables or add new trackables from custom user trackables.
---@return void
aura_env.handleCustomTrackables = function()
    local config = aura_env.config
    for i, trackable in pairs(config["custom_currencies"]) do
        aura_env.findAndReplaceOrNew(trackable, config.disableAllDefault);
    end
end

---aura_env.findAndReplaceOrNew
---Searches aura_env.trackables for the given argument object.
---If found it updates the values with the arguments values.
---If not found it creates a new object in aura_env.trackables with the arguments values.
---@param custom table the custom user trackables
---@param hide_all boolean
---@return void
aura_env.findAndReplaceOrNew = function(custom, hide_all)
    local found = false
    
    for k, trackable in pairs(aura_env.trackables) do
        if trackable.id == custom.id then
            found = true
            custom.mapID = aura_env.uiMapIDs_stringToTable(custom.mapID)
            custom.parentMapID = aura_env.uiMapIDs_stringToTable(custom.parentMapID)
            custom.excludeMapID = aura_env.uiMapIDs_stringToTable(custom.excludeMapID)
            custom.type = aura_env.convertTrackableTypeToString(custom.type)
            custom.faction = aura_env.convertFactionTypeToString(custom.faction)
            
            trackable.id = custom.id
            trackable.zones = custom.zones
            trackable.excludeByZoneText = custom.excludeByZoneText
            trackable.type = custom.type
            trackable.uiMapIDs = custom.mapID
            trackable.parentMapIDs = custom.parentMapID
            trackable.excludeMapIDs = custom.excludeMapID
            trackable.faction = custom.faction
            trackable.restrict = custom.restrict
            trackable.always = custom.always
            trackable.hide = custom.hide
            trackable.hideAlways = custom.hide
            trackable.hideZero = custom.hideZero
            trackable.warnings = {
                enabled=custom.warningEnabled, 
                value=custom.warningValue, 
                operator=custom.warningOperator
            }
            trackable.value = {
                enabled=custom.valueEnabled, 
                value=custom.valueValue, 
                operator=custom.valueOperator
            }
            trackable.shortenAmount = custom.shortenAmount-1 --ofset to correct index
            trackable.expansion = aura_env.setExpansionFromCustom(custom.expansion)
            trackable.customColorToggle = custom.customColorToggle
            trackable.customColor = custom.customColor
            trackable.custom = true
            trackable.priority = custom.priority
            
            aura_env.SetActiveMaps(trackable)
        end
    end
    
    if found == false then
        local trackable = custom;
        trackable.expansion = aura_env.setExpansionFromCustom(custom.expansion)
        trackable.type = aura_env.convertTrackableTypeToString(custom.type)
        trackable.uiMapIDs = aura_env.uiMapIDs_stringToTable(custom.mapID);
        trackable.parentMapIDs = aura_env.uiMapIDs_stringToTable(custom.parentMapID)
        trackable.excludeMapIDs = aura_env.uiMapIDs_stringToTable(custom.excludeMapID)
        trackable.faction = aura_env.convertFactionTypeToString(custom.faction)
        trackable.shortenAmount = custom.shortenAmount-1 --offset to correct index
        trackable.warnings = {
            enabled=custom.warningEnabled, 
            value=custom.warningValue, 
            operator=custom.warningOperator
        }
        trackable.value = {
            enabled=custom.valueEnabled, 
            value=custom.valueValue, 
            operator=custom.valueOperator
        }
        trackable.custom = true
        
        aura_env.WatchCooldown(trackable)
        table.insert(aura_env.trackables, trackable)
        aura_env.SetActiveMaps(trackable)
    end
    
end

---aura_env.convertTrackableTypeToString
---converts trackable type int to string
---@param type number trackable type
---@return string trackable type
aura_env.convertTrackableTypeToString = function(type)
    if type == 1 then
        return "currency"
    elseif type == 2 then
        return "item"
    else
        return "currency"
    end
end

---aura_env.uiMapIDs_stringToTable
---converts a string of uiMapIDs to a table;
---@param uiMapIDsString string
---@return table
aura_env.uiMapIDs_stringToTable = function(uiMapIDsString)
    local uiMapIDs = {}
    for uiMapID in uiMapIDsString:gsub("%s+", ""):gmatch("([^,]+)") do
        uiMapIDs[tonumber(uiMapID)] = true
    end
    return uiMapIDs
end

---aura_env.convertFactionTypeToString
---converts trackable faction int to string
---@param faction number
---@return string faction type
aura_env.convertFactionTypeToString = function(faction)
    if faction == 1 then
        return "alliance"
    elseif faction == 2 then
        return "horde"
    elseif faction == 3 then
        return "both"
    end
    return "both"
end

---aura_env.setExpansionFromCustom
---set the Trackable's expansion from the custom user object.
---@param expansion number
---@return number expansion int
aura_env.setExpansionFromCustom = function(expansion)
    if expansion == 1 then expansion = -1
    elseif expansion >= 2 then expansion = expansion -2 end
    return expansion
end

---aura_env.SetActiveMaps
---Creates a Table with all zonenames and uiMapIDs that should be checked when the player changes zones.
---@param trackable table
---@return void
aura_env.SetActiveMaps = function(trackable)
    ---SetMaps
    ---Insert the trackable's maps in the activeMaps table.
    ---@param trackableMaps table
    ---@param activeMaps table
    ---@return void
    local SetMaps = function(trackableMaps, activeMaps)
        for maps in pairs(trackableMaps) do
            if not activeMaps[maps] then activeMaps[maps] = {} end
            if #activeMaps[maps] >= 1 then
                local match = false
                --activeMaps[maps] contains an array of the trackables to load on that map
                for i, obj in pairs(activeMaps[maps]) do
                    if obj.id == trackable.id and obj.type == trackable.type then
                        match = true
                    end
                end
                if not match then table.insert(activeMaps[maps], trackable) end
            else
                table.insert(activeMaps[maps], trackable)
            end
        end
    end
    
    if trackable.uiMapIDs then
        SetMaps(trackable.uiMapIDs, aura_env.ActiveMaps.uiMapID)
    end
    if trackable.excludeMapIDs then
        SetMaps(trackable.excludeMapIDs, aura_env.ActiveMaps.uiMapID)
    end
    if trackable.parentMapIDs then
        local childMapTable = {}
        local formattedParentMapIDs = {}
        for uiMapID in pairs(trackable.parentMapIDs) do
            local recurse = nil
            if type(uiMapID) == "string" and uiMapID:sub(1,1) == "r" then
                recurse  = true
                uiMapID = tonumber(uiMapID:sub(2))
            end
            local childs = C_Map.GetMapChildrenInfo(uiMapID, nil, recurse)
            if childs then
                for i,info in pairs(childs) do
                    childMapTable[info.mapID] = info
                end
            end
            formattedParentMapIDs[uiMapID] = true
        end
        SetMaps(childMapTable, aura_env.ActiveMaps.parent)
        SetMaps(formattedParentMapIDs, aura_env.ActiveMaps.uiMapID) --add parent to uiMapID check
    end
    if trackable.areaMapIDs then
        local areaMapTable = {}
        for areaMapID in pairs(trackable.areaMapIDs) do
            local area = C_Map.GetAreaInfo(areaMapID) or "NilArea"
            area = area:gsub("%s+", ""):lower();
            areaMapTable[area] = true
        end
        SetMaps(areaMapTable, aura_env.ActiveMaps.area)
    end
    if trackable.zones then
        local zones = trackable.zones:gsub("%s+", ""):lower();
        local zoneTable = {}
        for zone in zones:gmatch('([^,]+)') do
            zoneTable[zone] = true
        end
        SetMaps(zoneTable, aura_env.ActiveMaps.zone)
    end
    if trackable.excludeByZoneText then
        local zones = trackable.excludeByZoneText:gsub("%s+", ""):lower();
        local zoneTable = {}
        for zone in zones:gmatch('([^,]+)') do
            zoneTable[zone] = true
        end
        SetMaps(zoneTable, aura_env.ActiveMaps.zone)
    end
    if trackable.always then
        table.insert(aura_env.ActiveMaps.always, trackable)
    end    
end

---aura_env.showOrHideTrackable
---Check for all conditions to show or hide the trackable object.
---@param trackable table
---@param UnitStatus table
---@return boolean show or hide
aura_env.showOrHideTrackable = function(trackable, UnitStatus)
    local minimapZoneText = UnitStatus.minimapZoneText
    local zoneText = UnitStatus.zoneText
    local currentBestMapID = UnitStatus.currentBestMapID
    local unitFaction = UnitStatus.unitFaction
    
    if minimapZoneText == "" or zoneText == "" then return false end --login/reload check
    if trackable.hide then return false elseif trackable.always then return true end
    if trackable.faction and trackable.faction ~= "both" and trackable.faction ~= unitFaction then return false end;
    if trackable.hideZero and trackable.currentAmount == 0 then return false end;
    if aura_env.config.expansions[trackable.expansion] == false then return false end;
    if trackable.tocversion and aura_env.tocversion < trackable.tocversion then return false end;
    if trackable.value and trackable.value.enabled then 
        local triggered = aura_env.checkValue(
            trackable.currentAmount, 
            trackable.value.value, 
            trackable.value.operator
        )
        if not triggered then return false end
    end    
    
    --if anything of the above didn't return, then we check for zone matches.
    local zoneMatch
    if trackable.excludeMapIDs and trackable.excludeMapIDs[currentBestMapID] then zoneMatch = false;
    elseif trackable.excludeByZoneText and trackable.excludeByZoneText:find(zoneText) then zoneMatch = false;
    elseif trackable.restrict and (
        trackable.uiMapIDs and trackable.uiMapIDs[currentBestMapID] and
        trackable.loadzones:find(minimapZoneText)
    ) then zoneMatch = true
    elseif not trackable.restrict then
        if trackable.loadzones:find(minimapZoneText) then zoneMatch = true;
        elseif trackable.loadzones:find(zoneText) then zoneMatch = true;
        elseif trackable.uiMapIDs and trackable.uiMapIDs[currentBestMapID] then zoneMatch = true
        elseif trackable.parentMapIDs then
            local childMapTable = {}
            for uiMapID in pairs(trackable.parentMapIDs) do
                local recurse = nil
                if type(uiMapID) == "string" and uiMapID:sub(1,1) == "r" then
                    recurse  = true
                    uiMapID = tonumber(uiMapID:sub(2))
                end
                childMapTable[uiMapID] = true --adds the parent itself
                local childs = C_Map.GetMapChildrenInfo(uiMapID, nil, recurse)
                if childs then
                    for i,info in pairs(childs) do
                        childMapTable[info.mapID] = info
                    end
                end
            end
            if childMapTable[currentBestMapID] then zoneMatch = true; end
        end;
        
        if trackable.areaMapIDs then 
            for areaMapID in pairs(trackable.areaMapIDs) do
                if C_Map.GetAreaInfo(areaMapID):gsub("%s+", ""):lower() == minimapZoneText
                or C_Map.GetAreaInfo(areaMapID):gsub("%s+", ""):lower() == zoneText
                then zoneMatch = true
                end
            end   
        end
    end
    
    if zoneMatch then return true else return false end;
end

---aura_env.handleDisplayText
---Creates a table-value:displayText with strings ready to display
---@param trackable table
---@return table trackable
aura_env.handleDisplayText = function(trackable)
    local displayText = trackable.displayText or {}
    displayText.amount = trackable.currentAmount
    displayText.name = trackable.name
    trackable.displayText = displayText
    
    --Check abbreviate settings
    if trackable.shortenAmount and trackable.shortenAmount ~= 0 then
        displayText.amount =
        (trackable.shortenAmount == 1 and AbbreviateNumbers(displayText.amount))
        or (trackable.shortenAmount == 2 and AbbreviateLargeNumbers(displayText.amount))
    end
    
    --Check weekly cap
    if trackable.CurrencyInfo
    and trackable.CurrencyInfo.maxWeeklyQuantity
    and trackable.CurrencyInfo.maxWeeklyQuantity > 0
    and trackable.CurrencyInfo.quantityEarnedThisWeek
    and trackable.CurrencyInfo.quantityEarnedThisWeek >= trackable.CurrencyInfo.maxWeeklyQuantity
    then
        trackable.weeklyCap = true
        displayText.amount = displayText.amount .."*"
    end
    
    --Warning Color overrides Quality Colors
    if (trackable.warnOnCount > 0
    and trackable.currentAmount >= trackable.warnOnCount)
    or (trackable.CurrencyInfo and trackable.CurrencyInfo.maxQuantity
        and trackable.CurrencyInfo.maxQuantity > 0
        and trackable.CurrencyInfo.maxQuantity <= trackable.currentAmount
    )
    or trackable.weeklyCap
    or trackable.warnings.show
    then
        local warningColorMixin = CreateColor(1,0,0,1)
        for key, text in pairs(displayText) do
            displayText[key] = warningColorMixin:WrapTextInColorCode(text)
        end
    else --Quality Colors
        if aura_env.config.color[1] then --Color:amount enabled
            displayText.amount = trackable.colorMixin:WrapTextInColorCode(displayText.amount)
            if displayText.extra then
                displayText.extra = trackable.colorMixin:WrapTextInColorCode(displayText.extra)
            end
        end
        if aura_env.config.color[2] then --Color:name enabled
            displayText.name = trackable.colorMixin:WrapTextInColorCode(displayText.name)
        end
    end
    
    return trackable
end

---aura_env.mergeExtraInfo
---merge extra_info text together with amount and amount_extra
---@param trackable table
---@return table trackable
aura_env.mergeExtraInfo = function(trackable)
    if not aura_env.config.merge_extra_info then
        return trackable
    end
    trackable.currentAmount = trackable.currentAmount or 0
    if trackable.amount_extra then
        trackable.currentAmount = trackable.currentAmount + trackable.amount_extra
    end
    return trackable
end

---aura_env.getItemCooldown
---get an items cooldowns and inject it into the trackable state
---@param state table
---@return table state
aura_env.getItemCooldown = function(state)
    if not aura_env.config.text[4] then return state end
    
    local start, duration, enabled = GetItemCooldown(state.idx)
    local expirationTime = start+duration
    if enabled == 1 and expirationTime > GetTime() then
        state.progressType = "timed"
        state.expirationTime = expirationTime
        state.duration = duration
        state.watchCooldown = true
    end
    return state
end

---aura_env.WatchCooldown
---Enable WeakAuras.WatchItemCooldown if the trackable is an item and the user has cooldown text enabled.
---@param trackable table
---@return void
aura_env.WatchCooldown = function(trackable)
    if trackable.type == "item" and aura_env.config.text[4] then
        aura_env.cooldownsToWatch[trackable.id] = true
        WeakAuras.WatchItemCooldown(trackable.id)
    end
end

---aura_env.getObjectInfo
---get and set the trackable object's info into the trackable object.
---@param trackable table
---@return table trackable
aura_env.getObjectInfo = function(trackable)
    if trackable.type == "currency" then
        local currency = C_CurrencyInfo.GetCurrencyInfo(trackable.id)
        if currency == nil then
            trackable.hide = true
            return trackable
        end
        trackable.CurrencyInfo = currency
        trackable.name, trackable.currentAmount, trackable.icon, trackable.quality = currency.name, currency.quantity, currency.iconFileID, currency.quality
    elseif trackable.type == "item" then
        local itemMixin = Item:CreateFromItemID(trackable.id)
        trackable.quality = itemMixin:GetItemQuality() or 1
        trackable.name = itemMixin:GetItemName() or "unknown"
        trackable.icon = itemMixin:GetItemIcon() or 13440 --fallback iconID (questionmark)
        trackable.currentAmount = C_Item.GetItemCount(trackable.id,true,true,true,true) or 0
    end
    
    --custom color field is present
    if trackable.customColorToggle and trackable.customColor then
        trackable.colorMixin = CreateColor(unpack(trackable.customColor))
        -- else create quality color
    elseif ITEM_QUALITY_COLORS[trackable.quality] then
        trackable.colorMixin = ITEM_QUALITY_COLORS[trackable.quality].color
    end
    
    return trackable
end

---aura_env.setObjectDefaults
---set the trackable object defaults
---@param trackable table
---@return table trackable
aura_env.setObjectDefaults = function(trackable)
    local disable = aura_env.config.disableAllDefault
    if not trackable.zones then trackable.loadzones = "ThereIsNoFuckingLoadZone"
    else trackable.loadzones = trackable.zones:gsub("%s+", ""):lower(); end
    if trackable.excludeByZoneText then
        trackable.excludeByZoneText = trackable.excludeByZoneText:gsub("%s+", ""):lower();
    end
    if not trackable.warnOnCount then trackable.warnOnCount = 0 end
    if not trackable.warnings then trackable.warnings = {} end
    if disable and not trackable.custom then trackable.hide = disable end
    if not trackable.expansion then trackable.expansion = -1 end
    return trackable
end

---aura_env.TriggerHandler
---calls all functions to build the trackable object when it is ready to be shown.
---@param trackable table
---@return table trackable
aura_env.TriggerHandler = function(trackable)
    trackable = aura_env.getObjectInfo(trackable)
    trackable = aura_env.setObjectDefaults(trackable)
    if aura_env.specialTrackables[trackable.id] then
        trackable = aura_env.specialTrackables[trackable.id](trackable)
    end
    trackable = aura_env.mergeExtraInfo(trackable)
    trackable.show = aura_env.showOrHideTrackable(trackable, aura_env.UnitStatus)
    return trackable
end

---aura_env.TackableOnShowHandler
---calls all functions to build additional trackable object information needed to show the trackable
---@param trackable table
---@return table trackable
aura_env.TrackableOnShowHandler = function(trackable)
    trackable.warnings.show = aura_env.showTrackableWarning(trackable)
    trackable = aura_env.handleDisplayText(trackable)
    
    return trackable
end


---aura_env.checkForStateUpdates
---check if the current shown state and the trackable have changed from eachother
---@param trackable table
---@param state table
---@return boolean state changed
aura_env.checkForStateUpdates = function(trackable, state)
    if (trackable.show and not state) --new state should be made
    or (--state exists and might need updating
        trackable.show
        and trackable.currentAmount
        and state
        and ((  --currentAmount changed
                state.amount
                and state.amount ~= trackable.currentAmount
            )
            or (--amount_extra changed
                trackable.amount_extra
                and state.amount_extra
                and state.amount_extra ~= trackable.amount_extra
            )
            or (--special trackable
                aura_env.specialTrackables[trackable.id]
            )
        )
    )
    or (not trackable.show and state) then --state should be removed
        return true
    end
end

---aura_env.GetActiveTrackables
---returns all active trackables, currencies, and items
---@return table activeTrackables
---@return table activeCurrencies
---@return table activeItems
aura_env.GetActiveTrackables = function()
    local UnitStatus = aura_env.UnitStatus
    local ActiveMaps = aura_env.ActiveMaps
    local activeTrackables = {}
    local activeCurrencies = {}
    local activeItems = {}
    
    ---addActiveTrackables
    ---adds active trackables to the corresponding tables
    ---@param trackables table
    ---@return void
    local addActiveTrackables = function(trackables)
        for _, trackable in pairs(trackables) do
            if not activeCurrencies[trackable.id] or activeItems[trackable.id] then
                if trackable.type == "currency" then activeCurrencies[trackable.id] = true end
                if trackable.type == "item" then activeItems[trackable.id] = true end
                table.insert(activeTrackables, trackable)
            end
        end
    end
    
    if ActiveMaps.uiMapID[UnitStatus.currentBestMapID] then
        addActiveTrackables(ActiveMaps.uiMapID[UnitStatus.currentBestMapID])
    end
    
    if ActiveMaps.area[UnitStatus.minimapZoneText] then
        addActiveTrackables(ActiveMaps.area[UnitStatus.minimapZoneText])
    end
    if ActiveMaps.area[UnitStatus.zoneText] then
        addActiveTrackables(ActiveMaps.area[UnitStatus.zoneText])
    end
    
    if ActiveMaps.zone[UnitStatus.minimapZoneText] then
        addActiveTrackables(ActiveMaps.zone[UnitStatus.minimapZoneText])
    end
    if ActiveMaps.zone[UnitStatus.zoneText] then
        addActiveTrackables(ActiveMaps.zone[UnitStatus.zoneText])
    end
    if ActiveMaps.parent[UnitStatus.currentBestMapID] then
        addActiveTrackables(ActiveMaps.parent[UnitStatus.currentBestMapID])
    end
    if ActiveMaps.always then
        addActiveTrackables(ActiveMaps.always)
    end
    
    return activeTrackables, activeCurrencies, activeItems
end

---aura_env.showTrackableWarning
---determines if the trackable value crossed a defined warning limit
---@return bool showWarning
aura_env.showTrackableWarning = function(trackable)
    if not trackable.warnings then return false end
    
    if trackable.warnings.enabled then 
        return aura_env.checkValue(
            trackable.currentAmount, 
            trackable.warnings.value, 
            trackable.warnings.operator
        )
    end
    
    if trackable.CurrencyInfo
    and trackable.CurrencyInfo.maxQuantity
    and trackable.CurrencyInfo.maxQuantity > 0
    and trackable.CurrencyInfo.maxQuantity <= trackable.currentAmount
    then return true end
    
    return false
end



init();
WeakAuras.ScanEvents("BONESHOCK_CURRENCY_INIT");


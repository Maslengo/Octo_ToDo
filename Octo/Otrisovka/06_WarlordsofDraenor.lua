local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local OCTOexpansionID = 6
function E:func_Otrisovka_06_WarlordsofDraenor()
	local OctoTable_Otrisovka_textLEFT = {}
	local OctoTable_Otrisovka_textCENT = {}
	local OctoTable_Otrisovka_tooltipCENT = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID] then
		-- 2    Type_6_0_Garrison    Warlords of Draenor
		-- 3    Type_7_0_Garrison    Legion
		-- 9    Type_8_0_Garrison    Battle for Azeroth
		-- 111    Type_9_0_Garrison    Shadowlands
		table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey = "", nil, "", {}, nil, {}, nil
				tooltipKey = "WoD_Garrison"
				textLEFT = E:func_texturefromIcon(E:func_GetItemIconByID(110560))..GARRISON_LOCATION_TOOLTIP
				if CharInfo.MASLENGO.HasGarrison[2] then
					local count = 0
					for garrisonType, id in next, (Enum.GarrisonType) do
						if id == 2 then -- Warlords of Draenor
							if CharInfo.MASLENGO.garrisonType[id] then
								local data = CharInfo.MASLENGO.garrisonType[id]
								for i, v in ipairs(data) do
									if v.buildingID and v.rank then
										local id = v.buildingID
										count = count + 1
									end
								end
							end
						end
					end
					if count ~= 0 then
						textCENT = count
					end
				else
					textCENT = E.NONE
				end
				----------------------------------------------------------------
				return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey, tooltipKey
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey = "", nil, "", {}, nil, {}, nil
				----------------------------------------------------------------
				tooltipKey = "WoD_824"
				local GARRISON_RESOURCE_ID = 824
				local RESOURCE_GENERATION_INTERVAL = 600  -- 10 minutes in seconds
				local RESOURCES_PER_INTERVAL = 1
				local MAX_CACHE_SIZE = 500
				textCENT = E:func_textCENT_Currency(CharInfo, 824)
				myType = {"Currency", 824}
				if CharInfo.MASLENGO.GARRISON.lastCacheTime and CharInfo.MASLENGO.GARRISON.lastCacheTime ~= 0 then
					local color = E.Gray_Color
					local cacheSize = CharInfo.MASLENGO.GARRISON.cacheSize or MAX_CACHE_SIZE
					local lastCacheTime = CharInfo.MASLENGO.GARRISON.lastCacheTime
					local timeUnitsSinceLastCollect = lastCacheTime and (GetServerTime()-lastCacheTime)/RESOURCE_GENERATION_INTERVAL or 0
					local earnedSinceLastCollect = min(cacheSize, floor(timeUnitsSinceLastCollect)*RESOURCES_PER_INTERVAL)
					local secondsToMax = cacheSize/RESOURCES_PER_INTERVAL*RESOURCE_GENERATION_INTERVAL
					local timeUntilFull = (lastCacheTime + secondsToMax) - GetServerTime()
					local timeToNextCurrency = RESOURCE_GENERATION_INTERVAL - (GetServerTime() - lastCacheTime) % RESOURCE_GENERATION_INTERVAL
					if earnedSinceLastCollect > 0 then
						if earnedSinceLastCollect >= 5 then
							color = (earnedSinceLastCollect == cacheSize) and E.Purple_Color or E.Yellow_Color
						end
						textCENT = textCENT .. color .. " +" .. earnedSinceLastCollect .. "|r"
					end
				end
				----------------------------------------------------------------
				textLEFT = E:func_currencyName(824)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey
				----------------------------------------------------------------
		end)
		E:funcOtrisivka_CURRENCIES(OctoTable_Otrisovka_textCENT, OCTOexpansionID)
		E:func_Universal(OctoTable_Otrisovka_textCENT, OCTOexpansionID)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka_textCENT
end
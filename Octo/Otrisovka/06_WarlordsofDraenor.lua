local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local currentSTATE = 6
function E.func_Otrisovka_06_WarlordsofDraenor()
	local OctoTable_Otrisovka_textCENT = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[currentSTATE] then
		table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey = "", nil, "", {}, nil, {}, nil
				----------------------------------------------------------------
				tooltipKey = "WoD_824"
				local GARRISON_RESOURCE_ID = 824
				local RESOURCE_GENERATION_INTERVAL = 600  -- 10 minutes in seconds
				local RESOURCES_PER_INTERVAL = 1
				local MAX_CACHE_SIZE = 500
				textCENT = E.func_textCENT_Currency(CharInfo, 824)
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
				textLEFT = E.func_currencyName(824)
				colorLEFT = E.OctoTable_Expansions[currentSTATE].color
				----------------------------------------------------------------
				return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType, tooltipKey
				----------------------------------------------------------------
		end)
		E.func_Otrisivka_CURRENCIESnITEMS(OctoTable_Otrisovka_textCENT, currentSTATE)
		E.func_Universal(OctoTable_Otrisovka_textCENT, currentSTATE)
		E.func_Otrisovka_REPUTATION(OctoTable_Otrisovka_textCENT, currentSTATE)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka_textCENT
end
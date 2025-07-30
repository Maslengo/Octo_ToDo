local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local OCTOexpansionID = 6
function E:func_Otrisovka_06_WarlordsofDraenor()
	local OctoTable_Otrisovka = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID] then

		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, "", {}, nil, {}
				----------------------------------------------------------------
				if CharInfo.MASLENGO.OctoTable_QuestID[38242] then
					textCENT = CharInfo.MASLENGO.OctoTable_QuestID[38242] and E.DONE
				end
				if CharInfo.MASLENGO.ItemsInBag[122457] then
					textCENT = textCENT.."+"..CharInfo.MASLENGO.ItemsInBag[122457]..E:func_GetItemIconByID(122457)
				end
				myType = {"Item", 122457}
				----------------------------------------------------------------
				textLEFT = E:func_questName(38242).." (ап пета)"
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, "", {}, nil, {}
				----------------------------------------------------------------


				local GARRISON_RESOURCE_ID = 824
				local RESOURCE_GENERATION_INTERVAL = 600  -- 10 minutes in seconds
				local RESOURCES_PER_INTERVAL = 1
				local MAX_CACHE_SIZE = 500
				textCENT = E:func_textCENT_Currency(CharInfo, 824)
				myType = {"Currency", 824}
				if CharInfo.GARRISON.lastCacheTime and CharInfo.GARRISON.lastCacheTime ~= 0 then
					local color = E.Gray_Color
					-- максимальный запас ресурсов
					-- Max resource capacity
					local cacheSize = CharInfo.GARRISON.cacheSize or MAX_CACHE_SIZE
					-- время последнего получения ресурсов
					-- Last resource collection time
					local lastCacheTime = CharInfo.GARRISON.lastCacheTime
					-- это время, прошедшее с последнего сбора, в 10-минутных интервалах. Она нужна, чтобы рассчитать, сколько новых ресурсов (earnedSinceLastCollect) игрок мог получить за это время.
					-- Time passed since last collection in 10-minute intervals
					local timeUnitsSinceLastCollect = lastCacheTime and (GetServerTime()-lastCacheTime)/RESOURCE_GENERATION_INTERVAL or 0
					-- сколько ресурсов накопилось с момента последнего сбора
					-- Resources earned since last collection
					local earnedSinceLastCollect = min(cacheSize, floor(timeUnitsSinceLastCollect)*RESOURCES_PER_INTERVAL)
					-- это время, за которое хранилище ресурсов заполнится полностью (в секундах).
					-- Time needed to fully fill the storage
					local secondsToMax = cacheSize/RESOURCES_PER_INTERVAL*RESOURCE_GENERATION_INTERVAL
					-- Time remaining until storage is full
					local timeUntilFull = (lastCacheTime + secondsToMax) - GetServerTime()
					-- Время до получения следующей 1 валюты
					local timeToNextCurrency = RESOURCE_GENERATION_INTERVAL - (GetServerTime() - lastCacheTime) % RESOURCE_GENERATION_INTERVAL
					if earnedSinceLastCollect > 0 then
						if earnedSinceLastCollect >= 5 then
							color = (earnedSinceLastCollect == cacheSize) and E.Purple_Color or E.Yellow_Color
						end
						textCENT = textCENT .. color .. " +" .. earnedSinceLastCollect .. "|r"
					end
					-- Tooltip lines
					tooltipRIGHT[#tooltipRIGHT+1] = {GARRISON_CACHE, color..earnedSinceLastCollect.."/"..cacheSize.."|r"}
					tooltipRIGHT[#tooltipRIGHT+1] = {" ", " "}  -- Empty separator
					if earnedSinceLastCollect ~= cacheSize then
						tooltipRIGHT[#tooltipRIGHT+1] = {"Time to full: ", E:func_SecondsToClock(timeUntilFull)}
					end
					tooltipRIGHT[#tooltipRIGHT+1] = {"Was earned: ", E:func_SecondsToClock(GetServerTime()-(CharInfo.GARRISON.lastCacheTime or time()))}
				end
				----------------------------------------------------------------
				textLEFT = E:func_currencyName(824)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)

		E:funcOtrisivka_CURRENCIES(OctoTable_Otrisovka, OCTOexpansionID)
		E:func_Universal(OctoTable_Otrisovka, OCTOexpansionID)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka
end
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

		-- table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
		-- 		----------------------------------------------------------------
		-- 		local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType = "", nil, "", {}, nil, {}
		-- 		----------------------------------------------------------------
		-- 		if CharInfo.MASLENGO.OctoTable_QuestID[38242] then
		-- 			textCENT = CharInfo.MASLENGO.OctoTable_QuestID[38242] and E.DONE
		-- 		end
		-- 		if CharInfo.MASLENGO.ItemsInBag[122457] then
		-- 			textCENT = textCENT.."+"..CharInfo.MASLENGO.ItemsInBag[122457]..E:func_GetItemIconByID(122457)
		-- 		end
		-- 		myType = {"Item", 122457}
		-- 		----------------------------------------------------------------
		-- 		textLEFT = E:func_questName(38242).." (ап пета)"
		-- 		colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
		-- 		----------------------------------------------------------------
		-- 		return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType
		-- 		----------------------------------------------------------------
		-- end)
		table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType = "", nil, "", {}, nil, {}
				----------------------------------------------------------------


				local GARRISON_RESOURCE_ID = 824
				local RESOURCE_GENERATION_INTERVAL = 600  -- 10 minutes in seconds
				local RESOURCES_PER_INTERVAL = 1
				local MAX_CACHE_SIZE = 500
				textCENT = E:func_textCENT_Currency(CharInfo, 824)
				myType = {"Currency", 824}
				if CharInfo.MASLENGO.GARRISON.lastCacheTime and CharInfo.MASLENGO.GARRISON.lastCacheTime ~= 0 then
					local color = E.Gray_Color
					-- максимальный запас ресурсов
					-- Max resource capacity
					local cacheSize = CharInfo.MASLENGO.GARRISON.cacheSize or MAX_CACHE_SIZE
					-- время последнего получения ресурсов
					-- Last resource collection time
					local lastCacheTime = CharInfo.MASLENGO.GARRISON.lastCacheTime
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
					tooltipCENT[#tooltipCENT+1] = {GARRISON_CACHE, color..earnedSinceLastCollect.."/"..cacheSize.."|r"}
					tooltipCENT[#tooltipCENT+1] = {" ", " "}  -- Empty separator
					if earnedSinceLastCollect ~= cacheSize then
						tooltipCENT[#tooltipCENT+1] = {"Time to full: ", E:func_SecondsToClock(timeUntilFull)}
					end
					tooltipCENT[#tooltipCENT+1] = {"Was earned: ", E:func_SecondsToClock(GetServerTime()-(CharInfo.MASLENGO.GARRISON.lastCacheTime or time()))}
				end
				----------------------------------------------------------------
				textLEFT = E:func_currencyName(824)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, colorLEFT, textCENT, tooltipCENT, colorCENT, myType
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
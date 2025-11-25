local GlobalAddonName, E = ...
-- 2032,
-- 3292,
local function setOrNil(tbl, key, val)
	tbl[key] = (val and val ~= 0) and val or nil
end
function E.Collect_All_Currency()
	if E.func_SpamBlock("Collect_All_Currency") then return end
	-- local startTime = debugprofilestop()
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectMASLENGO then return end
	if not Octo_Cache_DB and not Octo_Cache_DB.AllCurrencies then return end
	local currencyCache = {}
	for CurrencyID in next, (Octo_Cache_DB.AllCurrencies) do
		local isAccountWideCurrency = C_CurrencyInfo.IsAccountWideCurrency(CurrencyID)
		local data = C_CurrencyInfo.GetCurrencyInfo(CurrencyID)
		if not data then
			collectMASLENGO.Currency[CurrencyID] = nil
		else
			collectMASLENGO.Currency[CurrencyID] = collectMASLENGO.Currency[CurrencyID] or {}
			local quantity = data.quantity
			local maxQuantity = data.maxQuantity
			local totalEarned = data.totalEarned
			local maxWeeklyQuantity = data.maxWeeklyQuantity
			local useTotalEarnedForMaxQty = data.useTotalEarnedForMaxQty
			-- Получаем кэш данных аккаунтных валют
			if not currencyCache[CurrencyID] then
				currencyCache[CurrencyID] = C_CurrencyInfo.FetchCurrencyDataFromAccountCharacters(CurrencyID)
			end
			local rosterCurrencyData = currencyCache[CurrencyID]
			if rosterCurrencyData then
				local currencyMap = {}
				for _, v in ipairs(rosterCurrencyData) do
					currencyMap[v.characterGUID] = v.quantity
				end
				for GUID, CharInfo in next, Octo_ToDo_DB_Levels do
					if CharInfo and CharInfo.PlayerData and CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName and CharInfo.MASLENGO then
						CharInfo.MASLENGO.Currency[CurrencyID] = CharInfo.MASLENGO.Currency[CurrencyID] or {}
						setOrNil(CharInfo.MASLENGO.Currency[CurrencyID], "quantity", currencyMap[GUID])
						setOrNil(CharInfo.MASLENGO.Currency[CurrencyID], "maxQuantity", maxQuantity)
					end
				end
			end
			if not isAccountWideCurrency then
				-- Только для текущего персонажа
				local charCurrency = collectMASLENGO.Currency[CurrencyID]
				setOrNil(charCurrency, "quantity", quantity)
				setOrNil(charCurrency, "maxQuantity", maxQuantity)
				setOrNil(charCurrency, "totalEarned", totalEarned)
				setOrNil(charCurrency, "maxWeeklyQuantity", maxWeeklyQuantity)
				setOrNil(charCurrency, "useTotalEarnedForMaxQty", useTotalEarnedForMaxQty)
			else
				-- Валюта аккаунтная, нужно всем персонажам сохранить одни и те же значения
				-- print (E.func_currencyName(CurrencyID), CurrencyID)
				for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
					if CharInfo and CharInfo.PlayerData and CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName and CharInfo.MASLENGO then
						local shared = CharInfo.MASLENGO.Currency[CurrencyID] or {}
						CharInfo.MASLENGO.Currency[CurrencyID] = shared
						setOrNil(shared, "quantity", quantity)
						setOrNil(shared, "maxQuantity", maxQuantity)
						setOrNil(shared, "totalEarned", totalEarned)
						setOrNil(shared, "maxWeeklyQuantity", maxWeeklyQuantity)
						setOrNil(shared, "useTotalEarnedForMaxQty", useTotalEarnedForMaxQty)
					end
				end
			end
		end
	end
	-- local endTime = debugprofilestop()
	-- local elapsedMs = endTime - startTime
	-- local elapsedSec = elapsedMs / 1000
	-- print(string.format("Время выполнения: %.2f мс (%.3f сек)", elapsedMs, elapsedSec))
end
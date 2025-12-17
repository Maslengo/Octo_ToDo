local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Currencies()
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectMASLENGO then return end
	local currencyCache = {}
	for currencyID in next,(E.ALL_Currencies) do
		local isAccountWideCurrency = C_CurrencyInfo.IsAccountWideCurrency(currencyID)
		local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
		if not data then
			collectMASLENGO.Currency[currencyID] = nil
		else
			collectMASLENGO.Currency[currencyID] = collectMASLENGO.Currency[currencyID] or {}
			local quantity = data.quantity
			local maxQuantity = data.maxQuantity
			local totalEarned = data.totalEarned
			local maxWeeklyQuantity = data.maxWeeklyQuantity
			local useTotalEarnedForMaxQty = data.useTotalEarnedForMaxQty
			-- Получаем кэш данных аккаунтных валют
			if not currencyCache[currencyID] then
				currencyCache[currencyID] = C_CurrencyInfo.FetchCurrencyDataFromAccountCharacters(currencyID)
			end
			local rosterCurrencyData = currencyCache[currencyID]
			if rosterCurrencyData then
				local currencyMap = {}
				for _, v in ipairs(rosterCurrencyData) do
					currencyMap[v.characterGUID] = v.quantity
				end
				for GUID, CharInfo in next, Octo_ToDo_DB_Levels do
					if CharInfo and CharInfo.PlayerData and CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName and CharInfo.MASLENGO then
						CharInfo.MASLENGO.Currency[currencyID] = CharInfo.MASLENGO.Currency[currencyID] or {}
						E.func_SetOrNil(CharInfo.MASLENGO.Currency[currencyID], "quantity", currencyMap[GUID])
						E.func_SetOrNil(CharInfo.MASLENGO.Currency[currencyID], "maxQuantity", maxQuantity)
					end
				end
			end
			if not isAccountWideCurrency then
				-- Только для текущего персонажа
				local charCurrency = collectMASLENGO.Currency[currencyID]
				E.func_SetOrNil(charCurrency, "quantity", quantity)
				E.func_SetOrNil(charCurrency, "maxQuantity", maxQuantity)
				E.func_SetOrNil(charCurrency, "totalEarned", totalEarned)
				E.func_SetOrNil(charCurrency, "maxWeeklyQuantity", maxWeeklyQuantity)
				E.func_SetOrNil(charCurrency, "useTotalEarnedForMaxQty", useTotalEarnedForMaxQty)
			else
				-- Валюта аккаунтная, нужно всем персонажам сохранить одни и те же значения
				for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
					if CharInfo and CharInfo.PlayerData and CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName and CharInfo.MASLENGO then
						local shared = CharInfo.MASLENGO.Currency[currencyID] or {}
						CharInfo.MASLENGO.Currency[currencyID] = shared
						E.func_SetOrNil(shared, "quantity", quantity)
						E.func_SetOrNil(shared, "maxQuantity", maxQuantity)
						E.func_SetOrNil(shared, "totalEarned", totalEarned)
						E.func_SetOrNil(shared, "maxWeeklyQuantity", maxWeeklyQuantity)
						E.func_SetOrNil(shared, "useTotalEarnedForMaxQty", useTotalEarnedForMaxQty)
					end
				end
			end
		end
	end
end
----------------------------------------------------------------
local function Collect_Currencies_Account()
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectMASLENGO then return end
	local currencyCache = {}
	for currencyID in next,(E.ALL_Currencies) do
		local isAccountWideCurrency = C_CurrencyInfo.IsAccountWideCurrency(currencyID)
		local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
		if not data then
			collectMASLENGO.Currency[currencyID] = nil
		else
			collectMASLENGO.Currency[currencyID] = collectMASLENGO.Currency[currencyID] or {}
			local quantity = data.quantity
			local maxQuantity = data.maxQuantity
			local totalEarned = data.totalEarned
			local maxWeeklyQuantity = data.maxWeeklyQuantity
			local useTotalEarnedForMaxQty = data.useTotalEarnedForMaxQty
			-- Получаем кэш данных аккаунтных валют
			if not currencyCache[currencyID] then
				currencyCache[currencyID] = C_CurrencyInfo.FetchCurrencyDataFromAccountCharacters(currencyID)
			end
			local rosterCurrencyData = currencyCache[currencyID]
			if rosterCurrencyData then
				local currencyMap = {}
				for _, v in ipairs(rosterCurrencyData) do
					currencyMap[v.characterGUID] = v.quantity
				end
				for GUID, CharInfo in next, Octo_ToDo_DB_Levels do
					if CharInfo and CharInfo.PlayerData and CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName and CharInfo.MASLENGO then
						CharInfo.MASLENGO.Currency[currencyID] = CharInfo.MASLENGO.Currency[currencyID] or {}

						E.func_SetOrNil(CharInfo.MASLENGO.Currency[currencyID], "quantity", currencyMap[GUID])
						E.func_SetOrNil(CharInfo.MASLENGO.Currency[currencyID], "maxQuantity", maxQuantity)
					end
				end
			end
			if not isAccountWideCurrency then
				-- Только для текущего персонажа
				local charCurrency = collectMASLENGO.Currency[currencyID]
				E.func_SetOrNil(charCurrency, "quantity", quantity)
				E.func_SetOrNil(charCurrency, "maxQuantity", maxQuantity)
				E.func_SetOrNil(charCurrency, "totalEarned", totalEarned)
				E.func_SetOrNil(charCurrency, "maxWeeklyQuantity", maxWeeklyQuantity)
				E.func_SetOrNil(charCurrency, "useTotalEarnedForMaxQty", useTotalEarnedForMaxQty)
			else
				-- Валюта аккаунтная, нужно всем персонажам сохранить одни и те же значения
				for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
					if CharInfo and CharInfo.PlayerData and CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName and CharInfo.MASLENGO then
						local shared = CharInfo.MASLENGO.Currency[currencyID] or {}
						CharInfo.MASLENGO.Currency[currencyID] = shared
						E.func_SetOrNil(shared, "quantity", quantity)
						E.func_SetOrNil(shared, "maxQuantity", maxQuantity)
						E.func_SetOrNil(shared, "totalEarned", totalEarned)
						E.func_SetOrNil(shared, "maxWeeklyQuantity", maxWeeklyQuantity)
						E.func_SetOrNil(shared, "useTotalEarnedForMaxQty", useTotalEarnedForMaxQty)
					end
				end
			end
		end
	end
end
----------------------------------------------------------------
function E.Collect_TARGET_Currency(currencyID)
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectMASLENGO then return end
	collectMASLENGO.Currency = collectMASLENGO.Currency or {}

	local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
	if not data then
		collectMASLENGO.Currency[currencyID] = nil
	end

	collectMASLENGO.Currency[currencyID] = collectMASLENGO.Currency[currencyID] or {}
	local charCurrency = collectMASLENGO.Currency[currencyID]


	local quantity = data.quantity
	local maxQuantity = data.maxQuantity
	local totalEarned = data.totalEarned
	local maxWeeklyQuantity = data.maxWeeklyQuantity
	local useTotalEarnedForMaxQty = data.useTotalEarnedForMaxQty

	E.func_SetOrNil(charCurrency, "quantity", quantity)
	E.func_SetOrNil(charCurrency, "maxQuantity", maxQuantity)
	E.func_SetOrNil(charCurrency, "totalEarned", totalEarned)
	E.func_SetOrNil(charCurrency, "maxWeeklyQuantity", maxWeeklyQuantity)
	E.func_SetOrNil(charCurrency, "useTotalEarnedForMaxQty", useTotalEarnedForMaxQty)
end
----------------------------------------------------------------
function E.Collect_Currencies()
	E.func_SpamBlock(Collect_Currencies, true)
end
function E.Collect_Currencies_Account()
	E.func_SpamBlock(Collect_Currencies_Account, true)
end
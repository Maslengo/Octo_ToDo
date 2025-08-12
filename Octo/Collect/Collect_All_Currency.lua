local GlobalAddonName, E = ...

function E.Collect_All_Currency()

	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectMASLENGO then return end
	if not Octo_Cache_DB and not Octo_Cache_DB.AllCurrencies then return end
		----------------------------------------------------------------
		-- local listSize = C_CurrencyInfo.GetCurrencyListSize()
		-- local headerIndex
		-- for i = 1, listSize do
		-- local info = C_CurrencyInfo.GetCurrencyListInfo(i)
		-- if info and info.isHeader then
		-- C_CurrencyInfo.ExpandCurrencyList(i, true)
		-- listSize = C_CurrencyInfo.GetCurrencyListSize()
		-- headerIndex = i
		-- elseif info and info.name then
		-- local currencyLink = C_CurrencyInfo.GetCurrencyListLink(i)
		-- local currencyID = currencyLink and C_CurrencyInfo.GetCurrencyIDFromLink(currencyLink)
		-- if currencyID then
		-- list[currencyID] = list[currencyID] or false
		-- end
		-- end
		-- end
		-- for CurrencyID, v in next, (list) do
		----------------------------------------------------------------

		local currencyCache = {}

		for CurrencyID,	cachedName in next, (Octo_Cache_DB.AllCurrencies) do
			local isAccountWideCurrency = C_CurrencyInfo.IsAccountWideCurrency(CurrencyID)

			collectMASLENGO.Currency[CurrencyID] = collectMASLENGO.Currency[CurrencyID] or {}
			local data = C_CurrencyInfo.GetCurrencyInfo(CurrencyID)
			if data then
				local quantity = data.quantity
				local maxQuantity = data.maxQuantity
				local totalEarned = data.totalEarned

				local maxWeeklyQuantity = data.maxWeeklyQuantity
				local useTotalEarnedForMaxQty = data.useTotalEarnedForMaxQty
				-- local discovered = data.discovered
				-- local transferPercentage = data.transferPercentage
				-- local rechargingCycleDurationMS = data.rechargingCycleDurationMS
				-- local rechargingAmountPerCycle = data.rechargingAmountPerCycle


				----------------------------------------------------------------
				----------------------------------------------------------------
				----------------------------------------------------------------
				-- Проверяем, есть ли данные в кэше
				if not currencyCache[CurrencyID] then
					currencyCache[CurrencyID] = C_CurrencyInfo.FetchCurrencyDataFromAccountCharacters(CurrencyID)
				end

				local rosterCurrencyData = currencyCache[CurrencyID]
				if rosterCurrencyData then
					-- Создаем таблицу для быстрого доступа по GUID
					local currencyMap = {}
					for _, v in ipairs(rosterCurrencyData) do
						currencyMap[v.characterGUID] = v.quantity
					end

					for GUID, CharInfo in next, Octo_ToDo_DB_Levels do
						CharInfo.MASLENGO.Currency[CurrencyID] = CharInfo.MASLENGO.Currency[CurrencyID] or {}
						if currencyMap[GUID] then
							CharInfo.MASLENGO.Currency[CurrencyID].quantity = currencyMap[GUID]
							CharInfo.MASLENGO.Currency[CurrencyID].maxQuantity = maxQuantity
						else
							CharInfo.MASLENGO.Currency[CurrencyID].quantity = nil
						end
					end
				end
				----------------------------------------------------------------
				----------------------------------------------------------------
				----------------------------------------------------------------
				if not isAccountWideCurrency then
					if collectMASLENGO and not InCombatLockdown() then
						----------------------------------------------------------------
						if quantity and quantity ~= 0 then
							collectMASLENGO.Currency[CurrencyID].quantity = quantity
						else
							collectMASLENGO.Currency[CurrencyID].quantity = nil
						end
						if maxQuantity and maxQuantity ~= 0 then
							collectMASLENGO.Currency[CurrencyID].maxQuantity = maxQuantity
						else
							collectMASLENGO.Currency[CurrencyID].maxQuantity = nil
						end
						if totalEarned and totalEarned ~= 0 then
							collectMASLENGO.Currency[CurrencyID].totalEarned = totalEarned
						else
							collectMASLENGO.Currency[CurrencyID].totalEarned = nil
						end
						if maxWeeklyQuantity and maxWeeklyQuantity ~= 0 then
							collectMASLENGO.Currency[CurrencyID].maxWeeklyQuantity = maxWeeklyQuantity
						else
							collectMASLENGO.Currency[CurrencyID].maxWeeklyQuantity = nil
						end
						if useTotalEarnedForMaxQty and useTotalEarnedForMaxQty ~= 0 then
							collectMASLENGO.Currency[CurrencyID].useTotalEarnedForMaxQty = useTotalEarnedForMaxQty
						else
							collectMASLENGO.Currency[CurrencyID].useTotalEarnedForMaxQty = nil
						end
						----------------------------------------------------------------
					end
				else
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						if CharInfo and not InCombatLockdown() then
							----------------------------------------------------------------
						if quantity and quantity ~= 0 then
							collectMASLENGO.Currency[CurrencyID].quantity = quantity
						else
							collectMASLENGO.Currency[CurrencyID].quantity = nil
						end
						if maxQuantity and maxQuantity ~= 0 then
							collectMASLENGO.Currency[CurrencyID].maxQuantity = maxQuantity
						else
							collectMASLENGO.Currency[CurrencyID].maxQuantity = nil
						end
						if totalEarned and totalEarned ~= 0 then
							collectMASLENGO.Currency[CurrencyID].totalEarned = totalEarned
						else
							collectMASLENGO.Currency[CurrencyID].totalEarned = nil
						end
						if maxWeeklyQuantity and maxWeeklyQuantity ~= 0 then
							collectMASLENGO.Currency[CurrencyID].maxWeeklyQuantity = maxWeeklyQuantity
						else
							collectMASLENGO.Currency[CurrencyID].maxWeeklyQuantity = nil
						end
						if useTotalEarnedForMaxQty and useTotalEarnedForMaxQty ~= 0 then
							collectMASLENGO.Currency[CurrencyID].useTotalEarnedForMaxQty = useTotalEarnedForMaxQty
						else
							collectMASLENGO.Currency[CurrencyID].useTotalEarnedForMaxQty = nil
						end
							----------------------------------------------------------------
						end
					end
				end
			else
				collectMASLENGO.Currency[CurrencyID] = nil
			end
		end
		----------------------------------------------------------------
end
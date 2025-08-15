local GlobalAddonName, E = ...
function E.Collect_All_Currency()
	if E.func_SpamBlock("Collect_All_Currency") then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectMASLENGO then return end
	if not Octo_Cache_DB and not Octo_Cache_DB.AllCurrencies then return end
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
						CharInfo.MASLENGO.Currency[CurrencyID] = CharInfo.MASLENGO.Currency[CurrencyID] or {}
						if currencyMap[GUID] then
							CharInfo.MASLENGO.Currency[CurrencyID].quantity = currencyMap[GUID]
							CharInfo.MASLENGO.Currency[CurrencyID].maxQuantity = maxQuantity
						else
							CharInfo.MASLENGO.Currency[CurrencyID].quantity = nil
						end
					end
				end
				if not isAccountWideCurrency then
					if collectMASLENGO then
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
					end
				else
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						if CharInfo then
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
						end
					end
				end
			else
				collectMASLENGO.Currency[CurrencyID] = nil
			end
		end
end
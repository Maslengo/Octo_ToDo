local GlobalAddonName, E = ...
function E.Collect_All_Mounts()
	if E.func_SpamBlock("Collect_All_Mounts") then return end
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end


	local GetMountIDs = C_MountJournal.GetMountIDs
	local GetMountInfoByID = C_MountJournal.GetMountInfoByID
	local GetMountInfoExtraByID = C_MountJournal.GetMountInfoExtraByID
	for _, mountID in ipairs(GetMountIDs()) do
		local _, _, source = GetMountInfoExtraByID(mountID)
		-- if mountID == 635 then
		-- 	fpde(source)
		-- end
		local currencyLink = source:match("(|Hcurrency:%d+|h|T[^|]+|t|h)")
		-- local price = source:match("Цена: |r(%d+)")
		-- local currencyID = source:match("Hcurrency:(%d+)")
		local price, currencyID = source:match("([%d %.,]+)|Hcurrency:(%d+)")
		if price and currencyID then
			if type(price) == "string" then
				price = price:gsub("[%s%.]", "")
				price = tonumber(price)
			end
			currencyID = tonumber(currencyID)
			tinsert(E.ALL_Currencies, currencyID)
			E.OctoTable_ALL_Mounts[currencyID] = E.OctoTable_ALL_Mounts[currencyID] or {}
			E.OctoTable_ALL_Mounts[currencyID][mountID] = price
		end
		-- таймволк
		E.OctoTable_ALL_Mounts[1166] = E.OctoTable_ALL_Mounts[1166] or {}
		for i, v in ipairs(E.func_Mounts_1166()) do
			E.OctoTable_ALL_Mounts[1166][v.mountID] = v.price
		end
		-- Бронза
		E.OctoTable_ALL_Mounts[3252] = E.OctoTable_ALL_Mounts[3252] or {}
		for i, v in ipairs(E.func_Mounts_3252()) do
			E.OctoTable_ALL_Mounts[3252][v.mountID] = v.price
		end
	end




	local GetCurrencyInfo = GetCurrencyInfo or C_CurrencyInfo.GetCurrencyInfo

	-- Создаем временную таблицу для хранения данных перед сортировкой
	local tempTable = {}

	-- Собираем данные
	for currencyID, v in next, (E.OctoTable_ALL_Mounts) do
		local info = GetCurrencyInfo(currencyID)
		if info then
			local quality = info.quality or 0
			local name = info.name or ""
			tinsert(tempTable, {
					currencyID = tonumber(currencyID),
					quality = quality,
					name = name
			})
		end
	end

	-- Сортируем таблицу: сначала по quality (по убыванию), затем по name (по возрастанию)
	table.sort(tempTable, function(a, b)
			if a.quality ~= b.quality then
				return a.quality > b.quality -- Сначала сортируем по quality (высшее качество первым)
			else
				return a.name < b.name -- При одинаковом quality сортируем по имени в алфавитном порядке
			end
	end)

	function E.ebanieMounti(dropdownOrder)
		-- Вставляем отсортированные данные
		for _, data in ipairs(tempTable) do
			tinsert(E.OctoTables_DataOtrisovka[dropdownOrder].Currencies, data.currencyID)
		end
	end

end

-- /run fpde(E.OctoTables_DataOtrisovka[15])
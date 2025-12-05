local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local dropdownOrder = 15
local expansionID = 1
E.OctoTables_DataOtrisovka[dropdownOrder] = {}
E.OctoTables_Vibor[dropdownOrder] = {}
-- E.OctoTables_Vibor[dropdownOrder].icon = E.OctoTable_Expansions[expansionID].icon
E.OctoTables_Vibor[dropdownOrder].name = MOUNTS
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[dropdownOrder].Currencies = {

}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[dropdownOrder].Items = {

}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[dropdownOrder].Reputations = {

}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[dropdownOrder].UniversalQuests = {

}
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[dropdownOrder].Additionally = {

}


C_Timer.After(1, function()
	E.Collect_All_Mounts()
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
			return a.quality > b.quality  -- Сначала сортируем по quality (высшее качество первым)
		else
			return a.name < b.name  -- При одинаковом quality сортируем по имени в алфавитном порядке
		end
	end)

	-- Вставляем отсортированные данные
	for _, data in ipairs(tempTable) do
		tinsert(E.OctoTables_DataOtrisovka[dropdownOrder].Currencies, data.currencyID)
	end
end)
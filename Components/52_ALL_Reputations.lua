local GlobalAddonName, E = ...
----------------------------------------------------------------
if not E.DEBUG then return end
----------------------------------------------------------------
local categoryKey = 52
----------------------------------------------------------------
local L = E.L
----------------------------------------------------------------
local function tempFunction()
	local OctoTables_DataOtrisovka = {}
	local OctoTables_Vibor = {}
	OctoTables_DataOtrisovka[categoryKey] = {}
	OctoTables_Vibor[categoryKey] = {}
	OctoTables_Vibor[categoryKey].icon = E.ICON_DEBUG
	OctoTables_Vibor[categoryKey].name = L["REPUTATION"]
	OctoTables_Vibor[categoryKey].color = E.COLOR_RED
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Currencies = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Items = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Reputations = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].AdditionallyTOP = {
	}
	----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].AdditionallyBOTTOM = {
	}
	----------------------------------------------------------------



	local sorted = {}
	local test = {}
	local allReputations = {}
	local missingReputations = {}
	local TYPE = "reputation"

	-- Собираем ID репутаций, которые уже есть в DB
	for id in next, (E.OctoTable_Reputations_DB) do
		local name = E.func_GetName(TYPE, id)
		local debugTEXT = E.debugInfo and E.debugInfo(id) or ""
		if name ~= E.TEXT_UNKNOWN .. debugTEXT then
			tinsert(test, id)
			allReputations[id] = name
		end
	end

	-- Проверяем все возможные ID (1..3000) и находим отсутствующие
	for id = 1, 3000 do
		local name = E.func_GetName(TYPE, id)
		local debugTEXT = E.debugInfo and E.debugInfo(id) or ""
		if name ~= E.TEXT_UNKNOWN .. debugTEXT then
			tinsert(sorted, id)

			-- Если ID нет в allReputations, добавляем в missingReputations
			if not allReputations[id] then
				tinsert(missingReputations, id)
			end
		end
	end


	table.sort(sorted, E.func_ReversSort)
	table.sort(missingReputations, E.func_ReversSort)
	print(#sorted, #test, "INIT")


	local missingWithNames = {}
	for _, id in ipairs(missingReputations) do
		-- E.OctoTable_Reputations_DB[id] = E.OctoTable_Reputations_DB[id] or {}
		local name = E.func_GetName(TYPE, id)
		missingWithNames[id] = name
	end
	-- Отображаем отсутствующие репутации
	-- opde(missingReputations)
	-- opde(missingWithNames)



	for i, id in ipairs(sorted) do
	-- for i, id in ipairs(missingReputations) do
		tinsert(OctoTables_DataOtrisovka[categoryKey].Reputations, {id = id, defS = true,})
	end





	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)
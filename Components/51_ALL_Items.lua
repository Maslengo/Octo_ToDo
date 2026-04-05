local GlobalAddonName, E = ...
----------------------------------------------------------------
if not E.DEBUG then return end
----------------------------------------------------------------
local categoryKey = 51
----------------------------------------------------------------
local L = E.L
----------------------------------------------------------------
local function tempFunction()
	local OctoTables_DataOtrisovka = {}
	local OctoTables_Vibor = {}
	OctoTables_DataOtrisovka[categoryKey] = {}
	OctoTables_Vibor[categoryKey] = {}
	OctoTables_Vibor[categoryKey].icon = E.ICON_DEBUG
	OctoTables_Vibor[categoryKey].name = L["ITEMS"]
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
	local testTBL = {}
	for id in next, (E.KeyStoneTBL) do
		testTBL[id] = true
	end
	for id in next, (E.OctoTable_itemID_MECHAGON) do
		testTBL[id] = true
	end
	for id in next, (E.OctoTable_itemID_ALL) do
		testTBL[id] = true
	end
	for id in next, (E.ALL_Items) do
		testTBL[id] = true
	end


	local sorted = {}
	for id in next, (testTBL) do
		tinsert(sorted, id)
	end

	table.sort(sorted, E.func_ReversSort)



	for i, id in ipairs(sorted) do
		tinsert(OctoTables_DataOtrisovka[categoryKey].Items, {id = id, defS = true,})
	end
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)
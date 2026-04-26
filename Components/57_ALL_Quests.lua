local GlobalAddonName, E = ...
----------------------------------------------------------------
if not E.DEBUG then return end
----------------------------------------------------------------
local categoryKey = 57
----------------------------------------------------------------
local L = E.L
----------------------------------------------------------------
local function tempFunction()
	local OctoTables_DataOtrisovka = {}
	local OctoTables_Vibor = {}
	OctoTables_DataOtrisovka[categoryKey] = {}
	OctoTables_Vibor[categoryKey] = {}
	OctoTables_Vibor[categoryKey].icon = E.ICON_DEBUG
	OctoTables_Vibor[categoryKey].name = L["QUESTS_LABEL"]
	OctoTables_Vibor[categoryKey].color = E.COLOR_RED


	for _, dataType in ipairs(E.dataDisplayOrder) do
		OctoTables_DataOtrisovka[categoryKey][dataType] = {}
	end
	-- ----------------------------------------------------------------
	-- OctoTables_DataOtrisovka[categoryKey].AdditionallyTOP = {
	-- }
	-- ----------------------------------------------------------------
	OctoTables_DataOtrisovka[categoryKey].Quests = {
		{id = 94385, defS = true,}, -- Void Assaults: Eversong Woods
		{id = 94386, defS = true,}, -- Void Assaults: Zul'Aman
	}
	-- ----------------------------------------------------------------
	-- OctoTables_DataOtrisovka[categoryKey].Currencies = {
	-- }
	-- ----------------------------------------------------------------
	-- OctoTables_DataOtrisovka[categoryKey].Items = {
	-- }
	-- ----------------------------------------------------------------
	-- OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = {
	-- }
	-- ----------------------------------------------------------------
	-- OctoTables_DataOtrisovka[categoryKey].Reputations = {
	-- }
	-- ----------------------------------------------------------------
	-- OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {
	-- }
	-- ----------------------------------------------------------------
	-- OctoTables_DataOtrisovka[categoryKey].AdditionallyBOTTOM = {
	-- }
	----------------------------------------------------------------

	local sorted = {}
	for id = 93000, 96000 do
		tinsert(sorted, id)
	end

	table.sort(sorted, E.func_ReversSort)
	for i, id in ipairs(sorted) do
		tinsert(OctoTables_DataOtrisovka[categoryKey].Quests, {id = id, defS = true,})
	end
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)
local GlobalAddonName, E = ...
----------------------------------------------------------------
if not E.DEBUG then return end
----------------------------------------------------------------
local categoryKey = 53
----------------------------------------------------------------
local L = E.L
----------------------------------------------------------------
local function tempFunction()
	local OctoTables_DataOtrisovka = {}
	local OctoTables_Vibor = {}
	OctoTables_DataOtrisovka[categoryKey] = {}
	OctoTables_Vibor[categoryKey] = {}
	OctoTables_Vibor[categoryKey].icon = E.ICON_EMPTY
	OctoTables_Vibor[categoryKey].name = "RaidsOrDungeons"
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
	local uniqueIDs = {}
	for Field, Value in next, (Enum.CalendarEventType) do
		-- if Value == 0 or Value == 1 then
		for k, v in ipairs(C_Calendar.EventGetTextures(Value)) do
			local mapId = v.mapId
			uniqueIDs[mapId] = true
		end
		-- end
	end
	local sorted = {}
	for id in next,(uniqueIDs) do
		tinsert(sorted, id)
	end
	table.sort(sorted, E.func_ReversSort)
	for i, id in ipairs(sorted) do
		tinsert(OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons, {id = id, defS = true,})
	end
	return OctoTables_Vibor, OctoTables_DataOtrisovka
end
table.insert(E.Components, tempFunction)
-- do
-- local tbl = {}
-- local simpleIds = {}
-- local function func_BUILD()
-- -- Value Field
-- -- 0 Raid
-- -- 1 Dungeon
-- -- 2 PvP
-- -- 3 Meeting
-- -- 4 Other
-- -- 5 HeroicDeprecated
-- for Field, Value in next, (Enum.CalendarEventType) do
-- if Value == 0 or Value == 1 then
-- for k, v in ipairs(C_Calendar.EventGetTextures(Value)) do
-- local title = v.title
-- local mapId = v.mapId
-- local isLfr = v.isLfr
-- local difficultyId = v.difficultyId
-- local expansionLevel = (v.expansionLevel or 0) + 1
-- local iconTexture = v.iconTexture
-- -- if expansionLevel == 3 then
-- simpleIds[expansionLevel] = simpleIds[expansionLevel] or {}
-- simpleIds[expansionLevel][Field] = simpleIds[expansionLevel][Field] or {}
-- -- simpleIds[Field][mapId] = title
-- -- simpleIds[Field][mapId] = E.func_GetDungeonName(mapId)
-- local text = "{id = "..mapId..", defS = true,}, -- "..E.func_GetDungeonName(mapId)
-- simpleIds[expansionLevel][Field][mapId] = text
-- local SI_ID = mapId
-- local EJ_ID = E.func_SI_to_EJ(SI_ID)
-- local EJ_name, _, _, _, _, buttonImage2, _, _, _, _, _, isRaid = EJ_GetInstanceInfo(EJ_ID)
-- -- local name = E.func_GetDungeonName(mapId) -- GetRealZoneText(mapId)
-- local name = GetRealZoneText(mapId)
-- if EJ_name ~= name then
-- tbl[mapId] = tbl[mapId] or {}
-- -- tbl[mapId].diff = tbl[mapId].diff or {}
-- -- tbl[mapId].diff[difficultyId] = tbl[mapId].diff[difficultyId] or E.func_GetDifficultyName(difficultyId) -- GetDifficultyInfo(difficultyId)
-- -- tbl[mapId].expansionLevel = expansionLevel
-- -- tbl[mapId].iconTexture = iconTexture
-- tbl[mapId].RealZoneText = name
-- tbl[mapId].EJ_name = EJ_name
-- -- tbl[mapId].Field = Field
-- -- tbl[mapId].text = text
-- end
-- -- end
-- end
-- end
-- end
-- opde(simpleIds)
-- -- opde(tbl)
-- end
-- C_Timer.After(1, function()
-- func_BUILD()
-- end)
-- end


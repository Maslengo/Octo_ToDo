local GlobalAddonName, E = ...
local GetItemNameByID = C_Item.GetItemNameByID
local GetItemQualityByID = C_Item.GetItemQualityByID
local GetSpellName = C_Spell.GetSpellName
local GetCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo
local GetQuestInfo = C_QuestLog.GetQuestInfo
local GetTitleForQuestID = C_QuestLog.GetTitleForQuestID
local GetFactionDataByID = C_Reputation.GetFactionDataByID
local GetFriendshipReputation = C_GossipInfo.GetFriendshipReputation
local GetTradeSkillDisplayName = C_TradeSkillUI.GetTradeSkillDisplayName
local GetTradeSkillTexture = GetTradeSkillTexture or C_TradeSkillUI.GetTradeSkillTexture
local GetMapInfo = C_Map.GetMapInfo
local GetMapGroupID = C_Map.GetMapGroupID
local GetMapGroupMembersInfo = C_Map.GetMapGroupMembersInfo
local GetCurrentCalendarTime = C_DateAndTime.GetCurrentCalendarTime
local GetDayEvent = C_Calendar.GetDayEvent
local GetMonthInfo = C_Calendar.GetMonthInfo
local SetAbsMonth = C_Calendar.SetAbsMonth
local GetNumDayEvents =  C_Calendar.GetNumDayEvents
local GetMountInfoByID = C_MountJournal.GetMountInfoByID
local function GetOrCreateCache(category)
	Octo_Cache_DB = Octo_Cache_DB or {}
	Octo_Cache_DB[category] = Octo_Cache_DB[category] or {}
	return Octo_Cache_DB[category]
end
local function func_itemName_CACHE(id, forcedQuality)
	local Cache = GetOrCreateCache("AllItems", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		local cachedName = Cache[id][E.curLocaleLang]
		if forcedQuality then
			local nameOnly = cachedName:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
			local colorHex = ITEM_QUALITY_COLORS[forcedQuality].hex
			return colorHex..nameOnly.."|r"
		end
		return cachedName
	end
	local name = GetItemNameByID(id)
	local quality = forcedQuality or GetItemQualityByID(id)
	if name and name ~= "" and quality then
		Cache[id] = Cache[id] or {}
		local colorHex = ITEM_QUALITY_COLORS[quality].hex
		local result = colorHex..name.."|r"
		Cache[id][E.curLocaleLang] = result
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			E.func_PrintMessage(E.COLOR_LIME..ITEMS.."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
		end
		return result
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..RETRIEVING_DATA.."|r"
	return output
end
function E.func_GetItemName(id, forcedQuality)
	if not id then return "no id" end
	id = tonumber(id)
	local name = func_itemName_CACHE(id, forcedQuality)
	return E.func_translit(name)..E.debugInfo(id)
end
local function func_currencyName_CACHE(id, forcedQuality)
	local Cache = GetOrCreateCache("AllCurrencies", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		local hasMount = Octo_ToDo_DB_Vars.Config_MountsInTooltip and E.OctoTable_CurrencyMountForFuncCurName[id] or false
		if id == 3252 or id == 1166 or id == 2778 then
			hasMount = true
		end
		if forcedQuality then
			local colorHex = ITEM_QUALITY_COLORS[forcedQuality].hex
			return colorHex..Cache[id][E.curLocaleLang].."|r"..(hasMount and E.COLOR_LIME.."*|r" or "")
		end
		return Cache[id][E.curLocaleLang]..(hasMount and E.COLOR_RED.."*|r" or "")
	end
	local info = GetCurrencyInfo(id)
	if not info then
		return E.COLOR_RED..UNKNOWN.."|r"
	end
	local colorHex = (info.quality and ITEM_QUALITY_COLORS[info.quality].hex) or ITEM_QUALITY_COLORS[1].hex
	local name = info.name
	if name and name ~= "" then
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = colorHex..info.name.."|r"
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			E.func_PrintMessage(E.COLOR_LIME..CURRENCY.."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
		end
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r"
	return output
end
function E.func_GetCurrencyName(id, forcedQuality)
	if not id then return "no id" end
	id = tonumber(id)
	local cachedName = func_currencyName_CACHE(id, forcedQuality)
	return E.func_translit(cachedName)..E.debugInfo(id)
end
local function func_npcName_CACHE(id)
	local Cache = GetOrCreateCache("AllNPCs", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		return Cache[id][E.curLocaleLang]
	end
	if E.OctoTable_AllNPCs_DB and E.OctoTable_AllNPCs_DB[id] and E.OctoTable_AllNPCs_DB[id][E.curLocaleLang] then
		return E.OctoTable_AllNPCs_DB[id][E.curLocaleLang]
	end
	E.ScanningTooltipFUNC = E.ScanningTooltipFUNC or CreateFrame("GameTooltip", E.MainAddonName.."ScanningTooltipFUNC", nil, "GameTooltipTemplate")
	local tooltip = E.ScanningTooltipFUNC
	tooltip:Hide()
	tooltip:SetOwner(UIParent, "ANCHOR_NONE")
	tooltip:ClearLines()
	tooltip:SetHyperlink("unit:Creature-0-0-0-0-"..id)
	local name
	if tooltip:NumLines() > 0 then
		for i = 1, tooltip:NumLines() do
			if i == 1 then
				name = _G[E.MainAddonName.."ScanningTooltipFUNCTextLeft1"]:GetText()
			end
		end
	end
	if name and name ~= "" then
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = name
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			E.func_PrintMessage(E.COLOR_LIME.."NPC".."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
		end
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r"
	return output
end
function E.func_GetNPCName(id)
	if not id then return "no id" end
	local cachedName = func_npcName_CACHE(id)
	return E.func_translit(cachedName)..E.debugInfo(id)
	-- local name = UNKNOWN
	-- if E.OctoTable_AllNPCs_DB[id] and E.OctoTable_AllNPCs_DB[id][E.curLocaleLang] then
	-- 	name = E.OctoTable_AllNPCs_DB[id][E.curLocaleLang]
	-- else
	-- 	name = E.COLOR_RED..name.."|r"
	-- end
	-- return name..E.debugInfo(id)
end
-- function E.func_GetNPCName(id)
-- 	if not id then return "no id" end
-- 	local name = UNKNOWN
-- 	if E.OctoTable_AllNPCs_DB[id] and E.OctoTable_AllNPCs_DB[id][E.curLocaleLang] then
-- 		name = E.OctoTable_AllNPCs_DB[id][E.curLocaleLang]
-- 	else
-- 		name = E.COLOR_RED..name.."|r"
-- 	end
-- 	return name..E.debugInfo(id)
-- end
local function func_questName_CACHE(id)
	local Cache = GetOrCreateCache("AllQuests", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		return Cache[id][E.curLocaleLang]
	end
	local name = (GetTitleForQuestID or GetQuestInfo)(id)
	if name and name ~= "" then
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = name
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			E.func_PrintMessage(E.COLOR_LIME..QUESTS_LABEL.."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
		end
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r"
	return output
end
function E.func_GetQuestName(id, ShowIcon)
	if not id then return "no id" end
	id = tonumber(id)
	local cachedName = func_questName_CACHE(id)
	if ShowIcon == false then
		return cachedName..E.debugInfo(id)
	end
	return E.func_GetQuestIcon(id)..E.func_translit(cachedName)..E.debugInfo(id)
end
function E.func_GetQuestIcon(id)
	local icon = ""
	local info = C_QuestLog.GetQuestTagInfo(id)
	if info and info.tagID and QUEST_TAG_ATLAS[info.tagID] then
		local atlasName = QUEST_TAG_ATLAS[info.tagID]
		icon = icon..E.func_texturefromIcon(atlasName, nil, nil, true)
	end
	local classification, _, atlasName = QuestUtil.GetQuestClassificationDetails(id)
	if classification and atlasName then
		icon = icon..E.func_texturefromIcon(atlasName, nil, nil, true)
	end
	return icon
end
local rep_meta_table = {
	__index = function(self, id)
		id = tonumber(id)
		if not id then
			local unknown = E.COLOR_RED..UNKNOWN.."|r"
			rawset(self, id, unknown)
			return unknown
		end
		local Cache = GetOrCreateCache("AllReputations", id)
		local name
		if Cache[id] and Cache[id][E.curLocaleLang] then
			name = Cache[id][E.curLocaleLang]
		else
			local repInfo = GetFactionDataByID(id)
			if repInfo then
				name = repInfo.name
			else
				local reputationInfo = GetFriendshipReputation(id)
				if reputationInfo and reputationInfo.name then
					name = reputationInfo.name
				end
			end
			if name and name ~= "" then
				Cache[id] = Cache[id] or {}
				Cache[id][E.curLocaleLang] = name
			else
				local dbEntry = E.OctoTable_Reputations_DB[id]
				if dbEntry then
					if dbEntry[E.curLocaleLang] and dbEntry[E.curLocaleLang] ~= "NONE" then
						name = dbEntry[E.curLocaleLang]..E.COLOR_SLATEGRAY.." (DB)|r"
					elseif dbEntry["enUS"] then
						name = dbEntry["enUS"]..E.COLOR_SKYBLUE.." (enUS)|r"
					end
				end
			end
		end
		if not name or name == "" then
			name = E.COLOR_RED..UNKNOWN.."|r"
		end
		rawset(self, id, name)
		return name
	end
}
local ReputationNames = setmetatable({}, rep_meta_table)
function E.func_GetReputationName(id)
	if not id then return "no id" end
	local name = ReputationNames[id]
	return E.func_translit(name)..(E.debugInfo(id) or "")
end
function E.func_GetReputationIcon(id)
	local reputationData = E.OctoTable_Reputations_DB[id]
	if reputationData then
		return reputationData.icon1
	end
	return nil
end
function E.func_GetReputationAtlas(id)
	local reputationData = E.OctoTable_Reputations_DB[id]
	if reputationData then
		return reputationData.atlas
	end
	return nil
end
function E.func_GetReputationSideIcon(id)
	local reputationData = E.OctoTable_Reputations_DB[id]
	if reputationData and reputationData.side then
		local side = reputationData.side
		if side == "Horde" or side == "Alliance" then
			return reputationData.icon1
		end
	end
	return nil
end
local function func_spellName_CACHE(id)
	local Cache = GetOrCreateCache("AllSpells", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		return Cache[id][E.curLocaleLang]
	end
	local name = GetSpellName(id)
	if name and name ~= "" then
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = name
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			E.func_PrintMessage(E.COLOR_LIME..SPELLS.."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
		end
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r"
	return output
end
function E.func_GetSpellName(id)
	if not id then return "no id" end
	id = tonumber(id)
	local cachedName = func_spellName_CACHE(id)
	return E.func_translit(cachedName)..E.debugInfo(id)
end
local function func_achievementName_CACHE(id)
	local Cache = GetOrCreateCache("AllAchievements", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		return Cache[id][E.curLocaleLang]
	end
	local name = select(2, GetAchievementInfo(id))
	if name and name ~= "" then
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = name
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			E.func_PrintMessage(E.COLOR_LIME..LOOT_JOURNAL_LEGENDARIES_SOURCE_ACHIEVEMENT.."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
		end
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r"
	return output
end
function E.func_GetAchievementName(id)
	if not id then return "no id" end
	id = tonumber(id)
	local cachedName = func_achievementName_CACHE(id)
	return E.func_translit(cachedName)..E.debugInfo(id)
end
local function func_mountName_CACHE(id)
	local Cache = GetOrCreateCache("AllMounts", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		return Cache[id][E.curLocaleLang]
	end
	local name = GetMountInfoByID(id)
	if name and name ~= "" then
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = name
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			E.func_PrintMessage(E.COLOR_LIME..MOUNTS.."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
		end
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r"
	return output
end
function E.func_GetMountName(mountID)
	if not mountID then return end
	local cachedName = func_mountName_CACHE(mountID)
	return E.func_translit(cachedName)..E.debugInfo(mountID)
end
function E.func_GetMountTexture(mountID)
	if not mountID then return end
	return select(3, GetMountInfoByID(mountID))
end
function E.func_IsMountCollected(mountID)
	if not mountID then return "no mountID" end
	local isCollected = select(11, C_MountJournal.GetMountInfoByID(mountID))
	return isCollected
end
function E.func_GetMountCollectedColor(mountID)
	if not mountID then return end
	local isCollected = select(11, C_MountJournal.GetMountInfoByID(mountID))
	return isCollected and E.COLOR_WHITE or E.COLOR_RED
end
local function func_mapName_CACHE(id)
	local Cache = GetOrCreateCache("AllMaps", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		return Cache[id][E.curLocaleLang]
	end
	local name = GetMapInfo(id) and GetMapInfo(id).name or ""
	if name and name ~= "" then
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = name
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			E.func_PrintMessage(E.COLOR_LIME.."MAPS".."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
		end
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r"
	return output
end
function E.func_GetMapName(id)
	if not id then return "no id" end
	id = tonumber(id)
	local cachedName = func_mapName_CACHE(id)
	return E.func_translit(cachedName)..E.debugInfo(id)
end
function E.func_GetFullMapName(id)
	if not id then return "no id" end
	id = tonumber(id)
	local info = GetMapInfo(id)
	if not info then
		return UNKNOWN
	end
	local groupID = GetMapGroupID(id)
	if groupID then
		local groupdata = GetMapGroupMembersInfo(groupID)
		for _, subzonedata in ipairs(groupdata) do
			if subzonedata.mapID == id then
				return info.name, " ("..subzonedata.name..")"
			end
		end
	end
	return info.name, ""
end
function E.Cache_All_EventNames_Year()
	if not GetNumDayEvents then return end
	local currentYear = GetCurrentCalendarTime().year
	for month = 1, 12 do
		local monthInfo = GetMonthInfo(month, currentYear)
		if not monthInfo then
			break
		end
		SetAbsMonth(month, currentYear)
		for day = 1, monthInfo.numDays do
			local numEvents = GetNumDayEvents(0, day)
			for i = 1, numEvents do
				local event = GetDayEvent(0, day, i)
				if not event or event.calendarType ~= "HOLIDAY" then break end
				local Cache = GetOrCreateCache("AllEvents", event.eventID)
				Cache[event.eventID] = Cache[event.eventID] or {}
				Cache[event.eventID][E.curLocaleLang] = event.title
			end
		end
	end
end
local function func_EventName_CACHE(id)
	local Cache = Octo_Cache_DB.AllEvents
	if Cache[id] and Cache[id][E.curLocaleLang] then
		return Cache[id][E.curLocaleLang]
	end
	local name
	if not E.Holiday or next(E.Holiday) == nil then
		if E.Collect_Holidays then
			pcall(E.Collect_Holidays)
		end
	end
	for eventKey, v in next, (E.Holiday) do
		if id == v.eventID then
			name = v.title or ""
		end
	end
	if not name or name == "" then
		return E.COLOR_RED..UNKNOWN.."|r"
	end
	Cache[id] = Cache[id] or {}
	Cache[id][E.curLocaleLang] = name
	if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
		E.func_PrintMessage(E.COLOR_LIME.."MAPS".."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r"
	return output
end
function E.func_GetEventName(id)
	if not id then return "no id" end
	id = tonumber(id)
	local cachedName = func_EventName_CACHE(id)
	return E.func_translit(cachedName)..E.debugInfo(id)
end
local function func_ProfessionName_CACHE(id)
	local Cache = GetOrCreateCache("AllProfessions", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		return Cache[id][E.curLocaleLang]
	end
	local name = GetTradeSkillDisplayName(id)
	if name and name ~= "" then
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = name
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			E.func_PrintMessage(E.COLOR_LIME..PROFESSIONS_TRACKER_HEADER_PROFESSION.."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
		end
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r"
	return output
end
function E.func_GetProfessionName(id)
	if not id then return "no id" end
	id = tonumber(id)
	local cachedName = func_ProfessionName_CACHE(id)
	return E.func_translit(cachedName)..E.debugInfo(id)
end
function E.func_ProfessionIcon(skillLine)
	if not skillLine then return "" end
	return E.func_texturefromIcon(GetTradeSkillTexture(skillLine))
end
local function func_DungeonName_CACHE(id)
	local Cache = GetOrCreateCache("AllDungeons", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		return Cache[id][E.curLocaleLang]
	end
	-- local name = EJ_GetInstanceInfo(id) -- JI_ID
	local name = GetRealZoneText(id) -- SI_ID
	if name and name ~= "" then
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = name
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			E.func_PrintMessage(E.COLOR_LIME..DUNGEONS.."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
		end
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r"
	return output
end
function E.func_GetDungeonName(id) -- > COLLECT_ALL_RAIDS.lua
	if not id then return "no id" end
	id = tonumber(id)
	local cachedName = func_DungeonName_CACHE(id)
	return E.func_translit(cachedName)..E.debugInfo(id)
end
local function func_DifficultyName_CACHE(id)
	local Cache = GetOrCreateCache("AllDifficulty", id)
	if Cache[id] and Cache[id][E.curLocaleLang] then
		return Cache[id][E.curLocaleLang]
	end
	local name = GetDifficultyInfo(id)
	if name and name ~= "" then
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = name
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			E.func_PrintMessage(E.COLOR_LIME.."Difficulty".."|r", E.COLOR_ADDON_LEFT..E.curLocaleLang.."|r", Cache[id][E.curLocaleLang], E.COLOR_ADDON_RIGHT..id.."|r")
		end
	end
	local output = Cache[id] and Cache[id][E.curLocaleLang] or E.COLOR_RED..UNKNOWN.."|r"
	return output
end
function E.func_GetDifficultyName(id)
	if not id then return "no id" end
	id = tonumber(id)
	local cachedName = func_DifficultyName_CACHE(id)
	if Octo_ToDo_DB_Vars.Config_DifficultyAbbreviation then
		cachedName = E.OctoTable_Difficulties[id] and E.OctoTable_Difficulties[id].abbr or func_DifficultyName_CACHE(id)
	end
	return E.func_translit(cachedName)..E.debugInfo(id)
end
function E.func_CovenantName(covID)
	return E.OctoTable_Covenant[covID].name
end
function E.func_CovenantIcon(covID)
	return E.OctoTable_Covenant[covID].icon
end

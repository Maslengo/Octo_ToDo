local GlobalAddonName, E = ...
----------------------------------------------------------------
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
local GetNumDayEvents = C_Calendar.GetNumDayEvents
local GetMountInfoByID = C_MountJournal.GetMountInfoByID
----------------------------------------------------------------
local UNKNOWN = UNKNOWN
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function GetOrCreateCache(category)
	local Octo_Cache_DB = Octo_Cache_DB or {}
	Octo_Cache_DB[category] = Octo_Cache_DB[category] or {}
	return Octo_Cache_DB[category]
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_ForcedQuality(text, forcedQuality)
	if type(forcedQuality) ~= "number" then
		forcedQuality = 1
	end
	local nameOnly = text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
	local colorHex = ITEM_QUALITY_COLORS[forcedQuality].hex
	local coloredName = colorHex..nameOnly.."|r"
	return coloredName
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_CacheName(id, Cache, name, debugLabel)
	if name and name ~= "" then
		Cache[id] = Cache[id] or {}
		Cache[id][E.curLocaleLang] = name
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugCache then
			E.func_PrintMessage(
				E.COLOR_LIME..debugLabel.."|r",
				-- E.COLOR_GRAY..E.curLocaleLang.."|r",
				name,
				E.COLOR_GRAY.."id:"..id.."|r"
			)
		end
	end
	local entry = Cache[id]
	if entry then
		return entry[E.curLocaleLang]
	else
		return E.COLOR_DARKORANGE..UNKNOWN.."|r"
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
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
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- local rep_meta_table = {
-- 	__index = function(self, id)
-- 		id = tonumber(id)
-- 		if not id then
-- 			local unknown = E.COLOR_RED..UNKNOWN.."|r"
-- 			rawset(self, id, unknown)
-- 			return unknown
-- 		end
-- 		local Cache = GetOrCreateCache("reputation")
-- 		local name
-- 		local localeCache = Cache[id]
-- 		local cached = localeCache and localeCache[E.curLocaleLang] or nil
-- 		if localeCache and cached then
-- 			name = cached
-- 		else
-- 			local repInfo = GetFactionDataByID(id)
-- 			if repInfo then
-- 				name = repInfo.name
-- 			else
-- 				local reputationInfo = GetFriendshipReputation(id)
-- 				if reputationInfo and reputationInfo.name then
-- 					name = reputationInfo.name
-- 				end
-- 			end
-- 			if name and name ~= "" then
-- 				Cache[id] = Cache[id] or {}
-- 				Cache[id][E.curLocaleLang] = name
-- 			else
-- 				local dbEntry = E.OctoTable_Reputations_DB[id]
-- 				if dbEntry then
-- 					if dbEntry[E.curLocaleLang] and dbEntry[E.curLocaleLang] ~= "NONE" then
-- 						name = dbEntry[E.curLocaleLang]..E.COLOR_SLATEGRAY.." (DB)|r"
-- 					elseif dbEntry["enUS"] then
-- 						name = dbEntry["enUS"]..E.COLOR_SKYBLUE.." (enUS)|r"
-- 					end
-- 				end
-- 			end
-- 		end
-- 		if not name or name == "" then
-- 			name = E.COLOR_RED..UNKNOWN.."|r"
-- 		end
-- 		rawset(self, id, name)
-- 		return name
-- 	end
-- }
-- local ReputationNames = setmetatable({}, rep_meta_table)
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
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
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
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_ProfessionIcon(skillLine)
	if not skillLine then return "" end
	return E.func_texturefromIcon(GetTradeSkillTexture(skillLine))
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- function E.func_CovenantName(covID)
-- return E.OctoTable_Covenant[covID].name
-- end
function E.func_CovenantIcon(covID)
	return E.OctoTable_Covenant[covID].icon
end
function E.func_ClassColor(classID)
	local className, classFile = GetClassInfo(classID)
	-- local classColor = C_ClassColor.GetClassColor(classFile)
	-- local r, g, b = classColor.r, classColor.g, classColor.b
	-- local hex = E.func_RGB2Hex(r, g, b)
	local hex = C_ClassColor and C_ClassColor.GetClassColor and C_ClassColor.GetClassColor(classFile) and C_ClassColor.GetClassColor(classFile):GenerateHexColorMarkup() or E.COLOR_WHITE
	return hex
end
function E.func_ClassIcon(classID)
	local className, classFile = GetClassInfo(classID)
	local atlas = GetClassAtlas(classFile)
	return atlas
end
function E.func_SpecIcon(specID)
	local _, _, _, icon = GetSpecializationInfoByID(specID)
	return icon
end
----------------------------------------------------------------
----------------------------------------------------------------
local TooltipForNpcScan = CreateFrame("GameTooltip", E.MainAddonName.."TooltipForNpcScan", UIParent, "GameTooltipTemplate")
TooltipForNpcScan:Hide()
TooltipForNpcScan:SetOwner(UIParent, "ANCHOR_NONE")
----------------------------------------------------------------
function E.func_GetName(TYPE, id, forcedQuality)
	if not id then return "no id" end
	if type(id) ~= "number" then return "wrong id type" end
	if not TYPE then return "not TYPE" end
	local name
	id = tonumber(id)
	----------------------------------------------------------------
	----------------------------------------------------------------
	local Cache = GetOrCreateCache(TYPE)
	local localeCache = Cache[id]
	local cached = localeCache and localeCache[E.curLocaleLang] or nil
	if localeCache and cached then
		local hasMount
		if TYPE == "currency" then
			hasMount = Octo_ToDo_DB_Vars.Config_MountsInTooltip and E.OctoTable_CurrencyMountForFuncCurName[id] or false
			if id == 3252 or id == 1166 or id == 2778 then
				hasMount = true
			end
		end
		name = cached..(hasMount and E.COLOR_RED.."*|r" or "")
		-- return cached
	else
		----------------------------------------------------------------
		if TYPE == "item" then -- AllItems

			local quality = GetItemQualityByID(id)

			if quality and quality ~= "" then
				name = func_CacheName(id, Cache, E.func_GetQualityHexColor(quality)..GetItemNameByID(id).."|r", TYPE) -- ITEMS
			else
				name = GetItemNameByID(id)
			end

		elseif TYPE == "quest" then -- AllQuests
			local result = (GetTitleForQuestID or GetQuestInfo)(id)
			if result then
				name = E.func_GetQuestIcon(id)..func_CacheName(id, Cache, result, TYPE) -- QUESTS_LABEL
			end
		elseif TYPE == "currency" then -- AllCurrencies
			local info = GetCurrencyInfo(id)
			local result
			if info then
				local colorHex = (info.quality and ITEM_QUALITY_COLORS[info.quality].hex) or ITEM_QUALITY_COLORS[1].hex
				result = colorHex..info.name.."|r"
				-- result = info.name
			end
			name = func_CacheName(id, Cache, result, TYPE) -- CURRENCY
		elseif TYPE == "npc" then -- AllNPCs
			-- if Cache and not Cache[id] and not Cache[id][E.curLocaleLang] then
			TooltipForNpcScan:ClearLines()
			TooltipForNpcScan:SetHyperlink("unit:Creature-0-0-0-0-"..id)
			if TooltipForNpcScan:NumLines() > 0 then

				local result1 = _G[E.MainAddonName.."TooltipForNpcScanTextLeft1"]:GetText()
				-- print (result1)

				-- local result2 = _G[E.MainAddonName.."TooltipForNpcScanTextLeft2"]:GetText()
				-- print (result2)

				-- local result3 = _G[E.MainAddonName.."TooltipForNpcScanTextLeft3"]:GetText()
				-- print (result3)

				if result1 then
					name = func_CacheName(id, Cache, result1, TYPE) -- NPC
					-- name = func_CacheName(id, Cache, result1..E.COLOR_SKYBLUE.." ("..result3..")|r", TYPE) -- NPC
				end
			elseif E.OctoTable_AllNPCs_DB and E.OctoTable_AllNPCs_DB[id] and E.OctoTable_AllNPCs_DB[id][E.curLocaleLang] then
				local result = E.OctoTable_AllNPCs_DB[id][E.curLocaleLang]
				-- name = func_CacheName(id, Cache, result, TYPE) -- NPC
				name = result -- NPC
			end
		elseif TYPE == "reputation" then -- AllReputations -> reputation
			local repInfo = GetFactionDataByID(id)
			local result
			if repInfo then
				result = repInfo.name
			else
				local reputationInfo = GetFriendshipReputation(id)
				if reputationInfo and reputationInfo.name then
					result = reputationInfo.name
				end
			end
			if result and result ~= "" then
				name = func_CacheName(id, Cache, result, TYPE) -- NPC
			elseif E.OctoTable_Reputations_DB and E.OctoTable_Reputations_DB[id] then
				if E.OctoTable_Reputations_DB[id][E.curLocaleLang] then
					name = E.OctoTable_Reputations_DB[id][E.curLocaleLang]..E.COLOR_SLATEGRAY.." (DB)|r"
				elseif E.OctoTable_Reputations_DB[id]["enUS"] then
					name = E.OctoTable_Reputations_DB[id]["enUS"]..E.COLOR_SKYBLUE.." (enUS)|r"
				end
			end
			-- local QWEname = ReputationNames[id] -- setmetatable
			-- name = QWEname
			-- name = func_CacheName(id, Cache, QWEname, TYPE) -- reputation
		elseif TYPE == "spell" then -- AllSpells
			name = func_CacheName(id, Cache, GetSpellName(id), TYPE) -- SPELLS
		elseif TYPE == "achievement" then -- AllAchievements
			name = func_CacheName(id, Cache, select(2, GetAchievementInfo(id)), TYPE) -- LOOT_JOURNAL_LEGENDARIES_SOURCE_ACHIEVEMENT
		elseif TYPE == "mount" then -- AllMounts
			name = func_CacheName(id, Cache, GetMountInfoByID(id), TYPE) -- MOUNTS
		elseif TYPE == "map" then -- AllMaps
			local info = GetMapInfo(id)
			local result = info and info.name or ""
			name = func_CacheName(id, Cache, result, TYPE) -- "MAPS"
		elseif TYPE == "profession" then -- AllProfessions
			name = func_CacheName(id, Cache, GetTradeSkillDisplayName(id), TYPE) -- PROFESSIONS_TRACKER_HEADER_PROFESSION
		elseif TYPE == "dungeon" then -- AllDungeons
			name = func_CacheName(id, Cache, GetRealZoneText(id), TYPE) -- DUNGEONS SI_ID
		elseif TYPE == "difficulty" then -- AllDifficulty
			if Octo_ToDo_DB_Vars.Config_DifficultyAbbreviation then
				name = E.OctoTable_Difficulties[id] and E.OctoTable_Difficulties[id].abbr or func_CacheName(id, Cache, GetDifficultyInfo(id), "Difficulty")
			else
				name = func_CacheName(id, Cache, GetDifficultyInfo(id), TYPE)
			end
		elseif TYPE == "covenant" then
			if E.OctoTable_Covenant and E.OctoTable_Covenant[id] then
				local result = E.OctoTable_Covenant[id].name
				if result then
					name = func_CacheName(id, Cache, result, TYPE) -- QUESTS_LABEL
				end
			end
		elseif TYPE == "class" then
			local className, _ = GetClassInfo(id)
			-- local classColor = C_ClassColor.GetClassColor(classFile)
			if className and _ then
				-- local className_COLORED = classColor:WrapTextInColorCode(className)
				name = func_CacheName(id, Cache, className, TYPE)
			end
		elseif TYPE == "specialization" then
			local _, specName = GetSpecializationInfoByID(id)
			if specName then
				name = func_CacheName(id, Cache, specName, TYPE)
			end
		end
	end
	if forcedQuality and name then
		name = func_ForcedQuality(name, forcedQuality)
	end
	local debugTEXT = E.debugInfo and E.debugInfo(id) or ""
	local result = E.func_translit and E.func_translit(name or E.COLOR_RED..UNKNOWN.."|r") or ""
	return result..debugTEXT
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
end
local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
local GetSpellName = GetSpellName or C_Spell.GetSpellName
local GetCurrencyInfo = GetCurrencyInfo or C_CurrencyInfo.GetCurrencyInfo
local GetQuestInfo = GetQuestInfo or C_QuestLog.GetQuestInfo
local GetTitleForQuestID = GetTitleForQuestID or C_QuestLog.GetTitleForQuestID
local GetFactionDataByID = GetFactionDataByID or C_Reputation.GetFactionDataByID
local GetFriendshipReputation = GetFriendshipReputation or C_GossipInfo.GetFriendshipReputation
local GetTradeSkillDisplayName = GetTradeSkillDisplayName or C_TradeSkillUI.GetTradeSkillDisplayName
local GetTradeSkillTexture = GetTradeSkillTexture or GetTradeSkillTexture or C_TradeSkillUI.GetTradeSkillTexture
local GetMapInfo = GetMapInfo or C_Map.GetMapInfo
local GetMapGroupID = GetMapGroupID or C_Map.GetMapGroupID
local GetMapGroupMembersInfo = GetMapGroupMembersInfo or C_Map.GetMapGroupMembersInfo
local GetCurrentCalendarTime = GetCurrentCalendarTime or C_DateAndTime.GetCurrentCalendarTime
local GetDayEvent = GetDayEvent or C_Calendar.GetDayEvent
local GetMonthInfo = GetMonthInfo or C_Calendar.GetMonthInfo
local SetAbsMonth = SetAbsMonth or C_Calendar.SetAbsMonth
local GetNumDayEvents = GetNumDayEvents or C_Calendar.GetNumDayEvents
local GetMapUIInfo = GetMapUIInfo or C_ChallengeMode.GetMapUIInfo
----------------------------------------------------------------
local function GetOrCreateCache_Name(category)
	Octo_Cache_DB = Octo_Cache_DB or {}
	Octo_Cache_DB[category] = Octo_Cache_DB[category] or {}
	return Octo_Cache_DB[category]
end
----------------------------------------------------------------
local function GetOrCreateCache_Quality(category)
	Octo_Cache_DB = Octo_Cache_DB or {}
	local newCat = tostring(category).."_Quality"
	Octo_Cache_DB[newCat] = Octo_Cache_DB[newCat] or {}
	return Octo_Cache_DB[newCat]
end
----------------------------------------------------------------
local function func_ForcedQuality(text, forcedQuality)
	if type(forcedQuality) ~= "number" then
		forcedQuality = 1
	end
	local nameOnly = text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
	local colorHex = ITEM_QUALITY_COLORS[forcedQuality] and ITEM_QUALITY_COLORS[forcedQuality].hex or E.COLOR_RED
	local coloredName = colorHex..nameOnly.."|r"
	return coloredName
end
----------------------------------------------------------------
local function func_Cache_Name(id, Cache_Name, name, debugLabel)
	if type(name) == "string" and name ~= "" then
		Cache_Name[id] = Cache_Name[id] or {}
		Cache_Name[id][E.curLocaleLang] = name

		if Octo_DevTool_DB and Octo_DevTool_DB.CONFIG_DEBUG_CACHE then
			E.func_PrintMessage(
				E.COLOR_LIME..debugLabel.."|r",
				name,
				E.COLOR_GRAY.."id:"..id.."|r"
			)
		end
	end

	local entry = Cache_Name[id]
	if entry and type(entry) == "table" and type(entry[E.curLocaleLang]) == "string" then
		return entry[E.curLocaleLang]
	else
		return E.COLOR_DARKORANGE..L["UNKNOWN"].."|r"
	end
end
----------------------------------------------------------------
local function func_Cache_Quality(id, Cache_Quality, NEWquality, debugLabel)
	if NEWquality ~= nil and type(NEWquality) == "number" then
		Cache_Quality[id] = NEWquality
		return NEWquality
	end
	return Cache_Quality[id]
end
----------------------------------------------------------------
function E.func_GetQuestIcon(id)
	local icon = ""
	local info = C_QuestLog.GetQuestTagInfo(id)
	if info and info.tagID and QUEST_TAG_ATLAS[info.tagID] then
		local atlasName = QUEST_TAG_ATLAS[info.tagID]
		icon = icon..E.func_texturefromIcon(atlasName)
	end
	local classification, _, atlasName = QuestUtil.GetQuestClassificationDetails(id)
	if classification and atlasName then
		icon = icon..E.func_texturefromIcon(atlasName)
	end
	return icon
end
----------------------------------------------------------------
function E.func_GetReputationIcon(id)
	local reputationData = E.OctoTable_Reputations_DB[id]
	if reputationData then
		return reputationData.icon
	end
	return nil
end
----------------------------------------------------------------
function E.func_GetReputationSide(id)
	local reputationData = E.OctoTable_Reputations_DB[id]
	if reputationData then
		return reputationData.side
	end
	return nil
end
----------------------------------------------------------------
-- function E.func_GetReputationSideIcon(id)
--     local reputationData = E.OctoTable_Reputations_DB[id]
--     if reputationData and reputationData.side then
--         local side = reputationData.side
--         if side == "Horde" or side == "Alliance" then
--             return reputationData.icon1
--         end
--     end
--     return nil
-- end
----------------------------------------------------------------
function E.func_GetMountTexture(mountID)
	if not mountID then return end
	return select(3, E.func_GetMountInfoByID(mountID))
end
----------------------------------------------------------------
function E.func_IsMountCollected(mountID)
	if not mountID then return "no mountID" end
	local isCollected = select(11, E.func_GetMountInfoByID(mountID))
	return isCollected
end
----------------------------------------------------------------
function E.func_GetMountCollectedColor(mountID)
	if not mountID then return end
	local isCollected = select(11, E.func_GetMountInfoByID(mountID))
	return isCollected and E.COLOR_WHITE or E.COLOR_RED
end
----------------------------------------------------------------
function E.func_ProfessionIcon(skillLine)
	if not skillLine then return "" end
	return E.func_texturefromIcon(GetTradeSkillTexture(skillLine))
end
----------------------------------------------------------------
function E.func_CovenantIcon(covID)
	return E.OctoTable_Covenant[covID].icon
end
----------------------------------------------------------------
function E.func_ClassColor(classID)
	local className, classFile = GetClassInfo(classID)
	local hex = C_ClassColor and C_ClassColor.GetClassColor and C_ClassColor.GetClassColor(classFile) and C_ClassColor.GetClassColor(classFile):GenerateHexColorMarkup() or E.COLOR_WHITE
	return hex
end
----------------------------------------------------------------
function E.func_ClassIcon(classID)
	local className, classFile = GetClassInfo(classID)
	local atlas = GetClassAtlas(classFile)
	return atlas
end
----------------------------------------------------------------
function E.func_SpecIcon(specID)
	local _, _, _, icon = GetSpecializationInfoByID(specID)
	return icon
end
----------------------------------------------------------------
local TooltipForNpcScan = CreateFrame("GameTooltip", E.MainAddonName.."TooltipForNpcScan", UIParent, "GameTooltipTemplate")
TooltipForNpcScan:Hide()
TooltipForNpcScan:SetOwner(UIParent, "ANCHOR_NONE")
----------------------------------------------------------------
local function func_cached_Name(Cache_Name, id)
	local localeCache = Cache_Name[id]
	return localeCache and localeCache[E.curLocaleLang]
end
local function func_cached_Quality(Cache_Name, id)
	local localeCache = Cache_Name[id]
	return localeCache
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local handler = {}
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
handler.item = function(Cache_Name, Cache_Quality, category, id)
	----------
	-- NAME --
	----------
	local name
	local cached_Name = func_cached_Name(Cache_Name, id)
	if cached_Name then
		name = cached_Name
	else
		name = func_Cache_Name(id, Cache_Name, E.func_GetItemNameByID(id), category)
	end
	-----------
	-- COLOR --
	-----------
	if Octo_ToDo_DB_Vars and Octo_ToDo_DB_Vars.CONFIG_ITEMS_COLOREDNAME then
		local quality
		local cachedQuality = func_cached_Quality(Cache_Quality, id)
		if cachedQuality then
			quality = cachedQuality
		else
			quality = func_Cache_Quality(id, Cache_Quality, E.func_GetItemQualityByID(id), category)
		end
		if type(name) == "string" and name ~= "" and quality then
		    name = E.func_GetQualityHexColor(quality) .. name .. "|r"
		else
		    name = E.COLOR_PURPLE .. L["UNKNOWN"].."|r"
		end
	end
	-----------
	-- OTHER --
	-----------
	-- some code
	------------
	-- RETURN --
	------------
	return name
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
handler.quest = function(Cache_Name, Cache_Quality, category, id)
	----------
	-- NAME --
	----------
	local name
	local cached_Name = func_cached_Name(Cache_Name, id)
	if cached_Name then
		name = cached_Name
	else
		local result = (GetTitleForQuestID or GetQuestInfo)(id)
		if result then
			name = func_Cache_Name(id, Cache_Name, result, category)
		end
	end
	-----------
	-- COLOR --
	-----------
	-- some code
	-----------
	-- OTHER --
	-----------
	-- some code
	------------
	-- RETURN --
	------------
	return name
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
handler.currency = function(Cache_Name, Cache_Quality, category, id)
	----------
	-- NAME --
	----------
	local name
	local cached_Name = func_cached_Name(Cache_Name, id)
	if cached_Name then
		name = cached_Name
	else
		local info = E.func_GetCurrencyInfo(id)
		if info and info.name then
			name = func_Cache_Name(id, Cache_Name, info.name, category)
		end
	end
	-----------
	-- COLOR --
	-----------
	if Octo_ToDo_DB_Vars and Octo_ToDo_DB_Vars.CONFIG_CURRENCY_COLOREDNAME then
		local info = E.func_GetCurrencyInfo(id)
		if info then
			local colorHex = (info.quality and ITEM_QUALITY_COLORS[info.quality].hex) or ITEM_QUALITY_COLORS[1].hex
			name = colorHex..name.."|r"
		end
	end
	-----------
	-- OTHER --
	-----------
	------------
	-- RETURN --
	------------
	return name
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
handler.npc = function(Cache_Name, Cache_Quality, category, id)
	----------
	-- NAME --
	----------
	local name
	local cached_Name = func_cached_Name(Cache_Name, id)
	if cached_Name then
		name = cached_Name
	else
		TooltipForNpcScan:ClearLines()
		TooltipForNpcScan:SetHyperlink("unit:Creature-0-0-0-0-"..id)
		local result
		if TooltipForNpcScan:NumLines() > 0 then
			result = _G[E.MainAddonName.."TooltipForNpcScanTextLeft1"]:GetText()
		end
		if result and result ~= "" then
			name = func_Cache_Name(id, Cache_Name, result, category)
		elseif E.OctoTable_AllNPCs_DB and E.OctoTable_AllNPCs_DB[id] then
			if E.OctoTable_AllNPCs_DB[id][E.curLocaleLang] then
				name = E.OctoTable_AllNPCs_DB[id][E.curLocaleLang].." (DB)|r"
			elseif E.OctoTable_AllNPCs_DB[id]["enUS"] then
				name = E.OctoTable_AllNPCs_DB[id]["enUS"].." (enUS)|r"
			end
		end
	end
	-----------
	-- COLOR --
	-----------
	-- some code
	-----------
	-- OTHER --
	-----------
	-- some code
	------------
	-- RETURN --
	------------
	return name
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
handler.reputation = function(Cache_Name, Cache_Quality, category, id)
	----------
	-- NAME --
	----------
	local name
	local cached_Name = func_cached_Name(Cache_Name, id)
	if cached_Name then
		name = cached_Name
	else
		local repInfo = GetFactionDataByID and GetFactionDataByID(id)
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
			name = func_Cache_Name(id, Cache_Name, result, category)
		elseif GetFactionInfoByID and GetFactionInfoByID(id) then -- 10.2.7
			local n = GetFactionInfoByID(id)
			if type(n) == "string" then
				name = n
			end
			-- name = func_Cache_Name(id, Cache_Name, result, category)
		elseif E.OctoTable_Reputations_DB and E.OctoTable_Reputations_DB[id] then
			if E.OctoTable_Reputations_DB[id][E.curLocaleLang] then
				name = E.OctoTable_Reputations_DB[id][E.curLocaleLang]..E.COLOR_SLATEGRAY.." (DB)|r"
			elseif E.OctoTable_Reputations_DB[id]["enUS"] then
				name = E.OctoTable_Reputations_DB[id]["enUS"]..E.COLOR_SKYBLUE.." (enUS)|r"
			end
		end
	end
	-----------
	-- COLOR --
	-----------
	-- some code
	-----------
	-- OTHER --
	-----------
	-- some code
	------------
	-- RETURN --
	------------
	return name
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
handler.spell = function(Cache_Name, Cache_Quality, category, id)
	----------
	-- NAME --
	----------
	local name
	local cached_Name = func_cached_Name(Cache_Name, id)
	if cached_Name then
		name = cached_Name
	else
		local result = E.func_GetSpellName(id) or E.func_GetSpellInfo(id)
		if GetSpellName and GetSpellName(id) then
			result = GetSpellName(id)
		elseif GetSpellInfo and GetSpellInfo(id) then
			result = GetSpellInfo(id)
			-- /dump GetSpellInfo(20271)
		end
		name = func_Cache_Name(id, Cache_Name, result, category)
	end
	-----------
	-- COLOR --
	-----------
	-- some code
	-----------
	-- OTHER --
	-----------
	-- some code
	------------
	-- RETURN --
	------------
	return name
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
handler.achievement = function(Cache_Name, Cache_Quality, category, id)
	----------
	-- NAME --
	----------
	local name
	local cached_Name = func_cached_Name(Cache_Name, id)
	if cached_Name then
		name = cached_Name
	else
		local name
		name = func_Cache_Name(id, Cache_Name, select(2, GetAchievementInfo(id)), category)
	end
	-----------
	-- COLOR --
	-----------
	-- some code
	-----------
	-- OTHER --
	-----------
	-- some code
	------------
	-- RETURN --
	------------
	return name
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
handler.mount = function(Cache_Name, Cache_Quality, category, id)
	----------
	-- NAME --
	----------
	local name
	local cached_Name = func_cached_Name(Cache_Name, id)
	if cached_Name then
		name = cached_Name
	else
		local name
		name = func_Cache_Name(id, Cache_Name, E.func_GetMountInfoByID(id), category)
	end
	-----------
	-- COLOR --
	-----------
	-- some code
	-----------
	-- OTHER --
	-----------
	-- some code
	------------
	-- RETURN --
	------------
	return name
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
handler.map = function(Cache_Name, Cache_Quality, category, id)
	----------
	-- NAME --
	----------
	local name
	local cached_Name = func_cached_Name(Cache_Name, id)
	if cached_Name then
		name = cached_Name
	else
		local name
		local info = GetMapInfo(id)
		local result = info and info.name or ""
		name = func_Cache_Name(id, Cache_Name, result, category)
	end
	-----------
	-- COLOR --
	-----------
	-- some code
	-----------
	-- OTHER --
	-----------
	-- some code
	------------
	-- RETURN --
	------------
	return name
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
handler.profession = function(Cache_Name, Cache_Quality, category, id)
	----------
	-- NAME --
	----------
	local name
	local cached_Name = func_cached_Name(Cache_Name, id)
	if cached_Name then
		name = cached_Name
	else
		local name
		name = func_Cache_Name(id, Cache_Name, GetTradeSkillDisplayName(id), category)
	end
	-----------
	-- COLOR --
	-----------
	-- some code
	-----------
	-- OTHER --
	-----------
	-- some code
	------------
	-- RETURN --
	------------
	return name
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
handler.dungeon = function(Cache_Name, Cache_Quality, category, id)
	----------
	-- NAME --
	----------
	local name
	local cached_Name = func_cached_Name(Cache_Name, id)
	if cached_Name then
		name = cached_Name
	else
		name = func_Cache_Name(id, Cache_Name, GetRealZoneText(id), category)
	end
	-----------
	-- COLOR --
	-----------
	-- some code
	-----------
	-- OTHER --
	-----------
	-- some code
	------------
	-- RETURN --
	------------
	return name
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
handler.difficulty = function(Cache_Name, Cache_Quality, category, id)
	----------
	-- NAME --
	----------
	local name
	local cached_Name = func_cached_Name(Cache_Name, id)
	if Octo_ToDo_DB_Vars and Octo_ToDo_DB_Vars.CONFIG_RAIDS_DIFFICULTIES_ABBREVIATIONS then
		name = E.OctoTable_Difficulties and E.OctoTable_Difficulties[id] and E.OctoTable_Difficulties[id].abbr or func_Cache_Name(id, Cache_Name, GetDifficultyInfo(id), category)
	else
		if cached_Name then
			name = cached_Name
		else
			name = func_Cache_Name(id, Cache_Name, GetDifficultyInfo(id), category)
		end
	end
	-----------
	-- COLOR --
	-----------
	-- some code
	-----------
	-- OTHER --
	-----------
	-- some code
	------------
	-- RETURN --
	------------
	return name
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
handler.covenant = function(Cache_Name, Cache_Quality, category, id)
	----------
	-- NAME --
	----------
	local name
	local cached_Name = func_cached_Name(Cache_Name, id)
	if cached_Name then
		name = cached_Name
	else
		if E.OctoTable_Covenant and E.OctoTable_Covenant[id] then
			local result = E.OctoTable_Covenant[id].name
			if result then
				name = func_Cache_Name(id, Cache_Name, result, category)
			end
		end
	end
	-----------
	-- COLOR --
	-----------
	-- some code
	-----------
	-- OTHER --
	-----------
	-- some code
	------------
	-- RETURN --
	------------
	return name
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
handler.class = function(Cache_Name, Cache_Quality, category, id)
	----------
	-- NAME --
	----------
	local name
	local cached_Name = func_cached_Name(Cache_Name, id)
	if cached_Name then
		name = cached_Name
	else
		local className, classFile = GetClassInfo(id)
		if className and classFile then
			name = func_Cache_Name(id, Cache_Name, className, category)
		end
	end
	-----------
	-- COLOR --
	-----------
	-- some code
	-----------
	-- OTHER --
	-----------
	-- some code
	------------
	-- RETURN --
	------------
	return name
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
handler.specialization = function(Cache_Name, Cache_Quality, category, id)
	----------
	-- NAME --
	----------
	local name
	local cached_Name = func_cached_Name(Cache_Name, id)
	if cached_Name then
		name = cached_Name
	else
		local _, specName = GetSpecializationInfoByID(id)
		if specName then
			name = func_Cache_Name(id, Cache_Name, specName, category)
		end
	end
	-----------
	-- COLOR --
	-----------
	-- some code
	-----------
	-- OTHER --
	-----------
	-- some code
	------------
	-- RETURN --
	------------
	return name
end

handler.challenge = function(Cache_Name, Cache_Quality, category, id)
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
	local name
	local cached_Name = func_cached_Name(Cache_Name, id)
	if cached_Name then
		name = cached_Name
	else
		local n = GetMapUIInfo(id)
		if n and n ~= "" then
			name = func_Cache_Name(id, Cache_Name, n, category)
		end
	end
	return name

end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- /dump E.func_GetName("global", L["DONE"])
-- handler.global = function(Cache_Name, Cache_Quality, category, id)
-- local name = func_Cache_Name(id, Cache_Name, specName, category)
-- return name
-- end
----------------------------------------------------------------
function E.func_GetName(category, id, forcedQuality)
	if not id then return "no id" end
	id = tonumber(id)
	if type(id) ~= "number" then return "wrong id type" end
	if not category then return "not category" end
	local name
	local Cache_Name    = GetOrCreateCache_Name(category)
	local Cache_Quality = GetOrCreateCache_Quality(category)
	-- local localeCache = Cache_Name[id]
	-- local cached_Name = localeCache and localeCache[E.curLocaleLang]
	-- if cached_Name then
	-- name = cached_Name
	-- else
	local h = handler[category] or handler[category:lower()]
	if h then
		name = h(Cache_Name, Cache_Quality, category, id)
	end
	-- end
	if forcedQuality and name then
		name = func_ForcedQuality(name, forcedQuality)
	end
	local debugTEXT = E.debugInfo and E.debugInfo(id) or ""
	name = name or E.COLOR_RED..L["UNKNOWN"].."|r"
	----------------
	if category == "currency" then
		local hasMount = Octo_ToDo_DB_Vars and Octo_ToDo_DB_Vars.Config_MountsInTooltip and E.OctoTable_CurrencyMountForFuncCurName[id] or false
		if Octo_ToDo_DB_Vars and Octo_ToDo_DB_Vars.Config_MountsInTooltip and (id == 3252 or id == 1166 or id == 2778) then
			hasMount = true
		end
		name = name..(hasMount and E.COLOR_RED.."*|r" or "")
	end
	----------------
	-- if type(name) ~= "string" then
	-- 	error()
	-- end
	local result = name -- E.func_translit and E.func_translit(name) or name
	return result..debugTEXT
end
----------------------------------------------------------------
function E.func_GetIcon(category, id)
	local icon -- = E.ICON_QUESTION_MARK -- or E.ICON_EMPTY
	if id and category and type(id) == "number" then
		if category == "currency" then --  and Octo_ToDo_DB_Vars.CONFIG_CURRENCY_ICON
			local info = E.func_GetCurrencyInfo(id)
			icon = (info and info.iconFileID) or icon
		elseif category == "item" then -- and Octo_ToDo_DB_Vars.CONFIG_ITEMS_ICON
			icon = E.func_GetItemIconByID(id) or icon
		elseif category == "spell" then
			icon = E.func_GetSpellTexture(id) or icon
		elseif category == "reputation" then
			icon = E.ICON_TABARD
		elseif category == "challenge" then
			local texture = select(4, GetMapUIInfo(id))
			icon = texture
		end
	end

	return icon
end
----------------------------------------------------------------
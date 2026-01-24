local GlobalAddonName, E = ...
----------------------------------------------------------------
local L = E.L
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
local LibTranslit = LibStub("LibTranslit-1.0")
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
EventFrame.measureFrame = CreateFrame("Frame")
EventFrame.measureFrame:Hide()
EventFrame.measureFrame:SetParent(UIParent)
EventFrame.measureFrame:SetScale(UIParent:GetEffectiveScale())
EventFrame.measureText = EventFrame.measureFrame:CreateFontString()
EventFrame.measureText:SetFontObject(OctoFont11)
EventFrame.measureText:SetWordWrap(false)
local measureText = EventFrame.measureText
----------------------------------------------------------------
local utf8len, utf8sub, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8upper, string.utf8lower
local strsplit = strsplit
local GetClassColor = GetClassColor or C_ClassColor.GetClassColor
local DoesAddOnExist = DoesAddOnExist or C_AddOns.DoesAddOnExist
local EnableAddOn = EnableAddOn or C_AddOns.EnableAddOn
local GetAddOnMetadata = GetAddOnMetadata or C_AddOns.GetAddOnMetadata
local IsAddOnLoaded = IsAddOnLoaded or C_AddOns.IsAddOnLoaded
local LoadAddOn = LoadAddOn or C_AddOns.LoadAddOn
local GetItemCooldown = GetItemCooldown or C_Item.GetItemCooldown
local GetItemCount = GetItemCount or C_Item.GetItemCount
local GetItemIconByID = GetItemIconByID or C_Item.GetItemIconByID
local GetItemInfo = GetItemInfo or C_Item.GetItemInfo
local GetItemNameByID = GetItemNameByID or C_Item.GetItemNameByID
local GetItemQualityByID = GetItemQualityByID or C_Item.GetItemQualityByID
local GetItemQualityColor = GetItemQualityColor or C_Item.GetItemQualityColor
local IsAnimaItemByID = IsAnimaItemByID or C_Item.IsAnimaItemByID
local GetDetailedItemLevelInfo = GetDetailedItemLevelInfo or C_Item.GetDetailedItemLevelInfo
local GetSpellCooldown = GetSpellCooldown or C_Spell.GetSpellCooldown
local GetSpellName = GetSpellName or C_Spell.GetSpellName
local GetSpellSubtext = GetSpellSubtext or C_Spell.GetSpellSubtext
local GetSpellTexture = GetSpellTexture or C_Spell.GetSpellTexture
local GetSpellCharges = GetSpellCharges or C_Spell.GetSpellCharges
local IsSpellKnown = IsSpellKnown
local GetCurrencyInfo = GetCurrencyInfo or C_CurrencyInfo.GetCurrencyInfo
local IsAccountWideCurrency = IsAccountWideCurrency or C_CurrencyInfo.IsAccountWideCurrency
local IsAccountTransferableCurrency = IsAccountTransferableCurrency or C_CurrencyInfo.IsAccountTransferableCurrency
local GetQuestInfo = GetQuestInfo or C_QuestLog.GetQuestInfo
local GetTitleForQuestID = GetTitleForQuestID or C_QuestLog.GetTitleForQuestID
local IsQuestFlaggedCompleted = IsQuestFlaggedCompleted or C_QuestLog.IsQuestFlaggedCompleted
local IsQuestFlaggedCompletedOnAccount = IsQuestFlaggedCompletedOnAccount or C_QuestLog.IsQuestFlaggedCompletedOnAccount
local IsComplete = IsComplete or C_QuestLog.IsComplete
local IsOnQuest = IsOnQuest or C_QuestLog.IsOnQuest
local GetQuestObjectives = GetQuestObjectives or C_QuestLog.GetQuestObjectives
local GetInfo = GetInfo or C_QuestLog.GetInfo
local IsAccountQuest = IsAccountQuest or C_QuestLog.IsAccountQuest
local IsFailed = IsFailed or C_QuestLog.IsFailed
local GetNumQuestLogEntries = GetNumQuestLogEntries or C_QuestLog.GetNumQuestLogEntries
local GetMaxNumQuestsCanAccept = GetMaxNumQuestsCanAccept or C_QuestLog.GetMaxNumQuestsCanAccept
local GetFactionDataByID = GetFactionDataByID or C_Reputation.GetFactionDataByID
local IsFactionParagon = IsFactionParagon or C_Reputation.IsFactionParagon
local GetFactionParagonInfo = GetFactionParagonInfo or C_Reputation.GetFactionParagonInfo
local IsAccountWideReputation = IsAccountWideReputation or C_Reputation.IsAccountWideReputation
local IsMajorFaction = IsMajorFaction or C_Reputation.IsMajorFaction
local GetMajorFactionData = GetMajorFactionData or C_MajorFactions.GetMajorFactionData
local GetFriendshipReputation = GetFriendshipReputation or C_GossipInfo.GetFriendshipReputation
local GetFriendshipReputationRanks = GetFriendshipReputationRanks or C_GossipInfo.GetFriendshipReputationRanks
local GetCovenantData = GetCovenantData or C_Covenants.GetCovenantData
local GetTradeSkillDisplayName = GetTradeSkillDisplayName or C_TradeSkillUI.GetTradeSkillDisplayName
local GetTradeSkillTexture = GetTradeSkillTexture or C_TradeSkillUI.GetTradeSkillTexture
local GetMapInfo = GetMapInfo or C_Map.GetMapInfo
local GetMapGroupID = GetMapGroupID or C_Map.GetMapGroupID
local GetMapGroupMembersInfo = GetMapGroupMembersInfo or C_Map.GetMapGroupMembersInfo
local GetCurrentCalendarTime = GetCurrentCalendarTime or C_DateAndTime.GetCurrentCalendarTime
local GetSecondsUntilWeeklyReset = GetSecondsUntilWeeklyReset or C_DateAndTime.GetSecondsUntilWeeklyReset
local GetWeeklyResetStartTime = GetWeeklyResetStartTime or C_DateAndTime.GetWeeklyResetStartTime
local GetHolidayInfo = C_Calendar.GetHolidayInfo
local GetDayEvent = C_Calendar.GetDayEvent
local GetMonthInfo = C_Calendar.GetMonthInfo
local SetAbsMonth = C_Calendar.SetAbsMonth
local GetNumDayEvents = GetNumDayEvents or C_Calendar.GetNumDayEvents
local GetBuildingInfo = GetBuildingInfo or C_Garrison.GetBuildingInfo
local IsFollowerOnCompletedMission = IsFollowerOnCompletedMission or C_Garrison.IsFollowerOnCompletedMission
local GetFollowerNameByID = GetFollowerNameByID or C_Garrison.GetFollowerNameByID -- (garrFollowerID)
local GetPlayerAuraBySpellID = GetPlayerAuraBySpellID or C_UnitAuras.GetPlayerAuraBySpellID
-- local GetFollowerName = GetFollowerName or C_Garrison.GetFollowerName -- (followerID)
local GetMountIDs = C_MountJournal.GetMountIDs
local GetMountInfoByID = C_MountJournal.GetMountInfoByID
local GetMountInfoExtraByID = C_MountJournal.GetMountInfoExtraByID
local GetMountFromItem = C_MountJournal.GetMountFromItem
----------------------------------------------------------------
local GetCurrentAffixes = GetCurrentAffixes or C_MythicPlus.GetCurrentAffixes
local GetCurrentSeason = GetCurrentSeason or C_MythicPlus.GetCurrentSeason
local GetCurrentSeasonValues = GetCurrentSeasonValues or C_MythicPlus.GetCurrentSeasonValues
local GetCurrentUIDisplaySeason = GetCurrentUIDisplaySeason or C_MythicPlus.GetCurrentUIDisplaySeason
local GetEndOfRunGearSequenceLevel = GetEndOfRunGearSequenceLevel or C_MythicPlus.GetEndOfRunGearSequenceLevel
local GetLastWeeklyBestInformation = GetLastWeeklyBestInformation or C_MythicPlus.GetLastWeeklyBestInformation
local GetOwnedKeystoneChallengeMapID = GetOwnedKeystoneChallengeMapID or C_MythicPlus.GetOwnedKeystoneChallengeMapID
local GetOwnedKeystoneLevel = GetOwnedKeystoneLevel or C_MythicPlus.GetOwnedKeystoneLevel
local GetOwnedKeystoneMapID = GetOwnedKeystoneMapID or C_MythicPlus.GetOwnedKeystoneMapID
local GetRewardLevelForDifficultyLevel = GetRewardLevelForDifficultyLevel or C_MythicPlus.GetRewardLevelForDifficultyLevel
local GetRewardLevelFromKeystoneLevel = GetRewardLevelFromKeystoneLevel or C_MythicPlus.GetRewardLevelFromKeystoneLevel
local GetRunHistory = GetRunHistory or C_MythicPlus.GetRunHistory
local GetSeasonBestAffixScoreInfoForMap = GetSeasonBestAffixScoreInfoForMap or C_MythicPlus.GetSeasonBestAffixScoreInfoForMap
local GetSeasonBestForMap = GetSeasonBestForMap or C_MythicPlus.GetSeasonBestForMap
local GetSeasonBestMythicRatingFromThisExpansion = GetSeasonBestMythicRatingFromThisExpansion or C_MythicPlus.GetSeasonBestMythicRatingFromThisExpansion
local GetWeeklyBestForMap = GetWeeklyBestForMap or C_MythicPlus.GetWeeklyBestForMap
local GetWeeklyChestRewardLevel = GetWeeklyChestRewardLevel or C_MythicPlus.GetWeeklyChestRewardLevel
local IsMythicPlusActive = IsMythicPlusActive or C_MythicPlus.IsMythicPlusActive
local RequestCurrentAffixes = RequestCurrentAffixes or C_MythicPlus.RequestCurrentAffixes
local RequestMapInfo = RequestMapInfo or C_MythicPlus.RequestMapInfo
local RequestRewards = RequestRewards or C_MythicPlus.RequestRewards
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_GetAtlasIcon(atlasName, iconWidth, iconHeight)
	if not atlasName then return end
	local iconWidth = iconWidth or 16
	local iconHeight = iconHeight or 16
	return CreateAtlasMarkup(atlasName, iconWidth, iconHeight)
end
function E.func_GetItemIcon(itemID)
	local texture = GetItemIconByID(itemID) or E.ICON_QUESTION_MARK
	return texture
end
function E.func_GetSpellIcon(spellID)
	local texture = GetSpellTexture(spellID) or E.ICON_QUESTION_MARK
	return texture
end
function E.func_GetCurrencyIcon(currencyID)
	local info = GetCurrencyInfo(currencyID)
	return info and info.iconFileID or E.ICON_EMPTY
end
function E.func_IsAccountQuest(questID)
	if not questID then
		return false
	end
	return IsAccountQuest(questID)
end
function E.func_IsQuestFlaggedCompletedOnAccount(questID)
	return IsQuestFlaggedCompletedOnAccount(questID)
end
function E.func_GetItemData(itemInfo)
	return GetItemInfo(itemInfo)
end
function E.func_GetItemQuantity(itemID, includeBank, includeUses, includeReagentBank, includeAccountBank)
	if not itemID then return end
	return GetItemCount(itemID, includeBank, includeUses, includeReagentBank, includeAccountBank)
end
function E.func_GetItemHyperlink(itemID)
	local _, link = E.func_GetItemData(itemID)
	return link
end
function E.func_GetItemQualityLevel(itemID)
	return GetItemQualityByID(itemID) or 0
end
function E.func_GetItemQualityColorTable(itemID)
	return ITEM_QUALITY_COLORS[E.func_GetItemQualityLevel(itemID)]
end
function E.func_GetQualityHexColor(quality)
	local numQuality = tonumber(quality)
	if numQuality and numQuality > 0 and numQuality < 8 then
		return ITEM_QUALITY_COLORS[numQuality].hex
	end
	return E.COLOR_WHITE
end
----------------------------------------------------------------
function E.func_GetQualityColorRGB(quality)
	local r, g, b = GetItemQualityColor(quality)
	return r, g, b
end
----------------------------------------------------------------
function E.func_IsAnimaItemByID(itemID)
	return IsAnimaItemByID(itemID)
end
----------------------------------------------------------------
function E.func_GetItemLevelDetails(itemID)
	return GetDetailedItemLevelInfo(itemID)
end
----------------------------------------------------------------
function E.func_GetItemCooldown(itemID)
	local start, duration = GetItemCooldown(itemID)
	local result = 0
	if start > 0 and duration > 0 then
		result = (start + duration - GetTime())
	end
	return E.func_CompactRoundNumber(result)
end
----------------------------------------------------------------
function E.func_GetSpellDescription(spellID)
	local result = GetSpellSubtext(spellID)
	return result
end
----------------------------------------------------------------
function E.func_GetSpellCooldown(spellID)
	local start = GetSpellCooldown(spellID).startTime
	local duration = GetSpellCooldown(spellID).duration
	local result = 0
	if start > 0 and duration > 0 then
		result = (start + duration - GetTime())
	end
	return E.func_CompactRoundNumber(result)
end
----------------------------------------------------------------
function E.func_RGB2Hex(r, g, b, a)
	local r = r or 1
	local g = g or 1
	local b = b or 1
	local a = a or 1
	if not a then
		a = 1
	end
	return "|c"..string.format("%02x", math.floor(a*255))..utf8upper(string.format("%02x%02x%02x", math.floor(r*255), math.floor(g*255), math.floor(b*255)))
end
----------------------------------------------------------------
function E.func_Hex2RGBA(hex, forcedAlpha)
	if not hex or hex == "" or not hex:match("^|c") or #hex < 10 then
		return 1, 1, 1, 1
	end
	-- Формат: |cAARRGGBB
	-- Берем только hex часть после |c (10 символов всего)
	local a = tonumber(hex:sub(3, 4), 16) or 255 -- AA

	local r = tonumber(hex:sub(5, 6), 16) or 255 -- RR
	local g = tonumber(hex:sub(7, 8), 16) or 255 -- GG
	local b = tonumber(hex:sub(9, 10), 16) or 255 -- BB

	return r/255, g/255, b/255, forcedAlpha or a/255
end
----------------------------------------------------------------
function E.func_Hex2ColorTable(hex, forcedAlpha)
	local r, g, b, a = E.func_Hex2RGBA(hex)
	return {r = r, g = g, b = b, a = forcedAlpha or a}
end
----------------------------------------------------------------
function E.func_RGB2HexString(r, g, b, a)
	local r, g, b, a = r, g, b, a
	if not a then
		a = 1
	end
	return utf8upper(string.format("%02x%02x%02x", math.floor(r*255), math.floor(g*255), math.floor(b*255)))
end
----------------------------------------------------------------
function E.func_GetNextResetTime(time)
	local time = time or 1
	local daytime = 86400
	local thursdayReset = GetWeeklyResetStartTime()
	return (math.ceil((GetServerTime() - thursdayReset)/(daytime*time))*daytime*time)+thursdayReset
end
function E.func_GetSecondsToWeeklyReset()
	return GetSecondsUntilWeeklyReset()
end
function E.func_IsOnQuest(id)
	return IsOnQuest(id)
end
function E.func_IsAchievementCompleted(id)
	if not id then
		return false
	end
	local completed = select(4, GetAchievementInfo(id))
	return completed
end
function E.func_EncodeCoordinates(x, y)
	return math.floor(x * 10000 + 0.5) * 10000 + math.floor(y * 10000 + 0.5)
end
function E.func_FormatCoordinates(x, y)
	if not x or not y then return "" end
	if x == 0 or y == 0 then
		return ""
	end
	return string.format("%.1f / %.1f", x * 100, y * 100)
end
function E.func_UnpackCoordinates(packed)
	if not packed or packed == 0 then
		return nil, nil
	end
	local packedStr = tostring(packed)
	if #packedStr ~= 8 then
		return nil, nil
	end
	local x = tonumber(packedStr:sub(1, 4)) / 10000
	local y = tonumber(packedStr:sub(5, 8)) / 10000
	return x, y -- Возвращаем ДВА ЧИСЛА
end
function E.func_ReversSort(a, b)
	return b < a
end
function E.func_GetMaxRenownLevel(reputationID)
	local levels = C_MajorFactions.GetRenownLevels(reputationID)
	if levels then
		return levels[#levels].level
	end
end
function E.func_GetNumQuestLogEntries()
	local numShownEntries, numQuests = C_QuestLog.GetNumQuestLogEntries()
	return numShownEntries
end
-- /run E.func_GetQuestLogCount()
function E.func_GetQuestLogCount()
	local numQuests = 0
	local numShownEntries = E.func_GetNumQuestLogEntries()
	for i = 1, numShownEntries do
		local info = GetInfo(i)
		numQuests = numQuests + (info and info.frequency and info.questID ~= 0 and not info.isHeader and not info.isHidden and 1 or 0)
	end
	return numQuests
end
function E.func_GetMaxNumQuestsCanAccept()
	local result = GetMaxNumQuestsCanAccept()
	return result
end
function E.func_GetAddOnMetadata(name, variable)
	return GetAddOnMetadata(name, variable)
end
function E.func_IsAddOnLoaded(AddonNameOrIndex)
	return IsAddOnLoaded(AddonNameOrIndex)
end
function E.func_LoadAddOnForced(AddonName)
	if DoesAddOnExist(AddonName) and not E.func_IsAddOnLoaded(AddonName) then
		EnableAddOn(AddonName)
		LoadAddOn(AddonName)
	end
end
function E.func_GetCurrentExpansion()
	if LE_EXPANSION_LEVEL_CURRENT ~= nil then
		return LE_EXPANSION_LEVEL_CURRENT+1
	else
		return 1
	end
end
function E.func_FormatLastSeen(time, color)
	if not time then
		return FRIENDS_LIST_OFFLINE
	else
		return string.format(BNET_LAST_ONLINE_TIME, color..E.func_FormatTimeAgo(time).."|r")
	end
end
function E.func_FormatTimeAgo(timeDiff, isAbsolute)
	if not isAbsolute then
		timeDiff = time() - timeDiff
	end
	if timeDiff < SECONDS_PER_MIN then
		return LASTONLINE_SECS
	elseif timeDiff < SECONDS_PER_HOUR then
		return format(LASTONLINE_MINUTES, math.floor(timeDiff / SECONDS_PER_MIN))
	elseif timeDiff < SECONDS_PER_DAY then
		return format(LASTONLINE_HOURS, math.floor(timeDiff / SECONDS_PER_HOUR))
	elseif timeDiff < SECONDS_PER_MONTH then
		return format(LASTONLINE_DAYS, math.floor(timeDiff / SECONDS_PER_DAY))
	elseif timeDiff < SECONDS_PER_YEAR then
		return format(LASTONLINE_MONTHS, math.floor(timeDiff / SECONDS_PER_MONTH))
	else
		return format(LASTONLINE_YEARS, math.floor(timeDiff / SECONDS_PER_YEAR))
	end
end
function E.func_TableConcat(table1, table2) -- func_ArrayConcatUnsafe
	local len = #table1
	for i = 1, #table2 do
		len = len + 1
		table1[len] = table2[i]
	end
	return table1
end
function E.func_MergeTables(table1, table2)
	for k, v in next, (table2) do
		table1[k] = v
	end
	return table1
end
function E.func_GetTextWithColor(fontstring)
	if not fontstring then return nil end
	local text = fontstring:GetText()
	if not text or text == "" then return nil end
	return E.func_RGB2Hex(fontstring:GetTextColor())..text.."|r"
end
function E.func_FormatDateTwoDigits(date)
	local result = ("%.2d"):format(date)
	return result
end
function E.func_ShouldShow(id, dataType, profileName)
	local shouldShow = false
	if Octo_profileKeys.isSettingsEnabled then
		-- Режим настройки включен - показываем все валюты
		shouldShow = true
	else
		-- Режим настройки выключен - проверяем настройки валют
		local settingsTable = Octo_profileKeys.profiles[profileName][dataType] -- dataType
		if settingsTable then
			-- Проверяем числовой ключ
			if settingsTable[id] then
				shouldShow = true
			end
			-- Проверяем строковый ключ
			if settingsTable[tostring(id)] then
				shouldShow = true
			end
		end
	end
	return shouldShow
end
function E.func_InitField(tbl, field, default)
	if tbl[field] == nil then
		tbl[field] = default
	end
end
function E.func_InitSubTable(tbl, field)
	if type(tbl[field]) ~= "table" then
		tbl[field] = {}
	end
end
function E.func_SpamBlock(...)
	local key = (""):join(tostringall(...))
	local func, needCheckCombat, newSpamTimer = ...
	if type(func) ~= "function" then return end
	local SPAM_TIME = newSpamTimer and newSpamTimer or E.SPAM_TIME
	if (needCheckCombat == nil or needCheckCombat == true) and InCombatLockdown() then
		E._inCombats[key] = true
		return true -- заблочена и добавлена в выполнение после сброса комбата
	end
	local currentTime = GetTime()
	-- когда было последнее выполнение
	if E._spamLocks[key] then
		local timeSinceLast = currentTime - E._spamLocks[key]
		local timeToEnd = SPAM_TIME-timeSinceLast
		if timeSinceLast < SPAM_TIME then
			if not E._callAfterTimer[key] then
				E._callAfterTimer[key] = true;
				C_Timer.After(timeToEnd, function()
						E._callAfterTimer[key] = nil
						E.func_SpamBlock(func, needCheckCombat)
				end)
			end
			return true -- заблочена
		end
	end
	E._spamLocks[key] = currentTime -- Обновляем время последнего выполнения
	func() -- Выполняем функцию
	if E.func_UPDATE_MAINFRAME then
		E.func_UPDATE_MAINFRAME()
	end
	return false -- всё ок
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CreateMinimapButton(AddonName, Saved_Variables, frame, func, frameString)
	local iconName = AddonName:gsub("^Octo_", "")
	local qwe = E.func_GetAddOnMetadata(AddonName, "Title")
	local zxc = E.func_GetAddOnMetadata(AddonName, "Interface")
	local dataBroker = LibStub("LibDataBroker-1.1"):NewDataObject(AddonName, {
			type = "data source",
			icon = "Interface\\AddOns\\"..E.MainAddonName.."\\Media\\IconTexture\\"..iconName,
			OnClick = function(self, button)
				if button == "LeftButton" then
					-- if not InCombatLockdown() then
						Octo_profileKeys.isSettingsEnabled = nil
						if frame then
							if func then
								func()
							else
								frame:SetShown(not frame:IsShown())
							end
							if frame:IsShown() then
								if SettingsPanel:IsVisible() then
									HideUIPanel(SettingsPanel)
								end
								if GameMenuFrame:IsVisible() then
									HideUIPanel(GameMenuFrame)
								end
							end
						end
					-- end
				elseif button == "RightButton" then
					E.func_OpenToCategory(frame)
				end
			end,
			OnTooltipShow = function(tooltip)
				local version = E.func_GetAddOnMetadata(AddonName, "Version")
				local title = E.func_GetAddOnMetadata(AddonName, "Title")
				tooltip:AddLine(("%s (|cffff7f3f%s|r)"):format(title, version))
				tooltip:AddLine(" ")
				tooltip:AddDoubleLine(E.LEFT_MOUSE_ICON..L["LMB:"], HUD_EDIT_MODE_SETTING_ACTION_BAR_VISIBLE_SETTING)
				tooltip:AddDoubleLine(E.RIGHT_MOUSE_ICON..L["RMB:"], GAMEMENU_OPTIONS)
				-- tooltip:AddLine(" ")
				-- tooltip:AddLine(E.COLOR_RED..L["Temporarily disabled in combat"].."|r")
			end,
	})
	if type(Saved_Variables.LibDataBroker) ~= "table" then
		Saved_Variables.LibDataBroker = {}
	end
	if not Saved_Variables.LibDataBroker.minimapPos then
		Saved_Variables.LibDataBroker.minimapPos = random(1, 365)
	end
	LibStub("LibDBIcon-1.0"):Register(AddonName, dataBroker, Saved_Variables.LibDataBroker)
end
function E.func_Gradient(text, firstColor, secondColor)
	if not firstColor then firstColor = E.COLOR_ADDON_LEFT or "|cffD177FF" end
	if not secondColor then secondColor = E.COLOR_ADDON_RIGHT or "|cff63A4E0" end
	local result = ""
	local str = ""
	local total = utf8len(text)-1
	if total > 0 then
		local r1, g1, b1 = E.func_Hex2RGBA(firstColor)
		local r2, g2, b2 = E.func_Hex2RGBA(secondColor)
		local rdelta, gdelta, bdelta = (r2-r1)/total, (g2-g1)/total, (b2-b1)/total
		local r3 = r1
		local g3 = g1
		local b3 = b1
		for i = 1, total do
			str = str..E.func_RGB2Hex(r3, g3, b3)..utf8sub(text, i, i).."|r"
			r3 = r3 + rdelta
			g3 = g3 + gdelta
			b3 = b3 + bdelta
		end
		result = str..secondColor..utf8sub(text, utf8len(text)).."|r"
		return result
	else
		return text
	end
end
function E.func_CountVisibleCharacters()
	local isOnlyCurrentServer = Octo_ToDo_DB_Vars.isOnlyCurrentServer
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	local Config_LevelToShow = Octo_ToDo_DB_Vars.Config_LevelToShow
	local Config_LevelToShowMAX = Octo_ToDo_DB_Vars.Config_LevelToShowMAX
	local isOnlyCurrentFaction = Octo_ToDo_DB_Vars.isOnlyCurrentFaction
	local count = 0
	local curGUID = E.curGUID
	local curFaction = E.FACTION_CURRENT
	local curServer = E.func_GetPlayerRealm()
	local CurrentRegionName = E.CurrentRegionName
	local checkCurrentServer = isOnlyCurrentServer and curServer
	local checkCurrentRegion = ShowOnlyCurrentRegion and CurrentRegionName
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if CharInfo.PlayerData then
			local PlayerData = CharInfo.PlayerData
			if GUID == curGUID then
				count = count + 1
			else
				if PlayerData.isShownPlayer and
				PlayerData.UnitLevel and
				PlayerData.CurrentRegionName and
				PlayerData.curServer and
				PlayerData.Faction then
					local unitLevel = PlayerData.UnitLevel
					local meetsLevel = unitLevel >= Config_LevelToShow and unitLevel <= Config_LevelToShowMAX
					local meetsFaction = not isOnlyCurrentFaction or PlayerData.Faction == curFaction
					local meetsServer = not checkCurrentServer or PlayerData.curServer == curServer
					local meetsRegion = not checkCurrentRegion or PlayerData.CurrentRegionName == CurrentRegionName
					if meetsLevel and meetsFaction and meetsServer and meetsRegion then
						count = count + 1
					end
				end
			end
		end
	end
	return count > 0 and count or 1
end
function E.func_SortCharacters()
	local isOnlyCurrentServer = Octo_ToDo_DB_Vars.isOnlyCurrentServer
	local ShowOnlyCurrentRegion = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
	local Config_LevelToShow = Octo_ToDo_DB_Vars.Config_LevelToShow
	local Config_LevelToShowMAX = Octo_ToDo_DB_Vars.Config_LevelToShowMAX
	local isOnlyCurrentFaction = Octo_ToDo_DB_Vars.isOnlyCurrentFaction
	local sorted = {}
	local curGUID = E.curGUID
	local curFaction = E.FACTION_CURRENT
	local curServer = E.func_GetPlayerRealm()
	local CurrentRegionName = E.CurrentRegionName
	local checkCurrentServer = isOnlyCurrentServer and curServer
	local checkCurrentRegion = ShowOnlyCurrentRegion and CurrentRegionName
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if not CharInfo.PlayerData then
		else
			local PlayerData = CharInfo.PlayerData
			if GUID == curGUID then
				sorted[#sorted + 1] = CharInfo
			else
				if PlayerData.isShownPlayer and
				PlayerData.UnitLevel and
				PlayerData.CurrentRegionName and
				PlayerData.curServer and
				PlayerData.Faction then
					local unitLevel = PlayerData.UnitLevel
					local meetsLevel = unitLevel >= Config_LevelToShow and unitLevel <= Config_LevelToShowMAX
					local meetsFaction = not isOnlyCurrentFaction or PlayerData.Faction == curFaction
					local meetsServer = not checkCurrentServer or PlayerData.curServer == curServer
					local meetsRegion = not checkCurrentRegion or PlayerData.CurrentRegionName == CurrentRegionName
					if meetsLevel and meetsFaction and meetsServer and meetsRegion then
						sorted[#sorted + 1] = CharInfo
					end
				end
			end
		end
	end
	table.sort(sorted, function(a, b)
			local aData, bData = a.PlayerData, b.PlayerData
			local aLevel = aData.UnitLevel or 0
			local bLevel = bData.UnitLevel or 0
			if aLevel ~= bLevel then
				return aLevel > bLevel
			end
			local aItemLevel = aData.avgItemLevelEquipped or 0
			local bItemLevel = bData.avgItemLevelEquipped or 0
			if aItemLevel ~= bItemLevel then
				return aItemLevel > bItemLevel
			end
			local aName = aData.Name or "noname"
			local bName = bData.Name or "noname"
			return aName < bName
	end)
	return sorted
end
----------------------------------------------------------------
function E.func_GetColorGradient(value, minValue, maxValue)
	if E.PROFTBL.ConfigColor_TOOLTIP_usegradient == nil or E.PROFTBL.ConfigColor_TOOLTIP_usegradient == false then
		return E.COLOR_WHITE
	end
	-- Проверяем, что цвета есть в БД
	if not value
	or not minValue
	or not maxValue
	then
		return E.COLOR_GREEN
	end

	local r_max = E.PROFTBL.ConfigColor_TOOLTIP_max_RGBA_r
	local g_max = E.PROFTBL.ConfigColor_TOOLTIP_max_RGBA_g
	local b_max = E.PROFTBL.ConfigColor_TOOLTIP_max_RGBA_b
	local a_max = E.PROFTBL.ConfigColor_TOOLTIP_max_RGBA_a

	local r_mid = E.PROFTBL.ConfigColor_TOOLTIP_mid_RGBA_r
	local g_mid = E.PROFTBL.ConfigColor_TOOLTIP_mid_RGBA_g
	local b_mid = E.PROFTBL.ConfigColor_TOOLTIP_mid_RGBA_b
	local a_mid = E.PROFTBL.ConfigColor_TOOLTIP_mid_RGBA_a

	local r_min = E.PROFTBL.ConfigColor_TOOLTIP_min_RGBA_r
	local g_min = E.PROFTBL.ConfigColor_TOOLTIP_min_RGBA_g
	local b_min = E.PROFTBL.ConfigColor_TOOLTIP_min_RGBA_b
	local a_min = E.PROFTBL.ConfigColor_TOOLTIP_min_RGBA_a



	if minValue >= maxValue then
		return E.func_RGB2Hex(r_max, g_max, b_max, a_max)
	end
	-- Нормализуем значение
	local p = (value - minValue) / (maxValue - minValue)
	if p < 0 then p = 0 end
	if p > 1 then p = 1 end
	local UseOnlyTwoColor = false
	local r1, g1, b1, r2, g2, b2, t
	if UseOnlyTwoColor then
		-- Два цвета: min -> max
		r1, g1, b1 = r_min, g_min, b_min
		r2, g2, b2 = r_max, g_max, b_max
		t = p
	else
		-- Три цвета: min -> mid -> max
		if p < 0.5 then
			r1, g1, b1 = r_min, g_min, b_min
			r2, g2, b2 = r_mid, g_mid, b_mid
			t = p * 2
		else
			r1, g1, b1 = r_mid, g_mid, b_mid
			r2, g2, b2 = r_max, g_max, b_max
			t = (p - 0.5) * 2
		end
	end
	-- Интерполяция и конвертация в 0-255
	local r = math.floor(Lerp(r1, r2, t) * 255 + 0.5)
	local g = math.floor(Lerp(g1, g2, t) * 255 + 0.5)
	local b = math.floor(Lerp(b1, b2, t) * 255 + 0.5)
	-- return string.format("|cff%02x%02x%02x", r, g, b)
	local result = E.func_RGB2Hex(r/255, g/255, b/255, 1)
	return result
end
----------------------------------------------------------------
function E.func_CleanTable(tbl)
	for k, v in pairs(tbl) do
		if type(v) == "table" then
			prune(v)
			if not next(v) then tbl[k] = nil end
		elseif v == 0 or v == "" then
			tbl[k] = nil
		end
	end
end
----------------------------------------------------------------
function E.func_RemoveEmptyValues(t)
	for k, v in pairs(t) do
		if type(v) == "table" then
			Cleanup(v)
			if next(v) == nil then
				t[k] = nil
			end
		elseif v == 0 or v == "" then
			t[k] = nil
		end
	end
end
----------------------------------------------------------------
function E.func_CleanDeepTable(t, rules)
	if type(t) ~= "table" then return false end
	for k, v in pairs(t) do
		local remove = false
		if type(v) == "table" then
			local empty = E.func_CleanDeepTable(v, rules)
			if empty then
				remove = true
			end
		else
			if rules.zero and v == 0 then remove = true end
			if rules.emptyString and v == "" then remove = true end
			if rules.falseValue and v == false then remove = true end
			if rules.values then
				for _, bad in ipairs(rules.values) do
					if v == bad then
						remove = true
						break
					end
				end
			end
			if rules.strings and type(v) == "string" then
				for _, pattern in ipairs(rules.strings) do
					if v:find(pattern) then
						remove = true
						break
					end
				end
			end
		end
		if remove then
			t[k] = nil
		end
	end
	return next(t) == nil
end
----------------------------------------------------------------
function E.func_SetOrNil(tbl, key, val)
	tbl[key] = (val and val ~= 0) and val or nil
end
----------------------------------------------------------------
function E.func_RemoveZeroValues(tbl, smth)
	-- Проверка входных параметров
	if not tbl or not smth or type(tbl) ~= "table" then return end
	-- Обработка случая когда smth - таблица значений для удаления
	if type(smth) == "table" then
		for q, w in ipairs(smth) do
			for k, value in pairs(tbl) do
				if value == w then -- Точное совпадение значения
					E.func_PrintMessage(k, E.COLOR_YELLOW..tostring(value).."|r")
					tbl[k] = nil -- Удаляем значение
				elseif type(value) == "table" then
					E.func_RemoveZeroValues(value, w) -- Рекурсия для вложенных таблиц
				end
			end
			return tbl
		end
		-- Обработка числовых значений для удаления
	elseif type(smth) == "number" then
		for k, value in pairs(tbl) do
			if value == smth then
				E.func_PrintMessage(k, E.COLOR_PURPLE..tostring(value).."|r")
				tbl[k] = nil
			elseif type(value) == "table" then
				E.func_RemoveZeroValues(value, smth) -- Рекурсия
			end
		end
		return tbl
		-- Обработка строковых шаблонов
	elseif type(smth) == "string" then
		for k, value in pairs(tbl) do
			-- Специальный случай для любых числовых значений
			if value and smth == "anynumber" and type(value) == "number" then
				E.func_PrintMessage(k, E.COLOR_WOW_TOKEN..tostring(value).."|r")
				tbl[k] = nil
			else
				E.func_RemoveZeroValues(value, smth)
			end
			-- Поиск по строковому шаблону
			if value and type(value) == "string" then
				if string.find(value, smth) then
					E.func_PrintMessage(k, E.COLOR_MAGENTA..tostring(value).."|r")
					tbl[k] = nil
				end
			else
				E.func_RemoveZeroValues(value, smth)
			end
		end
		return tbl
	end
end
----------------------------------------------------------------
-- Функция глубокого копирования таблицы
function E.func_CopyTableDeep(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == "table" then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[E.func_CopyTableDeep(orig_key)] = E.func_CopyTableDeep(orig_value)
		end
		setmetatable(copy, E.func_CopyTableDeep(getmetatable(orig)))
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end
----------------------------------------------------------------
function E.func_AddonNameForOptionsInit(addonName)
	-- return E.func_texturefromIcon(E.func_GetAddOnMetadata(addonName, "IconTexture"))..E.func_GetAddOnMetadata(addonName, "Title")
	return E.func_GetAddOnMetadata(addonName, "Title")
end
----------------------------------------------------------------
function E.func_AddonNameForOptionsFunc(addonName)
	return E.func_texturefromIcon(E.func_GetAddOnMetadata(addonName, "IconTexture"))..E.func_GetAddOnMetadata(addonName, "Title").." "..E.COLOR_GRAY..E.func_GetAddOnMetadata(addonName, "Version").."|r"
end
----------------------------------------------------------------
local countSavedVars = 0
function E.func_GetSavedVars(addonName)
	if not (E.SavedVarsByAddon and E.SavedVarsByAddon[addonName]) then
		E.InitGlobalDB(addonName)
	end
	countSavedVars = countSavedVars + 1
	return E.SavedVarsByAddon[addonName]
end
----------------------------------------------------------------
function E.func_RequestUIUpdate(event_name)
	if not E.DebugEvent then return end
	local isMainFrameVisible = Octo_MainFrame and Octo_MainFrame:IsShown()
	if isMainFrameVisible then
		if not E.updateScheduledFlag then
			E.updateScheduledFlag = true
			C_Timer.After(0.1, function()
					E.updateScheduledFlag = false
					if Octo_MainFrame and Octo_MainFrame:IsShown() then
						-- E.func_TODO_CreateDataProvider()
						DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("E.func_RequestUIUpdate ", E.COLOR_GREEN, E.COLOR_YELLOW)..event_name)
					end
			end)
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("E.func_RequestUIUpdate ", E.COLOR_RED, E.COLOR_PURPLE)..event_name)
	end
end
function E.func_GetTimewalkingDungeon()
	local joinable, timewalkDungeonName, result = false, "", ""
	for expID, v in ipairs(E.OctoTable_Expansions) do
		if v.timewalkDungeonID and IsLFGDungeonJoinable(v.timewalkDungeonID) then
			joinable = true
			result = E.func_FormatExpansion(expID)
			timewalkDungeonName = GetLFGDungeonInfo(v.timewalkDungeonID)
			-- break
		end
	end
	return joinable, result, timewalkDungeonName:match("%((.-)%)")
end
function E.func_FormatExpansion(expID, iconSide, fullName)
	local expansion = E.OctoTable_Expansions[expID]
	local expIcon = E.func_texturefromIcon(expansion.icon, 16, 32)
	local color = expansion.color
	local expName = color.. (fullName and expansion.name or expansion.nameVeryShort)
	if iconSide == "LEFT" then
		return expIcon..expName.."|r"
	end
	-- По умолчанию RIGHT
	return expName..expIcon.."|r"
end
----------------------------------------------------------------
function E.func_GetCurrentRegionName()
	local result = GetCurrentRegionName()
	if result == "" then
		result = "PTR "..E.buildVersion
	end
	return result
end
E.CurrentRegionName = E.func_GetCurrentRegionName()
function E.func_RegisterFrame_ICONS(frame)
	E.OctoTable_Frames_ICONS = E.OctoTable_Frames_ICONS or {}
	E.OctoTable_Frames_SIMPLE = E.OctoTable_Frames_SIMPLE or {}
	if not frame or frame.insertIn_SecuredFrames_SequredFrames then return end
	frame.insertIn_SecuredFrames_SequredFrames = true
	table.insert(E.OctoTable_Frames_ICONS, frame)
	table.insert(UISpecialFrames, frame:GetName())
	C_Timer.After(0, function()
			frame:HookScript("OnShow", function()
					for i, other in ipairs(E.OctoTable_Frames_ICONS) do
						if frame ~= other and other:IsShown() then
							other:Hide()
						end
					end
			end)
			frame:HookScript("OnHide", function()
					if E.OctoTable_Frames_SIMPLE then
						for i, other in ipairs(E.OctoTable_Frames_SIMPLE) do
							if other:IsShown() then
								other:Hide()
							end
						end
					end
			end)
	end)
end
function E.func_RegisterFrame_SIMPLE(frame)
	E.OctoTable_Frames_ICONS = E.OctoTable_Frames_ICONS or {}
	E.OctoTable_Frames_SIMPLE = E.OctoTable_Frames_SIMPLE or {}
	if not frame or frame.insertIn_SecuredFrames_SequredFrames then return end
	frame.insertIn_SecuredFrames_SequredFrames = true
	table.insert(E.OctoTable_Frames_SIMPLE, frame)
	table.insert(UISpecialFrames, frame:GetName())
end
function E.func_GetPlayerRealm()
	local result = GetRealmName()
	if E.func_IsRemix() then
		result = result.." (Remix)"
	end
	return result
end
function E.SafeCall(func, ...)
	local success, result = pcall(func,...)
	if not success then
		-- Логирование ошибки
		return nil
	end
	return result
end
function E.func_AddTooltipSeparator(tooltip)
	if not tooltip then return end
	if #tooltip > 0 then
		tooltip[#tooltip+1] = {" "}
	end
	return
end
----------------------------------------------------------------
function E.func_GetMinMaxValue(tbl, data)
	if type(tbl) ~= "table" then
		return nil, nil
	end
	local minValue, maxValue
	for _, v in next, tbl do
		local value = (type(v) == "table" and v[data]) or 0
		if minValue == nil or value < minValue then
			minValue = value
		end
		if maxValue == nil or value > maxValue then
			maxValue = value
		end
	end
	return minValue, maxValue
end
----------------------------------------------------------------
-- Функция показа сообщения
function E.func_PrintMessage(...)
	-- Используем стандартное сообщение WoW или создаем свое
	-- UIErrorsFrame:AddMessage(E.func_Gradient(text), 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)
	-- DEFAULT_CHAT_FRAME:AddMessage(E.func_GetAddOnMetadata(E.MainAddonName, "Title")..": "..text)
	-- DEFAULT_CHAT_FRAME:AddMessage(...)
	print(...)
end
function E.InitGlobalDB(addonName)
	local savedVarName = addonName.."_DB"
	_G[savedVarName] = _G[savedVarName] or {}
	-- Защита от повторов
	for _, entry in ipairs(E.OctoTable_SavedVariables or {}) do
		if entry.name == savedVarName then
			E.SavedVarsByAddon = E.SavedVarsByAddon or {}
			E.SavedVarsByAddon[addonName] = _G[savedVarName]
			return _G[savedVarName], savedVarName
		end
	end
	E.OctoTable_SavedVariables = E.OctoTable_SavedVariables or {}
	table.insert(E.OctoTable_SavedVariables, {
			tbl = _G[savedVarName],
			name = savedVarName
	})
	E.SavedVarsByAddon = E.SavedVarsByAddon or {}
	E.SavedVarsByAddon[addonName] = _G[savedVarName]
	return _G[savedVarName], savedVarName
end
function E.func_FormatMountInfo(mountID)
	local mountIconNumber = E.func_GetMountTexture(mountID)
	local mountIcon = E.func_texturefromIcon(mountIconNumber)
	local mountName = mountIcon..E.func_GetMountCollectedColor(mountID)..E.func_GetMountName(mountID).."|r"
	return mountName
end
function E.func_FormatMoney(number)
	if not number then return 0 end
	if number > 10000 then
		return E.func_CompactFormatNumber(number/10000).."|r".."|TInterface\\MoneyFrame\\UI-GoldIcon:12:12|t"
	elseif number > 100 then
		return E.func_CompactFormatNumber(number/100).."|r".."|TInterface\\MoneyFrame\\UI-SilverIcon:12:12|t"
	else
		return E.func_CompactFormatNumber(number).."|r".."|TInterface\\MoneyFrame\\UI-CopperIcon:12:12|t"
	end
end
function E.func_CompactRoundNumber(number)
	local number = number or 0
	if number == 0 then
		return 0
	else
		return math.floor(number+.5)
	end
end
function E.func_SecondsToClock(time, allwaysShowSeconds)
	local time = tonumber(time) or 0
	if time <= 0 then
		return ""
	end
	local years = math.floor(time / 31536000)
	local days = math.floor(time % 31536000 / 86400)
	local hours = math.floor(time % 86400 / 3600)
	local mins = math.floor(time % 3600 / 60)
	local secs = math.floor(time % 60)
	local ms = time - math.floor(time)
	local parts = {}
	if years > 0 then
		table.insert(parts, years..L["y"].." ")
		table.insert(parts, days..L["d"].." ")
		table.insert(parts, hours..L["h"].." ")
		table.insert(parts, mins..L["m"])
		if allwaysShowSeconds then
			table.insert(parts, " "..secs..L["s"])
		end
	elseif days > 0 then
		table.insert(parts, days..L["d"].." ")
		table.insert(parts, hours..L["h"].." ")
		table.insert(parts, mins..L["m"])
		if allwaysShowSeconds then
			table.insert(parts, " "..secs..L["s"])
		end
	elseif hours > 0 then
		table.insert(parts, hours..L["h"].." ")
		table.insert(parts, string.format("%02d", mins)..L["m"])
		if allwaysShowSeconds then
			table.insert(parts, " "..string.format("%02d", secs)..L["s"])
		end
	elseif time >= 60 then
		table.insert(parts, mins..L["m"].." ")
		if time < 600 or allwaysShowSeconds then
			table.insert(parts, secs..L["s"])
		end
	elseif time >= 1 then
		table.insert(parts, secs..L["s"])
	else
		table.insert(parts, string.format("%.3f", time).."ms")
	end
	return table.concat(parts)
end
function E.func_texturefromIcon(icon, iconWidth, iconHeight, isAtlas)
	local iconWidth = iconWidth or 16
	local iconHeight = iconHeight or 16
	if isAtlas then
		return E.func_GetAtlasIcon(icon, iconWidth, iconHeight)
	else
		return "|T"..(icon or E.ICON_QUESTION_MARK)..":"..(iconWidth)..":"..(iconHeight)..":::64:64:6:58:6:58|t "
	end
end
function E.func_texturefromIconEVENT(icon, iconSize)
	iconSize = iconSize or 16
	return "|T"..(icon or E.ICON_QUESTION_MARK)..":"..(iconSize)..":"..(iconSize)..":::128:128:0:91:0:91|t "
end
function E.func_GetPlayerLocation()
	-- Получаем текстовые данные о местоположении
	local curRealZone = GetRealZoneText()
	local curSubZone = GetSubZoneText()
	local FIRSTtext = curRealZone ~= "" and curRealZone or GetZoneText()
	local SECONDtext = curSubZone ~= "" and curSubZone or GetMinimapZoneText()
	-- Получаем ID карты для игрока
	local uiMapID = MapUtil.GetDisplayableMapForPlayer()
	if uiMapID ~= 0 then
		local mapInfo = C_Map.GetMapInfo(uiMapID)
		if mapInfo then
			local mapGroupID = C_Map.GetMapGroupID(uiMapID)
			if mapGroupID then
				local mapGroupInfo = C_Map.GetMapGroupMembersInfo(mapGroupID)
				if mapGroupInfo then
					for _, mapGroupMemberInfo in ipairs(mapGroupInfo) do
						if mapGroupMemberInfo.mapID == uiMapID then
							mapInfo.name = ("%s (%s)"):format(mapInfo.name, mapGroupMemberInfo.name)
							break
						end
					end
				end
			end
			-- Логика определения текста для возврата
			if FIRSTtext == "" then
				return E.COLOR_RED..mapInfo.name.."|r", false
			elseif FIRSTtext == SECONDtext then
				return FIRSTtext, true
			else
				return SECONDtext ~= "" and FIRSTtext.." ("..SECONDtext..")" or FIRSTtext, true
			end
		end
	end
	return UNKNOWN, true
end
function E.func_GetQuestStatus(questID, forceBoolean)
	if not questID then return end
	local result
	-- серый фейл
	-- красный не сделан
	-- желтный делается
	-- фиолетовый можно сдать
	if IsFailed(questID) then
		result = E.COLOR_RED..FAILED.."|r"
	elseif IsQuestFlaggedCompleted(questID) then
		if forceBoolean then
			result = true
		else
			result = E.DONE
		end
	elseif IsComplete(questID) then
		result = E.COLOR_PURPLE..">"..QUEST_WATCH_QUEST_READY.."<|r"
	elseif not E.func_IsOnQuest(questID) then
		result = nil
	else
		local objectives = GetQuestObjectives(questID)
		if not objectives then
			result = ""
		else
			local parts = {}
			for i = 1, #objectives do
				local objective = objectives[i]
				if objective then
					local objectiveText, objectiveType, finished, numFulfilled, numRequired = GetQuestObjectiveInfo(questID, i, false)
					local color = finished and E.COLOR_YELLOW or E.COLOR_RED
					local text
					if objectiveType == "progressbar" then
						text = color..GetQuestProgressBarPercent(questID).."%|r"
					else
						text = color..objective.numFulfilled.."/"..objective.numRequired.."|r"
					end
					table.insert(parts, text)
				end
			end
			result = table.concat(parts, " ")
		end
	end
	return result
end
function E.func_GetRealmShortName(text)
	local a, b = strsplit(" ", text:gsub("[-']", " "))
	local isRemix = E.func_IsRemix() and " (Remix)" or ""
	local output
	if b then
		output = utf8sub(a, 1, 1):upper()..utf8sub(b, 1, 1):upper()
	else
		output = utf8sub(a, 1, 1):upper()..utf8sub(a, 2, 3):lower()
	end
	return output..isRemix
end
E.curServerShort = E.func_GetRealmShortName(GetRealmName())
function E.func_TableRemoveDuplicates(table1)
	if type(table1) ~= "table" then
		return {}
	end
	local seen = {}
	local write_idx = 1
	for i = 1, #table1 do
		local value = table1[i]
		if not seen[value] then
			seen[value] = true
			if write_idx ~= i then
				table1[write_idx] = value
			end
			write_idx = write_idx + 1
		end
	end
	for i = write_idx, #table1 do
		table1[i] = nil
	end
	return table1
end
function E.func_GetFactionIcon(faction)
	if faction == "Horde" then
		return 2565244
	elseif faction == "Alliance" then
		return 2565243
	else
		return 775462
	end
end
function E.func_FormatResetType(text)
	if not text then return end
	local result = ""
	if text == "Regular" then
		result = E.COLOR_YELLOW.."O|r"
	elseif text == "Daily" then
		result = E.COLOR_BLUE.."D|r"
	elseif text == "Weekly" then
		result = E.COLOR_PURPLE.."W|r"
	elseif text == "Month" then
		result = E.COLOR_RED.."M|r"
	end
	return result
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
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local CompactSuffixes = {
	enUS = { "", "k", "M", "B", "T" },
	enGB = { "", "k", "M", "B", "T" },
	ruRU = { "", " тыс.", " млн", " млрд", " трлн" },
	deDE = { "", " Tsd.", " Mio.", " Mrd.", " Bio." },
	frFR = { "", " k", " M", " Md", " T" },
	esES = { "", " mil", " M", " mil M", " B" },
	esMX = { "", " mil", " M", " mil M", " B" },
	ptBR = { "", " mil", " mi", " bi", " tri" },
	itIT = { "", " mila", " mln", " mld", " tln" },
	zhCN = { "", "万", "亿", "兆" }, -- Упрощённый китайский
	zhTW = { "", "萬", "億", "兆" }, -- Традиционный китайский
	koKR = { "", "만", "억", "조" }, -- Корейский
}
local AsianLocales = {
	zhCN = true,
	zhTW = true,
	koKR = true,
}
local function FormatWithSeparators(num)
	local formatted = tostring(num)
	while true do
		local k = formatted:gsub("^(-?%d+)(%d%d%d)", "%1 %2")
		if k == formatted then break end
		formatted = k
	end
	return formatted
end
function E.func_CompactFormatNumber(num)
	num = num or 0
	local locale = "enUS"
	local suffixes = CompactSuffixes["enUS"]
	local mode = Octo_ToDo_DB_Vars.Config_numberFormatMode or 1
	local STEP_WEST = 1000
	local STEP_ASIA = 10000
	local DECIMALS = 1
	local step = STEP_WEST
	----------------------------------------------------------------
	if mode == 1 then
		suffixes = CompactSuffixes["enUS"]
	elseif mode == 2 then
		locale = E.curLocaleLang
		suffixes = CompactSuffixes[locale] or CompactSuffixes["enUS"]
		step = AsianLocales[locale] and STEP_ASIA or STEP_WEST
	elseif mode == 3 then -- ПОЛНЫЙ С РАЗДЕЛИТЕЛЯМИ
		return FormatWithSeparators(math.floor(num + 0.5))
	elseif mode == 4 then -- ПОЛНЫЙ
		return (math.floor(num + 0.5))
	elseif mode == 5 then -- BLIZZ LIKE
		if AbbreviateLargeNumbers then
			return AbbreviateLargeNumbers(math.floor(num + 0.5))
		else
			return tostring(math.floor(num + 0.5))
		end
	elseif mode == 6 then -- Short & Clean
		local i = 1
		local sign = num < 0 and -1 or 1
		num = math.abs(num)
		while num >= step and i < #suffixes do
			num = num / step
			i = i + 1
		end
		local rounded = math.floor(num + 0.5) * sign
		return tostring(rounded)..suffixes[i]
	end
	----------------------------------------------------------------
	local i = 1
	local sign = num < 0 and -1 or 1
	num = math.abs(num)
	if not suffixes then
		return tostring(math.floor(num * sign + 0.5))
	end
	while num >= step and i < #suffixes do
		num = num / step
		i = i + 1
	end
	local rounded = tonumber(string.format("%."..DECIMALS.."f", num))
	if rounded >= step and i < #suffixes then
		rounded = rounded / step
		i = i + 1
	end
	rounded = rounded * sign
	local s = tostring(rounded):gsub("%.0$", "")
	return s..suffixes[i]
end
----------------------------------------------------------------
function E.func_GetFactionDataByID(id)
	return GetFactionDataByID(id)
end
function E.func_GetFactionParagonInfo(id)
	return GetFactionParagonInfo(id)
end
function E.func_GetMajorFactionData(id)
	return GetMajorFactionData(id)
end
function E.func_GetFriendshipReputationRanks(id)
	return GetFriendshipReputationRanks(id)
end
function E.func_IsFactionParagon(id)
	return IsFactionParagon(id)
end
function E.func_GetFriendshipReputation(id)
	return GetFriendshipReputation(id)
end
function E.func_IsMajorFaction(id)
	return IsMajorFaction(id)
end
----------------------------------------------------------------
function E.func_SI_to_EJ(id) -- jInstanceID func_SI_to_EJ
	if not id then return end
	local newID = Octo_Cache_DB.SavedInstanceID_to_EJInstance[id] or 0 -- jInstanceID
	return newID
end
----------------------------------------------------------------
function E.func_EJ_to_SI(id) -- 721 Чертоги доблести
	if not id then return end
	local newID = Octo_Cache_DB.EJInstance_to_SavedInstanceID[id] or 0 -- instanceID
	return newID
end
----------------------------------------------------------------
function E.func_GetSpecializationIconSafe()
	local specID = GetSpecialization()
	if specID then
		local _, _, _, icon = GetSpecializationInfo(specID)
		return icon
	end
	return nil
end
----------------------------------------------------------------
function E.func_MeasureTextWidth(textToMeasure, minWidth, indent)
	minWidth = minWidth or 1
	local result = type(textToMeasure) == "function" and textToMeasure() or textToMeasure
	local text = tostring(result or "")
	measureText:SetText(text)
	local width = math.max(math.ceil(measureText:GetStringWidth()), minWidth) -- 8 indent
	return width
end
----------------------------------------------------------------
function E.func_UpdateFont()
	local Config_FontStyle = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle
	local Config_FontSize = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize
	local Config_FontFlags = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags
	local fontPath = LibSharedMedia:Fetch("font", Config_FontStyle)



	E.OctoFont10:CopyFontObject(GameTooltipText)
	E.OctoFont11:CopyFontObject(GameTooltipText)
	E.OctoFont22:CopyFontObject(SystemFont_Outline_Small)



	E.OctoFont10:SetFont(fontPath, Config_FontSize-1, Config_FontFlags)
	E.OctoFont11:SetFont(fontPath, Config_FontSize, Config_FontFlags)
	E.OctoFont22:SetFont(fontPath, 22, Config_FontFlags)
	measureText:SetFontObject(OctoFont11)
end
----------------------------------------------------------------
function E.func_GetSlotNameForEmptySlot(slotID)
	local slotAPIName = E.OctoTable_SlotMapping[slotID].name
	if slotAPIName then
		return _G[slotAPIName] or slotAPIName
	end
	return "Slot "..slotID
end
----------------------------------------------------------------
function E.func_GetEmptySlotIcon(slotID)
	local slotAPIName = E.OctoTable_SlotMapping[slotID].name
	if slotAPIName then
		local _, texture = GetInventorySlotInfo(slotAPIName)
		return texture or 134400
	end
	return 134400
end
----------------------------------------------------------------
function E.func_translit(text)
	if not E.Config_UseTranslit then
		return text
	end
	if type(text) ~= "string" or text == "" then
		return text
	end
	-- нет кириллицы → не трогаем
	if not text:find("[А-Яа-яЁё]") then
		return text
	end
	local result = LibTranslit:Transliterate(text)
	-- защита от пустых строк
	if not result or result == "" then
		return text
	end
	return result
end
----------------------------------------------------------------
function E:func_CanCollectData()
	local db = Octo_ToDo_DB_Levels
	if not db then return false end
	local char = db[self.curGUID]
	if not char then return false end
	return char.MASLENGO ~= nil and char.PlayerData ~= nil
end
----------------------------------------------------------------
function E.func_RefreshTranslations()
	wipe(E.L)
end
----------------------------------------------------------------
function E.func_Save(v)
	if v == false or v == 0 then
		return nil
	end
	return v
end
----------------------------------------------------------------
function E.func_formatMplusKey(keyStoneLevel, OwnedKeystoneChallengeMapID, needIcon, fullName)
	if not keyStoneLevel or not OwnedKeystoneChallengeMapID then return "" end
	local levelPart = keyStoneLevel
	local namePart = ""
	local iconPart = ""
	local colorPart = E.COLOR_PURPLE
	-- pd.CurrentKey
	local name, id, timeLimit, texture, backgroundTexture, mapID = C_ChallengeMode.GetMapUIInfo(OwnedKeystoneChallengeMapID)
	if fullName then
		namePart = name
	elseif not fullName and E.OctoTable_KeystoneAbbr[OwnedKeystoneChallengeMapID] then -- dungeonID
		namePart = E.OctoTable_KeystoneAbbr[OwnedKeystoneChallengeMapID].abbreviation
	else
		namePart = name or UNKNOWN
	end
	if needIcon and texture then
		iconPart = E.func_texturefromIcon(texture)
	end
	local result = iconPart..colorPart..levelPart .." ".. namePart.."|r"
	return result
end
function E.func_DB_FRAME_Color(frame, Type, r, g, b, a, UseFaction, UseClass)
	if not frame then return end
	if UseClass then
		r, g, b = E.func_Hex2RGBA(E.classColorHexCurrent)
	elseif UseFaction then
		r, g, b = E.func_Hex2RGBA(E.COLOR_FACTION)
	end
	if Type == "frame" then
		frame:SetBackdropColor(r, g, b, a)
	elseif Type == "border" then
		frame:SetBackdropBorderColor(r, g, b, a)
	elseif Type == "highlight" then
		frame.highlight:SetVertexColor(r, g, b) -- a?
	end
end
local function func_UpdateGlobals()
	local db = Octo_ToDo_DB_Vars
	if db then
		if db.Config_ADDON_HEIGHT then
			E.GLOBAL_LINE_HEIGHT = db.Config_ADDON_HEIGHT
			E.HEADER_HEIGHT = E.GLOBAL_LINE_HEIGHT*2
			E.HEADER_TEXT_OFFSET = E.HEADER_HEIGHT / 5
			E.ddMenuButtonHeight = E.GLOBAL_LINE_HEIGHT
		end
		db.FontOption = db.FontOption or {}
		db.FontOption[E.curLocaleLang] = db.FontOption[E.curLocaleLang] or {}
		if db.FontOption[E.curLocaleLang].Config_FontStyle then
			E.func_UpdateFont()
		end
		if db.Config_DebugID_ALL ~= nil then
			E.Config_DebugID_ALL = db.Config_DebugID_ALL
		end
		if db.Config_SPAM_TIME ~= nil then
			E.SPAM_TIME = db.Config_SPAM_TIME
		end
		if db.Config_UseTranslit ~= nil then
			E.Config_UseTranslit = db.Config_UseTranslit
		end
		if db.Config_ShowAllDifficulties ~= nil then
			E.Config_ShowAllDifficulties = db.Config_ShowAllDifficulties
		end
		if db.Config_DifficultyAbbreviation ~= nil then
			E.Config_DifficultyAbbreviation = db.Config_DifficultyAbbreviation
		end
		if db.Config_ClampedToScreen ~= nil then
			E.Config_ClampedToScreen = db.Config_ClampedToScreen
			if Octo_MainFrame then
				Octo_MainFrame:SetClampedToScreen(E.Config_ClampedToScreen)
			end
			if Octo_EquipmentsFrame then
				Octo_EquipmentsFrame:SetClampedToScreen(E.Config_ClampedToScreen)
			end
			-- if Octo_TooltipFrame then
			-- Octo_TooltipFrame:SetClampedToScreen(E.Config_ClampedToScreen)
			-- end
			if Octo_MainFrame_QuestsChanged then
				Octo_MainFrame_QuestsChanged:SetClampedToScreen(E.Config_ClampedToScreen)
			end
			if Octo_MainFrame_Achievements then
				Octo_MainFrame_Achievements:SetClampedToScreen(E.Config_ClampedToScreen)
			end
		end
		----------------------------------------------------------------
		if E.PROFTBL then
			----------------------------------------------------------------
			local r = E.PROFTBL.ConfigColor_faction_Horde_r
			local g = E.PROFTBL.ConfigColor_faction_Horde_g
			local b = E.PROFTBL.ConfigColor_faction_Horde_b
			local a = E.PROFTBL.ConfigColor_faction_Horde_a
			E.COLOR_HORDE = E.func_RGB2Hex(r, g, b, a)


			----------------------------------------------------------------



			local r = E.PROFTBL.ConfigColor_faction_Alliance_r
			local g = E.PROFTBL.ConfigColor_faction_Alliance_g
			local b = E.PROFTBL.ConfigColor_faction_Alliance_b
			local a = E.PROFTBL.ConfigColor_faction_Alliance_a
			E.COLOR_ALLIANCE = E.func_RGB2Hex(r, g, b, a)
			----------------------------------------------------------------





			local r = E.PROFTBL.ConfigColor_faction_Neutral_r
			local g = E.PROFTBL.ConfigColor_faction_Neutral_g
			local b = E.PROFTBL.ConfigColor_faction_Neutral_b
			local a = E.PROFTBL.ConfigColor_faction_Neutral_a
			E.COLOR_NEUTRAL = E.func_RGB2Hex(r, g, b, a)
			E.COLOR_FACTION = E.FACTION_CURRENT == "Horde" and E.COLOR_HORDE or E.FACTION_CURRENT == "Alliance" and E.COLOR_ALLIANCE or E.Class_Monk_Color



			----------------------------------------------------------------
			local r = E.PROFTBL.ConfigColor_MAIN_MainFrame_r
			local g = E.PROFTBL.ConfigColor_MAIN_MainFrame_g
			local b = E.PROFTBL.ConfigColor_MAIN_MainFrame_b
			local a = E.PROFTBL.ConfigColor_MAIN_MainFrame_a

			local UseFaction = E.PROFTBL.ConfigColor_MAIN_MainFrame_UseFaction_CONFIG
			local UseClass = E.PROFTBL.ConfigColor_MAIN_MainFrame_UseClass_CONFIG
			E.backgroundColorR = r
			E.backgroundColorG = g
			E.backgroundColorB = b
			E.backgroundColorA = a
			E.func_DB_FRAME_Color(Octo_MainFrame, "frame", r, g, b, a, UseFaction, UseClass)
			E.func_DB_FRAME_Color(Octo_EquipmentsFrame, "frame", r, g, b, a, UseFaction, UseClass)
			E.func_DB_FRAME_Color(Octo_MainFrame_QuestsChanged, "frame", r, g, b, a, UseFaction, UseClass)
			E.func_DB_FRAME_Color(Octo_MainFrame_Achievements, "frame", r, g, b, a, UseFaction, UseClass)
			for k, frame in next, (E.OctoFrames_Dropdowns) do
				E.func_DB_FRAME_Color(frame, "frame", r, g, b, a, UseFaction, UseClass)
			end
			----------------------------------------------------------------

			local r = E.PROFTBL.ConfigColor_MAIN_Border_r
			local g = E.PROFTBL.ConfigColor_MAIN_Border_g
			local b = E.PROFTBL.ConfigColor_MAIN_Border_b
			local a = E.PROFTBL.ConfigColor_MAIN_Border_a
			local UseFaction = E.PROFTBL.ConfigColor_MAIN_Border_UseFaction_CONFIG
			local UseClass = E.PROFTBL.ConfigColor_MAIN_Border_UseClass_CONFIG
			E.func_DB_FRAME_Color(Octo_MainFrame, "border", r, g, b, a, UseFaction, UseClass)
			E.func_DB_FRAME_Color(Octo_EquipmentsFrame, "border", r, g, b, a, UseFaction, UseClass)
			E.func_DB_FRAME_Color(Octo_MainFrame_QuestsChanged, "border", r, g, b, a, UseFaction, UseClass)
			E.func_DB_FRAME_Color(Octo_MainFrame_Achievements, "border", r, g, b, a, UseFaction, UseClass)
			E.func_DB_FRAME_Color(Octo_TooltipFrame, "border", r, g, b, a, UseFaction, UseClass)
			for k, frame in next, (E.OctoFrames_Dropdowns) do
				E.func_DB_FRAME_Color(frame, "border", r, g, b, a, UseFaction, UseClass)
			end


		----------------------------------------------------------------


			local r = E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_r
			local g = E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_g
			local b = E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_b
			local a = E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_a
			local UseFaction = E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_UseFaction_CONFIG
			local UseClass = E.PROFTBL.ConfigColor_TOOLTIP_TooltipFrame_UseClass_CONFIG


			E.func_DB_FRAME_Color(Octo_TooltipFrame, "frame", r, g, b, a, UseFaction, UseClass)
		----------------------------------------------------------------
		end
		----------------------------------------------------------------
	end
	E.func_UpdateCurrent_profileKeys()
end
function E.func_UpdateGlobals()
	E.func_SpamBlock(func_UpdateGlobals, true, 1)
end
----------------------------------------------------------------
function E.func_DB_REP_COLOR(repType, reaction)
	local result = E.COLOR_GRAY
	if not repType then return result end
	if not E.PROFTBL then return result end
	local OctoTable_reactionColors = E.OctoTable_reactionColors
	-- if repType == 2 then
	-- color = OctoTable_reactionColors[repType] or E.COLOR_PINK
	-- elseif repType == 3 then
	-- color = OctoTable_reactionColors[repType] or E.COLOR_BLUE
	-- elseif repType == 1 and reaction then
	-- color = OctoTable_reactionColors[repType][reaction] or E.COLOR_WHITE
	-- elseif repType == 4 then
	-- color = OctoTable_reactionColors[repType] or E.COLOR_BLUE
	-- end
	if repType == 1 and reaction and type(reaction) == "number" and reaction > 0 then
	    -- local colorKeys = {
	    --     [1] = "ConfigColor_Rep_Standard_1",
	    --     [2] = "ConfigColor_Rep_Standard_2",
	    --     [3] = "ConfigColor_Rep_Standard_3",
	    --     [4] = "ConfigColor_Rep_Standard_4",
	    --     [5] = "ConfigColor_Rep_Standard_5",
	    --     [6] = "ConfigColor_Rep_Standard_6",
	    --     [7] = "ConfigColor_Rep_Standard_7",
	    --     [8] = "ConfigColor_Rep_Standard_8",
	    -- }

	    -- local key = colorKeys[reaction]
        -- local r = E.PROFTBL[key .. "_r"]
        -- local g = E.PROFTBL[key .. "_g"]
        -- local b = E.PROFTBL[key .. "_b"]
        -- local a = E.PROFTBL[key .. "_a"]

	    local baseKey = string.format("ConfigColor_Rep_Standard_%d", reaction)
	    local r = E.PROFTBL[baseKey .. "_r"]
	    local g = E.PROFTBL[baseKey .. "_g"]
	    local b = E.PROFTBL[baseKey .. "_b"]
	    local a = E.PROFTBL[baseKey .. "_a"]
		result = E.func_RGB2Hex(r, g, b, a)
	elseif repType == 2 then
							local r = E.PROFTBL.ConfigColor_Rep_Friend_r
							local g = E.PROFTBL.ConfigColor_Rep_Friend_g
							local b = E.PROFTBL.ConfigColor_Rep_Friend_b
							local a = E.PROFTBL.ConfigColor_Rep_Friend_a
		result = E.func_RGB2Hex(r, g, b, a)
	elseif repType == 3 then
							local r = E.PROFTBL.ConfigColor_Rep_Major_r
							local g = E.PROFTBL.ConfigColor_Rep_Major_g
							local b = E.PROFTBL.ConfigColor_Rep_Major_b
							local a = E.PROFTBL.ConfigColor_Rep_Major_a
		result = E.func_RGB2Hex(r, g, b, a)
	elseif repType == 4 then
							local r = E.PROFTBL.ConfigColor_Rep_Paragon_r
							local g = E.PROFTBL.ConfigColor_Rep_Paragon_g
							local b = E.PROFTBL.ConfigColor_Rep_Paragon_b
							local a = E.PROFTBL.ConfigColor_Rep_Paragon_a
		result = E.func_RGB2Hex(r, g, b, a)
	end
	return result
end
----------------------------------------------------------------
function E.func_DB_COV_COLOR(covenantID)
	local result = E.COLOR_WHITE
	if not E.PROFTBL then return result end
	if covenantID == 1 then
							local r = E.PROFTBL.ConfigColor_KYRIAN_r
							local g = E.PROFTBL.ConfigColor_KYRIAN_g
							local b = E.PROFTBL.ConfigColor_KYRIAN_b
							local a = E.PROFTBL.ConfigColor_KYRIAN_a
		result = E.func_RGB2Hex(r, g, b, a)
	elseif covenantID == 2 then
							local r = E.PROFTBL.ConfigColor_VENTHYR_r
							local g = E.PROFTBL.ConfigColor_VENTHYR_g
							local b = E.PROFTBL.ConfigColor_VENTHYR_b
							local a = E.PROFTBL.ConfigColor_VENTHYR_a
		result = E.func_RGB2Hex(r, g, b, a)
	elseif covenantID == 3 then
							local r = E.PROFTBL.ConfigColor_NECROLORD_r
							local g = E.PROFTBL.ConfigColor_NECROLORD_g
							local b = E.PROFTBL.ConfigColor_NECROLORD_b
							local a = E.PROFTBL.ConfigColor_NECROLORD_a
		result = E.func_RGB2Hex(r, g, b, a)
	elseif covenantID == 4 then
							local r = E.PROFTBL.ConfigColor_NIGHTFAE_r
							local g = E.PROFTBL.ConfigColor_NIGHTFAE_g
							local b = E.PROFTBL.ConfigColor_NIGHTFAE_b
							local a = E.PROFTBL.ConfigColor_NIGHTFAE_a
		result = E.func_RGB2Hex(r, g, b, a)
	end
	return result
end
----------------------------------------------------------------
function E.func_DB_FACTION_COLOR(CharInfo)
	local r, g, b, a = 1, 1, 1, 1
	if not CharInfo then return r, g, b, a end
	local pd = CharInfo.PlayerData
	local faction = pd.Faction or "Neutral"
	local result = E.Class_Monk_Color
	if faction == "Horde" then
		r = E.PROFTBL.ConfigColor_faction_Horde_r
		g = E.PROFTBL.ConfigColor_faction_Horde_g
		b = E.PROFTBL.ConfigColor_faction_Horde_b
		a = E.PROFTBL.ConfigColor_faction_Horde_a
	elseif faction == "Alliance" then
		r = E.PROFTBL.ConfigColor_faction_Alliance_r
		g = E.PROFTBL.ConfigColor_faction_Alliance_g
		b = E.PROFTBL.ConfigColor_faction_Alliance_b
		a = E.PROFTBL.ConfigColor_faction_Alliance_a
	elseif faction == "Neutral" then
		r = E.PROFTBL.ConfigColor_faction_Neutral_r
		g = E.PROFTBL.ConfigColor_faction_Neutral_g
		b = E.PROFTBL.ConfigColor_faction_Neutral_b
		a = E.PROFTBL.ConfigColor_faction_Neutral_a
	end
	return r, g, b, a
end
----------------------------------------------------------------
function E.func_DB_HEADER_COLOR(CharInfo)
	local r, g, b, a = 1, 1, 1, 1
	if not CharInfo then return r, g, b, a end
	local pd = CharInfo.PlayerData
	if not pd then return r, g, b, a end
	local classColorHex = pd.classColorHex or E.COLOR_WHITE
	if E.PROFTBL.ConfigColor_CharHeader_UseFaction_CONFIG then
		r, g, b = E.func_DB_FACTION_COLOR(CharInfo)
	elseif E.PROFTBL.ConfigColor_CharHeader_UseClass_CONFIG then
		r, g, b = E.func_Hex2RGBA(classColorHex)
	else
		r = E.PROFTBL.ConfigColor_CharHeader_r
		g = E.PROFTBL.ConfigColor_CharHeader_g
		b = E.PROFTBL.ConfigColor_CharHeader_b
	end
	a = E.PROFTBL.ConfigColor_CharHeader_a
	return r, g, b, a
end
----------------------------------------------------------------
function E.func_DB_CHARLINE_COLOR()
	local r, g, b, a = 1, 1, 1, 1
	local CharInfo = Octo_ToDo_DB_Levels[E.curGUID]
	local pd = CharInfo.PlayerData
	local classColorHex = pd.classColorHex or E.COLOR_WHITE
	if E.PROFTBL.ConfigColor_CharLines_UseFaction_CONFIG then
		r, g, b = E.func_DB_FACTION_COLOR(CharInfo)
	elseif E.PROFTBL.ConfigColor_CharLines_UseClass_CONFIG then
		r, g, b = E.func_Hex2RGBA(classColorHex)
	else
		r = E.PROFTBL.ConfigColor_CharLines_r
		g = E.PROFTBL.ConfigColor_CharLines_g
		b = E.PROFTBL.ConfigColor_CharLines_b
	end
	a = E.PROFTBL.ConfigColor_CharLines_a
	return r, g, b, a
end
----------------------------------------------------------------
-- function E.func_DB_HIGHLIGHT_COLOR()
-- local r, g, b, a = 1, 1, 1, 1
-- return r, g, b, a
-- end
----------------------------------------------------------------
local function ResetHighlightState(frame)
	if frame.highlightLeave then
		frame.highlightLeave:Stop()
	end
	if frame.highlight then
		frame.highlight:SetAlpha(0)
	end
	if frame.HighlightTexture then
		frame.HighlightTexture:SetAlpha(0)
	end
end
----------------------------------------------------------------
function E.func_ApplyHighlightTemplate(frame, anchorFrame)
	if not frame or not anchorFrame or frame.highlight then
		return
	end
	if anchorFrame then
		frame:SetFrameLevel(anchorFrame:GetFrameLevel() - 2)
		frame:SetPoint("LEFT", anchorFrame)
		frame:SetPoint("TOP", anchorFrame)
		frame:SetPoint("BOTTOM", anchorFrame)
		frame:SetPoint("RIGHT")
	end
	-- =========================
	-- Overlay Texture
	-- =========================
	-- local bg = frame:CreateTexture(nil, "BACKGROUND")
	-- bg:SetAtlas(E.TEXTURE_HIGHLIGHT_ATLAS)
	-- bg:SetAlpha(0)
	-- bg:SetBlendMode("ADD")
	-- bg:SetAllPoints(frame)
	-- frame.highlight = bg
	local bg = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
	bg:Hide()
	bg:SetTexture(E.TEXTURE_CHAR_PATH) --E.TEXTURE_HIGHLIGHT_PATH
	bg:SetAlpha(0)
	-- bg:SetAllPoints(frame)
	bg:SetPoint("TOPLEFT", frame, "TOPLEFT", 1, 0)  -- отступ слева 1 пиксель
	bg:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -1, 0)  -- отступ справа 1 пиксель
	frame.highlight = bg
	-- =========================
	-- Animation (fade-out)
	-- =========================
	local ag = bg:CreateAnimationGroup()
	ag:SetToFinalAlpha(true)
	local alpha = ag:CreateAnimation("Alpha")
	alpha:SetOrder(1)
	alpha:SetDuration(0.3)
	alpha:SetSmoothing("IN_OUT")

	alpha:SetToAlpha(0)
	ag.alpha = alpha
	frame.highlightLeave = ag
	-- =========================
	-- Scripts
	-- =========================
	local function ResetHighlightState(self)
		if self.highlightLeave then
			self.highlightLeave:Stop()
		end
		if self.highlight then
			self.highlight:SetAlpha(0)
		end
	end
	frame:SetScript("OnEnter", function(self)
			frame.highlight:Show()

			ResetHighlightState(self)
			self.highlight:SetAlpha(E.PROFTBL.ConfigColor_Highlight_a or .2)
	end)
	frame:SetScript("OnLeave", function(self)
			-- frame.highlight:Hide()
			ResetHighlightState(self)
			if E.PROFTBL.ConfigColor_ENABLE_HIGHLIGHT_ANIMATION then
				-- При выключенном флаге, используем fade
				self.highlightLeave:Restart()
			end
			GameTooltip:Hide()
	end)
	frame:SetScript("OnShow", function(self)
			local r = E.PROFTBL.ConfigColor_Highlight_r
			local g = E.PROFTBL.ConfigColor_Highlight_g
			local b = E.PROFTBL.ConfigColor_Highlight_b
			local a = E.PROFTBL.ConfigColor_Highlight_a


			local UseFaction = E.PROFTBL.ConfigColor_Highlight_UseFaction_CONFIG
			local UseClass = E.PROFTBL.ConfigColor_Highlight_UseClass_CONFIG
			alpha:SetFromAlpha(E.PROFTBL.ConfigColor_Highlight_a or .2)
			E.func_DB_FRAME_Color(frame, "highlight", r, g, b, a, UseFaction, UseClass)
			ResetHighlightState(self)
	end)

	frame:GetScript("OnShow")(frame)
end
----------------------------------------------------------------
-- function E.func_OpenToCategory(frame)
-- if frame and frame:IsShown() then
-- frame:Hide()
-- end
-- if SettingsPanel:IsVisible() then
-- HideUIPanel(SettingsPanel)
-- else
-- Settings.OpenToCategory(E.func_GetAddOnMetadata(E.MainAddonName, "Title"), true)
-- -- Settings.OpenToCategory(category:GetID(), E.func_GetAddOnMetadata(E.MainAddonName, "Title"))
-- -- Settings.OpenToCategory(category:GetID(), addon)
-- end
-- end


function E.func_Create_Highlight(frame, owner)
	frame.Highlight = CreateFrame("FRAME", nil, owner, "OctoPropagateTemplate")
	E.func_ApplyHighlightTemplate(frame.Highlight, frame)
end


function E.func_OpenToCategory(frame)
	if InCombatLockdown() then return end
	if frame and frame:IsShown() then
		frame:Hide()
	end
	if SettingsPanel:IsVisible() then
		HideUIPanel(SettingsPanel)
	else
		if C_SettingsUtil and E.SettingsCategoryID then
			C_SettingsUtil.OpenSettingsPanel(E.SettingsCategoryID) -- 5
		elseif Settings then
			Settings.OpenToCategory(E.func_GetAddOnMetadata(E.MainAddonName, "Title"), true)
		end
	end
end
----------------------------------------------------------------
local order_index = 0
function E.func_GetOrder()
	order_index = order_index + 1
	return order_index
end
----------------------------------------------------------------
function E.func_AutoKey()
	return tostring("key_"..E.func_GetOrder())
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
function E.func_RegisterEvents(frame, MyEventsTable)
	local stack = debugstack(2)
	local STR = stack:match("Interface/AddOns/(.-):%d+") or UNKNOWN
	local DebugPath = STR:gsub("]", "")
	for _, event in ipairs(MyEventsTable) do frame:RegisterEvent(event) end
	frame:SetScript("OnEvent",
		function(self, event,...)
			if self[event] then
				self[event](self,...)
			else
				DEFAULT_CHAT_FRAME:AddMessage(E.COLOR_EVENT..event.."|r"..tostring(DebugPath))
				self:UnregisterEvent(event)
				self.event = nil
			end
	end)
end
----------------------------------------------------------------
function E.func_RunAfterCombat()
	for key in next, (E._inCombats) do
		if type(callback) == "function" then
			callback()
			E._inCombats[key] = nil
		end
	end
end
local MyEventsTable = {
	"PLAYER_REGEN_ENABLED",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
----------------------------------------------------------------
function EventFrame:PLAYER_REGEN_ENABLED()
	E.func_RunAfterCombat()
end
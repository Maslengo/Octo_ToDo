local GlobalAddonName, E = ...
local EventFrame = CreateFrame("FRAME")
local L = LibStub("AceLocale-3.0"):GetLocale(E.MainAddonName)
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
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
local classR, classG, classB = GetClassColor(E.classFilename)
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
function E.func_GetQualityColorRGB(quality)
	local r, g, b = GetItemQualityColor(quality)
	return r, g, b
end
function E.func_IsAnimaItemByID(itemID)
	return IsAnimaItemByID(itemID)
end
function E.func_GetItemLevelDetails(itemID)
	return GetDetailedItemLevelInfo(itemID)
end
function E.func_GetItemCooldown(itemID)
	local start, duration = GetItemCooldown(itemID)
	local result = 0
	if start > 0 and duration > 0 then
		result = (start + duration - GetTime())
	end
	return E.func_CompactRoundNumber(result)
end
function E.func_GetSpellDescription(spellID)
	local result = GetSpellSubtext(spellID)
	return result
end
function E.func_GetSpellCooldown(spellID)
	local start = GetSpellCooldown(spellID).startTime
	local duration = GetSpellCooldown(spellID).duration
	local result = 0
	if start > 0 and duration > 0 then
		result = (start + duration - GetTime())
	end
	return E.func_CompactRoundNumber(result)
end
function E.func_Hex2RGB(hex)
	hex = hex:gsub("|cff", "")
	return tonumber("0x"..hex:sub(1, 2)), tonumber("0x"..hex:sub(3, 4)), tonumber("0x"..hex:sub(5, 6))
end
function E.func_Hex2RGBFloat(hex)
	if hex and hex ~= "" then
		hex = hex:gsub("|cff", "")
		return tonumber("0x"..hex:sub(1, 2))/255, tonumber("0x"..hex:sub(3, 4))/255, tonumber("0x"..hex:sub(5, 6))/255, 1
	else
		return 1, 1, 1
	end
end
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
function E.func_ProfessionIcon(skillLine)
	return skillLine and E.func_texturefromIcon(GetTradeSkillTexture(skillLine)) or ""
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
function E.func_TableConcat(table1, table2)
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
	E.func_UPDATE_MAINFRAME()
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
					if not InCombatLockdown() then
						Octo_profileKeys.isSettingsEnabled = false
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

					end
				elseif button == "RightButton" then
					if frame and frame:IsShown() then
						frame:Hide()
					end
					if SettingsPanel:IsVisible() then
						HideUIPanel(SettingsPanel)
					else
						Settings.OpenToCategory(E.func_GetAddOnMetadata(E.MainAddonName, "Title"), true)
					end
				end
			end,
			OnTooltipShow = function(tooltip)
				local version = E.func_GetAddOnMetadata(AddonName, "Version")
				local title = E.func_GetAddOnMetadata(AddonName, "Title")
				tooltip:AddLine(("%s (|cffff7f3f%s|r)"):format(title, version))

				tooltip:AddLine(" ")
				tooltip:AddDoubleLine(E.LEFT_MOUSE_ICON..L["Left Click:"], HUD_EDIT_MODE_SETTING_ACTION_BAR_VISIBLE_SETTING)
				tooltip:AddDoubleLine(E.RIGHT_MOUSE_ICON..L["Right Click:"], GAMEMENU_OPTIONS)
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
	if not firstColor then firstColor = "|cffD177FF" end
	if not secondColor then secondColor = "|cff63A4E0" end
	local result = ""
	local str = ""
	local total = utf8len(text)-1
	if total > 0 then
		local r1, g1, b1 = E.func_Hex2RGB(firstColor)
		local r2, g2, b2 = E.func_Hex2RGB(secondColor)
		local rdelta, gdelta, bdelta = (r2-r1)/total, (g2-g1)/total, (b2-b1)/total
		local r3 = r1
		local g3 = g1
		local b3 = b1
		for i = 1, total do
			str = str..("|cff%02x%02x%02x%s|r"):format(math.floor(r3+.5), math.floor(g3+.5), math.floor(b3+.5), utf8sub(text, i, i))
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
	for GUID, CharInfo in next, Octo_ToDo_DB_Levels do
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
	for GUID, CharInfo in next, Octo_ToDo_DB_Levels do
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
function E.func_SmoothBackgroundAlphaChange(frame_main, frame_Background, event)
	if InCombatLockdown() or not frame_main or not frame_Background or not event then return end
	if frame_main:IsShown() then
		local targetAlpha = E.MOVINGBACKGROUND_ALPHA
		-- if targetAlpha == 1 then return end
		local duration = 0.3
		local currentAlpha = frame_Background:GetAlpha()
		if event == "PLAYER_STOPPED_MOVING" then
			targetAlpha = 1
			duration = 0.1
		elseif event == "OnShow" then
			targetAlpha = 1
			duration = 0.5
		end
		if currentAlpha == targetAlpha then return end
		if not frame_Background.alphaAnim then
			frame_Background.alphaAnim = frame_Background:CreateAnimationGroup()
			frame_Background.alphaAnim.animation = frame_Background.alphaAnim:CreateAnimation("Alpha")
			frame_Background.alphaAnim.animation:SetDuration(duration)
			frame_Background.alphaAnim:SetScript("OnFinished", function(self)
					frame_Background:SetAlpha(self.targetAlpha)
			end)
		end
		if math.abs(currentAlpha - targetAlpha) < 0.01 then
			return
		end
		frame_Background.alphaAnim.animation:SetFromAlpha(currentAlpha)
		frame_Background.alphaAnim.animation:SetToAlpha(targetAlpha)
		frame_Background.alphaAnim.targetAlpha = targetAlpha
		if frame_Background.alphaAnim:IsPlaying() then
			frame_Background.alphaAnim:Stop()
		end
		frame_Background.alphaAnim:Play()
	end
end
----------------------------------------------------------------
function E.func_GetColorGradient(value, minValue, maxValue, minHex, midHex, maxHex)
	local UseOnlyTwoColor = false -- (min and max)
	-- дефолты на случай кривых рук
	minHex = minHex or E.COLOR_RED
	midHex = midHex or E.COLOR_YELLOW
	maxHex = maxHex or E.COLOR_GREEN
	if not value or not minValue or not maxValue or minValue >= maxValue then
		return maxHex
	end
	local p = (value - minValue) / (maxValue - minValue)
	if p < 0 then p = 0 end
	if p > 1 then p = 1 end
	local r1, g1, b1
	local r2, g2, b2
	local t
	if UseOnlyTwoColor then
		-- Используем только начальный и конечный цвета
		r1, g1, b1 = E.func_Hex2RGB(minHex)
		r2, g2, b2 = E.func_Hex2RGB(maxHex)
		t = p -- используем полный диапазон от 0 до 1
	else
		-- Оригинальная логика с тремя цветами
		if p < 0.5 then
			r1, g1, b1 = E.func_Hex2RGB(minHex)
			r2, g2, b2 = E.func_Hex2RGB(midHex)
			t = p * 2
		else
			r1, g1, b1 = E.func_Hex2RGB(midHex)
			r2, g2, b2 = E.func_Hex2RGB(maxHex)
			t = (p - 0.5) * 2
		end
	end
	local r = math.floor(Lerp(r1, r2, t))
	local g = math.floor(Lerp(g1, g2, t))
	local b = math.floor(Lerp(b1, b2, t))
	return string.format("|cff%02x%02x%02x", r, g, b)
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
function E.func_UpdateFont()
	local Config_FontStyle = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle
	local Config_FontSize = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize
	local Config_FontFlags = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags
	E.OctoFont10:SetFont(LibSharedMedia:Fetch("font", Config_FontStyle), Config_FontSize-1, Config_FontFlags)
	E.OctoFont11:SetFont(LibSharedMedia:Fetch("font", Config_FontStyle), Config_FontSize, Config_FontFlags)
end
-- Функция глубокого копирования таблицы
function E.func_CopyTableDeep(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
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
function E.func_AddonNameForOptionsFunc(addonName)
	return E.func_texturefromIcon(E.func_GetAddOnMetadata(addonName, "IconTexture"))..E.func_GetAddOnMetadata(addonName, "Title").." "..E.COLOR_GRAY..E.func_GetAddOnMetadata(addonName, "Version").."|r"
end
function E.func_AddonNameForOptionsInit(addonName)
	return E.func_texturefromIcon(E.func_GetAddOnMetadata(addonName, "IconTexture"))..E.func_GetAddOnMetadata(addonName, "Title")
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
	local isMainFrameVisible = Octo_MainFrame_ToDo and Octo_MainFrame_ToDo:IsShown()
	if isMainFrameVisible then
		if not E.updateScheduledFlag then
			E.updateScheduledFlag = true
			C_Timer.After(0.1, function()
					E.updateScheduledFlag = false
					if Octo_MainFrame_ToDo and Octo_MainFrame_ToDo:IsShown() then
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
function E.func_FormatExpansion(expID, iconSide)
	local expansion = E.OctoTable_Expansions[expID]
	local expIcon = E.func_texturefromIcon(expansion.icon, 16, 32)
	local expName = expansion.color..expansion.nameVeryShort
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
function E.func_RegisterFrame(frame)
	if not frame or frame.insertIn_SecuredFrames_SequredFrames then return end
	frame.insertIn_SecuredFrames_SequredFrames = true
	table.insert(E.OctoTable_Frames, frame)
	table.insert(UISpecialFrames, frame:GetName())
	C_Timer.After(0, function()
			frame:HookScript("OnShow", function()
					for i, other in ipairs(E.OctoTable_Frames) do
						if frame ~= other and other:IsShown() then
							other:Hide()
						end
					end
			end)
	end)
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
function E.func_PrintMessage(text)
	-- Используем стандартное сообщение WoW или создаем свое
	UIErrorsFrame:AddMessage(E.func_Gradient(text), 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)
	-- DEFAULT_CHAT_FRAME:AddMessage(E.func_GetAddOnMetadata(E.MainAddonName, "Title")..": "..text)
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
function E.func_GetQuestStatus(questID)
	if not questID then return end
	local result
	-- серый фейл
	-- красный не сделан
	-- желтный делается
	-- фиолетовый можно сдать
	if IsFailed(questID) then
		result = E.COLOR_RED..FAILED.."|r"
	elseif IsQuestFlaggedCompleted(questID) then
		result = E.DONE
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
	if text == "Once" then
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
		return tostring(rounded) .. suffixes[i]
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
	return s .. suffixes[i]

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
	for key in next,(E._inCombats) do
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
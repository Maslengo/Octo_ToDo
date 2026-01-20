local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Reputations()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	local OctoTable_reactionColors = E.OctoTable_reactionColors
	local gender = UnitSex("player")
	local function func_GetReputationProgress(reputationID)
		local FIRST, SECOND = 0, 0
		-- local color = E.COLOR_WHITE
		local standingTEXT = ""
		local reaction = 0
		local hasValidData = false  -- Флаг наличия данных
		local simpleData = E.func_GetFactionDataByID(reputationID)
		local friendData = E.func_GetFriendshipReputation(reputationID)
		local isFriend = friendData and friendData.friendshipFactionID and friendData.friendshipFactionID > 0
		local isMajor = E.func_IsMajorFaction(reputationID)
		local isParagon = E.func_IsFactionParagon(reputationID)
		local repType = 0
		local renownLevel
		local renownMaxLevel
		local rankInfocurrentLevel
		local rankInfomaxLevel
		local ParagonCount
		-- FRIENDSHIP
		if isFriend then
			repType = 2
			hasValidData = true
			reaction = friendData.reaction
			-- color = OctoTable_reactionColors[repType] or E.COLOR_PINK
			local cur = friendData.standing - friendData.reactionThreshold
			local max = (friendData.nextThreshold or friendData.reactionThreshold) - friendData.reactionThreshold
			if max <= 0 then cur, max = 1, 1 end
			FIRST = cur
			SECOND = max
			local rankInfo = E.func_GetFriendshipReputationRanks(friendData.friendshipFactionID)
			if rankInfo then
				standingTEXT = " ("..rankInfo.currentLevel.."/"..rankInfo.maxLevel..")"
				rankInfocurrentLevel = rankInfo.currentLevel
				rankInfomaxLevel = rankInfo.maxLevel
			end
			-- MAJOR FACTION (RENOWN)
		elseif isMajor then
			repType = 3
			hasValidData = true
			local m = E.func_GetMajorFactionData(reputationID)
			if m then
				-- color = OctoTable_reactionColors[repType] or E.COLOR_BLUE
				FIRST = m.renownReputationEarned
				SECOND = m.renownLevelThreshold
				renownLevel = m.renownLevel
				renownMaxLevel = E.func_GetMaxRenownLevel(reputationID)
				standingTEXT = " ("..renownLevel.."/"..renownMaxLevel..")"
			end
			-- STANDARD
		elseif simpleData and simpleData.currentReactionThreshold then
			repType = 1
			hasValidData = true
			reaction = simpleData.reaction
			-- color = OctoTable_reactionColors[repType][reaction] or E.COLOR_WHITE
			local cur = simpleData.currentStanding - simpleData.currentReactionThreshold
			local max = simpleData.nextReactionThreshold - simpleData.currentReactionThreshold
			if max <= 0 then cur, max = 1, 1 end
			FIRST = cur
			SECOND = max
			standingTEXT = GetText("FACTION_STANDING_LABEL"..reaction, gender)
		end
		-- Если нет валидных данных, возвращаем nil
		if not hasValidData then
			return nil
		end
		-- PARAGON OVERLAY
		if isParagon then
			repType = 4
			local earned, threshold = E.func_GetFactionParagonInfo(reputationID)
			if earned and threshold and threshold > 0 then
				FIRST = earned % threshold
				SECOND = threshold
				-- color = OctoTable_reactionColors[repType] or E.COLOR_BLUE
			end
		end
		if isParagon then
			local currentValue, threshold, _, hasRewardPending = E.func_GetFactionParagonInfo(reputationID)
			if currentValue and threshold then
				-- local level = math.floor(earned / threshold)
				local level = math.floor(currentValue/threshold)-(hasRewardPending and 1 or 0)
				if level > 0 then
					ParagonCount = level
				end
			end
		end
		-- ДЕБАГ
		-- if reputationID == 47 then
		--     E.func_PrintMessage(
		--         reputationID,
		--         "friend:", isFriend,
		--         "major:", isMajor,
		--         "paragon:", isParagon,
		--         "val:", FIRST, "/", SECOND,
		--     )
		-- end
		-- Цвет «прогресса», а не «статуса» (НЕ ОЧЕНЬ)
		-- local pct = FIRST / math.max(SECOND, 1)
		-- if pct < 0.25 then
		--     color = E.COLOR_RED
		-- elseif pct < 0.75 then
		--     color = E.COLOR_YELLOW
		-- else
		--     color = E.COLOR_GREEN
		-- end
		local result = nil
		if SECOND > 0 then
			result = {
				FIRST = FIRST,					-- число
				SECOND = SECOND,				-- число
				ParagonCount = ParagonCount,	-- число
				-- color = color,					-- строка или таблица цветов (УБРАТЬ)
				-- standingTEXT = standingTEXT,	-- строка (УБРАТЬ)

				repType = repType,				-- число
				reaction = reaction,			-- число

				renownLevel = renownLevel,
				renownMaxLevel = renownMaxLevel,
				rankInfocurrentLevel = rankInfocurrentLevel,
				rankInfomaxLevel = rankInfomaxLevel,
			}
		end

		-- local result = FIRST.."#"..SECOND.."#"..ParagonCount.."#"..color.."#"..standingTEXT.."#"..repType.."#"..reaction
		return result
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	-- Сброс таблицы репутаций для текущего персонажа
	if collectMASLENGO.Reputation then
		wipe(collectMASLENGO.Reputation)  -- Полная очистка таблицы
	else
		collectMASLENGO.Reputation = {}
	end
	for reputationID in next, (E.TBL_validReps) do
		local output = func_GetReputationProgress(reputationID)
		-- if output then
		local isAccountWide = C_Reputation.IsAccountWideReputation(reputationID)
		if isAccountWide then
			-- Аккаунтовая: обновляем всех
			for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
				local pd = CharInfo.PlayerData
				local cm = CharInfo.MASLENGO
				if pd.CurrentRegionName == E.CurrentRegionName then
					cm.Reputation = cm.Reputation or {}
					cm.Reputation[reputationID] = output or nil
				end
			end
		else
			-- Персонажная: только текущему
			collectMASLENGO.Reputation = collectMASLENGO.Reputation or {}
			collectMASLENGO.Reputation[reputationID] = output or nil
		end
		-- end
	end
	-- opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.Reputation)
end
----------------------------------------------------------------
function E.Collect_Reputations()
	E.func_SpamBlock(Collect_Reputations, true)
end
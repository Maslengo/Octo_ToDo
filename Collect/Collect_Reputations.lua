local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Reputations()
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectMASLENGO then return end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	local reactionColors = {
		[0] = E.COLOR_WHITE,
		[1] = E.COLOR_RED,
		[2] = E.COLOR_RED,
		[3] = E.COLOR_ORANGE,
		[4] = E.COLOR_YELLOW,
		[5] = E.COLOR_YELLOW,
		[6] = E.COLOR_GREEN,
		[7] = E.COLOR_GREEN,
		[8] = E.COLOR_GREEN,
	}
	local function func_GetReputationProgress(reputationID)
		local FIRST, SECOND = 0, 0
		local color = E.COLOR_WHITE
		local standingTEXT = ""
		local reaction = 0
		local hasValidData = false  -- Флаг наличия данных
		local simpleData = E.func_GetFactionDataByID(reputationID)
		local friendData = E.func_GetFriendshipReputation(reputationID)
		local isFriend = friendData and friendData.friendshipFactionID and friendData.friendshipFactionID > 0
		local isMajor = E.func_IsMajorFaction(reputationID)
		local isParagon = E.func_IsFactionParagon(reputationID)
		local repType = 0
		-- FRIENDSHIP
		if isFriend then
			repType = 2
			hasValidData = true
			reaction = friendData.reaction
			color = reactionColors[reaction] or E.COLOR_PINK
			local cur = friendData.standing - friendData.reactionThreshold
			local max = (friendData.nextThreshold or friendData.reactionThreshold) - friendData.reactionThreshold
			if max <= 0 then cur, max = 1, 1 end
			FIRST, SECOND = cur, max
			local rankInfo = E.func_GetFriendshipReputationRanks(friendData.friendshipFactionID)
			if rankInfo then
				standingTEXT = " ("..rankInfo.currentLevel.."/"..rankInfo.maxLevel..")"
			end
			-- MAJOR FACTION (RENOWN)
		elseif isMajor then
			repType = 3
			hasValidData = true
			local m = E.func_GetMajorFactionData(reputationID)
			if m then
				color = E.COLOR_BLUE
				FIRST, SECOND = m.renownReputationEarned, m.renownLevelThreshold
				standingTEXT = " ("..m.renownLevel.."/"..E.func_GetMaxRenownLevel(reputationID)..")"
			end
			-- STANDARD
		elseif simpleData and simpleData.currentReactionThreshold then
			repType = 1
			hasValidData = true
			reaction = simpleData.reaction
			color = reactionColors[reaction] or E.COLOR_PINK
			local cur = simpleData.currentStanding - simpleData.currentReactionThreshold
			local max = simpleData.nextReactionThreshold - simpleData.currentReactionThreshold
			if max <= 0 then cur, max = 1, 1 end
			FIRST, SECOND = cur, max
			standingTEXT = GetText("FACTION_STANDING_LABEL"..reaction, UnitSex("player"))
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
				color = E.COLOR_BLUE
			end
		end
		-- PARAGON COUNT (сделать отдельно, сейчас прилепает к standingTEXT)
		local ParagonCount = ""
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
		--     print(
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
		return FIRST.."#"..SECOND.."#"..ParagonCount.."#"..color.."#"..standingTEXT.."#"..repType
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
	for reputationID in next,(E.OctoTable_Reputations_DB) do -- E.ALL_Reputations
		local output = func_GetReputationProgress(reputationID)
		-- if output then
		local isAccountWide = C_Reputation.IsAccountWideReputation(reputationID)
		if isAccountWide then
			-- Аккаунтовая: обновляем всех
			for GUID, CharInfo in next, Octo_ToDo_DB_Levels do
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
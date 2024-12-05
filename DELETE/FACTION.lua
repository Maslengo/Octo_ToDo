FACTION_BAR_COLORS =  {
	FACTION_RED_COLOR,
	FACTION_RED_COLOR,
	FACTION_ORANGE_COLOR,
	FACTION_YELLOW_COLOR,
	FACTION_GREEN_COLOR,
	FACTION_GREEN_COLOR,
	FACTION_GREEN_COLOR,
	FACTION_GREEN_COLOR,
}


local function InitializeBarForStandardReputation(factionData, reputationBar)
	local isCapped = factionData.reaction == MAX_REPUTATION_REACTION
	local minValue, maxValue, currentValue
	if isCapped then
		-- Max rank, make it look like a full bar
		minValue, maxValue, currentValue = 0, 1, 1
	else
		minValue, maxValue, currentValue = factionData.currentReactionThreshold, factionData.nextReactionThreshold, factionData.currentStanding
	end
	minValue, maxValue, currentValue = NormalizeBarValues(minValue, maxValue, currentValue)
	reputationBar:UpdateBarValues(minValue, maxValue, currentValue)
	
	local progressText = not isCapped and HIGHLIGHT_FONT_COLOR:WrapTextInColorCode(REPUTATION_PROGRESS_FORMAT:format(BreakUpLargeNumbers(currentValue), BreakUpLargeNumbers(maxValue))) or nil 
	reputationBar:UpdateBarProgressText(progressText)
	local gender = UnitSex("player")
	local reputationStandingtext = GetText("FACTION_STANDING_LABEL" .. factionData.reaction, gender)
	reputationBar:UpdateReputationStandingText(reputationStandingtext)
	reputationBar:TryShowReputationStandingText()

	local colorIndex = factionData.reaction
	reputationBar:UpdateBarColor(FACTION_BAR_COLORS[colorIndex])
end


function ReputationParagonFrame_SetupParagonTooltip(frame)
	local factionID = frame.factionID
	EmbeddedItemTooltip.factionID = frame.factionID

	local factionStandingtext
	local factionData = C_Reputation.GetFactionDataByID(factionID)
	local reputationInfo = C_GossipInfo.GetFriendshipReputation(factionID)
	if reputationInfo and reputationInfo.friendshipFactionID > 0 then
		factionStandingtext = reputationInfo.reaction
	elseif C_Reputation.IsMajorFaction(factionID) then
		factionStandingtext = MAJOR_FACTION_MAX_RENOWN_REACHED
	else
		local gender = UnitSex("player")
		factionStandingtext = GetText("FACTION_STANDING_LABEL"..factionData.reaction, gender)
	end
	local currentValue, threshold, rewardQuestID, hasRewardPending, tooLowLevelForParagon = C_Reputation.GetFactionParagonInfo(factionID)

	if ( tooLowLevelForParagon ) then
		GameTooltip_SetTitle(EmbeddedItemTooltip, PARAGON_REPUTATION_TOOLTIP_TEXT_LOW_LEVEL, NORMAL_FONT_COLOR)
	else
		GameTooltip_SetTitle(EmbeddedItemTooltip, factionStandingtext, HIGHLIGHT_FONT_COLOR)

		TryAppendAccountReputationLineToTooltip(EmbeddedItemTooltip, factionID)
		GameTooltip_AddBlankLineToTooltip(EmbeddedItemTooltip)

		local description = PARAGON_REPUTATION_TOOLTIP_TEXT:format(factionData.name)
		if ( hasRewardPending ) then
			local questIndex = C_QuestLog.GetLogIndexForQuestID(rewardQuestID)
			local text = GetQuestLogCompletionText(questIndex)
			if ( text and text ~= "" ) then
				description = text
			end
		end
		GameTooltip_AddNormalLine(EmbeddedItemTooltip, description)
		if ( not hasRewardPending and currentValue and threshold ) then
			local value = mod(currentValue, threshold)
			-- show overflow if reward is pending
			if ( hasRewardPending ) then
				value = value + threshold
			end
			GameTooltip_ShowProgressBar(EmbeddedItemTooltip, 0, threshold, value, REPUTATION_PROGRESS_FORMAT:format(value, threshold))
		end
		GameTooltip_AddQuestRewardsToTooltip(EmbeddedItemTooltip, rewardQuestID)
	end
end
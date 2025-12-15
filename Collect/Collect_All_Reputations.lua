local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_All_Reputations()
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectMASLENGO then return end

	for reputationID in next,(E.OctoTable_Reputations_DB) do -- E.ALL_Reputations
		local output = E.func_GetReputationProgress(reputationID)
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
	end
end
----------------------------------------------------------------
function E.Collect_All_Reputations()
	E.func_SpamBlock(Collect_All_Reputations, true)
end


-- /run opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.Reputation)


function E.PackMeta(standing, isMax, isParagon, isMajor, isFriendship)
	local meta = standing  -- начинаем со standing (0-7 обычно)

	if isMax then meta = meta + 16 end      -- 4-й бит (1<<4)
	if isParagon then meta = meta + 32 end  -- 5-й бит (1<<5)
	if isMajor then meta = meta + 64 end    -- 6-й бит (1<<6)
	if isFriendship then meta = meta + 128 end -- 7-й бит (1<<7)

	return meta
end

function E.UnpackMeta(meta)
	local standing = bit.band(meta, 0x0F)  -- младшие 4 бита
	local isMax = bit.band(meta, 0x10) ~= 0
	local isParagon = bit.band(meta, 0x20) ~= 0
	local isMajor = bit.band(meta, 0x40) ~= 0
	local isFriendship = bit.band(meta, 0x80) ~= 0

	return standing, isMax, isParagon, isMajor, isFriendship
end


function E.TEST_QWE()
	-- local meta = PackMeta(
	-- 	standing,										-- текущий уровень отношения (0-8)
	-- 	isMax,											-- максимальный уровень достигнут
	-- 	isParagon,										-- это парагон-репутация
	-- 	isMajor,										-- это мажор-фракция (реновн)
	-- 	GetFriendshipReputation(reputationID) ~= nil	-- это дружба
	-- )

	local meta = E.PackMeta(
		14,												-- текущий уровень отношения (0-8)
		false,											-- максимальный уровень достигнут
		true,											-- это парагон-репутация
		false,											-- это мажор-фракция (реновн)
		true 											-- это дружба
	)
	-- isSimple
	-- isParagon
	-- isFriend
	-- isMajor

	print(meta) -- 165
	return meta

end

-- /run opde(E.UnpackMeta(E.TEST_QWE()))






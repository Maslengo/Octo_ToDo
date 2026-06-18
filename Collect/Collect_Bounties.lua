local GlobalAddonName, E = ...

local mapTBL = {
	E.MapID_Dalaran, -- 627 Legion
	E.MapID_Zandalar, -- 875 BFA
}

local CURRENT_REGION_NAME = E.CURRENT_REGION_NAME
local FACTION_CURRENT = E.FACTION_CURRENT
----------------------------------------------------------------
local function Collect_Bounties()
    if not E.func_CanCollectData() then return end
    local ServerTime = E.TIME_SERVER()

    for _, mapID in ipairs(mapTBL) do
        local cmKey = "Bounties" .. mapID
        local cacheKey = "Bounties" .. mapID

        E.cm[cmKey] = E.cm[cmKey] or {}
        Octo_ToDo_DB_AccountData[cacheKey] = Octo_ToDo_DB_AccountData[cacheKey] or {}
        E.cm[cmKey][CURRENT_REGION_NAME] = E.cm[cmKey][CURRENT_REGION_NAME] or {}
        Octo_ToDo_DB_AccountData[cacheKey][CURRENT_REGION_NAME] = Octo_ToDo_DB_AccountData[cacheKey][CURRENT_REGION_NAME] or {}
        E.cm[cmKey][CURRENT_REGION_NAME][FACTION_CURRENT] = E.cm[cmKey][CURRENT_REGION_NAME][FACTION_CURRENT] or {}
        Octo_ToDo_DB_AccountData[cacheKey][CURRENT_REGION_NAME][FACTION_CURRENT] = Octo_ToDo_DB_AccountData[cacheKey][CURRENT_REGION_NAME][FACTION_CURRENT] or {}

        local collectCACHE = Octo_ToDo_DB_AccountData[cacheKey][CURRENT_REGION_NAME][FACTION_CURRENT]
        local bounties, _, lockedType = C_QuestLog.GetBountiesForMapID(mapID)

        -- Пропускаем только если совсем нет данных или заблокировано
        if not (bounties and #bounties > 0 and not lockedType) then
            -- Ничего не делаем для этой карты
        else
            local currentBountyIDs = {}

            for i = 1, #bounties do
                local d = bounties[i]
                local questID = d.questID
                if questID then
                    currentBountyIDs[questID] = true
                    collectCACHE[questID] = collectCACHE[questID] or {}
                    collectCACHE[questID].icon = d.icon
                    collectCACHE[questID].name = E.func_GetName("quest", questID)
                    collectCACHE[questID].lastUpdate = ServerTime

                    local _, objectiveType = GetQuestObjectiveInfo(questID, d.numObjectives or 1, false)
                    local bountyStr = E.COLOR_GRAY .. "0/1|r"
                    if objectiveType == "progressbar" then
                        bountyStr = E.COLOR_GRAY .. "0%|r"
                    end
                    collectCACHE[questID].bountyStr = bountyStr

                    local diff = E.func_GetQuestTimeLeftSeconds(questID)
                    if diff then
                        collectCACHE[questID].endTime = ServerTime + diff
                        collectCACHE[questID].haveTime = true
                    else
                        collectCACHE[questID].endTime = ServerTime + (3 * 24 * 60 * 60)
                        collectCACHE[questID].haveTime = false
                    end
                end
            end

            local collect = E.cm[cmKey][CURRENT_REGION_NAME][FACTION_CURRENT]
            wipe(collect)

            for questID, v in pairs(collectCACHE) do
                local isOnQuest = E.func_IsOnQuest(questID)
                if isOnQuest then
                    -- Обновляем время в кеше
                    local diff = E.func_GetQuestTimeLeftSeconds(questID)
                    if diff then
                        collectCACHE[questID].endTime = ServerTime + diff
                        collectCACHE[questID].haveTime = true
                    end
                    collect[questID] = {
                        isOnQuest = true,
                        bountyStr = E.func_GetQuestStatus(questID),
                    }
                else
                    if not currentBountyIDs[questID] and E.func_IsQuestFlaggedCompleted(questID) then
                        collect[questID] = {
                            isCompleted = true,
                            bountyStr = E.DONE,
                        }
                    end
                end
            end
        end
    end
end
----------------------------------------------------------------
function E.Collect_Bounties()
	E.func_SpamBlock(Collect_Bounties, true)
end
----------------------------------------------------------------
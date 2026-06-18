local GlobalAddonName, E = ...
----------------------------------------------------------------
local CURRENT_REGION_NAME = E.CURRENT_REGION_NAME
local FACTION_CURRENT = E.FACTION_CURRENT
----------------------------------------------------------------
function E.Collect_Callings(...)
	if not E.func_CanCollectData() then return end
	local calling = ...
	if not calling then return end
	local COVENANT_CURRENT = C_Covenants and C_Covenants.GetActiveCovenantID()
	if not COVENANT_CURRENT or COVENANT_CURRENT == 0 then return end

	E.cm.Callings = E.cm.Callings or {}
	Octo_ToDo_DB_AccountData.Callings = Octo_ToDo_DB_AccountData.Callings or {}
	E.cm.Callings[CURRENT_REGION_NAME] = E.cm.Callings[CURRENT_REGION_NAME] or {}
	Octo_ToDo_DB_AccountData.Callings[CURRENT_REGION_NAME] = Octo_ToDo_DB_AccountData.Callings[CURRENT_REGION_NAME] or {}
	E.cm.Callings[CURRENT_REGION_NAME][COVENANT_CURRENT] = E.cm.Callings[CURRENT_REGION_NAME][COVENANT_CURRENT] or {}
	Octo_ToDo_DB_AccountData.Callings[CURRENT_REGION_NAME][COVENANT_CURRENT] = Octo_ToDo_DB_AccountData.Callings[CURRENT_REGION_NAME][COVENANT_CURRENT] or {}

	local collectCACHE = Octo_ToDo_DB_AccountData.Callings[CURRENT_REGION_NAME][COVENANT_CURRENT]
	local ServerTime = E.TIME_SERVER()

	-- Таблица для быстрой проверки квестов из свежего calling
	local currentCallingIDs = {}

	for i = 1, #calling do
		local d = calling[i]
		local questID = d.questID
		currentCallingIDs[questID] = true   -- запоминаем, что квест был в этом обновлении

		collectCACHE[questID] = collectCACHE[questID] or {}
		collectCACHE[questID].icon = d.icon
		collectCACHE[questID].lastUpdate = ServerTime

		local _, objectiveType = GetQuestObjectiveInfo(questID, d.numObjectives, false)
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

	local collect = E.cm.Callings[CURRENT_REGION_NAME][COVENANT_CURRENT]
	wipe(collect)

	for questID, v in pairs(collectCACHE) do
		local isOnQuest = E.func_IsOnQuest(questID)
		if isOnQuest then
			-- Активный квест: обновляем время в кеше
			local diff = E.func_GetQuestTimeLeftSeconds(questID)
			if diff then
				collectCACHE[questID].endTime = ServerTime + diff
				collectCACHE[questID].haveTime = true
			end
			-- Сохраняем прогресс в Data
			collect[questID] = {
				isOnQuest = true,
				bountyStr = E.func_GetQuestStatus(questID),
			}
		else
			if not currentCallingIDs[questID] and E.func_IsQuestFlaggedCompleted(questID) then
				collect[questID] = {
					isCompleted = true,
					bountyStr = E.DONE,
				}
			end
		end
	end
end
----------------------------------------------------------------
-- local CallingsPrev = 0
-- tinsert(ToDoFunc, function(self, collect)
--     if not isLevel60 then
--         return
--     end
--     local ServerTime = E.TIME_SERVER()
--     if not CallingsPrev or ServerTime - CallingsPrev > 1 then
--         CallingsPrev = ServerTime
--         CallingsUpdater.collect = collect
--         --collect.bounty1 = nil
--         --collect.bounty2 = nil
--         --collect.bounty3 = nil
--         C_CovenantCallings.RequestCallings()
--     end
-- end)
----------------------------------------------------------------
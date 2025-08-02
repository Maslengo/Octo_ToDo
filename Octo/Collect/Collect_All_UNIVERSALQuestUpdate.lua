local GlobalAddonName, E = ...
----------------------------------------------------------------
local function func_ConcatAtStart_UniversalQuest()
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_01_WorldofWarcraft())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_02_TheBurningCrusade())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_03_WrathoftheLichKing())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_04_Cataclysm())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_05_MistsofPandaria())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_06_WarlordsofDraenor())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_07_Legion())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_08_BattleforAzeroth())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_09_Shadowlands())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_10_Dragonflight())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_11_TheWarWithin())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_12_Midnight())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_13_TheLastTitan())
	E:func_TableConcat(E.OctoTable_UniversalQuest, E:func_Universal_99_Other())
end


----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

function E:func_Collect_All_UNIVERSALQuestUpdate()
	if not E.func_ConcatAtStart_UniversalQuest then
		E.func_ConcatAtStart_UniversalQuest = true
		func_ConcatAtStart_UniversalQuest()
	end

	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	if not collectMASLENGO or InCombatLockdown() then return end

	collectMASLENGO.UniversalQuest = {}

	for _, data in ipairs(E.OctoTable_UniversalQuest) do
		if not data.quests then
			-- Пропускаем записи без квестов
			break
		end

		local questKey = data.desc.."_"..data.name_save.."_"..data.reset
		collectMASLENGO.UniversalQuest[questKey] = collectMASLENGO.UniversalQuest[questKey] or {}
		local count = 0
		local forcedMaxQuest = data.forcedMaxQuest
		local hasSingleQuestOutput = false

		-- Обработка квестов
		for _, questData in ipairs(data.quests) do
			local questID = questData[1]
			local faction = questData.faction -- может быть nil (общий)

			-- Пропускаем квесты не нашей фракции
			if faction and faction ~= E.curFaction then
				-- Переходим к следующему квесту
			else
				-- Проверка завершенности квеста
				local isCompleted = C_QuestLog.IsQuestFlaggedCompleted(questID)
				local status = E:func_CheckCompletedByQuestID(questID)

				collectMASLENGO.UniversalQuest[questKey][questID] = status

				if isCompleted then
					count = count + 1
				end

				-- Особый случай для forcedMaxQuest == 1
				if forcedMaxQuest == 1 and E:func_IsOnQuest(questID) then
					collectMASLENGO.UniversalQuest[questKey].textCENT = status
					hasSingleQuestOutput = true
				end
			end
		end

		-- Устанавливаем счетчик, если не установлен в особом случае
		if not hasSingleQuestOutput then
			collectMASLENGO.UniversalQuest[questKey].textCENT = count
		end
	end
end
local GlobalAddonName, E = ...
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
local funcName = GlobalAddonName.."WTF"
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("Octo") -- Локализация
local LibDataBroker = LibStub("LibDataBroker-1.1") -- Для брокера данных
local LibSharedMedia = LibStub("LibSharedMedia-3.0") -- Для медиа-ресурсов
local LibThingsLoad = LibStub("LibThingsLoad-1.0") -- Для асинхронной загрузки
----------------------------------------------------------------
function E.Cleanup_Obsolete_Reputations()
	-- E.func_StartDebugTimer()
	-- Создаем быстрый lookup таблицу актуальных ID
	local validReps = {}
	for reputationID in next,(E.OctoTable_Reputations_DB) do
		validReps[reputationID] = true
	end

	-- Проходим по всем персонажам
	for GUID, CharInfo in next, Octo_ToDo_DB_Levels do
		local cm = CharInfo.MASLENGO
		if cm and cm.Reputation then
			local toRemove = {}

			-- Собираем ID для удаления
			for reputationID in next, cm.Reputation do
				if not validReps[reputationID] then
					table.insert(toRemove, reputationID)
				end
			end

			-- Удаляем устаревшие
			for _, repID in ipairs(toRemove) do
				cm.Reputation[repID] = nil
			end

			-- Опционально: удаляем пустую таблицу
			if next(cm.Reputation) == nil then
				cm.Reputation = nil
			end
		end
	end
	-- E.func_StopDebugTimer()
end




local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_LOGIN",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
----------------------------------------------------------------
function EventFrame:ADDON_LOADED(addonName)
	----------------------------------------------------------------
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
end
function EventFrame:PLAYER_LOGIN()
	E.Cleanup_Obsolete_Reputations()
	-- C_Timer.After(2, function()
	-- 	opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.Reputation)
	-- end)
end
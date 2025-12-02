local GlobalAddonName, ns = ...
E = _G.OctoEngine
--
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
local GetBestMapForUnit = GetBestMapForUnit or C_Map.GetBestMapForUnit
local GetPlayerMapPosition = GetPlayerMapPosition or C_Map.GetPlayerMapPosition
local GetAllCompletedQuestIDs = GetAllCompletedQuestIDs or C_QuestLog.GetAllCompletedQuestIDs
local C_Timer_After = C_Timer.After
local session_quests = {}
local known_completed_quests = {}
local SPAM_QUESTS = {
	[32468] = true, -- Crystal Clarity
	[32469] = true, -- Crystal Clarity
}
-- Очистка session_quests каждые 30 минут
C_Timer.NewTicker(1800, function()
		session_quests = {}
end)
-- Безопасное получение иконки спека
local function GetSpecializationIconSafe()
	local specID = GetSpecialization()
	if specID then
		local _, _, _, icon = GetSpecializationInfo(specID)
		return icon
	end
	return nil
end
-- Безопасное получение позиции игрока и mapID
local function GetPlayerMapData()
	local mapID = GetBestMapForUnit("player")
	local x, y = 0, 0
	if mapID then
		local position = GetPlayerMapPosition(mapID, "player")
		if position then
			x, y = position:GetXY()
		end
	end
	return mapID or 0, x or 0, y or 0
end
-- Безопасное получение списка завершённых квестов
local function GetCompletedQuestsSafe()
	local ok, result = pcall(GetAllCompletedQuestIDs)
	if ok and type(result) == "table" then
		return result
	end
	return {}
end
-- Добавление нового квеста в базу
local function AddQuestToDB(questID)
	local mapID, x, y = GetPlayerMapData()
	if Octo_Debug_DB.Config_QC_Quests then
		print (E.func_questName(questID), E.Gray_Color.."id:"..questID.."|r")
	end
	local quest = {
		id = questID,
		time = time(),
		mapID = mapID,
		x = x,
		y = y,
		playerName = E.curCharName,
		curServer = E.func_GetRealmName(),
		classColorHex = E.classColorHexCurrent,
		curLocation = E.func_GetCurrentLocation and E.func_GetCurrentLocation() or "",
		specIcon = GetSpecializationIconSafe(),
	}
	EventFrame.savedVars.QC_Quests[questID] = quest
end
-- Проверка на новые квесты
function EventFrame:func_CheckQuests()
	if E.func_CheckQuests_pause then return end
	E.func_CheckQuests_pause = true
	C_Timer_After(E.SPAM_TIME, function()
			local current = GetCompletedQuestsSafe()
			for _, questID in ipairs(current) do
				-- local nameTEST = E.func_questName(questID)
				if not known_completed_quests[questID] and not session_quests[questID] and not SPAM_QUESTS[questID] then
					session_quests[questID] = true
					known_completed_quests[questID] = true
					AddQuestToDB(questID)
				end
			end
			E.func_CheckQuests_pause = false
	end)
end
-- Инициализация: запоминаем уже завершённые квесты при логине
local function InitializeKnownQuests()
	local initial = GetCompletedQuestsSafe()
	for _, questID in ipairs(initial) do
		known_completed_quests[questID] = true
	end
end
-- Обработка событий
local MyEventsTable = {
	"ADDON_LOADED",
	"QUEST_LOG_UPDATE",
	"PLAYER_LOGIN",
}
E.func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
end
function EventFrame:PLAYER_LOGIN()
	InitializeKnownQuests()
end
-- function EventFrame:PLAYER_ENTERING_WORLD()
-- InitializeKnownQuests
-- end
function EventFrame:QUEST_LOG_UPDATE()
	self:func_CheckQuests()
end
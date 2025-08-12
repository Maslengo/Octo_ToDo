local GlobalAddonName, ns = ...
E = _G.OctoEngine
local Octo_EventFrame = CreateFrame("Frame")
Octo_EventFrame:Hide()

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
	if not Octo_QuestsChanged_DB then return end
	Octo_QuestsChanged_DB.QC_Quests = Octo_QuestsChanged_DB.QC_Quests or {}
	local mapID, x, y = GetPlayerMapData()



	if Octo_ToDo_DB_Vars.DebugQC_Vignettes then
		print (E.func_questName(questID), E.Gray_Color.."id:"..id.."|r")
	end

	local quest = {
		id = questID,
		time = time(),
		mapID = mapID,
		x = x,
		y = y,
		playerName = E.curCharName,
		curServer = GetRealmName(),
		classColorHex = E.classColorHexCurrent,
		curLocation = E.func_GetCurrentLocation and E.func_GetCurrentLocation() or "",
		specIcon = GetSpecializationIconSafe(),
	}
	Octo_QuestsChanged_DB.QC_Quests[questID] = quest
end
-- Проверка на новые квесты
function Octo_EventFrame:func_CheckQuests()
	if E.func_CheckQuests_pause then return end
	E.func_CheckQuests_pause = true
	C_Timer_After(E.SPAM_TIME, function()
			local current = GetCompletedQuestsSafe()
			for _, questID in ipairs(current) do
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
	"QUEST_LOG_UPDATE",
	"PLAYER_LOGIN",
}
E.func_RegisterMyEventsToFrames(Octo_EventFrame, MyEventsTable)
function Octo_EventFrame:PLAYER_LOGIN()
	InitializeKnownQuests()
end
-- function Octo_EventFrame:PLAYER_ENTERING_WORLD()
--     InitializeKnownQuests
-- end
function Octo_EventFrame:QUEST_LOG_UPDATE()
	self:func_CheckQuests()
end
local GlobalAddonName, ns = ...
E = _G.OctoEngine



local EventFrame = CreateFrame("Frame")
local session_quests = {}
local known_completed_quests = {}

-- 🧠 Очистка session_quests каждые 30 минут
C_Timer.NewTicker(1800, function()
    session_quests = {}
end)

-- 🛡️ Безопасное получение иконки спека
local function GetSpecializationIconSafe()
    local specID = GetSpecialization()
    if specID then
        local _, _, _, icon = GetSpecializationInfo(specID)
        return icon
    end
    return nil
end

-- 🗺️ Безопасное получение позиции игрока и mapID
local function GetPlayerMapData()
    local mapID = C_Map.GetBestMapForUnit("player")
    local x, y = 0, 0
    if mapID then
        local position = C_Map.GetPlayerMapPosition(mapID, "player")
        if position then
            x, y = position:GetXY()
        end
    end
    return mapID or 0, x or 0, y or 0
end

-- 📋 Безопасное получение списка завершённых квестов
local function GetCompletedQuestsSafe()
    local ok, result = pcall(C_QuestLog.GetAllCompletedQuestIDs)
    if ok and type(result) == "table" then
        return result
    end
    return {}
end

-- 🧾 Добавление нового квеста в базу
local function AddQuestToDB(questID)
    if not Octo_QuestsChanged_DB then return end
    Octo_QuestsChanged_DB.QC_Quests = Octo_QuestsChanged_DB.QC_Quests or {}

    local mapID, x, y = GetPlayerMapData()
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

-- 🔁 Проверка на новые квесты
function EventFrame:func_CheckQuests()
    if E.func_CheckQuests_pause then return end
    E.func_CheckQuests_pause = true

    C_Timer.After(1, function()
        local current = GetCompletedQuestsSafe()
        for _, questID in ipairs(current) do
            if not known_completed_quests[questID] and not session_quests[questID] then
                session_quests[questID] = true
                known_completed_quests[questID] = true
                AddQuestToDB(questID)
            end
        end
        E.func_CheckQuests_pause = false
    end)
end

-- 🧠 Инициализация: запоминаем уже завершённые квесты при логине
local function InitializeKnownQuests()
    local initial = GetCompletedQuestsSafe()
    for _, questID in ipairs(initial) do
        known_completed_quests[questID] = true
    end
end

-- 📡 Обработка событий
local MyEventsTable = {
	"QUEST_LOG_UPDATE",
	"PLAYER_LOGIN",
}
E.func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
function EventFrame:PLAYER_LOGIN()
	InitializeKnownQuests()
end
-- function EventFrame:PLAYER_ENTERING_WORLD()
-- 	InitializeKnownQuests
-- end
function EventFrame:QUEST_LOG_UPDATE()
	self:func_CheckQuests()
end
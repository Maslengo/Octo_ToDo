local GlobalAddonName, ns = ...
E = _G.OctoEngine
-- 
local EventFrame = CreateFrame("FRAME")
local funcName = GlobalAddonName.."WTF"
----------------------------------------------------------------
EventFrame[funcName] = function(self)
	EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
	----------------------------------------------------------------
	local defaultOptions = {
		addonFontSize = 11,
		DebugButton = false, -- Отладка кнопок
		DebugEvent = false, -- Отладка событий
		DebugFunction = false, -- Отладка функций
		DebugIDs = false, -- Отладка ID
		DebugCharacterInfo = false, -- Отладка информации
		DebugGossip = false, -- Отладка информации
		DebugCache = false, -- Отладка информации
		DebugQC_Vignettes = false, -- Отладка информации
		DebugQC_Quests = false, -- Отладка информации
		DebugUniversal = false, -- Отладка информации
		editorFontSize = 12,
		editorTabSpaces = 4,
		editorTheme = "Twilight",
	}
	for k, v in next, (defaultOptions) do
		E.func_InitField(EventFrame.savedVars, k, v)
		E[k] = EventFrame.savedVars[k] -- Копируем в глобальную таблицу
	end
	----------------------------------------------------------------
	EventFrame.savedVars.profileKeys = EventFrame.savedVars.profileKeys or {}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if CharInfo.PlayerData then
			local currentKey = CharInfo.PlayerData.Name.." - "..CharInfo.PlayerData.curServer
			EventFrame.savedVars.profileKeys[currentKey] = "OctoUI"
		end
	end
	----------------------------------------------------------------
end
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED", -- Событие загрузки аддона
	"PLAYER_LOGIN",
}
----------------------------------------------------------------
E.func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
------------------------------------------------------------
----------------------------------------------------------------
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	EventFrame[funcName](EventFrame)
end
function EventFrame:PLAYER_LOGIN()
	E.DebugButton = Octo_Debug_DB.DebugButton
	E.DebugEvent = Octo_Debug_DB.DebugEvent
	E.DebugFunction = Octo_Debug_DB.DebugFunction
	E.DebugIDs = Octo_Debug_DB.DebugIDs
	E.DebugCharacterInfo = Octo_Debug_DB.DebugCharacterInfo
	E.DebugGossip = Octo_Debug_DB.DebugGossip
	E.DebugCache = Octo_Debug_DB.DebugCache
	E.DebugQC_Vignettes = Octo_Debug_DB.DebugQC_Vignettes
	E.DebugQC_Quests = Octo_Debug_DB.DebugQC_Quests
	E.DebugUniversal = Octo_Debug_DB.DebugUniversal
end
----------------------------------------------------------------
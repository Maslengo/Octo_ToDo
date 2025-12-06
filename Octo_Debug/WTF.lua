local GlobalAddonName, ns = ...
E = _G.OctoEngine
local EventFrame = CreateFrame("FRAME")
local funcName = GlobalAddonName.."WTF"
----------------------------------------------------------------
EventFrame[funcName] = function(self)
	EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
	----------------------------------------------------------------
	local defaultOptions = {
		DebugIDs = false,
		DebugCharacterInfo = false,
		DebugEvent = false,
		DebugFunction = false,
		DebugButton = false,
		DebugGossip = false,
		DebugCache = false,
		DebugQC_Vignettes = false,
		DebugQC_Quests = false,
		DebugUniversal = false,
		CVar = false, -- CVar настройки
		SPAM_TIME = 2,
		editorFontSize = 12, -- for i = 10, 16 do
		editorTabSpaces = 4, -- for _, v in ipairs({0, 2, 3, 4}) do
		editorTheme = "Twilight", -- for name in next, E.editorThemes do
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
	"ADDON_LOADED",
	"VARIABLES_LOADED",
	"PLAYER_LOGIN",
	"PLAYER_LOGOUT",
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
function EventFrame:VARIABLES_LOADED()
	if E.func_IsPTR() then
		C_Timer.After(0, function()
				SetCVar("addonChatRestrictionsForced", "1")
				SetCVar("secretAurasForced", "1")
				SetCVar("secretCooldownsForced", "1")
				SetCVar("secretUnitIdentityForced", "1")
				SetCVar("secretSpellcastsForced", "1")
				SetCVar("secretUnitPowerForced", "1")
				SetCVar("secretUnitPowerMaxForced", "1")
				SetCVar("secretUnitComparisonForced", "1")
		end)
	end
	if Octo_Debug_DB.CVar then
		E.func_LoadCVars()
	end
end
function EventFrame:PLAYER_LOGOUT()
	if E.func_IsPTR() then
		SetCVar("addonChatRestrictionsForced", "0")
		SetCVar("secretAurasForced", "0")
		SetCVar("secretCooldownsForced", "0")
		SetCVar("secretUnitIdentityForced", "0")
		SetCVar("secretSpellcastsForced", "0")
		SetCVar("secretUnitPowerForced", "0")
		SetCVar("secretUnitPowerMaxForced", "0")
		SetCVar("secretUnitComparisonForced", "0")
	end
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
	E.SPAM_TIME = Octo_Debug_DB.SPAM_TIME
end
----------------------------------------------------------------
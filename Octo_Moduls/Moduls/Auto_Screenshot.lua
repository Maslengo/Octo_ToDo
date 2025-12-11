local GlobalAddonName, ns = ...
E = _G.OctoEngine
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
tinsert(E.Modules, function()
	EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
	if not EventFrame.savedVars.Config_Auto_Screenshot then return end
	-- Создаем таблицу сообщений для разных событий
	local EVENT_MESSAGES = {
		SHOW_LOOT_TOAST_LEGENDARY_LOOTED = "Received a legendary item: ",
		ACHIEVEMENT_EARNED = "Earned an achievement: ",
		PLAYER_LEVEL_UP = "Leveled up: ",
		CHALLENGE_MODE_COMPLETED = "Completed M+: ",
		NEW_MOUNT_ADDED = "New mount added: ",
		NEW_PET_ADDED = "New pet added: ",
		NEW_TOY_ADDED = "New toy added: ",
		TRADE_ACCEPT_UPDATE = "Trade completed: "
	}
	local function TakeScreenshotWithMessage(event)
		local message = EVENT_MESSAGES[event] or ""
		local currentTime = date("%m/%d/%y %H:%M:%S")
		C_Timer.After(1, function()
			DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient(message).." "..E.Yellow_Color..currentTime.."|r")
			Screenshot()
		end)
	end
	-- Регистрируем события
	EventFrame:RegisterEvent("PLAYER_LEVEL_UP")
	EventFrame:RegisterEvent("ACHIEVEMENT_EARNED")
	EventFrame:RegisterEvent("SHOW_LOOT_TOAST_LEGENDARY_LOOTED")
	EventFrame:RegisterEvent("NEW_MOUNT_ADDED")
	EventFrame:RegisterEvent("NEW_PET_ADDED")
	EventFrame:RegisterEvent("NEW_TOY_ADDED")
	EventFrame:RegisterEvent("TRADE_ACCEPT_UPDATE")
	EventFrame:RegisterEvent("CHALLENGE_MODE_COMPLETED")
	-- Устанавливаем обработчик событий
	EventFrame:SetScript("OnEvent", function(self, event, ...)
		if EVENT_MESSAGES[event] then
			-- DEFAULT_CHAT_FRAME:AddMessage(event)
			TakeScreenshotWithMessage(event)
		end
	end)
end)
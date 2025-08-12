local GlobalAddonName, ns = ...
E = _G.OctoEngine




tinsert(E.Modules, function()
	if not Octo_ToDo_DB_Vars.Config_Auto_Screenshot then return end

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

		DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient(message).." "..E.Yellow_Color..currentTime.."|r")

		C_Timer.After(E.SPAM_TIME, function()
			Screenshot()
		end)
	end

	-- Создаем и настраиваем фрейм
	local eventFrame_Screenshot = CreateFrame("Frame")
	eventFrame_Screenshot:Hide()
	-- Регистрируем события
	eventFrame_Screenshot:RegisterEvent("PLAYER_LEVEL_UP")
	eventFrame_Screenshot:RegisterEvent("ACHIEVEMENT_EARNED")
	eventFrame_Screenshot:RegisterEvent("SHOW_LOOT_TOAST_LEGENDARY_LOOTED")
	eventFrame_Screenshot:RegisterEvent("NEW_MOUNT_ADDED")
	eventFrame_Screenshot:RegisterEvent("NEW_PET_ADDED")
	eventFrame_Screenshot:RegisterEvent("NEW_TOY_ADDED")
	eventFrame_Screenshot:RegisterEvent("TRADE_ACCEPT_UPDATE")
	eventFrame_Screenshot:RegisterEvent("CHALLENGE_MODE_COMPLETED")

	-- Устанавливаем обработчик событий
	eventFrame_Screenshot:SetScript("OnEvent", function(self, event, ...)
		if EVENT_MESSAGES[event] then
			-- DEFAULT_CHAT_FRAME:AddMessage(event)
			TakeScreenshotWithMessage(event)
		end
	end)
end)
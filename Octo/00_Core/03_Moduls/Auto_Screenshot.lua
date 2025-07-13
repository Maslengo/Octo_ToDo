local GlobalAddonName, E = ...
if not E.Enable_Moduls then return end

tinsert(E.Modules, function()
	if not Octo_ToDo_DB_Vars.Auto_Screenshot then return end

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

		DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient(message, E.Addon_Left_Color, E.Addon_Right_Color).." "..E.Yellow_Color..currentTime.."|r")

		C_Timer.After(1, function()
			Screenshot()
		end)
	end

	-- Создаем и настраиваем фрейм
	local eventFrame = CreateFrame("Frame", E.func_GenerateUniqueID())

	-- Регистрируем события
	eventFrame:RegisterEvent("PLAYER_LEVEL_UP")
	eventFrame:RegisterEvent("ACHIEVEMENT_EARNED")
	eventFrame:RegisterEvent("SHOW_LOOT_TOAST_LEGENDARY_LOOTED")
	eventFrame:RegisterEvent("NEW_MOUNT_ADDED")
	eventFrame:RegisterEvent("NEW_PET_ADDED")
	eventFrame:RegisterEvent("NEW_TOY_ADDED")
	eventFrame:RegisterEvent("TRADE_ACCEPT_UPDATE")

	if E.func_IsRetail() then
		eventFrame:RegisterEvent("CHALLENGE_MODE_COMPLETED")
	end

	-- Устанавливаем обработчик событий
	eventFrame:SetScript("OnEvent", function(self, event, ...)
		if EVENT_MESSAGES[event] then
			TakeScreenshotWithMessage(event)
		end
	end)
end)
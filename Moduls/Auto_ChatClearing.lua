local GlobalAddonName, E = ...
----------------------------------------------------------------------------------------------------------------------------------
-- Auto_Chat_Clearing
tinsert(E.Modules, function()
	if Octo_ToDo_DB_Vars.config.Auto_ChatClearing then
		-- C_Timer.After(1, function() ChatFrame1:Clear() end)
		C_Timer.After(1, function() DEFAULT_CHAT_FRAME:Clear() end)
		
	end
end)

local GlobalAddonName, E = ...
----------------------------------------------------------------
-- Auto_ChatClearing
tinsert(E.Modules, function()
	if Octo_ToDo_DB_Vars.Auto_ChatClearing then
		C_Timer.After(1, function()
			DEFAULT_CHAT_FRAME:Clear()
		end)
	end
end)

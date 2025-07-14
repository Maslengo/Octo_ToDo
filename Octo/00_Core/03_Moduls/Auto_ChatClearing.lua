local GlobalAddonName, E = ...
-- if not Octo_ToDo_DB_Vars.Enable_Moduls then return end

-- Auto_ChatClearing
tinsert(E.Modules, function()
	if Octo_ToDo_DB_Vars.Auto_ChatClearing then
		C_Timer.After(1, function()
			(SELECTED_CHAT_FRAME or DEFAULT_CHAT_FRAME):Clear()
		end)
	end
end)
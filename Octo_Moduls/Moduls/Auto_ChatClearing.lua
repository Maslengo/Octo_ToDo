local GlobalAddonName, ns = ...
E = _G.OctoEngine




tinsert(E.Modules, function()
	if Octo_ToDo_DB_Vars.Config_Auto_ChatClearing then
		C_Timer.After(1, function()
			(SELECTED_CHAT_FRAME or DEFAULT_CHAT_FRAME):Clear()
		end)
	end
end)
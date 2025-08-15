local GlobalAddonName, ns = ...
E = _G.OctoEngine
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
tinsert(E.Modules, function()
	EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
	if EventFrame.savedVars.Config_Auto_ChatClearing then
		C_Timer.After(1, function()
			(SELECTED_CHAT_FRAME or DEFAULT_CHAT_FRAME):Clear()
		end)
	end
end)
----------------------------------------------------------------
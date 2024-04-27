local GlobalAddonName, E = ...
local AddonTitle = GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--CinematicCanceler
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDo_DB_Vars.config.CinematicCanceler then
			CinematicFrame:HookScript("OnShow", function(self, ...)
					if IsModifierKeyDown() then
						return
					end --если нажат модификатор, то не запустится мувик
					ChatFrame1:AddMessage(E.Octo_Func.func_Gradient("Cinematic canceled", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color))
					CinematicFrame_CancelCinematic()
					-- StopCinematic()
			end)
			local omfpf = _G["MovieFrame_PlayMovie"] --запускает мувик?
			_G["MovieFrame_PlayMovie"] = function(...)
				if IsModifierKeyDown() then
					return omfpf(...) end
				ChatFrame1:AddMessage(E.Octo_Func.func_Gradient("Movie canceled", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color))
				GameMovieFinished() return true
			end
		end
end)
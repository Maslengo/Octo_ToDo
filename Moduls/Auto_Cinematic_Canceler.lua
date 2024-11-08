local GlobalAddonName, E = ...
----------------------------------------------------------------------------------------------------------------------------------
-- Auto_Cinematic_Canceler
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDo_DB_Vars.config.CinematicCanceler then
			CinematicFrame:HookScript("OnShow", function(self, ...)
					if IsModifierKeyDown() then
						return
					end
					ChatFrame1:AddMessage(E.Octo_Func.func_Gradient("Cinematic canceled", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color))
					CinematicFrame_CancelCinematic()
			end)
			local omfpf = _G["MovieFrame_PlayMovie"]
			_G["MovieFrame_PlayMovie"] = function(...)
				if IsModifierKeyDown() then
					return omfpf(...)
				end
				ChatFrame1:AddMessage(E.Octo_Func.func_Gradient("Movie canceled", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color))
				-- GameMovieFinished()
				-- https://warcraft.wiki.gg/wiki/API_CinematicFinished
				for i = 1, #Enum.CinematicType do
					CinematicFinished(i)
					return true
				end
			end
		end
end)



-- /dump GameMovieFinished()
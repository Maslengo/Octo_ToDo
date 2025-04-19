local GlobalAddonName, E = ... 
----------------------------------------------------------------------------------------------------------------------------------
-- Auto_CinematicCanceler
tinsert(E.Modules, function()
		if Octo_ToDo_DB_Vars.Auto_CinematicCanceler then
			CinematicFrame:HookScript("OnShow", function(self, ...)
					if IsModifierKeyDown() then
						return
					end
					if CinematicFrame:IsShown() and CinematicFrame.closeDialog and CinematicFrameCloseDialogConfirmButton then
						CinematicFrameCloseDialog:Hide()
						CinematicFrameCloseDialogConfirmButton:Click()
						DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("Cinematic canceled", E.Addon_Left_Color, E.Addon_Right_Color))
					end
			end)
			MovieFrame:HookScript("OnShow", function(self, ...)
					if IsModifierKeyDown() then
						return
					end
					if MovieFrame:IsShown() and MovieFrame.CloseDialog and MovieFrame.CloseDialog.ConfirmButton then
						MovieFrame.CloseDialog.ConfirmButton:Click()
						DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("Movie canceled", E.Addon_Left_Color, E.Addon_Right_Color))
					end
			end)
		end
end)
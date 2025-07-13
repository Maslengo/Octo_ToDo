local GlobalAddonName, E = ...
if not E.Enable_Moduls then return end
-- Auto_Cinematic_Canceler
tinsert(E.Modules, function()
		local function HandleFrameAction(frame, dialogPath, confirmButtonPath, message)
			if not frame:IsShown() then return end
			local dialog = frame[dialogPath] or _G[dialogPath]
			local confirmButton = dialog and (dialog[confirmButtonPath] or _G[confirmButtonPath])
			if not confirmButton then return end
			if dialog.Hide then dialog:Hide() end
			confirmButton:Click()
			if message then
				DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient(message, E.Addon_Left_Color, E.Addon_Right_Color))
			end
		end
		local function OnKeyUp(self, key)
			if key == "SPACE" or key == "ESCAPE" or key == "ENTER" then
				if self == CinematicFrame then
					HandleFrameAction(CinematicFrame, "closeDialog", "CloseDialogConfirmButton")
				elseif self == MovieFrame then
					HandleFrameAction(MovieFrame, "CloseDialog", "ConfirmButton")
				end
			end
		end
		local function OnFrameShow(self)
			if IsModifierKeyDown() then return end
			if self == CinematicFrame then
				HandleFrameAction(CinematicFrame, "closeDialog", "CloseDialogConfirmButton", "Cinematic canceled")
			elseif self == MovieFrame then
				HandleFrameAction(MovieFrame, "CloseDialog", "ConfirmButton", "Movie canceled")
			end
		end
		-- Fast Skip functionality
		if Octo_ToDo_DB_Vars.Auto_CinematicFastSkip then
			CinematicFrame:HookScript("OnKeyDown", function(self, key)
					if key == "ESCAPE" then
						HandleFrameAction(CinematicFrame, "closeDialog", "CloseDialogConfirmButton")
					end
			end)
			CinematicFrame:HookScript("OnKeyUp", OnKeyUp)
			MovieFrame:HookScript("OnKeyUp", OnKeyUp)
		end
		-- Auto Canceler functionality
		if Octo_ToDo_DB_Vars.Auto_CinematicCanceler then
			CinematicFrame:HookScript("OnShow", OnFrameShow)
			MovieFrame:HookScript("OnShow", OnFrameShow)
		end
end)
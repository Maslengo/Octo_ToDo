local GlobalAddonName, ns = ...
E = _G.OctoEngine
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
local function HELP_TEXT(name)
	return E.func_Gradient(name)
end
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"CINEMATIC_START",
	"PLAY_MOVIE",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
end
function EventFrame:CINEMATIC_START()
	if EventFrame.savedVars.Config_Auto_CinematicCanceler then
		DEFAULT_CHAT_FRAME:AddMessage(HELP_TEXT("Cancel Cinematic"))
		CinematicFrame_CancelCinematic()
	end
end
function EventFrame:PLAY_MOVIE(...) -- movieID
	Octo_Cache_DB.watchedMovies[...] = true
end
tinsert(E.Modules, function()
		local function HandleFrameAction(frame, dialogPath, confirmButtonPath, message)
			if not frame:IsShown() then return end
			local dialog = frame[dialogPath] or _G[dialogPath]
			local confirmButton = dialog and (dialog[confirmButtonPath] or _G[confirmButtonPath])
			if not confirmButton then return end
			if dialog.Hide then dialog:Hide() end
			confirmButton:Click()
			if message then
				DEFAULT_CHAT_FRAME:AddMessage(HELP_TEXT(message))
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
		if EventFrame.savedVars.Config_Auto_CinematicFastSkip then
			CinematicFrame:HookScript("OnKeyDown", function(self, key)
					if key == "ESCAPE" then
						HandleFrameAction(CinematicFrame, "closeDialog", "CloseDialogConfirmButton")
					end
			end)
			CinematicFrame:HookScript("OnKeyUp", OnKeyUp)
			MovieFrame:HookScript("OnKeyUp", OnKeyUp)
		end
		-- Auto Canceler functionality
		if EventFrame.savedVars.Config_Auto_CinematicCanceler then
			CinematicFrame:HookScript("OnShow", OnFrameShow)
			MovieFrame:HookScript("OnShow", OnFrameShow)
		end
end)
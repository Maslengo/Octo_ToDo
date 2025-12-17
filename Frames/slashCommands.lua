local GlobalAddonName, E = ...
----------------------------------------------------------------
-- Slash-команды
----------------------------------------------------------------
local slashCommands = {
	OCTO = {
		commands = {"/octo"},
		handler = function(msg)
			if not InCombatLockdown() then
				E.func_main_frame_toggle() -- Переключаем фрейм
			end
		end
	},
	RELOAD = {
		commands = {"/rl"},
		handler = function()
			ReloadUI()
		end
	},
	FRAMESTK = {
		commands = {"/fs"},
		handler = function(msg)
			if not E.func_IsAddOnLoaded("Blizzard_DebugTools") then
				E.func_LoadAddOnForced("Blizzard_DebugTools")
			end
			FrameStackTooltip_Toggle(msg == "true", true, true)
		end
	},
	EVENTTREEASCE = {
		commands = {"/et"},
		handler = function(msg)
			UIParentLoadAddOn("Blizzard_EventTrace")
			if not EventTrace:ProcessChatCommand(msg) then
				EventTrace:SetShown(not EventTrace:IsShown())
			end
		end
	},
}
-- Регистрируем все slash-команды
for name, data in next, (slashCommands) do
	SlashCmdList[name] = data.handler
	for i, cmd in ipairs(data.commands) do
		_G["SLASH_"..name..i] = cmd
	end
end
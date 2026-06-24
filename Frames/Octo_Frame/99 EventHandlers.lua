local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
local function func_OnLoad()
	E.isPanning = false
end
----------------------------------------------------------------
local MyEventsTable = {
	"PLAYER_LOGIN",
	"PLAYER_REGEN_DISABLED",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)

function EventFrame:PLAYER_LOGIN()
	----------------------------------------------------------------
	E.func_CreateMenuStyle()
	----------------------------------------------------------------
	func_OnLoad()
	local f = E.func_CreateMainFrame(E.MAIN_FRAME_NAME)
	E.FRAMES[E.MAIN_FRAME_NAME] = f
	local MAIN_FRAME = E.FRAMES[E.MAIN_FRAME_NAME]
	-- local MAIN_FRAME = E.FRAMES[E.MAIN_FRAME_NAME]
	if MAIN_FRAME then
		E.func_CreateSearchBox(MAIN_FRAME)
		E.func_WeeklyResetFrameLeft(MAIN_FRAME)
		do
			local providerfunc = function() E.func_UPDATE_MAINFRAME(MAIN_FRAME) end
			local buttonName = nil
			E.func_Create_DDframe_ToDo(MAIN_FRAME, providerfunc, buttonName)
		end
		-- local settingsProfile = E.func_GetProfile_SETTINGS_CURRENT()
		E.func_CreateMinimapButton(GlobalAddonName, Octo_ToDo_DB_Variables, MAIN_FRAME, function() E.func_main_frame_toggle(MAIN_FRAME) end)
	end
	----------------------------------------------------------------
end
function EventFrame:PLAYER_REGEN_DISABLED()
	local MAIN_FRAME = E.FRAMES[E.MAIN_FRAME_NAME]
	if MAIN_FRAME then
		MAIN_FRAME:Hide()
	end
end
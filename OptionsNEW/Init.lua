local GlobalAddonName, E = ...

local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")


local EventFrame = CreateFrame("FRAME")
-------------------------------------------------------------------------
function EventFrame:func_InitOptions()
	if not E.DEBUG then return end






end
----------------------------------------------------------------
local MyEventsTable = {
	"PLAYER_LOGIN",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:PLAYER_LOGIN()
	self:func_InitOptions()
end
----------------------------------------------------------------
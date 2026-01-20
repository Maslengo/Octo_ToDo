local GlobalAddonName, E = ...
local L = E.L
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
-------------------------------------------------------------------------
local enable = false
if not enable then return end
-------------------------------------------------------------------------
function E.func_Options_About(name, savedVars)
	local Options = {
		type = "group",
		childGroups = "tab",
		name = name,
		args = {
			-------------------------------------------------
			["Header"..E.func_GetOrder()] = {
				type = "header",
				name = "",
				order = E.func_GetOrder(),
			},
		},
	}
	-------------------------------------------------
	-------------------------------------------------
	-------------------------------------------------
	return Options
end
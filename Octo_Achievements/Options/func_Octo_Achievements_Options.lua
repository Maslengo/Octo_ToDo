local GlobalAddonName, ns = ...
E = _G.OctoEngine
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
-------------------------------------------------------------------------
function E.func_Octo_Achievements_Options(savedVars)
	local index = 0
	local function GetOrder()
		index = index + 1
		return index
	end
	local Achievements = {
		type = "group",
		childGroups = "tab",
		name = E.func_AddonNameForOptionsFunc(GlobalAddonName),
		args = {
			-------------------------------------------------
			["Header"..GetOrder()] = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_AchievementShowCompleted = {
				type = "toggle",
				name = "Config_AchievementShowCompleted",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Config_AchievementShowCompleted
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_AchievementShowCompleted = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
		},
	}
	return Achievements
end
if GetLocale() ~= "zhCN" then return end

local GlobalAddonName, E = ...
local AL3 = LibStub("AceLocale-3.0")
local debug = false
local L = AL3:NewLocale(E.MainAddonName, "zhCN", false, debug)

if L then
	L["Weekly Reset"] = "周常重置"

end
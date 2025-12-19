if GetLocale() ~= "zhTW" then return end
local GlobalAddonName, E = ...
local AL3 = LibStub("AceLocale-3.0")
local debug = false
local L = AL3:NewLocale(E.MainAddonName, "zhTW", false, debug)
if L then
	L["Weekly Reset"] = "每週重置"
end
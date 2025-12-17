if GetLocale() ~= "koKR" then return end

local GlobalAddonName, E = ...
local AL3 = LibStub("AceLocale-3.0")
local debug = false
local L = AL3:NewLocale(E.MainAddonName, "koKR", false, debug)

if L then
	L["Weekly Reset"] = "주간 초기화"

end
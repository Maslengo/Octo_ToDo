if GetLocale() ~= "frFR" then return end

local GlobalAddonName, E = ...
local AL3 = LibStub("AceLocale-3.0")
local debug = false
local L = AL3:NewLocale(E.MainAddonName, "frFR", false, debug)

if L then
	L["Weekly Reset"] = "Réinitialisation hebdomadaire"

end
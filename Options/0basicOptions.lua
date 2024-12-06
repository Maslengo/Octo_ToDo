local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
function E.ADDON_LOADED(E_name)
	if E_name == GlobalAddonName then
		E.Init()
	end
end
function E.Init()
	----------------------------------------------------------------
	AceConfigRegistry:RegisterOptionsTable("CreateGeneralOptions", E.CreateGeneralOptions())
	AceConfigRegistry:RegisterOptionsTable("Reputations", E.Reputations())
	AceConfigRegistry:RegisterOptionsTable("Currencies", E.Currencies())
	AceConfigRegistry:RegisterOptionsTable("LoadAddons", E.LoadAddons())
	AceConfigRegistry:RegisterOptionsTable("Developing", E.Developing())
	----------------------------------------------------------------
	local categoryFrame, mainCategoryID = AceConfigDialog:AddToBlizOptions("CreateGeneralOptions", E.AddonTitle)
	AceConfigDialog:AddToBlizOptions("Reputations", REPUTATION, E.AddonTitle)
	AceConfigDialog:AddToBlizOptions("Currencies", CURRENCY, E.AddonTitle)
	AceConfigDialog:AddToBlizOptions("LoadAddons", ADDONS, E.AddonTitle)
	AceConfigDialog:AddToBlizOptions("Developing", "Developing", E.AddonTitle)
	----------------------------------------------------------------
end



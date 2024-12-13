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
	AceConfigRegistry:RegisterOptionsTable("Currencies", E.Currencies())
	AceConfigRegistry:RegisterOptionsTable("Reputations", E.Reputations())
	AceConfigRegistry:RegisterOptionsTable("Items", E.Items())
	AceConfigRegistry:RegisterOptionsTable("Developing", E.Developing())
	----------------------------------------------------------------
	local categoryFrame, mainCategoryID = AceConfigDialog:AddToBlizOptions("CreateGeneralOptions", E.func_AddonTitle(GlobalAddonName))
	AceConfigDialog:AddToBlizOptions("Currencies", CURRENCY, E.func_AddonTitle(GlobalAddonName))
	AceConfigDialog:AddToBlizOptions("Reputations", REPUTATION, E.func_AddonTitle(GlobalAddonName))
	AceConfigDialog:AddToBlizOptions("Items", ITEMS, E.func_AddonTitle(GlobalAddonName))
	AceConfigDialog:AddToBlizOptions("Developing", E.Green_Color.."Developing".."|r", E.func_AddonTitle(GlobalAddonName))
	----------------------------------------------------------------
end
local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
-------------------------------------------------------------------------
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
function E:InitOptions()
	----------------------------------------------------------------
	AceConfigRegistry:RegisterOptionsTable("CreateGeneralOptionsMAIN", E.CreateGeneralOptions())
	AceConfigRegistry:RegisterOptionsTable("CurrenciesMAIN", E.Currencies())
	AceConfigRegistry:RegisterOptionsTable("ReputationsMAIN", E.Reputations())
	AceConfigRegistry:RegisterOptionsTable("ItemsMAIN", E.Items())
	AceConfigRegistry:RegisterOptionsTable("DevelopingMAIN", E.Developing())
	----------------------------------------------------------------
	local categoryFrame, mainCategoryID = AceConfigDialog:AddToBlizOptions("CreateGeneralOptionsMAIN", E.func_AddonTitle(GlobalAddonName))
	AceConfigDialog:AddToBlizOptions("CurrenciesMAIN", CURRENCY, E.func_AddonTitle(GlobalAddonName))
	AceConfigDialog:AddToBlizOptions("ReputationsMAIN", REPUTATION, E.func_AddonTitle(GlobalAddonName))
	AceConfigDialog:AddToBlizOptions("ItemsMAIN", ITEMS, E.func_AddonTitle(GlobalAddonName))
	AceConfigDialog:AddToBlizOptions("DevelopingMAIN", E.Debug_Color..BINDING_HEADER_DEBUG.."|r", E.func_AddonTitle(GlobalAddonName))
	----------------------------------------------------------------
end
local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
-------------------------------------------------------------------------
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
function E:InitOptions()
	----------------------------------------------------------------
	AceConfigRegistry:RegisterOptionsTable("CreateGeneralOptions", E:CreateGeneralOptions())
	AceConfigRegistry:RegisterOptionsTable("Automatization", E:Automatization())
	AceConfigRegistry:RegisterOptionsTable("HideFrames", E:HideFrames())
	AceConfigRegistry:RegisterOptionsTable("Cvars", E:Cvars())

	AceConfigRegistry:RegisterOptionsTable("Debug", E:Debug())
	----------------------------------------------------------------
	local categoryFrame, mainCategoryID = AceConfigDialog:AddToBlizOptions("CreateGeneralOptions", E:func_AddonTitle(GlobalAddonName))
	AceConfigDialog:AddToBlizOptions("Automatization", "Automatization", E:func_AddonTitle(GlobalAddonName))
	AceConfigDialog:AddToBlizOptions("HideFrames", "HideFrames", E:func_AddonTitle(GlobalAddonName))
	AceConfigDialog:AddToBlizOptions("Cvars", "Cvars", E:func_AddonTitle(GlobalAddonName))

	AceConfigDialog:AddToBlizOptions("Debug", "Debug", E:func_AddonTitle(GlobalAddonName))
	----------------------------------------------------------------
end
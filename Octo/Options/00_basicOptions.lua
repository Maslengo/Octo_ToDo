local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
-------------------------------------------------------------------------
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
function E.func_InitOptions()
	----------------------------------------------------------------
	AceConfigRegistry:RegisterOptionsTable("CreateGeneralOptions", E.func_CreateGeneralOptions())
	AceConfigRegistry:RegisterOptionsTable("Automatization", E.func_Automatization())
	AceConfigRegistry:RegisterOptionsTable("HideFrames", E.func_HideFrames())
	AceConfigRegistry:RegisterOptionsTable("Cvars", E.func_Cvars())

	AceConfigRegistry:RegisterOptionsTable("Debug", E.func_Debug())
	----------------------------------------------------------------
	local categoryFrame, mainCategoryID = AceConfigDialog:AddToBlizOptions("CreateGeneralOptions", E.func_GetAddOnMetadata(E.MainAddonName, "Title"))
	AceConfigDialog:AddToBlizOptions("Automatization", "Automatization", E.func_GetAddOnMetadata(E.MainAddonName, "Title"))
	AceConfigDialog:AddToBlizOptions("HideFrames", "HideFrames", E.func_GetAddOnMetadata(E.MainAddonName, "Title"))
	AceConfigDialog:AddToBlizOptions("Cvars", "Cvars", E.func_GetAddOnMetadata(E.MainAddonName, "Title"))

	AceConfigDialog:AddToBlizOptions("Debug", "Debug", E.func_GetAddOnMetadata(E.MainAddonName, "Title"))
	----------------------------------------------------------------
end